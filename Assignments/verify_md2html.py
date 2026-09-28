#!/usr/bin/env python
"""Regression check for the Assignments folder.

    python verify_md2html.py

Two independent phases:

  1. GENERATOR - for every doc in md2html.py's DOCS list: the generator exits
     clean, writes exactly one .html per doc, output is deterministic across
     two runs, and every .html is newer than md2html.py.

  2. QUOTE PROVENANCE - every quotation in Empathy-Maps-REAL.md and in
     make_empathy_maps.py must appear verbatim in one of the interview
     transcripts, or in the team's own briefing document. `...` marks a
     deliberate omission; each fragment on either side must still match
     exactly. This is the guard against a quote being tidied up, paraphrased,
     or invented.

Exits non-zero on the first failure so it can gate a commit.
"""
import hashlib, os, re, subprocess, sys

SRC = os.path.dirname(os.path.abspath(__file__))
GEN = os.path.join(SRC, "md2html.py")

# every participant transcript, so a quotation is checked against a real source
SOURCES = [
    ("stephane", "Stephane Tchachum Interview Session 20260927 1830 CAT.pdf"),
    ("kami", "Transcripts/02-kami.txt"),
    ("kevin", "Transcripts/03-kevin.txt"),
    ("jospin", "Transcripts/04-jospin.txt"),
]
BRIEFING = "FIELDWORK.pdf"
QUOTE_FILES = ["Empathy-Maps-REAL.md", "make_empathy_maps.py", "Personas.md"]

# an omission may be written either way: unicode ellipsis or three periods
OMISSION = re.compile(r"\s*(?:\u2026|\.\.\.)\s*")
LABELS = {"says", "thinks", "does", "feels", "sights", "sounds", "smells"}


def norm(s):
    """Fold whitespace and curly quotes so line-wrapping cannot hide a mismatch."""
    s = " ".join((l.lstrip()[1:].lstrip() if l.lstrip().startswith(">") else l) for l in s.splitlines())
    return re.sub(r"\s+", " ", s).lower().strip().replace("\u2019", "'")


def run():
    return subprocess.run([sys.executable, GEN], cwd=SRC, capture_output=True, text=True)


def docs():
    m = re.search(r"^DOCS\s*=\s*\[(.*?)\]", open(GEN, encoding="utf-8").read(), re.M)
    return [n[:-3] for n in re.findall(r'"([^"]+\.md)"', m.group(1))]


def digests(names):
    return {n: hashlib.sha256(open(os.path.join(SRC, n + ".html"), "rb").read()).hexdigest()
            for n in names}


def source_text(rel):
    """Text of a transcript or briefing, from PDF or plain text."""
    path = os.path.join(SRC, rel)
    if rel.lower().endswith(".pdf"):
        cached = os.path.join(SRC, "_extract", os.path.splitext(os.path.basename(rel))[0] + ".txt")
        if not os.path.exists(cached):
            os.makedirs(os.path.dirname(cached), exist_ok=True)
            subprocess.run(["pdftotext", "-layout", path, cached], check=True)
        return open(cached, encoding="utf-8", errors="replace").read()
    return open(path, encoding="utf-8", errors="replace").read()


def phase_generator():
    names = docs()
    print("PHASE 1 - generator (%d docs)" % len(names))

    p = run()
    if p.returncode or "Traceback" in p.stderr or "MISSING" in p.stdout:
        reason = ([l.strip() for l in p.stdout.splitlines() if "MISSING" in l]
                  or p.stderr.strip().splitlines()[-1:] or ["exit code %s" % p.returncode])
        print("  FAIL generator: %s" % "; ".join(reason))
        return False
    if p.stdout.count("wrote:") != len(names):
        print("  FAIL wrote %d files, expected %d" % (p.stdout.count("wrote:"), len(names)))
        return False

    first = digests(names)
    run()
    if digests(names) != first:
        print("  FAIL output is not deterministic across runs")
        return False

    late = [n for n in names
            if os.path.getmtime(os.path.join(SRC, n + ".html")) <= os.path.getmtime(GEN)]
    if late:
        print("  FAIL these outputs predate the generator: %s" % late)
        return False

    print("  ok   deterministic, one output per doc, generator predates all outputs")
    return True


def extract_quotes(rel):
    """Quotations from a markdown doc or from the diagram script.

    Markdown uses *"..."*. In Python, a participant quotation is written as a
    single-quoted string whose content begins with a double quote, optionally
    behind a segment marker such as [A]. Labels ("SAYS"), inferred lines
    ("[inferred]") and sensory notes carry no embedded double-quoted span and
    are therefore not mistaken for quotations.
    """
    text = open(os.path.join(SRC, rel), encoding="utf-8").read()
    if rel.endswith(".md"):
        return re.findall(r'\*"([^"]+)"\*', text)

    found = []
    for literal in re.findall(r"'((?:\\'|[^'])*)'", text):
        body = re.sub(r"^\[[A-Z]\]\s*", "", literal)
        if not body.startswith('"'):
            continue
        m = re.match(r'"((?:\\\'|[^"])*)"', body)
        if m:
            quote = m.group(1).replace("\\'", "'")
            if norm(quote) not in LABELS:
                found.append(quote)
    return found


def phase_quotes():
    print("\nPHASE 2 - quote provenance")
    paths = [f for f in QUOTE_FILES if os.path.exists(os.path.join(SRC, f))]
    if not paths:
        print("  skip no quote-bearing files found")
        return True

    corpus = [(name, norm(source_text(rel))) for name, rel in SOURCES if
              os.path.exists(os.path.join(SRC, rel))]
    briefing = norm(source_text(BRIEFING))
    if not corpus:
        print("  skip no transcripts found")
        return True

    verified, sourced, bad = {}, 0, 0
    for rel in paths:
        for q in extract_quotes(rel):
            frags = [f for f in OMISSION.split(norm(q)) if f]
            hit = next((name for name, text in corpus if all(f in text for f in frags)), None)
            if hit:
                verified[hit] = verified.get(hit, 0) + 1
            elif frags and all(f in briefing for f in frags):
                sourced += 1
            else:
                bad += 1
                print("  FAIL untraceable in %s: %r" % (os.path.basename(rel), q[:66]))
                for f in frags:
                    if not any(f in text for _, text in corpus):
                        print("       not in any transcript: %r" % f[:76])

    for name, count in sorted(verified.items()):
        print("  ok   %-10s %d quotes verbatim" % (name, count))
    print("  ok   %-10s %d quotes verbatim" % ("TOTAL", sum(verified.values())))
    if sourced:
        print("  ok   briefing   %d quotes from the team's own document" % sourced)
    if bad:
        print("  FAIL %d quotation(s) cannot be traced to any source" % bad)
        return False
    return True


def main():
    ok = phase_generator() and phase_quotes()
    print("\n%s" % ("PASS  generator + quote provenance" if ok else "FAILED"))
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
