from __future__ import annotations

import argparse
from pathlib import Path

from pypdf import PdfReader


def check_page_count(path: Path, minimum: int = 95, maximum: int = 110) -> int:
    pages = len(PdfReader(str(path)).pages)
    if not minimum <= pages <= maximum:
        raise ValueError(f"page count {pages} is outside {minimum}..{maximum}")
    return pages


def main() -> int:
    parser = argparse.ArgumentParser(description="Check a PDF page-count range.")
    parser.add_argument("pdf", type=Path)
    parser.add_argument("--minimum", type=int, default=95)
    parser.add_argument("--maximum", type=int, default=110)
    args = parser.parse_args()

    try:
        pages = check_page_count(args.pdf, args.minimum, args.maximum)
    except (OSError, ValueError) as error:
        print(f"ERROR: {error}")
        return 1

    print(f"PAGE_COUNT={pages}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
