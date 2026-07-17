from __future__ import annotations

import argparse
import math
from pathlib import Path

import fitz


def render_pdf(pdf: Path, out_dir: Path, dpi: int = 144) -> list[Path]:
    out_dir.mkdir(parents=True, exist_ok=True)
    for old_page in out_dir.glob("page-*.png"):
        old_page.unlink()
    contact_sheet = out_dir / "contact-sheet.png"
    if contact_sheet.exists():
        contact_sheet.unlink()

    scale = dpi / 72
    matrix = fitz.Matrix(scale, scale)
    rendered: list[Path] = []
    with fitz.open(pdf) as document:
        for index, page in enumerate(document, start=1):
            path = out_dir / f"page-{index:03d}.png"
            page.get_pixmap(matrix=matrix, alpha=False).save(path)
            rendered.append(path)

        if rendered:
            columns = 4
            gap = 8
            thumb_width = 240
            first_page = document[0].rect
            thumb_height = round(thumb_width * first_page.height / first_page.width)
            rows = math.ceil(len(rendered) / columns)
            sheet_width = columns * thumb_width + (columns + 1) * gap
            sheet_height = rows * thumb_height + (rows + 1) * gap
            with fitz.open() as sheet_pdf:
                sheet_page = sheet_pdf.new_page(
                    width=sheet_width,
                    height=sheet_height,
                )
                for index, image_path in enumerate(rendered):
                    row, column = divmod(index, columns)
                    left = gap + column * (thumb_width + gap)
                    top = gap + row * (thumb_height + gap)
                    rect = fitz.Rect(
                        left,
                        top,
                        left + thumb_width,
                        top + thumb_height,
                    )
                    sheet_page.insert_image(
                        rect,
                        filename=str(image_path),
                        keep_proportion=True,
                    )
                sheet_page.get_pixmap(alpha=False).save(contact_sheet)

    return rendered


def main() -> int:
    parser = argparse.ArgumentParser(description="Render a PDF and contact sheet.")
    parser.add_argument("pdf", type=Path)
    parser.add_argument("out_dir", type=Path)
    parser.add_argument("--dpi", type=int, default=144)
    args = parser.parse_args()

    try:
        pages = render_pdf(args.pdf, args.out_dir, args.dpi)
    except (OSError, RuntimeError, ValueError) as error:
        print(f"ERROR: {error}")
        return 1

    print(f"RENDERED_PAGES={len(pages)}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
