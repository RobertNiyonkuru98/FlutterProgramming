#!/usr/bin/env python
"""Render the PulseTrack planning markdown into self-contained, print-ready HTML.

Run from this folder:  python md2html_sla.py
Writes a sibling .html per doc in DOCS (shared CSS, no external assets).
"""
import os
import re
import sys

import markdown

SRC = os.path.dirname(os.path.abspath(__file__))
DOCS = [
    "SLA-Tracker-Team-Plan.md",
    "SLA-Tracker-Stitch-Prompt-Pack.md",
    "Roberts-Task-Workout.md",
]

CSS = """
:root{
  --ink:#10182b; --muted:#5b6b7f; --line:#dde5ee; --soft:#f7f9fc;
  --brand:#1D3B8B; --brand-soft:#eaeefb; --accent:#F97316; --accent-soft:#fef2e8;
  --green:#12A150; --green-soft:#E6F6EC;
  --amber:#B3780F; --amber-soft:#FDF3E0;
  --red:#D92D20; --red-soft:#FDECEA;
  --slate:#54637A; --slate-soft:#EEF1F5;
}
*{box-sizing:border-box}
body{
  font-family:"Segoe UI",-apple-system,BlinkMacSystemFont,Inter,Roboto,Helvetica,Arial,sans-serif;
  color:var(--ink); line-height:1.65; max-width:940px; margin:0 auto;
  padding:56px 44px 100px; background:#fff; font-size:15.5px;
  -webkit-print-color-adjust:exact; print-color-adjust:exact;
}
h1{font-size:2.1em; line-height:1.18; margin:0 0 .1em; letter-spacing:-.025em; color:var(--brand)}
h1+h2{border:0; margin-top:.35em; color:var(--muted); font-weight:600; font-size:1.02em; padding:0}
h1+h2+h3{border:0;margin-top:.7em}
h2{font-size:1.38em; margin:2.4em 0 .7em; padding-top:.6em;
   border-top:2px solid var(--line); letter-spacing:-.012em; color:var(--brand)}
h3{font-size:1.1em; margin:1.9em 0 .5em; color:#14225a}
h3:first-of-type{margin-top:1.1em}
p{margin:.72em 0}
a{color:var(--brand); word-break:break-word}
strong{color:#0b1220}
hr{border:0;border-top:1px solid var(--line);margin:2.3em 0}
hr+h2{border-top:0; margin-top:1.3em}
ul,ol{margin:.6em 0 .9em; padding-left:1.35em}
li{margin:.32em 0}
/* tables */
table{border-collapse:collapse; width:100%; margin:1.15em 0 1.6em; font-size:.91em}
th,td{border:1px solid var(--line); padding:9px 11px; text-align:left; vertical-align:top}
th{background:var(--soft); font-weight:650; font-size:.94em; color:#14225a}
tbody tr:nth-child(even){background:#fbfcfe}
/* blockquotes / callouts */
blockquote{margin:1.4em 0; padding:14px 20px; border-left:4px solid var(--accent);
  background:var(--accent-soft); border-radius:0 8px 8px 0}
blockquote p{margin:.35em 0}
blockquote strong{color:#8a3d05}
/* code */
code{background:#eef2f7; padding:2px 6px; border-radius:4px; font-size:.87em;
  font-family:"Cascadia Mono",Consolas,"SF Mono",Menlo,monospace; color:#14225a}
pre{background:#0f1830; border:0; border-left:4px solid var(--accent); border-radius:8px;
  padding:16px 18px; overflow-x:auto; margin:1.1em 0}
pre code{background:none; padding:0; font-size:.845em; line-height:1.6; color:#e8eefc}
/* meta banner + footer */
.meta{background:var(--brand-soft); border:1px solid #d5ddf7; border-left:4px solid var(--brand);
  border-radius:0 8px 8px 0; padding:14px 18px; margin:1.4em 0 1.8em; font-size:.93em; color:#1b2a5c}
.footer{margin-top:3em; padding-top:1em; border-top:1px solid var(--line);
  color:var(--muted); font-size:.85em; text-align:center}
/* print */
@page{size:A4; margin:15mm 13mm}
@media print{
  body{padding:0; max-width:none; font-size:10.2pt; line-height:1.48}
  h2{page-break-after:avoid} h3{page-break-after:avoid}
  table,blockquote,pre{page-break-inside:avoid}
  pre{background:#f4f7fb; border-left:4px solid var(--accent)}
  pre code{color:#12203f}
  a{color:var(--ink); text-decoration:none}
}
"""

TPL = """<!DOCTYPE html>
<html lang="en"><head><meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>{title}</title>
<style>{css}</style>
</head><body>
{body}
</body></html>"""


def main():
    missing = [n for n in DOCS if not os.path.exists(os.path.join(SRC, n))]
    if missing:
        for n in missing:
            print("MISSING:", n)
        return 1

    failures = []
    for name in DOCS:
        path = os.path.join(SRC, name)
        with open(path, encoding="utf-8") as f:
            text = f.read()
        md = markdown.Markdown(extensions=[
            "tables", "fenced_code", "sane_lists", "attr_list",
            "md_in_html", "nl2br",
        ])
        body = md.convert(text)
        body = body.replace("[ ]", "\u2610").replace("[x]", "\u2611")
        title = re.sub(r"[#`*]", "", text.splitlines()[0])[:90]
        out = os.path.join(SRC, os.path.splitext(name)[0] + ".html")
        try:
            with open(out, "w", encoding="utf-8") as f:
                f.write(TPL.format(title=title, css=CSS, body=body))
        except OSError as e:  # transient Windows file lock
            failures.append((name, str(e)))
            print("LOCKED/FAILED:", name, e)
            continue
        print("wrote:", os.path.basename(out), os.path.getsize(out), "bytes")

    return 1 if failures else 0


if __name__ == "__main__":
    sys.exit(main())
