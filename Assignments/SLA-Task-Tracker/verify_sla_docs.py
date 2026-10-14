#!/usr/bin/env python
"""Repeatable verification entry point for the SLA-Task-Tracker planning docs.

    python verify_sla_docs.py        # exit 0 = pass, non-zero = fail

DOCS is imported straight from md2html_sla so the generator and this checker
cannot drift. Covers the generator's output contract, proves the checker can
fail (temp sandbox), and validates the screen-flow SVG. Does NOT cover the
prose in the .md files.
"""
import hashlib
import os
import shutil
import subprocess
import sys
import tempfile
import time
import xml.etree.ElementTree as ET

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
import md2html_sla as gen  # noqa: E402

CHROME = r"C:\Program Files\Google\Chrome\Application\chrome.exe"
GEN = os.path.join(HERE, "md2html_sla.py")
SVG = os.path.join(HERE, "SLA-Tracker-Screen-Flow.svg")
OUTS = [os.path.splitext(d)[0] + ".html" for d in gen.DOCS]
SCREENS = ["Sign In / User Selection", "Dashboard  (home)", "Task List", "Task Details",
           "Create / Edit Task", "Team Members", "Profile", "Insights",
           "SLA Rules & Thresholds", "Activity Log"]

fails = []


def check(name, ok, detail=""):
    print(("PASS  " if ok else "FAIL  ") + name + (f"   :: {detail}" if detail else ""))
    if not ok:
        fails.append(name)


def sha(p):
    with open(p, "rb") as f:
        return hashlib.sha256(f.read()).hexdigest()


def run(*cmd, **kw):
    return subprocess.run(cmd, capture_output=True, text=True, **kw)


# ---- 1. generator contract: clean exit, one output per doc, deterministic, fresh ----
t0 = time.time()
r = run(sys.executable, GEN, cwd=HERE)
check("generator exits 0", r.returncode == 0, (r.stdout + r.stderr).strip().replace("\n", " | "))
check("one html per doc", all(os.path.exists(os.path.join(HERE, o)) for o in OUTS), OUTS)

first = {o: sha(os.path.join(HERE, o)) for o in OUTS}
run(sys.executable, GEN, cwd=HERE)
check("output deterministic across runs", first == {o: sha(os.path.join(HERE, o)) for o in OUTS})
check("outputs fresh (mtime >= t0)", all(os.path.getmtime(os.path.join(HERE, o)) >= t0 for o in OUTS))
check("no stray .html", sorted(f for f in os.listdir(HERE) if f.endswith(".html")) == sorted(OUTS))

for o in OUTS:
    txt = open(os.path.join(HERE, o), encoding="utf-8").read()
    check(f"{o}: html passed through, not escaped", '<div class="meta">' in txt and "&lt;div" not in txt)
    check(f"{o}: tables rendered", "<table>" in txt and "</html>" in txt)

# ---- 2. prove the checker can fail (sandbox, never in place) ----
sb = tempfile.mkdtemp(prefix="hermes-verify-")
try:
    for f in ["md2html_sla.py"] + gen.DOCS:
        shutil.copy(os.path.join(HERE, f), sb)
    p = os.path.join(sb, "md2html_sla.py")
    src = open(p, encoding="utf-8").read().replace(
        f'"{gen.DOCS[0]}",', f'"DOES-NOT-EXIST.md", "{gen.DOCS[0]}",', 1)
    open(p, "w", encoding="utf-8").write(src)
    before = sha(os.path.join(HERE, gen.DOCS[0]))
    rn = run(sys.executable, p)
    check("negative: missing doc -> non-zero exit", rn.returncode != 0, rn.returncode)
    check("negative: names the offending file", "DOES-NOT-EXIST.md" in rn.stdout + rn.stderr)
    check("negative: real folder untouched", sha(os.path.join(HERE, gen.DOCS[0])) == before)
finally:
    shutil.rmtree(sb, ignore_errors=True)

# ---- 3. screen-flow SVG ----
root = ET.parse(SVG).getroot()
check("svg is xml + 1500x900", root.tag.endswith("svg") and (root.get("width"), root.get("height")) == ("1500", "900"))
text = "".join(root.itertext())
check("svg has every screen", all(s in text for s in SCREENS), [s for s in SCREENS if s not in text])

if os.path.exists(CHROME):
    png = os.path.join(tempfile.gettempdir(), "hermes-verify-flow.png")
    run(CHROME, "--headless=new", "--disable-gpu", "--hide-scrollbars", "--force-device-scale-factor=1.4",
        "--window-size=1500,900", "--default-background-color=FFFFFFFF", f"--screenshot={png}",
        "file:///" + SVG.replace("\\", "/").replace(" ", "%20"))
    ok = os.path.exists(png) and os.path.getsize(png) > 20000
    check("chrome rasterises svg", ok, f"{os.path.getsize(png)} bytes" if ok else "missing")
    if ok:
        os.remove(png)
else:
    print("SKIP  chrome raster check (chrome not found)")

print()
print("RESULT:", "ALL PASS" if not fails else f"{len(fails)} FAILED -> {fails}")
sys.exit(1 if fails else 0)
