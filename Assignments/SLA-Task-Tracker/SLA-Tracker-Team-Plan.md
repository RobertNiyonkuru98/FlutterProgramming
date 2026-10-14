# PulseTrack — Project & SLA Task Tracker
### Team Playbook — Gideon · Admire · Robert

<div class="meta">
<b>Course:</b> Mobile Development · <b>Type:</b> Group Assignment (3 members) · <b>Stack:</b> Flutter (no backend)<br>
<b>Kickoff:</b> Thursday 08 October 2026, 09:30 · <b>Hard deadline:</b> <b>Sunday 11 October 2026, 23:59</b><br>
<b>Time available from kickoff:</b> <b>≈ 86 hours (3 days 14 hours)</b> · <b>App name:</b> <b>PulseTrack</b>
</div>

---

## 1. What is actually being graded

Read this table before planning anything. The app is only *one* of six graded artefacts.

| # | Deliverable | Marks hinge on | Owner |
|---|---|---|---|
| 1 | **GitHub repo** | every member has a **branch**, **visible commits spread across the days**, PRs, readable code, clear structure. A single big upload at the end = **not sufficient evidence** | Robert (setup) → all |
| 2 | **PDF report (max 3 pages)** | repo link · project structure · what was built · screenshots | Admire |
| 3 | **Technical report (2–4 pages)** | **challenges faced + how you solved them** — this is the whole point of the doc | Admire + Robert |
| 4 | **Demo video (10–15 min)** | main workflow (create → update → SLA status), UI decisions, navigation, validation, state, SLA logic, persistence. **Every member speaks.** Must show what makes your app unique | All 3 |
| 5 | **Group contribution tracker link** | copy of the course tracker, filled in. **Missing = your work is not graded at all** | Admire |
| 6 | **AI Usage Declaration** | brief, honest description of how AI tools were used | Robert |
| 7 | **Runs on emulator / real device** | browser-only run = **automatic zero** | All 3 |

**Graded feature requirements inside the app**

- At least **6 screens**: Sign In / User Selection, Project Dashboard, Task List, Task Details, Create/Edit Task, Team Members/Profile. *(We are building 10.)*
- **SLA status** on every task: On Track · At Risk · Overdue · Completed — and you must be able to **explain your At Risk rule out loud**.
- **Persistence across app restart** — SharedPreferences or sqflite, and you must **justify the choice**.
- Sign-in does **not** need a real auth service — just a believable Flutter flow.
- Demonstrates: widgets, layouts, navigation, forms + validation, error handling, application state, business logic.

**Filename rule:** `GroupName_AssignmentName` (e.g. `PulseTrack_ProjectAndSLATaskTracker.pdf`). Pick a group name tonight and write it down — you will reuse it in four places.

---

## 2. The app we are building

**PulseTrack** — a project & SLA task tracker for a small software team. Not a generic to-do list: the product promise is **"tell me, in one screen, which tasks are about to breach their SLA."**

### Screens (10 — the brief asks for 6)

| # | Screen | What it does | Rubric it wins |
|---|---|---|---|
| 1 | **Sign In / Sign Up / User Selection** | email + password with **validation**, plus one-tap "continue as" team member cards | forms, validation, navigation, state |
| 2 | **Dashboard** | KPI cards, **Project Health ring gauge**, status donut, attention queue, recent activity | layout, charts, business logic |
| 3 | **Task List** | search, **SLA filter chips**, sort, task cards with coloured SLA badges | lists, filtering, state |
| 4 | **Task Details** | SLA panel **that explains why** the status was assigned, progress slider, status changer, notes, activity trail | business logic, state, navigation args |
| 5 | **Create / Edit Task** | full form + field-level validation + error states | forms, validation, error handling |
| 6 | **Team Members** | per-member workload & breach counts | lists, aggregation |
| 7 | **Member Detail** | one member's tasks + their SLA mix | navigation, aggregation |
| 8 | **Profile** | current user, stats, settings entry, sign out | session state, persistence |
| 9 | **Insights** | status bar chart, breach leaderboard, upcoming deadlines | charts, business logic |
| 10 | **SLA Rules & Thresholds** | **live-editable at-risk thresholds** | ⭐ the differentiator |

### What makes it unique (your demo-video money-shot)

1. **Explainable SLA engine** — the Task Details screen *prints the rule* that produced the status (`"At Risk — 68% of the allotted window has elapsed"`). No other group will do this.
2. **Live rule editing** — on screen 10, drag the At Risk slider and watch task badges **flip colour across the app in real time**. This is your 60-second live demonstration of business logic.
3. **Project Health Score (0–100)** — one number computed from the SLA mix, shown as a ring gauge.
4. **Attention Queue** — Overdue + At Risk only, ranked by an urgency score, so the user sees the two things that matter.
5. **Team breach board** — who is overloaded, who is about to miss.
6. **Activity Log** — every status change journalled, persisted, filterable.

---

## 3. Our SLA rules (learn these — you will be asked)

Fields: `createdAt`, `dueDate`, `status` (To Do / In Progress / Blocked / Completed), `priority` (Low / Medium / High / Critical), `progress` (0–100).

Evaluate **in this order** — first match wins:

| Order | Condition | Result |
|---|---|---|
| 1 | `status == Completed` | **Completed** |
| 2 | `status == Blocked` | **At Risk** (blocked work cannot progress, so it is escalated) |
| 3 | `now > dueDate` | **Overdue** |
| 4 | `remaining ≤ 24h` | **At Risk** (hard safety net) |
| 5 | `remainingPct ≤ threshold(priority)` | **At Risk** |
| 6 | otherwise | **On Track** |

Where `remainingPct = (dueDate − now) / (dueDate − createdAt)`.

**Priority-weighted thresholds** — the higher the priority, the earlier the warning:

| Priority | At Risk when remaining time drops below | Why |
|---|---|---|
| Critical | 50 % | half the window gone and it is not done → alarm |
| High | 40 % | |
| Medium | 30 % | |
| Low | 20 % | ample slack |

**Project Health Score** = `100 × average(statusWeight)` over all tasks, where Completed = 1.0, On Track = 1.0, At Risk = 0.5, Overdue = 0.0. One sentence to explain, and it moves visibly when you complete a task on stage.

> **Why this is defensible in the demo:** a flat "48 hours left = at risk" rule treats a 2-day task and a 6-week task identically. A percentage-of-window rule with a priority weight is proportional and tunable — and we can *show* it being tuned.

---

## 4. Technical decisions (and the exact words to say)

| Decision | Choice | What you say in the demo |
|---|---|---|
| **Persistence** | **sqflite** | "Our data is relational — members own many tasks and the Insights screen aggregates with GROUP BY. sqflite gives us queries and sorting; SharedPreferences would force us to load and re-sort whole JSON lists on every screen." |
| **Session user** | `shared_preferences` | "The signed-in member is a single small value, so it lives in SharedPreferences while the task data lives in SQLite — each store is used for what it is good at." |
| **State** | `provider` (ChangeNotifier) | "One `TaskProvider` exposes tasks and derived metrics. Screens call `context.watch` to rebuild. `setState` alone would force us to pass data down every widget tree, and Bloc is more ceremony than a 3-day build needs." |
| **Navigation** | named routes + `Navigator.pushNamed(arguments:)` | "Routes are declared in one place, arguments are typed objects, and the back stack behaves correctly on Android." |
| **Charts** | `fl_chart` | donut + bar chart, no hand-rolled painters. |
| **Theme** | one `AppColors` + one `AppTheme` | "Every colour comes from a single token file, so the Flutter build matches the Figma design exactly." |
| **Validation** | `Form` + `TextFormField` validators | title required + min 3 chars, due date must be in the future, assignee required, progress 0–100. Error text shown under the field. |
| **Error handling** | `FutureBuilder`/try-catch around every DB call + empty states | "The list has an empty state, and a failed DB read shows a retry card instead of a red screen." |

Dependencies: `sqflite`, `path`, `provider`, `intl`, `fl_chart`, `shared_preferences`, `uuid`.

---

## 5. File ownership map — one file, one owner

**Rule: nobody edits a file they do not own.** Need a change in someone else's file? Open a PR or ask in the group chat. This is what keeps a 3-person, 3-day build from drowning in merge conflicts.

The **FREEZE** files are written by Robert *first* and merged to `main` **before** Gideon and Admire create their branches. Nobody is ever blocked waiting for a type that does not exist.

```
lib/
  main.dart                     Robert   [FREEZE]
  routes.dart                   Robert   [FREEZE]
  theme/app_colors.dart         Robert   [FREEZE]
  theme/app_theme.dart          Robert   [FREEZE]
  data/db_helper.dart           Robert   [FREEZE]
  data/seed_data.dart           Admire
  data/models/task.dart         Robert   [FREEZE]
  data/models/member.dart       Robert   [FREEZE]
  data/models/activity.dart     Robert   [FREEZE]
  data/models/sla_status.dart   Robert   [FREEZE]
  data/models/sla_settings.dart Robert   [FREEZE]
  data/repositories/*.dart      Robert   [FREEZE]
  logic/sla_engine.dart         Robert   ★ graded core
  logic/health_score.dart       Robert
  widgets/sla_badge.dart        Admire
  widgets/kpi_card.dart         Admire
  widgets/health_ring.dart      Admire
  widgets/activity_tile.dart    Admire
  widgets/empty_state.dart      Admire
  widgets/task_tile.dart        Gideon
  screens/sign_in_screen.dart   Admire
  screens/team_members_screen.dart  Admire
  screens/member_detail_screen.dart Admire
  screens/profile_screen.dart   Admire
  screens/activity_log_screen.dart  Admire
  screens/task_list_screen.dart Gideon
  screens/task_details_screen.dart Gideon
  screens/task_form_screen.dart Gideon
  screens/dashboard_screen.dart Robert
  screens/insights_screen.dart  Robert
  screens/sla_settings_screen.dart Robert
test/sla_engine_test.dart       Robert
test/health_score_test.dart     Robert
test/form_validation_test.dart  Gideon
```

---

## 6. Git & GitHub workflow

1. **Robert** creates the repo `pulsetrack` (public), adds Gideon + Admire as **collaborators**, and pushes `main` containing: `README.md`, `.gitignore`, `pubspec.yaml`, the skeleton above, and **seed/demo data** so the app is never empty on stage.
2. Each member creates one branch off `main`:
   ```bash
   git checkout main && git pull
   git checkout -b feat/gideon-task-crud
   ```
3. **Commit small and often** — a commit is evidence. Target 3–5 commits per member per day, four days running. Example messages:
   ```bash
   feat(tasks): add task list screen with SLA filter chips
   feat(sla): add priority-weighted at-risk thresholds
   fix(form): validate due date is in the future
   test(sla): cover blocked-task escalation
   ```
4. **One PR per feature**, 1 reviewer from another member, squash-merge into `main`.
5. Keep a `README.md` with the branch table and a `docs/` folder for screenshots.

> ⚠️ **The single biggest mark-loser:** committing everything in one push on Saturday night. The brief says that is *not* sufficient evidence of collaboration. Push real commits **tonight**.

---

## 7. The 86-hour timeline

### 🗓️ Thursday 08 October

| Time | Who | What |
|---|---|---|
| 10:00–12:00 | **All — MEETING 1 (Kickoff)** | Agree scope · run the Stitch prompt · pick one design variant · agree the SLA rules in §3 · freeze the data model · assign files (§5) · create repo + branches |
| 12:00–18:00 | Robert | Build the FULL skeleton: models, DB helper, repositories, theme, routes, `main.dart`, seed data, **SLA engine + tests** → merge to `main` |
| 12:00–18:00 | Admire | Run Stitch for your 5 screens, export to Figma, build `sign_in_screen` + `profile_screen` against the skeleton |
| 12:00–18:00 | Gideon | Stitch for your 3 screens, export to Figma, build `task_tile` + `task_list_screen` shell |
| 19:00–23:00 | All | First real screens. Commit and push. |

### 🗓️ Friday 09 October

| Time | Who | What |
|---|---|---|
| 09:00–14:00 | All | Build. Everyone opens their first PR. |
| 14:00–15:00 | **All — MEETING 2 (Integration)** | Merge PRs · resolve conflicts together · **prove persistence on the emulator** (kill app → reopen) · re-balance the leftovers |
| 15:00–23:00 | All | Forms + validation · Insights charts · Activity log · SLA settings screen |

### 🗓️ Saturday 10 October

| Time | Who | What |
|---|---|---|
| 09:00–12:00 | All | Polish: empty states, error handling, seeded demo data, app icon/name |
| **12:00** | — | **FEATURE FREEZE.** Nothing new after this. |
| 13:00–15:00 | **All — MEETING 3 (Demo rehearsal)** | Full dry run on the emulator · script the 10–15 min video · **agree who explains which section** |
| 15:00–20:00 | All | **Record the demo video** — emulator/device, screen + all three voices |
| 18:00–23:00 | Admire + Robert | PDF report + technical report; Gideon captures screenshots |

### 🗓️ Sunday 11 October

| Time | Who | What |
|---|---|---|
| 09:00–13:00 | Admire | Finish both reports, fill the contribution tracker, write the AI declaration |
| 13:00–18:00 | All | Buffer — fix anything the recording exposed · re-record if needed |
| 18:00–19:00 | **All — FINAL REVIEW call** | Walk the §9 checklist line by line, out loud |
| 20:00–21:00 | Robert | **Submit.** Two and a half hours of buffer, deliberately. |

---

## 8. Per-person brief (paste into WhatsApp)

### 🧩 Robert — architecture, SLA engine, dashboard, insights, SLA settings
- Own: repo + branch setup, `main.dart`, `routes.dart`, theme, all models, DB helper, repositories, **SLA engine + health score**, Dashboard, Insights, SLA Rules screen, 2 unit-test files.
- Deliverable: **freeze the skeleton to `main` by Thu 18:00** — Gideon and Admire are blocked on it.
- Also: AI Usage Declaration, final submission, PR reviews.
- Done when: `flutter test` green on `sla_engine_test.dart`; a task's badge changes colour when you move the threshold slider.

### 🧩 Gideon — the task journey (list → details → form)
- Own: `task_tile.dart`, `task_list_screen.dart`, `task_details_screen.dart`, `task_form_screen.dart`, `form_validation_test.dart`.
- Deliverable: create a task in the form → it appears in the list → open details → change status → it persists after restart.
- Done when: the form rejects an empty title and a past due date with visible error text; filter chips actually filter.
- Blocker warning: your 3 screens are the heaviest work in the build — start the list shell on Thursday, do not wait for Figma.

### 🧩 Admire — entry point, team, profile, activity, and the reports
- Own: `sign_in_screen.dart`, `team_members_screen.dart`, `member_detail_screen.dart`, `profile_screen.dart`, `activity_log_screen.dart`, the shared widgets (`sla_badge`, `kpi_card`, `health_ring`, `activity_tile`, `empty_state`), `seed_data.dart`.
- Also: **the 3-page PDF + the 2–4 page technical report + the contribution tracker + video editing.**
- Deliverable: sign in as a member → dashboard greets that member → sign out → sign in as another member.
- Done when: `sla_badge.dart` renders all four statuses correctly — Gideon and Robert depend on it. **Build it Thursday evening and push it early.**

---

## 9. Deliverables checklist — run this on Sunday

- [ ] Repo link in the PDF, repo is public
- [ ] 3 branches exist; **3 names appear in `git shortlog -sn`**
- [ ] Commits on all four days (Thu · Fri · Sat · Sun), no single mass upload
- [ ] At least one PR per member, each with a description
- [ ] App runs on an emulator or physical device (**not** a browser)
- [ ] ≥ 6 screens present (we ship 10)
- [ ] All four SLA statuses reachable and visible
- [ ] Data survives killing and reopening the app
- [ ] Form validation demonstrably fires
- [ ] `flutter analyze` clean, `flutter test` passing
- [ ] PDF report ≤ 3 pages, filename `GroupName_AssignmentName.pdf`
- [ ] Technical report 2–4 pages, split into Challenges / Solutions
- [ ] Demo video 10–15 min, **all three members speak**, on emulator/device
- [ ] Contribution tracker copied, filled, link in the PDF
- [ ] AI Usage Declaration included
- [ ] Submitted Sunday evening, **not** at 23:58

---

## 10. Risks and how we kill them

| Risk | Impact | Mitigation |
|---|---|---|
| **Figma handoff eats a day** | nobody codes on Thursday | The data model and SLA engine do **not** depend on the visual design. Robert builds logic Thursday while design is generated. Design never blocks logic. |
| **Merge conflicts** | hours lost Sunday | The freeze-then-branch rule in §5. One file, one owner. |
| **Emulator blows up at record time** | zero on the video | Test `flutter run` on the emulator **Thursday**, long before the recording. Have one member's physical phone as backup. |
| **Screens left half-built** | rubric gaps | Feature freeze Saturday noon, not Saturday night. |
| **Reports written at 23:00 Sunday** | poor marks on 5 of 6 deliverables | Reports are a Saturday-evening + Sunday-morning task with a named owner (Admire). |
| **One person does everything** | contribution tracker looks fake | The ownership map assigns every screen to a named person, and the tracker records it. |
| **"We'll polish later"** | nothing is finishable | Polish is Friday night's job. Saturday is freeze + record. |

---

<div class="footer">
<b>PulseTrack</b> · Team Playbook · generated 08 October 2026 · Gideon · Admire · Robert
</div>
