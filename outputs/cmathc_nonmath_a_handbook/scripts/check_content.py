from __future__ import annotations

import argparse
import csv
from collections import Counter
from pathlib import Path


EXPECTED_COUNTS = {
    "worked": 50,
    "quick": 35,
    "exercise": 35,
    "mock": 12,
}
REVIEW_FIELDS = (
    "recomputed",
    "conditions_checked",
    "endpoints_checked",
    "notation_checked",
)


def _read_csv(path: Path) -> list[dict[str, str]]:
    with path.open(encoding="utf-8-sig", newline="") as handle:
        return list(csv.DictReader(handle))


def scan_project(root: Path) -> dict[str, int]:
    problems = _read_csv(root / "references" / "problem-ledger.csv")
    counts = Counter(row.get("kind", "").strip() for row in problems)
    result = {kind: counts.get(kind, 0) for kind in EXPECTED_COUNTS}
    result["total"] = sum(result.values())
    return result


def _duplicates(values: list[str]) -> list[str]:
    counts = Counter(values)
    return sorted(value for value, count in counts.items() if value and count > 1)


def _scope_ids(value: str) -> list[str]:
    return [scope_id.strip() for scope_id in value.split(";") if scope_id.strip()]


def validate_project(root: Path, allow_incomplete: bool = False) -> list[str]:
    references = root / "references"
    problems = _read_csv(references / "problem-ledger.csv")
    scopes = _read_csv(references / "scope-matrix.csv")
    reviews = _read_csv(references / "math-review.csv")
    errors: list[str] = []

    problem_ids = [row.get("problem_id", "").strip() for row in problems]
    for duplicate in _duplicates(problem_ids):
        errors.append(f"duplicate problem_id {duplicate}")
    for index, problem_id in enumerate(problem_ids, start=2):
        if not problem_id:
            errors.append(f"problem-ledger.csv row {index} has no problem_id")

    scope_by_id = {
        row.get("scope_id", "").strip(): row
        for row in scopes
        if row.get("scope_id", "").strip()
    }
    for duplicate in _duplicates(
        [row.get("scope_id", "").strip() for row in scopes]
    ):
        errors.append(f"duplicate scope_id {duplicate}")

    source_gaps_path = root / "SOURCE_GAPS.md"
    source_gaps = (
        source_gaps_path.read_text(encoding="utf-8-sig")
        if source_gaps_path.exists()
        else ""
    )
    for row in scopes:
        scope_id = row.get("scope_id", "").strip()
        if row.get("status", "").strip() != "gap":
            continue
        if scope_id not in source_gaps:
            errors.append(f"gap {scope_id} is not documented in SOURCE_GAPS.md")
        if row.get("chapter", "").strip() or row.get("content_id", "").strip():
            errors.append(f"gap {scope_id} is bound to chapter or content_id")

    for row in problems:
        problem_id = row.get("problem_id", "").strip() or "<missing>"
        kind = row.get("kind", "").strip()
        if kind not in EXPECTED_COUNTS:
            errors.append(f"problem {problem_id} has unsupported kind {kind or '<missing>'}")
        if not row.get("answer_anchor", "").strip():
            errors.append(f"problem {problem_id} has no answer_anchor")
        for scope_id in _scope_ids(row.get("scope_ids", "")):
            scope = scope_by_id.get(scope_id)
            if scope is None:
                errors.append(f"problem {problem_id} references unknown scope_id {scope_id}")
            elif scope.get("status", "").strip() == "gap":
                errors.append(
                    f"problem {problem_id} references unresolved gap {scope_id}"
                )
        if not _scope_ids(row.get("scope_ids", "")):
            errors.append(f"problem {problem_id} has no scope_ids")

    review_ids = [row.get("problem_id", "").strip() for row in reviews]
    for duplicate in _duplicates(review_ids):
        errors.append(f"duplicate math review for {duplicate}")
    review_by_id = {
        row.get("problem_id", "").strip(): row
        for row in reviews
        if row.get("problem_id", "").strip()
    }
    for row in problems:
        if row.get("kind", "").strip() != "worked":
            continue
        problem_id = row.get("problem_id", "").strip()
        review = review_by_id.get(problem_id)
        if review is None:
            errors.append(f"worked problem {problem_id} has no math review")
            continue
        for field in REVIEW_FIELDS:
            if review.get(field, "").strip().lower() != "yes":
                errors.append(f"worked problem {problem_id} review field {field} is not yes")
        if not review.get("review_note", "").strip():
            errors.append(f"worked problem {problem_id} has no review_note")

    if not allow_incomplete:
        counts = scan_project(root)
        for kind, expected in EXPECTED_COUNTS.items():
            if counts[kind] != expected:
                errors.append(f"{kind} count {counts[kind]} does not equal {expected}")

    return errors


def main() -> int:
    parser = argparse.ArgumentParser(description="Validate handbook content ledgers.")
    parser.add_argument("root", type=Path)
    parser.add_argument("--allow-incomplete", action="store_true")
    args = parser.parse_args()

    try:
        counts = scan_project(args.root)
        errors = validate_project(args.root, args.allow_incomplete)
    except (OSError, csv.Error) as error:
        print(f"ERROR: {error}")
        return 1

    print(
        "WORKED={worked} QUICK={quick} EXERCISE={exercise} "
        "MOCK={mock} TOTAL={total}".format(**counts)
    )
    if errors:
        for error in errors:
            print(f"ERROR: {error}")
        return 1

    print("CONTENT_CHECK=PASS")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
