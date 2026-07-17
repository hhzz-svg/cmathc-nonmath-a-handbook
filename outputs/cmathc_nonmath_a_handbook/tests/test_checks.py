from __future__ import annotations

import csv
import sys
from pathlib import Path

import pytest
from pypdf import PdfWriter


PROJECT_ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(PROJECT_ROOT))

from scripts.check_content import validate_project
from scripts.check_page_count import check_page_count


def _write_pdf(path: Path, pages: int) -> None:
    writer = PdfWriter()
    for _ in range(pages):
        writer.add_blank_page(width=595, height=842)
    with path.open("wb") as handle:
        writer.write(handle)


def _write_csv(path: Path, fieldnames: list[str], rows: list[dict[str, str]]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open("w", encoding="utf-8", newline="") as handle:
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(rows)


def _write_project(
    root: Path,
    problems: list[dict[str, str]],
    reviews: list[dict[str, str]] | None = None,
    scopes: list[dict[str, str]] | None = None,
    source_gaps: str = "",
) -> None:
    references = root / "references"
    _write_csv(
        references / "problem-ledger.csv",
        [
            "problem_id",
            "chapter",
            "kind",
            "title",
            "scope_ids",
            "source_type",
            "source_ref",
            "answer_anchor",
            "difficulty",
            "minutes",
        ],
        problems,
    )
    _write_csv(
        references / "scope-matrix.csv",
        [
            "scope_id",
            "category",
            "official_item",
            "official_source",
            "chapter",
            "coverage_kind",
            "content_id",
            "verification_date",
            "status",
        ],
        scopes or [_scope("S-HM-000", "verified")],
    )
    _write_csv(
        references / "math-review.csv",
        [
            "problem_id",
            "recomputed",
            "conditions_checked",
            "endpoints_checked",
            "notation_checked",
            "review_note",
        ],
        reviews or [],
    )
    if source_gaps:
        (root / "SOURCE_GAPS.md").write_text(source_gaps, encoding="utf-8")


def _scope(scope_id: str, status: str) -> dict[str, str]:
    is_gap = status == "gap"
    return {
        "scope_id": scope_id,
        "category": "初赛-范围",
        "official_item": scope_id,
        "official_source": "SRC-CMS-18-PDF",
        "chapter": "" if is_gap else "第1章",
        "coverage_kind": "reference",
        "content_id": "" if is_gap else "R01-SCOPE",
        "verification_date": "2026-07-17",
        "status": status,
    }


def _problem(problem_id: str, kind: str, answer_anchor: str) -> dict[str, str]:
    return {
        "problem_id": problem_id,
        "chapter": "2",
        "kind": kind,
        "title": problem_id,
        "scope_ids": "S-HM-000",
        "source_type": "原创",
        "source_ref": "",
        "answer_anchor": answer_anchor,
        "difficulty": "2",
        "minutes": "5",
    }


def _review(problem_id: str) -> dict[str, str]:
    return {
        "problem_id": problem_id,
        "recomputed": "yes",
        "conditions_checked": "yes",
        "endpoints_checked": "yes",
        "notation_checked": "yes",
        "review_note": "independently checked",
    }


def test_page_count_rejects_94_pages(tmp_path: Path) -> None:
    pdf = tmp_path / "too-short.pdf"
    _write_pdf(pdf, 94)

    with pytest.raises(ValueError, match=r"page count 94 is outside 95\.\.110"):
        check_page_count(pdf)


def test_page_count_accepts_105_pages(tmp_path: Path) -> None:
    pdf = tmp_path / "accepted.pdf"
    _write_pdf(pdf, 105)

    assert check_page_count(pdf) == 105


def test_validate_project_reports_missing_answer_anchor(tmp_path: Path) -> None:
    _write_project(tmp_path, [_problem("Q02-01", "quick", "")])

    errors = validate_project(tmp_path, allow_incomplete=True)

    assert "problem Q02-01 has no answer_anchor" in errors


def test_validate_project_reports_wrong_worked_count(tmp_path: Path) -> None:
    problems = [
        _problem(f"W02-{index:02d}", "worked", f"answer-w02-{index:02d}")
        for index in range(1, 50)
    ]
    reviews = [_review(problem["problem_id"]) for problem in problems]
    _write_project(tmp_path, problems, reviews)

    errors = validate_project(tmp_path)

    assert "worked count 49 does not equal 50" in errors


def test_allow_incomplete_rejects_problem_bound_to_gap(tmp_path: Path) -> None:
    problem = _problem("Q02-01", "quick", "answer-q02-01")
    problem["scope_ids"] = "S-HM-GAP-001"
    _write_project(
        tmp_path,
        [problem],
        scopes=[_scope("S-HM-GAP-001", "gap")],
        source_gaps="S-HM-GAP-001",
    )

    errors = validate_project(tmp_path, allow_incomplete=True)

    assert "problem Q02-01 references unresolved gap S-HM-GAP-001" in errors


@pytest.mark.parametrize(
    ("problems", "expected"),
    [
        (
            [
                _problem("Q02-01", "quick", "answer-1"),
                _problem("Q02-01", "quick", "answer-2"),
            ],
            "duplicate problem_id Q02-01",
        ),
        (
            [
                {
                    **_problem("Q02-01", "quick", "answer-q02-01"),
                    "scope_ids": "S-HM-UNKNOWN",
                }
            ],
            "problem Q02-01 references unknown scope_id S-HM-UNKNOWN",
        ),
        (
            [_problem("W02-01", "worked", "answer-w02-01")],
            "worked problem W02-01 has no math review",
        ),
    ],
    ids=("duplicate-id", "unknown-scope", "missing-worked-review"),
)
def test_allow_incomplete_keeps_structural_checks(
    tmp_path: Path,
    problems: list[dict[str, str]],
    expected: str,
) -> None:
    _write_project(tmp_path, problems)

    errors = validate_project(tmp_path, allow_incomplete=True)

    assert expected in errors
