# PulseTrack — Google Stitch Prompt Pack
### Copy-paste prompts that generate the full 10-screen UI

<div class="meta">
<b>Tool:</b> Google Stitch (stitch.withgoogle.com) · <b>Device:</b> Mobile · <b>Output:</b> 10 screens → export to Figma → hand to the Flutter developers<br>
<b>Read §1 and §2 first — they stop you wasting a day.</b>
</div>

---

## 1. Stitch in 90 seconds (you have never used it — here is the whole thing)

1. Go to **stitch.withgoogle.com**, sign in with a Google account.
2. Create a project, set **Device = Mobile**. Pick **Android / Material 3** if asked.
3. There is a prompt box. You type a description, it generates a screen. **One screen per prompt works far better than one giant prompt.**
4. Switch to **Experimental mode** (Gemini-powered) for the complex screens — Dashboard, Task Details, SLA Rules. Standard mode is fine for simple list screens.
5. Under each generated screen there is an input to **refine**: "make the badges pill-shaped", "add an empty state", "darken the header". Iterate 2–3 times per screen. Do not accept the first render.
6. When happy: **select the screen → "Copy to Figma"** (see §6).
7. Stitch has a **free daily generation limit**. Do not burn generations re-rolling for taste — generate, then refine, then move on.

### Five rules that make Stitch prompts work

| Rule | Why |
|---|---|
| **Name the platform and the grid** — "mobile screen, 8pt grid, 16px margins" | Stitch otherwise guesses desktop proportions |
| **Give the palette as hex values** | Vague colour words ("modern blue") produce a different blue every screen |
| **Describe the layout top-to-bottom, in order** | Stitch follows the order you write in |
| **Name every label and its exact text** | You get 'Project Health', not 'some card title' |
| **One prompt per screen, and re-state the style in each** | Stitch does not reliably carry a style across separate generations |

---

## 2. The design system (this is your house style)

| Token | Value | Used for |
|---|---|---|
| Brand primary | `#1D3B8B` | buttons, active nav, selected chip, headers |
| Accent | `#F97316` | FAB, highlights, progress fill |
| Background | `#F5F7FB` | screen background |
| Surface | `#FFFFFF` | cards |
| Border | `#E2E8F0` | 1px card/field borders |
| Ink | `#0F172A` | primary text |
| Muted | `#64748B` | secondary text, labels |
| **On Track** | `#12A150` on `#E6F6EC` | SLA badge |
| **At Risk** | `#E8A317` on `#FDF3E0` | SLA badge |
| **Overdue** | `#D92D20` on `#FDECEA` | SLA badge |
| **Completed** | `#64748B` on `#EEF1F5` | SLA badge |
| Font | **Inter** | titles 20px semi-bold, body 14px |
| Radii | cards 16px · badges 999px · buttons 12px · inputs 12px | |
| Icons | rounded outlined Material Symbols | |
| Avatars | circle, initials, tinted background | |

> **Say this in the demo if asked about the palette:** red/amber/green for SLA status is a deliberate domain convention — a manager reads the colour before the word. The brand navy and orange sit outside that set so they can never be confused with a status.

---

## 3. PROMPT 0 — run this first (it generates the Dashboard and sets the tone)

```
Design a mobile app UI for a software-team task tracker called "PulseTrack".

PLATFORM: mobile app screen, 390 x 844, Material 3, 8pt spacing grid, 16px screen margins.

STYLE: modern, clean, professional productivity tool. Not playful, not corporate-sterile.
Background #F5F7FB. Cards are white, 16px corner radius, 1px #E2E8F0 border, soft subtle shadow, 16px internal padding.
Primary colour deep navy #1D3B8B. Accent orange #F97316. Body text #0F172A, secondary text #64748B.
Typography: Inter. Screen titles 20px semibold. Card titles 15px semibold. Body 14px. Captions 12px #64748B.

SIGNATURE COMPONENTS:
- SLA status badge: pill shape (fully rounded), soft tinted background, small 6px solid dot before the label, 12px medium text.
  On Track = green text #12A150 on #E6F6EC. At Risk = amber text #E8A317 on #FDF3E0.
  Overdue = red text #D92D20 on #FDECEA. Completed = slate text #64748B on #EEF1F5.
- Circular avatar with initials on a tinted background.
- Rounded outlined Material icons.

BOTTOM NAVIGATION: 4 tabs - Home, Tasks, Team, Profile. Active tab is navy with a filled icon, inactive is grey.

SCREEN: Dashboard.
- App bar: hamburger menu icon on the left, title "Dashboard", a bell icon with a small red dot badge on the right. White app bar, no shadow, 1px bottom border.
- Greeting block: "Good morning, John" in 22px semibold, and beneath it "Here's what's happening with your project." in 14px muted.
- Four KPI cards in a 2x2 grid. Each has a rounded tinted icon circle top-left, a large bold number, and a small label underneath:
  Total Tasks 12 (navy icon), On Track 5 (green), At Risk 3 (amber), Overdue 2 (red).
- A full-width card titled "Project Health": a circular ring gauge in the centre showing 78 out of 100 with a navy-to-green arc, the label "Health Score" and a caption "Based on the SLA status of 12 tasks".
- A full-width card titled "Task Overview": a donut chart with a legend of four rows - green dot On Track 5, amber dot At Risk 3, red dot Overdue 2, slate dot Completed 2.
- A full-width card titled "Attention Needed": two list rows, each showing a task title, its due date in muted 12px, and an SLA status badge on the right, with a chevron.
- A section titled "Recent Activity" with three rows: circular avatar, text like "Sarah updated UI Design", and a muted timestamp "2 hours ago".
- Orange rounded floating action button with a plus icon, bottom right.
```

---

## 4. PROMPT 1 — Sign In / Sign Up / User Selection

```
Mobile app screen, same PulseTrack style as before: background #F5F7FB, white cards 16px radius with 1px #E2E8F0 borders, primary navy #1D3B8B, accent orange #F97316, Inter font, 16px screen margins.

SCREEN: Sign In.
- Top area with generous whitespace: a rounded-square app icon (navy background, white pulse-waveform glyph, 20px radius), the app name "PulseTrack" in 26px bold navy, and the tagline "Plan. Track. Deliver." in 13px muted letter-spaced.
- Card containing a form:
  - Heading "Welcome back" 18px semibold, subtext "Sign in to continue" 13px muted.
  - Field "Email" with a rounded outlined text input, an envelope icon on the left, hint text "you@company.com".
  - Field "Password" with a rounded outlined text input, a lock icon on the left, a visibility eye toggle on the right, hint text "••••••••".
  - Below the email field show a validation error state on ONE field as a second variant: red 1px outline, red helper text "Enter a valid email address", and a small red alert icon.
  - Primary navy full-width button "Sign In" with 12px radius.
  - Centred muted line: "Don't have an account?  Sign Up" with "Sign Up" in navy semibold.
- Below the card, a divider with the centred label "or continue as".
- A horizontal row of four circular avatars with initials and the first name beneath each (John, Sarah, Mike, Emily). One avatar has a navy ring and a small check badge to show it is selected.
- A ghost link at the very bottom: "Manage team".
No system status bar content. Clean, airy, lots of whitespace.
```

---

## 5. PROMPT 2 — Task List

```
Mobile app screen, same PulseTrack style: background #F5F7FB, white cards 16px radius with 1px #E2E8F0 borders, primary navy #1D3B8B, accent orange #F97316, Inter font, 16px margins.

SCREEN: Task List.
- App bar: hamburger menu left, title "Tasks", a filter icon with a small navy badge dot on the right.
- A search field: rounded filled #FFFFFF with a 1px border, search icon left, hint "Search tasks...".
- A horizontally scrollable row of filter chips: "All" (selected, navy background, white text), then "On Track", "At Risk", "Overdue", "Completed" - unselected chips are white with a 1px border and dark text. The "On Track" chip is shown in its green tint, "At Risk" in amber tint, "Overdue" in red tint.
- A sort control row: left label "12 tasks", right small text button "Sort: Due date" with a chevron.
- A vertical list of 5 task cards. Each card is a white 16px-radius card with a 6px vertical accent bar down the LEFT edge coloured by SLA status, and contains:
  - top row: task title in 15px semibold on the left, and an SLA status badge on the right
  - second row: a small muted project label with a folder icon, e.g. "UI/UX Design"
  - third row: a priority pill ("High" in a soft red pill, "Medium" in a soft amber pill), a due date with a calendar icon "10 Dec 2024", and an assignee avatar with initials on the far right
  Example rows: "Design Login Screen" / UI/UX Design / High / On Track. "Implement Local Storage" / Mobile Development / Medium / At Risk. "Create Task Model" / Backend (Local) / Low / Overdue. "Test Application" / Quality Assurance / Medium / To Do. "Prepare Demo" / Documentation / Low / To Do.
- Also show a second variant of this screen: the EMPTY STATE - a dashed rounded illustration of a checklist, heading "No tasks match your filter", muted subtext "Try a different filter or create a new task", and a navy outline button "Clear filters".
- Orange rounded-square floating action button with a plus icon, bottom right, casting a soft shadow.
```

---

## 6. PROMPT 3 — Task Details (use Experimental mode)

```
Mobile app screen, same PulseTrack style: background #F5F7FB, white cards 16px radius with 1px #E2E8F0 borders, primary navy #1D3B8B, accent orange #F97316, Inter font, 16px margins.

SCREEN: Task Details.
- App bar: back chevron left, title "Task Details", a three-dot overflow menu right.
- Header block: the task title "Design Login Screen" in 22px bold, and on the same line to the right an SLA status badge "On Track" (green pill, soft #E6F6EC background).
- Card "Overview" with four label/value rows separated by hairline dividers:
  - "Assigned To" - circular avatar with initials plus the name "Sarah Lee"
  - "Due Date" - calendar icon plus "10 Dec 2024"
  - "Priority" - a red-tinted pill "High"
  - "Status" - a field showing "In Progress" with a dropdown chevron
- Card "SLA Status": a banner with a soft green #E6F6EC background and a 4px green left border containing a large badge "On Track", a sentence "The task is progressing as expected - 42% of the allotted window has elapsed." and a thin horizontal time-elapsed progress bar that is 42% filled in green, with small muted caption beneath: "Deadline in 3 days".
- Card "Notes": a multiline note placeholder text "Add any additional notes...".
- Sticky bottom bar with two buttons: a full-width navy primary button "Edit Task" and a ghost outlined button "Mark Complete".
- Also show a second variant of the SLA Status card for an At Risk task: soft amber #FDF3E0 background, 4px amber left border, amber badge "At Risk", sentence "The deadline is approaching - 78% of the allotted window has elapsed."
```

---

## 7. PROMPT 4 — Create / Edit Task

```
Mobile app screen, same PulseTrack style: background #F5F7FB, white card 16px radius with 1px #E2E8F0 borders, primary navy #1D3B8B, accent orange #F97316, Inter font, 16px margins.

SCREEN: Create Task.
- App bar: back chevron left, title "Create Task". No other actions.
- A single white card holding a vertical form. Every field has a 13px semibold label ABOVE the input:
  1. "Task Title" - rounded outlined text input, hint "Enter task title", with a small red asterisk on the label.
  2. "Description" - rounded outlined multiline textarea, 3 lines, hint "Enter task description".
  3. "Project" - rounded dropdown field showing "UI/UX Design" with a chevron.
  4. "Assign To" - rounded dropdown field showing an avatar with initials plus "Select team member".
  5. "Due Date" - rounded outlined field with a calendar icon on the right, showing "Select date".
  6. "Priority" - a segmented control with four options: Low, Medium (selected, navy), High, Critical.
  7. "Status" - rounded dropdown field showing "To Do".
  8. "Progress" - a horizontal slider at 0% with a small % value at the right end.
- Show the validation error state on TWO fields as a second variant: "Task Title" has a red 1px outline with red helper text "Title is required" and a red alert icon, and "Due Date" has a red outline with red helper text "Due date must be in the future".
- Bottom: a full-width navy button "Create Task" with 12px radius, plus a ghost text button "Cancel" beneath it.
```

---

## 8. PROMPT 5 — Team Members

```
Mobile app screen, same PulseTrack style: background #F5F7FB, white cards 16px radius with 1px #E2E8F0 borders, primary navy #1D3B8B, accent orange #F97316, Inter font, 16px margins.

SCREEN: Team Members.
- App bar: hamburger menu left, title "Team Members", a search icon right.
- A summary strip of three small rounded stat chips in a row: "4 Members" (navy tint), "12 Open" (slate tint), "2 Overdue" (red tint). Each has a big number and a small label.
- A vertical list of member cards. Each card: a large circular avatar with initials on a tinted background on the left, the member's full name in 15px semibold, their role in 13px muted beneath it, and on the right side three small stacked status pills showing counts - a green pill with a number for tasks on track, an amber pill for at risk, a red pill for overdue. A three-dot overflow menu at the far right of each card.
  Members: John Doe - Project Manager. Sarah Lee - UI/UX Designer. Mike Kim - Mobile Developer. Emily Wong - QA Tester. David Liu - Documentation.
- Below the list, a muted section label "Workload" and a simple horizontal bar for each member showing how many open tasks they hold, with the bar filled proportionally in navy.
- Orange rounded floating action button with a plus icon, bottom right, to add a member.
```

---

## 9. PROMPT 6 — Profile

```
Mobile app screen, same PulseTrack style: background #F5F7FB, white cards 16px radius with 1px #E2E8F0 borders, primary navy #1D3B8B, accent orange #F97316, Inter font, 16px margins.

SCREEN: Profile.
- App bar: back chevron left, title "Profile".
- Centred header block: a large 88px circular avatar with the initials "JD" in white on a navy background, the name "John Doe" in 20px bold beneath it, and the role "Project Manager" in 13px muted.
- A white rounded card containing three evenly spaced columns: "Assigned 8", "Completed 5", "Overdue 1" - each with a large bold number and a small muted label, separated by thin vertical dividers.
- A white rounded settings list with rounded outlined icons on the left, a label, and a chevron on the right:
  "Edit Profile" (person icon), "SLA Rules & Thresholds" (sliders icon), "Notifications" (bell icon), "About PulseTrack" (info icon).
- At the bottom, on its own, a sign-out row: a logout icon and the text "Sign Out" both in red #D92D20, no chevron.
```

---

## 10. PROMPT 7 — Insights / Task Statistics

```
Mobile app screen, same PulseTrack style: background #F5F7FB, white cards 16px radius with 1px #E2E8F0 borders, primary navy #1D3B8B, accent orange #F97316, Inter font, 16px margins.

SCREEN: Insights.
- App bar: back chevron left, title "Insights", a small "This week" dropdown on the right.
- Card "Task Status": a vertical bar chart with four bars - green bar height 5 labelled On Track, amber bar height 3 labelled At Risk, red bar height 2 labelled Overdue, slate bar height 2 labelled Completed. Value labels sit above each bar and the axis labels beneath, in 12px muted.
- Card "SLA Breach by Member": a leaderboard list of four rows, each with a circular avatar, the member name, a horizontal bar filled in red proportional to the breach count, and the count number on the right.
- Card "Upcoming Deadlines": three rows, each with a small calendar icon, a task title, the due date in muted 12px, and an SLA badge on the right. Rows: "Implement Local Storage - 12 Dec - At Risk", "Test Application - 15 Dec - To Do", "Prepare Demo - 18 Dec - To Do".
- Card "Project Health": a small line chart of the health score over the last 7 days, navy line with a soft navy gradient fill beneath it, with a single highlighted dot on today's value.
```

---

## 11. PROMPT 8 — Activity Log

```
Mobile app screen, same PulseTrack style: background #F5F7FB, white card 16px radius with 1px #E2E8F0 borders, primary navy #1D3B8B, accent orange #F97316, Inter font, 16px margins.

SCREEN: Activity.
- App bar: back chevron left, title "Activity", a small calendar range button on the right.
- A horizontally scrollable row of filter chips: "All" (selected, navy), "Status", "Created", "Assigned".
- A vertical timeline: a thin 2px light grey vertical line down the left, with circular coloured dots on it marking each event. Each entry to the right of the dot has:
  - a circular avatar with initials
  - one line of 14px text with the actor's name in semibold, e.g. "Sarah changed the status of Design Login Screen to In Progress"
  - a muted 12px timestamp beneath, e.g. "Today, 09:14"
  Dots are coloured by event type: navy for status changes, green for completions, blue for creation, amber for assignment.
- Six entries visible, dated Today and Yesterday.
```

---

## 12. PROMPT 9 — SLA Rules & Thresholds ⭐ (your differentiator — use Experimental mode)

```
Mobile app screen, same PulseTrack style: background #F5F7FB, white cards 16px radius with 1px #E2E8F0 borders, primary navy #1D3B8B, accent orange #F97316, Inter font, 16px margins.

SCREEN: SLA Rules.
- App bar: back chevron left, title "SLA Rules", a "Reset" text button on the right.
- Card "How At Risk is calculated": a short paragraph of 13px muted explanatory text, and beneath it a bordered formula block in monospace 12px reading "remaining % = (due date - now) / (due date - created)". Below that, four rows each with a priority pill on the left and an editable percentage value on the right: "Critical 50%", "High 40%", "Medium 30%", "Low 20%".
- Card "Adjust threshold": a large horizontal slider currently at 30% with a big navy value readout "30%" above it, and axis labels "10%" and "60%" at the ends in 12px muted.
- Card "Options" with two toggle rows: "Flag blocked tasks as At Risk" (ON, navy switch) and "Warn when less than 24 hours remain" (ON, navy switch). Each has a one-line muted description beneath it.
- Card "Live preview": a single task card mock-up showing "Implement Local Storage", a due date, and a badge that currently reads "At Risk" in amber, with a caption "A Medium-priority task due in 2 days".
- A sticky bottom bar with a full-width navy button "Save Rules" and a ghost text button "Cancel".
```

---

## 13. Refinement prompts (use these whenever a render is close but not right)

```
Make every SLA status badge pill-shaped with a 6px solid dot before the label and a soft tinted background.
```
```
The card shadows are too heavy. Reduce them to a very subtle elevation, keep the 1px #E2E8F0 border.
```
```
Add a skeleton loading state to the dashboard cards: grey rounded placeholder blocks in place of the numbers and chart.
```
```
Tighten the spacing to a strict 8pt grid and increase the whitespace between cards to 16px.
```
```
Use filled Material icons for the active bottom-navigation tab and outlined icons for the inactive tabs.
```
```
Make the app bar flat white with a 1px #E2E8F0 bottom border and no drop shadow.
```
```
Increase the contrast of the secondary text: keep #64748B but raise the caption size to 12px and the weight to medium.
```
```
Re-render this screen with the longest realistic content so I can see how the layout handles overflowing titles.
```

---

## 14. Getting the designs into Figma

1. In Stitch, open the generated screen and choose **Copy to Figma** (or **Export → Figma**).
2. Open the **Figma desktop app**, create a file `PulseTrack UI`, and paste (`Ctrl+V`). Stitch pastes as editable Figma layers/frames, not a flat image.
3. Paste all ten screens into one page, arranged left to right in journey order: Sign In → Dashboard → Task List → Task Details → Create Task → Team Members → Member Detail → Profile → Insights → Activity → SLA Rules.
4. Add frame labels above each screen (the Flutter screen filename, e.g. `task_list_screen.dart`) — this is what the developers work from, and it is what you show in the demo video when you say "here is our design".
5. Optional but strong for the report: select all frames → export as PNG at 2x → drop into the PDF report.
6. **Paste the Figma link into the GitHub README** — it is free evidence of design process.

---

## 15. Figma tokens → Flutter tokens

Put these in `theme/app_colors.dart` once, and never type a colour literal anywhere else. This is what lets you say, honestly, *"the build matches the design"*.

| Token | Hex | Flutter constant |
|---|---|---|
| Brand primary | `#1D3B8B` | `AppColors.primary` |
| Accent | `#F97316` | `AppColors.accent` |
| Background | `#F5F7FB` | `AppColors.background` |
| Surface | `#FFFFFF` | `AppColors.surface` |
| Border | `#E2E8F0` | `AppColors.border` |
| Ink | `#0F172A` | `AppColors.ink` |
| Muted | `#64748B` | `AppColors.muted` |
| On Track | `#12A150` / `#E6F6EC` | `AppColors.onTrack` / `AppColors.onTrackSoft` |
| At Risk | `#E8A317` / `#FDF3E0` | `AppColors.atRisk` / `AppColors.atRiskSoft` |
| Overdue | `#D92D20` / `#FDECEA` | `AppColors.overdue` / `AppColors.overdueSoft` |
| Completed | `#64748B` / `#EEF1F5` | `AppColors.completed` / `AppColors.completedSoft` |

<div class="footer">
<b>PulseTrack</b> · Stitch Prompt Pack · generated 08 October 2026
</div>
