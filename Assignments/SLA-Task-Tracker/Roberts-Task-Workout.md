# Robert's Task Workout — PulseTrack
### Your part, start to finish. Work top to bottom; do not skip a gate.

<div class="meta">
<b>You are:</b> <b>Robert Tony MITALI Niyonkuru</b> — the integrator, architecture owner, and SLA-engine author.<br>
<b>Hard deadline:</b> <b>Sunday 11 October 2026, 23:59</b> — this doc was written <b>Thursday 08 October, 09:45</b>.<br>
<b>Today's single goal:</b> get the <b>frozen skeleton on <code>main</code> by 18:00</b>. Gideon and Admire are blocked until you do.
</div>

---

## ⏱️ Status board — update this after every work session

| Phase | What | Target | State |
|---|---|---|---|
| **0** | Project + GitHub repo + collaborators | Thu 10:30 | ☐ |
| **1** | Skeleton frozen on `main` (models, DB, repos, theme, routes, SLA engine, tests) | Thu 18:00 | ☐ |
| **2** | Dashboard verified on device | Fri 12:00 | ☐ |
| **3** | Insights + SLA Rules screens (the differentiator) | Sat 12:00 | ☐ |
| **4** | AI Usage Declaration + final submission | Sun 21:00 | ☐ |

**Gates** are where you stop and report back to me. There are **three** of them. Everything else you can just do.

---

## Two rules before you touch anything

1. **You are the blocker.** Nobody can write a screen until the models, `AppState` and routes exist. Phase 1 is not "your work" — it is everyone's work, and you are the one holding it.
2. **Commit in small pieces, today.** The rubric explicitly says a single big upload before the deadline is *not sufficient evidence of collaboration*. Your commit history over four days is a graded artefact.

---

## PHASE 0 — Project + repo (~30 min). Do this now.

### 0.1 Create the Flutter project

Open your terminal (git-bash) and run these exactly:

```bash
cd "/c/Users/Richter Richard NAHO/TonyRobert98/FlutterProgramming/Assignments/SLA-Task-Tracker"
mkdir -p pulsetrack
cd pulsetrack
flutter create --org com.pulsetrack --project-name pulsetrack --platforms=android,ios .
```

Why these flags:
- `--project-name pulsetrack` — the Dart package name. **The skeleton's tests import `package:pulsetrack/...`, so this must be `pulsetrack` or the tests will not compile.**
- `--platforms=android,ios` — we only ship mobile. The brief says a browser-only app scores zero, so there is no web target to accidentally submit.
- `--org com.pulsetrack` — the Android application id becomes `com.pulsetrack.pulsetrack`.

### 0.2 ⛔ GATE — prove it runs on the emulator

**Do not continue until a real emulator shows the Flutter counter app.**

```bash
flutter emulators
flutter emulators --launch <the_id_from_the_list_above>
flutter devices
flutter run
```

When the counter app appears on the emulator, press **`q`** in the terminal to quit.

> **Why this gate matters more than it looks.** This is the single riskiest part of the whole assignment: the brief scores zero for a browser-only app, and you cannot record a demo video without a working device. Finding out on Saturday that your emulator is broken is a disaster. Finding out on Thursday morning costs ten minutes.
>
> If the emulator will not boot or `flutter run` fails, **stop and tell me** — do not spend an hour on it.

### 0.3 First commit

`flutter create` already wrote a `.gitignore` for you.

```bash
git init -b main
git add .
git commit -m "chore: scaffold PulseTrack Flutter project"
```

### 0.4 Create the GitHub repo and push

The group needs **its own** public repo — not your personal `FlutterProgramming` one, because the rubric wants each member on their own branch with their own pull requests.

```bash
gh auth status
```

**If `gh` is authenticated:**

```bash
gh repo create pulsetrack --public --source=. --remote=origin --push
```

**If `gh` is not installed or not logged in**, create the repo manually at github.com/new (name: `pulsetrack`, public, **do not** add a README), then:

```bash
git remote add origin git@github.com:RobertNiyonkuru98/pulsetrack.git
git push -u origin main
```

### 0.5 Add Gideon and Admire as collaborators

Replace the two placeholders with their real GitHub usernames (I still need these from you):

```bash
gh api -X PUT repos/RobertNiyonkuru98/pulsetrack/collaborators/<GIDEON_USERNAME> -f permission=push
gh api -X PUT repos/RobertNiyonkuru98/pulsetrack/collaborators/<ADMIRE_USERNAME> -f permission=push
```

Via the website instead: repo → **Settings** → **Collaborators** → **Add people** → enter their username → role **Write**.

### 0.6 Keep your personal repo clean

`pulsetrack/` is its own git repo nested inside `FlutterProgramming`, which is *also* a git repo. Tell the outer repo to ignore it, or your personal `git status` will fill up with noise:

```bash
cd "/c/Users/Richter Richard NAHO/TonyRobert98/FlutterProgramming"
grep -qxF "Assignments/SLA-Task-Tracker/pulsetrack/" .gitignore 2>/dev/null || echo "Assignments/SLA-Task-Tracker/pulsetrack/" >> .gitignore
```

### ✅ Phase 0 done when
- [ ] The Flutter counter app ran on your emulator and you pressed `q`
- [ ] `github.com/RobertNiyonkuru98/pulsetrack` exists and is public
- [ ] Your first commit is pushed and visible on GitHub
- [ ] Gideon and Admire have accepted the collaborator invite

---

## PHASE 1 — Freeze the skeleton (~2–3 h). Target: **on `main` by 18:00.**

Everything in `Assignments/SLA-Task-Tracker/skeleton/` is written and syntax-checked. It contains the shared types, the SQLite layer, the theme, the routes, the **SLA engine with 15 passing test expectations**, four shared widgets, a complete Dashboard as the reference screen, and a stub for every other screen — so the app compiles and runs from the moment you push.

### 1.1 Add the dependencies

```bash
cd "/c/Users/Richter Richard NAHO/TonyRobert98/FlutterProgramming/Assignments/SLA-Task-Tracker/pulsetrack"
flutter pub add sqflite path provider intl shared_preferences uuid
```

`flutter pub add` picks versions compatible with your Flutter, so you cannot get this wrong by guessing a version number.

### 1.2 Drop the skeleton in

```bash
rm -f test/widget_test.dart
cp -r ../skeleton/lib/. lib/
cp -r ../skeleton/test/. test/
```

`rm` is required: `flutter create` leaves a `widget_test.dart` that tests the counter app you just deleted, and it will fail the moment you run the tests.

### 1.3 Run the app

```bash
flutter run
```

You should now get a real PulseTrack screen: the **Dashboard**, with 10 seeded tasks, a health ring, a donut chart, KPI cards and an "Attention Needed" queue. **Look at it** — the numbers are the SLA engine working.

### 1.4 ⛔ GATE — check the code

```bash
flutter analyze
flutter test
```

**Expected:** `flutter test` reports all tests passing. `flutter analyze` may report *info*-level style lints, and any finding makes it exit non-zero.

Either way: **paste me both outputs.** I will fix every finding before you commit, so `main` is clean for Gideon and Admire. Do not commit with a red analyze if you can avoid it.

### 1.5 Branch, commit, pull request

The rubric wants a branch and a PR from each member — including you.

```bash
git checkout -b feat/robert-skeleton
git add .
git commit -m "feat(skeleton): add data models, sqflite layer, repositories, theme, routes, SLA engine, widgets and screen stubs"
git push -u origin feat/robert-skeleton
```

Open the PR. Title: **Freeze the shared skeleton (models + SLA engine + routes)**. Body: summary → why (unblocks all three members) → files added → how you verified (`flutter test`).

```bash
gh pr create --title "Freeze the shared skeleton (models + SLA engine + routes)" --body "Adds the frozen shared layer so Gideon and Admire can branch tonight. Verified with flutter analyze + flutter test."
```

Then merge it **without deleting the branch** (the branch itself is evidence):

```bash
gh pr merge --squash
```

### 1.6 Unblock the team — send this message

> **PulseTrack — skeleton is frozen on `main`, you can start now.**
> Pull it: `git clone git@github.com:RobertNiyonkuru98/pulsetrack.git`
> Then: `flutter pub get` and `flutter run` — the Dashboard already works with seeded demo data.
> **Read `lib/screens/dashboard_screen.dart`** — it is the reference screen, copy its patterns.
> Your files are stubbed and waiting, with `/// OWNER:` comments on them.
> **Gideon:** `task_list_screen.dart`, `task_details_screen.dart`, `task_form_screen.dart`, `widgets/task_tile.dart`
> **Admire:** `sign_in_screen.dart`, `team_members_screen.dart`, `member_detail_screen.dart`, `profile_screen.dart`, `activity_log_screen.dart`
> Do not edit files you do not own — ask in the group.
> Branch: `git checkout -b feat/<yourname>-<what>`
> Kickoff call tonight 10:00 where we pick the Figma design.

### ✅ Phase 1 done when
- [ ] `flutter test` is green
- [ ] `flutter analyze` is clean (or every finding is understood)
- [ ] The skeleton is merged into `main` on GitHub
- [ ] Gideon and Admire have been messaged

---

## PHASE 2 — Your screens

**Already done for you:** `lib/screens/dashboard_screen.dart`. Read it, understand it, and be ready to explain it — it is your screen and your reference pattern for the team.

### 2.1 Insights (`screens/insights_screen.dart`)
- Status bar chart: On Track / At Risk / Overdue / Completed counts, colour-matched to the badges.
- SLA breach leaderboard: one row per member, avatar, name, a red bar proportional to their overdue count.
- Upcoming deadlines: the five soonest `dueDate` tasks with an SLA badge.
- **Acceptance:** numbers match the Dashboard's KPI cards. If they disagree, one of the two is wrong — and that is exactly the kind of bug you want to find before the video.

### 2.2 SLA Rules & Thresholds (`screens/sla_settings_screen.dart`) — ⭐ the differentiator
- Four sliders, one per priority, bound to `SlaSettings`.
- Two switches: `flagBlockedAsAtRisk`, `warnUnder24h`.
- **A live preview card** showing what a chosen sample task's status would become.
- Save writes through `AppState.saveSettings`, which persists to SQLite.
- **Acceptance — this is the demo moment:** drag the Medium threshold slider and **watch the badges across the app change colour without restarting.** If the preview updates but the Dashboard does not, you have forgotten to call through `AppState` (which calls `notifyListeners()`).

### 2.3 Your logic is already tested
`test/sla_engine_test.dart` and `test/health_score_test.dart` cover the rule order, the priority weighting, the 24-hour safety net, the blocked escalation, both toggles, and the health score. **Learn these two files** — when a lecturer asks "explain your SLA rules", the tests *are* your explanation.

---

## PHASE 3 — Declaration and submission (Sunday)

### 3.1 AI Usage Declaration
Write it honestly and specifically. Something like: *"We used AI tools to scaffold the initial project structure, to draft UI copy, and to help debug Flutter layout errors. All architectural decisions, the SLA rule design, and the final code were reviewed, tested and adjusted by the group. Every member can explain and modify any part of the submitted code."* Then list which tools, for what, and where.

Say clearly **what the AI did not do**: it did not write your report, and it did not make your design choices. Then be able to prove it live.

### 3.2 Final gate — walk the checklist out loud with the team
Use §9 of `SLA-Tracker-Team-Plan.html`. Then submit at **21:00, not 23:58**.

### 3.3 Update the tracker
`Contribution-Tracker.csv` sits in this folder with every row at `Not started`. Update the **Status** column as you finish each item, and paste the rows into your copy of the course tracker. The brief is blunt: **no contribution tracker link = no grade.**

---

## APPENDIX A — What every file does (so you can answer any question)

| File | Purpose |
|---|---|
| `lib/main.dart` | Boots the app, installs `AppState`, declares all named routes |
| `lib/routes.dart` | Every route name, in one place |
| `lib/theme/app_colors.dart` | Every colour — the single source of truth from Figma |
| `lib/theme/app_theme.dart` | Material 3 theme + the shared card decoration |
| `lib/data/models/task.dart` | `Task`, plus the `Priority` and `TaskStatus` enums |
| `lib/data/models/member.dart` | A team member, plus the `initials` avatar helper |
| `lib/data/models/sla_status.dart` | The four SLA states and their display labels |
| `lib/data/models/sla_settings.dart` | The tunable thresholds |
| `lib/data/models/activity.dart` | One audit-trail entry |
| `lib/data/db_helper.dart` | Opens SQLite, creates the 4 tables, seeds demo data |
| `lib/data/seed_data.dart` | 10 demo tasks across all four SLA states, 5 members, 5 activity rows |
| `lib/data/repositories/*.dart` | Thin CRUD wrappers — the only place SQL is written |
| `lib/logic/sla_engine.dart` | **The graded core.** Deadline + status → SLA status, plus the explanation sentence |
| `lib/logic/health_score.dart` | The 0–100 project health number |
| `lib/state/app_state.dart` | The `ChangeNotifier` every screen watches |
| `lib/widgets/sla_badge.dart` | The status pill used app-wide |
| `lib/widgets/kpi_card.dart` · `health_ring.dart` · `donut_chart.dart` · `empty_state.dart` · `app_bottom_nav.dart` | Shared UI |

**The one-sentence architecture answer:** *Screens never touch the database. They read from `AppState`, which talks to repositories; the repositories are the only code that writes SQL.*

---

## APPENDIX B — Commit messages to use

```
chore: scaffold PulseTrack Flutter project
feat(skeleton): add models, sqflite layer, repositories, theme, routes and screen stubs
feat(sla): add priority-weighted at-risk thresholds and health score
feat(widgets): add SLA badge, KPI card, health ring and donut chart
feat(dashboard): add health gauge, KPI grid, attention queue and recent activity
feat(insights): add status chart and breach leaderboard
feat(sla-rules): make thresholds editable at runtime
test(sla): cover rule order, priority weighting and both toggles
fix(sla): clamp elapsed percentage so bad dates cannot break the UI
```

Commit in small logical pieces **every day**. Four days of history is what the rubric is looking for.

---

## APPENDIX C — If something breaks

| Symptom | Cause and fix |
|---|---|
| `Target of URI doesn't exist: package:pulsetrack/...` | The project was created with a different `--project-name`. Either recreate with `--project-name pulsetrack`, or find-and-replace `pulsetrack` with your name across `lib/` and `test/`. |
| `flutter test` fails on `widget_test.dart` | You forgot `rm -f test/widget_test.dart` (step 1.2). |
| `MissingPluginException` on `sqflite` | sqflite is a native plugin — it does **not** run on Chrome/web. Run on the emulator or a device. This is expected, not a bug. |
| `flutter analyze` exits non-zero with only `info` lines | Style lints. Paste them to me rather than disabling the linter — a clean analyzer is a strong signal in the report. |
| The app shows 0 tasks | The database was created before the seed existed. Uninstall the app from the emulator and `flutter run` again to force a fresh database. |
| Emulator will not boot | Report it immediately. Do not burn an hour. We have a fallback path. |
| Merge conflict | Nobody edits a file they do not own. If it happens anyway, stop and ask — do not "fix" it by overwriting someone's work. |

<div class="footer">
<b>PulseTrack</b> · Robert's Task Workout · generated 08 October 2026
</div>
