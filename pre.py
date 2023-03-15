#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0

"""Preprocesses the "book".
"""

import json
import pathlib
import re

def main():
    md_files_in_summary = set()
    mdbook_summary = ""
    json_summary = {}
    json_current_block = None
    json_current_section = None

    with open("SUMMARY.md", "r", encoding="utf-8") as f:
        for line in f:
            # Blank lines.
            if line == "\n":
                continue

            # The index/root link.
            if line == "[Rust for Linux](https://rust-for-linux.com)\n":
                md_files_in_summary.add("Rust-for-Linux.md")
                mdbook_summary += "[Rust for Linux](Rust-for-Linux.md)\n"
                continue

            # Blocks.
            match = re.match(r"^# (.*)$", line)
            if match:
                json_current_block = match[1]
                json_current_section = ""
                json_summary[json_current_block] = {}
                json_summary[json_current_block][json_current_section] = []
                continue

            # Titles.
            match = re.match(r"^## (.*)$", line)
            if match:
                json_current_section = match[1]
                json_summary[json_current_block][json_current_section] = []
                continue

            # Hidden links.
            match = re.match(r"^  - Hidden \[(.*)\]\((.*)\.md\)$", line)
            if match:
                md_files_in_summary.add(f"{match[2]}.md")
                mdbook_summary += f"  - [{match[1]}]({match[2]}.md)\n"
                continue

            # Chapter links.
            match = re.match(r"^  - \[(.*)\]\((.*)\.md\)$", line)
            if match:
                md_files_in_summary.add(f"{match[2]}.md")
                mdbook_summary += line
                json_summary[json_current_block][json_current_section].append((match[1], f"{match[2]}.html"))
                continue

            # External links.
            match = re.match(r"^  - \[(.*)\]\((.*)\)$", line)
            if match:
                json_summary[json_current_block][json_current_section].append((match[1], match[2]))
                continue

            raise RuntimeError("Unknown syntax")

    md_files_in_src = set(str(path.relative_to("src")) for path in pathlib.Path("src").glob("**/*.md"))
    md_files_in_src.discard("SUMMARY.md")
    if md_files_in_summary != md_files_in_src:
        raise AssertionError("Unmatched files in generated `SUMMARY.md` vs. `src` folder")

    with open("src/SUMMARY.md", "w", encoding="utf-8") as f:
        f.write(mdbook_summary)

    with open("summary.json", "w", encoding="utf-8") as f:
        json.dump(json_summary, f)

if __name__ == "__main__":
    main()
