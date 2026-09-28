#!/usr/bin/env python
"""Render empathy-map diagrams as PNGs, in the classic 2x2 quadrant layout.

    python make_empathy_maps.py

Writes to Empathy-Maps/ :
  01..04  one individual map per interviewed participant
  05      aggregated map over three behaviour segments
  06      blank template to fill in by hand

Every quotation is verbatim from its transcript. `...` marks an omission.
Run verify_md2html.py to prove each quotation against its source before submitting.
"""
import os
import sys
import time
from PIL import Image, ImageDraw, ImageFont

FAILED = []
OUT = os.path.join(os.path.dirname(os.path.abspath(__file__)), "Empathy-Maps")
W, H = 1600, 1150

NW = (40, 150, 700, 520)
NE = (900, 150, 1560, 520)
SW = (40, 555, 700, 925)
SE = (900, 555, 1560, 925)
CX, CY, CR = 800, 540, 108
STRIP = (40, 965, 1560, 1115)

TINT = {"SAYS": (219, 233, 247), "THINKS": (223, 240, 220),
        "DOES": (234, 243, 208), "FEELS": (251, 220, 220)}
EDGE = {"SAYS": (126, 168, 216), "THINKS": (150, 196, 143),
        "DOES": (172, 196, 108), "FEELS": (216, 140, 140)}

FONT_DIR = "C:/Windows/Fonts"


def font(size, bold=False):
    for name in (("arialbd.ttf", "segoeuib.ttf") if bold else ("arial.ttf", "segoeui.ttf")):
        try:
            return ImageFont.truetype(os.path.join(FONT_DIR, name), size)
        except OSError:
            continue
    return ImageFont.load_default()


def save(img, path, attempts=4):
    """Write the PNG, retrying a transient Windows lock.

    An image viewer, Word, or a chat window can hold the file open for a moment
    after it is displayed, which makes img.save() fail with EINVAL. Retry, then
    report the file by name rather than killing the whole run -- the other
    diagrams are still good.
    """
    err = None
    for attempt in range(attempts):
        try:
            img.save(path)
            print("wrote %-34s %s" % (os.path.basename(path), "%dx%d" % img.size))
            return True
        except OSError as e:
            err = e
            time.sleep(0.5 * (attempt + 1))
    FAILED.append((os.path.basename(path), err.strerror or str(err)))
    return False


def wrap(draw, text, f, width):
    words, lines, cur = text.split(), [], ""
    for word in words:
        trial = (cur + " " + word).strip()
        if draw.textlength(trial, font=f) <= width or not cur:
            cur = trial
        else:
            lines.append(cur)
            cur = word
    if cur:
        lines.append(cur)
    return lines


def block(draw, box, label, lines, size=16, gap=6, pad=16):
    x0, y0, x1, y1 = box
    draw.rounded_rectangle(box, 10, fill=TINT[label], outline=EDGE[label], width=3)
    draw.text((x0 + pad, y0 + pad), label, font=font(24, bold=True), fill=(40, 50, 60))
    y = y0 + pad + 40
    f = font(size)
    for line in lines:
        for wrapped in wrap(draw, line, f, (x1 - x0) - 2 * pad - 10):
            if y + size + 4 > y1 - pad:
                return
            draw.text((x0 + pad + 8, y), wrapped, font=f, fill=(35, 45, 55))
            y += size + gap
        y += 4


def strip(draw, cells):
    x0, y0, x1, y1 = STRIP
    w = (x1 - x0) // 4
    for i, (label, text) in enumerate(cells):
        bx = (x0 + i * w, y0, x0 + (i + 1) * w, y1)
        draw.rectangle(bx, fill=(245, 247, 249), outline=(180, 190, 200), width=2)
        draw.text((bx[0] + 12, y0 + 10), label, font=font(18, bold=True), fill=(40, 50, 60))
        f = font(14)
        y = y0 + 40
        for wrapped in wrap(draw, text, f, w - 28):
            if y + 18 > y1 - 8:
                break
            draw.text((bx[0] + 12, y), wrapped, font=f, fill=(60, 70, 80))
            y += 18


def render(path, heading, sublines, centre, quads, sensory):
    img = Image.new("RGB", (W, H), "white")
    d = ImageDraw.Draw(img)
    d.text((40, 34), heading, font=font(32, bold=True), fill=(25, 35, 45))
    y = 78
    for i, line in enumerate(sublines):
        d.text((40, y), line, font=font(16), fill=(110, 120, 130))
        y += 22

    block(d, NW, "SAYS", quads[0])
    block(d, NE, "THINKS", quads[1])
    block(d, SW, "DOES", quads[2])
    block(d, SE, "FEELS", quads[3])

    d.ellipse((CX - CR, CY - CR, CX + CR, CY + CR),
              fill=(255, 255, 255), outline=(90, 105, 120), width=4)
    f = font(19, bold=True)
    lines = wrap(d, centre, f, 2 * CR - 24)
    ty = CY - len(lines) * 12
    for line in lines:
        d.text((CX - d.textlength(line, font=f) / 2, ty), line, font=f, fill=(25, 35, 45))
        ty += 24

    strip(d, sensory)
    save(img, path)


REMOTE = ("SIGHTS", "Not in an audio transcript. Take from the video: room, environment, lighting. That frame is also the persona-card image.")


# ---------------------------------------------------------------- participants

STEF = [[
    '"I usually check because our insurance give us a list of hospitals they ... cover or pharmacies they cover"',
    '"No, I don\'t think I know them." (emergency hotlines)',
    '"in case of an emergency, I really don\'t know what I\'m going to do."',
    '"If you have all that in one place in ... form of an app, it\'s going to be way easier."',
    '"we might reach the pharmacy and then they don\'t have the particular drug you\'re looking for"',
], [
    '[inferred] The answer lives in two places: the insurer\'s list, then Google Maps',
    '[inferred] Verifying is my job, not the pharmacy\'s',
    '[inferred] A covered pharmacy that is out of stock is still a wasted journey',
    '[inferred] I have no plan for an emergency, and I know it',
], [
    'Keeps the insurer\'s covered-provider list as their reference point',
    'Cross-references it with Google Maps to find the nearest option',
    'Asks a friend or a school facilitator when they do not know',
    'Would Google the emergency number rather than know it',
    'Sat through Britam verification while a sick friend waited',
], [
    'Frustrated: could not speed up the paperwork while a friend suffered',
    'Unsettled about emergencies: resigned rather than confused',
    'Relieved by consolidation ("way easier", "that\'s a great idea")',
    'Positive about Rwanda itself, separately from the health system',
]]

KAMI = [[
    '"I have an international health insurance. However, one of the challenges is that many health clinics and hospitals in Rwanda do not accept my insurance directly."',
    '"When I presented my international insurance, they told me that they did not accept it. I had to pay for the consultation and any medication myself."',
    '"Sometimes I contact my insurance company first to find out which healthcare providers they work with. This can be inconvenient, especially when I need care urgently."',
    '"when I have needed medicine late at night, finding an open pharmacy can be challenging."',
    '"This can be stressful and expensive, especially for unexpected or emergency healthcare."',
    '"It would be helpful if more healthcare providers had direct agreements with international insurance companies"',
], [
    '[inferred] The problem is not the cover, it is the acceptance',
    '[inferred] I am my own claims department: receipts, documents, submit, wait',
    '[inferred] Cost is unpredictable and lands at the worst possible moment',
    '[inferred] I must resolve cover before I can be treated',
], [
    'Presents the international card; when refused, pays out of pocket',
    'Keeps receipts and medical documents to submit a reimbursement claim',
    'Contacts the insurer first to ask which providers they work with',
    'Weighs service quality against whether the clinic accepts their insurance',
    'Calls 112 for an ambulance, and the insurer\'s emergency assistance line',
], [
    '"This can be stressful and expensive" - cost anxiety',
    '"inconvenient, especially when I need care urgently" - the timing is the insult',
    'Let down: many clinics "do not recognize or accept my insurance"',
    'Clear about the remedy they want: direct agreements, and published acceptance info',
]]

KEVIN = [[
    '"for my health insurance, I use I use Britam."',
    '"there was RSSB, uh and then I switched from that and went to Old Mutual, and now currently I\'m using Britam."',
    '"the insurance is covered uh at at my work"',
    '"I pay on the very last minute. Uh, that\'s where they ask me what insurance I\'m using."',
    '"They write me the medicine, then I have to go to another pharmacy, you know, to take medicine."',
    '"It it was it was it was—I don\'t know, it\'s either 912 or 112."',
    '"I live near a pharmacy. I would just walk to that pharmacy."',
    '"I haven\'t been in a pharmacy like at night, but I would assume that they would be working 24/7."',
    '"What I would really love is if there was, you know, these kinds of delivery services."',
], [
    '[inferred] Insurance is a work benefit to be optimised, not a fixed fact',
    '[inferred] Paying last makes insurance an afterthought at the counter',
    '[inferred] The clinic and the pharmacy are two separate stops',
    '[inferred] If it is near and open, it will probably work',
    '[inferred] Delivery would solve it, but trust and fraud are the blockers',
], [
    'Chooses insurance by comparing workplace packages and benefits',
    'Walks into a small clinic first; escalates to a hospital if equipment is lacking',
    'Pays at the very end of the visit, when asked which insurance they use',
    'Takes the prescription to a separate pharmacy',
    'Would walk to the nearby pharmacy at night',
    'Would order medicine by delivery service if one existed',
], [
    'Familiar and unhurried about routine care: "That would be my usual"',
    'Genuinely uncertain about the emergency number',
    'Enthusiastic about delivery: "what I would really love"',
    'Cautious and realistic: anticipates fraud, wants "integrity"',
]]

JOSPIN = [[
    '"So currently, I\'m using … Mutuelle"',
    '"I had to visit the hospital for a quick full-body medical checkup. It was not just because I was sick; I just wanted to check up on my body."',
    '"it\'s more of the distance—where the hospital is located—than what kind of hospital it is."',
    '"I\'ve not used an ambulance before, but for a fact, I know it\'s 112—the ambulance number for Rwanda."',
    '"I\'ve had a bad experience with that."',
    '"It was more and more difficult to find an open pharmacy, and the hospital or clinic near me was also closed."',
    '"It was a bit challenging and a horrible experience."',
    '"instead of being treated first, they are asked for insurance."',
    '"you might lose a life during that process."',
], [
    '[inferred] Proximity is the real currency, especially at night',
    '[inferred] The system works, but the order of steps is wrong',
    '[inferred] Being asked for insurance before treatment is a risk to life',
    '[inferred] Night is when the system reliably fails',
], [
    'Uses Mutuelle',
    'Picks the hospital by distance from home, not by type',
    'Attended for preventive care: a full-body checkup, not illness',
    'Knows 112 for the ambulance',
    'At night: looks for an open pharmacy, then a clinic, then a distant hospital',
], [
    '"a horrible experience" - the strongest language in the whole dataset',
    'Grateful for the national scheme: "we give great thanks to the government"',
    'Indignant about insurance-before-treatment, framed as a moral failure',
    'Constructive: wants treatment first, cover verified in parallel',
]]

SENS_01 = [(REMOTE[0], REMOTE[1]),
           ("SOUNDS", "Repeated \"I don't know\", unprompted. A stall before answering. A warm, informal close about a choir recording and a birthday: they trust the interviewer."),
           ("FEELS", "Not in audio. From the video: posture, whether they lean in, hand movement during the hospital story."),
           ("SMELLS", "Not evidenced. Fill only if the interviewer honestly recalls it; otherwise state that the interview was remote.")]

SENS_02 = [(REMOTE[0], REMOTE[1]),
           ("SOUNDS", "Measured and reflective. Answers are well-formed and complete, with little hesitation - they have told this story before."),
           ("FEELS", "Not in audio. From the video: expression when describing the refusal at the clinic counter."),
           ("SMELLS", "Not evidenced. State that the interview was remote if nothing was observed.")]

SENS_03 = [(REMOTE[0], REMOTE[1]),
           ("SOUNDS", "Long hesitations and self-corrections. Searches for the word \"consultation\". Twice the question is repeated back instead of answering it - the emergency number question lands as unfamiliar."),
           ("FEELS", "Not in audio. From the video: hesitation before admitting they do not know the number."),
           ("SMELLS", "Not evidenced. State that the interview was remote if nothing was observed.")]

SENS_04 = [(REMOTE[0], REMOTE[1]),
           ("SOUNDS", "Emphatic and vivid: repeats for effect (\"more and more difficult\"), uses a folk comparison for the flu, and pauses to recall the time of night."),
           ("FEELS", "Not in audio. From the video: expression while describing the night they could not find medicine."),
           ("SMELLS", "Not evidenced. State that the interview was remote if nothing was observed.")]

SENS_AGG = [("SIGHTS", "Video frames per participant. Currently unevidenced - the front-door notices and the clinic counters are the images worth capturing."),
            ("SOUNDS", "Stephane hedges; Kevin hesitates and self-corrects; Kami is fluent; Jospin is emphatic. Confident fluency tracks with having used the system more."),
            ("FEELS", "Pending video review per participant."),
            ("SMELLS", "Record only if observed. Otherwise state that the interviews were remote.")]

AGG = [[
    '[A] "I look ... at the list and then I look for the one that\'s closest to my place." - Stephane',
    '[B] "many health clinics and hospitals in Rwanda do not accept my insurance directly" - Kami',
    '[C] "It was more and more difficult to find an open pharmacy, and the hospital or clinic near me was also closed." - Jospin',
], [
    '[A] The answer exists in two places and I have to reconcile them',
    '[B] My card is not accepted, so I pay now and claim later',
    '[C] At night, distance and whether it is open outrank everything else',
], [
    '[A] Checks the insurer\'s list, then Google Maps; keeps to a clinic they know',
    '[B] Presents the card, is refused, pays, keeps receipts, submits a claim',
    '[C] Walks to the nearest open place and settles cover at the counter',
], [
    '[A] Resigned - the process works, it just costs time',
    '[B] Stressed and out of pocket at the worst possible moment',
    '[C] Jospin: "a horrible experience"; anger that cover is asked for before care',
]]

os.makedirs(OUT, exist_ok=True)

PEOPLE = [
    ("01-individual-stephane.png", "Stephane Tchatchum",
     "Stephane Tchatchum | from Cameroon | 1 year in Rwanda | Britam | interviewed 27 Sep 2026, 16m16s | consent given on recording",
     ["Source: Google Meet transcript, 16m16s. Quotations are verbatim; `...` marks an omission. [inferred] lines are analysis, not quotations."],
     STEF, SENS_01),
    ("02-individual-kami.png", "Kami",
     "Kami | international health insurance | ALU student | interviewed 27 Sep 2026 | consent given on recording",
     ["Source: transcript via David. Quotations are verbatim. [inferred] lines are analysis, not quotations."],
     KAMI, SENS_02),
    ("03-individual-kevin.png", "Kevin",
     "Kevin | Britam (previously RSSB, then Old Mutual) | cover provided through their employer | last clinic visit c. 2 years ago",
     ["Source: transcript via David. Quotations are verbatim. [inferred] lines are analysis, not quotations."],
     KEVIN, SENS_03),
    ("04-individual-jospin.png", "Jospin",
     "Jospin | Mutuelle | ALU student | last hospital visit c. 2 months ago (Kibagabaga) | interviewed 27 Sep 2026",
     ["Source: transcript via David. Quotations are verbatim. [inferred] lines are analysis, not quotations."],
     JOSPIN, SENS_04),
]

for fname, centre, sub, subs, quads, sens in PEOPLE:
    render(os.path.join(OUT, fname), "Empathy Map - Individual", [sub] + subs, centre, quads, sens)

render(os.path.join(OUT, "05-aggregated.png"),
       "Empathy Map - Aggregated",
       ["Three behaviour segments, named by behaviour, drawn from four interviews: Stephane, Kami, Kevin, Jospin.",
        "Where all four converge: nobody could check cover before travelling; night access failed or was feared; two of four did not know the emergency number.",
        "[A] the list-crosser (Stephane, Kevin)   [B] the excluded cardholder (Kami)   [C] the nearest-open (Jospin, Kevin at night)."],
       "Aggregate", AGG, SENS_AGG)

render(os.path.join(OUT, "06-blank-template.png"),
       "Empathy Map - [Participant name]",
       ["[segment] | [origin] | [time in Rwanda] | [insurer] | interviewed [date], [duration] | consent: [yes/no]",
        "Fill only from the transcript or video. Never write what you think they would have said."],
       "[ Name ]", [[], [], [], []],
       [("SIGHTS", ""), ("SOUNDS", ""), ("FEELS", ""), ("SMELLS", "")])

if FAILED:
    print("\nCould not write %d diagram(s):" % len(FAILED))
    for name, why in FAILED:
        print("  %s  (%s)" % (name, why))
    print("\nA file that is open in an image viewer, a Word/PDF document, or a")
    print("chat window cannot be overwritten on Windows. Close it and re-run.")
    print("Anything already written above is current; only the listed files")
    print("are stale. Nothing has been deleted.")
    sys.exit(1)

print("\nAll diagrams in %s" % OUT)
