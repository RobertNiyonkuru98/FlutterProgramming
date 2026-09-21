#!/usr/bin/env python
"""Convert the ALU Part-1 planning markdown docs into clean, print-ready HTML."""
import os, re, html
import markdown

SRC = r"C:\Users\Richter Richard NAHO\TonyRobert98\FlutterProgramming\Assignments"
DOCS = ["Team-Tasks-Round1.md", "Phase-Playbook.md", "Part1-RUBRIC-CHECKLIST.md"]

CSS = """
:root{
  --ink:#16202b; --muted:#5a6b7b; --line:#dbe3ea; --soft:#f6f8fa;
  --accent:#0b6b5f; --accent-soft:#e6f2f0; --warn:#a8410d; --warn-soft:#fdf1e7;
  --hi:#8a1c1c; --hi-soft:#fdecec;
}
*{box-sizing:border-box}
body{
  font-family:"Segoe UI",-apple-system,BlinkMacSystemFont,Roboto,Helvetica,Arial,sans-serif;
  color:var(--ink); line-height:1.62; max-width:920px; margin:0 auto;
  padding:56px 40px 96px; background:#fff; font-size:15.5px;
  -webkit-print-color-adjust:exact; print-color-adjust:exact;
}
h1{font-size:2.05em; line-height:1.2; margin:0 0 .15em; letter-spacing:-.02em}
h1+h2{border:0; margin-top:.1em; color:var(--muted); font-weight:600; font-size:1.06em; padding:0}
h1+h2+h3{border:0;margin-top:.6em}
h2{
  font-size:1.42em; margin:2.2em 0 .7em; padding-top:.55em;
  border-top:2px solid var(--line); letter-spacing:-.01em;
}
h3{font-size:1.12em; margin:1.9em 0 .5em; color:var(--accent)}
h3:first-of-type{margin-top:1.1em}
p{margin:.72em 0}
a{color:var(--accent)}
strong{color:#0d1720}
hr{border:0;border-top:1px solid var(--line);margin:2.2em 0}
/* tables */
table{border-collapse:collapse; width:100%; margin:1.1em 0 1.5em; font-size:.92em}
th,td{border:1px solid var(--line); padding:9px 11px; text-align:left; vertical-align:top}
th{background:var(--soft); font-weight:650; font-size:.95em}
tbody tr:nth-child(even){background:#fbfcfd}
/* blockquotes */
blockquote{
  margin:1.3em 0; padding:14px 20px; border-left:4px solid var(--accent);
  background:var(--accent-soft); border-radius:0 6px 6px 0;
}
blockquote p{margin:.35em 0}
blockquote h3{margin-top:0; color:var(--accent)}
/* code */
code{
  background:#eef2f5; padding:2px 6px; border-radius:4px; font-size:.87em;
  font-family:"Cascadia Mono",Consolas,"SF Mono",Menlo,monospace;
}
pre{background:#f4f7f9; border:1px solid var(--line); border-radius:6px; padding:14px 16px; overflow-x:auto}
pre code{background:none; padding:0; font-size:.86em; line-height:1.5}
/* task lists */
ul li{margin:.3em 0}
input[type=checkbox]{margin-right:7px}
/* print */
@page{size:A4; margin:16mm 14mm}
@media print{
  body{padding:0; max-width:none; font-size:10.4pt; line-height:1.5}
  h2{page-break-after:avoid} h3{page-break-after:avoid}
  table,blockquote,pre{page-break-inside:avoid}
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

for name in DOCS:
    path = os.path.join(SRC, name)
    if not os.path.exists(path):
        print("MISSING:", name); continue
    with open(path, encoding="utf-8") as f:
        text = f.read()
    md = markdown.Markdown(extensions=["tables", "fenced_code", "sane_lists",
                                       "attr_list", "md_in_html", "nl2br"])
    body = md.convert(text)
    # GitHub-style task list checkboxes -> real, printable glyphs
    body = body.replace("[ ]", "\u2610").replace("[x]", "\u2611")
    title = re.sub(r"[#`*]", "", text.splitlines()[0])[:90]
    out = os.path.join(SRC, os.path.splitext(name)[0] + ".html")
    with open(out, "w", encoding="utf-8") as f:
        f.write(TPL.format(title=title, css=CSS, body=body))
    print("wrote:", os.path.basename(out), os.path.getsize(out), "bytes")
