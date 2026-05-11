# Contributing

Welcome! This guide covers how we work with branches, pull requests, and the
git workflow on this project. If you've never used any of these conventions
before, don't worry — read through once, keep this file handy for your first
few PRs, and it'll start to feel natural quickly.

---

## The workflow at a glance

We use `dev` as our integration branch. Everyone branches off `dev`, opens a
PR back into `dev`, and `dev` gets promoted to `main` on releases.

```
main   ←  dev   ←  your feature branch
```

The full cycle for any piece of work:

1. Make sure your local `dev` is up to date.
2. Create a new branch off `dev`.
3. Do your work, commit as you go.
4. Push your branch and open a PR back into `dev`.
5. Address review feedback.
6. Once approved, your PR gets squash-merged into `dev`.

Concrete commands:

```bash
# 1. Update your local dev
git checkout dev
git pull origin dev

# 2. Create your branch
git checkout -b feat/dark-mode-toggle

# 3. Do work, commit
git add .
git commit -m "add toggle component"
# (commit as many times as you want — they'll be squashed at the end)

# 4. Push and open PR
git push -u origin feat/dark-mode-toggle
# Then open the PR on GitHub, targeting `dev`
```

---

## Branch naming

Format: `type/short-description`

```
feat/dark-mode-toggle
fix/crash-on-empty-project
chore/update-electron-version
refactor/extract-file-loader
docs/setup-instructions
```

**Types:**

| Type       | When to use it                                              |
|------------|-------------------------------------------------------------|
| `feat`     | New functionality the user can see                          |
| `fix`      | Bug fix                                                     |
| `refactor` | Restructuring code without changing behaviour               |
| `chore`    | Dependency bumps, config changes, build tweaks              |
| `docs`     | Documentation only                                          |
| `test`     | Adding or fixing tests, no production code change           |

**Rules:**

- Lowercase, hyphen-separated. No spaces, no underscores, no camelCase.
- 3–5 words after the type. The PR title carries the full description.
- No personal names (`remi/dark-mode` is an anti-pattern — git already knows who you are).
- Always branch from the latest `dev`, not from another feature branch.

If you can't name your branch in 3–5 clear words, that's usually a sign the
branch is doing too many things and should be split into two.

---

## PR titles

Format: `type: short description in present tense, lowercase`

```
feat: add dark mode toggle to settings
fix: prevent crash when opening empty project
refactor: extract file loader into its own module
chore: bump electron to v28
docs: explain how to run tests on windows
```

**Rules:**

- Same `type` prefix as your branch. If the branch is `feat/...`, the PR is `feat: ...`.
- **Present tense, imperative mood.** "add", not "added" or "adds". Reads as a command: *this PR will add dark mode*.
- Lowercase after the colon.
- No period at the end.
- Aim for 50 characters, hard cap at 72.

This convention is called [Conventional Commits](https://www.conventionalcommits.org/),
and it's used by most professional teams. Worth learning once — you'll see
it everywhere.

---

## PR description

Fill out the PR template (`.github/PULL_REQUEST_TEMPLATE.md`) — it loads
automatically when you open a PR. The short version:

- **Summary**: what's different after this merges (the *outcome*, not the activity)
- **Related issue**: link to the ticket
- **How to test**: steps a reviewer can follow
- **Screenshots**: for any UI change
- **Notes for the reviewer**: anything you're unsure about or want extra eyes on

Skip sections that don't apply, but write "N/A because…" so your reviewer
can see you thought about it.

---

## Keeping your branch up to date

While you're working, `dev` will move forward as other PRs land. You need
to pull those changes into your branch periodically — especially before
opening your PR for review.

**We use `merge` for this, not `rebase`.** Here's how:

```bash
# From your feature branch
git checkout feat/dark-mode-toggle

# Get the latest dev
git fetch origin
git merge origin/dev

# Resolve any conflicts, commit them, push
git push
```

That's it. If there are conflicts, your editor or a tool like VS Code's
merge editor will guide you through resolving them. Commit the resolution
and push.

### Why merge and not rebase?

Both are valid ways to stay in sync. Here's the honest tradeoff:

- **Merge** is safer and conceptually simpler. You never rewrite history.
  If you get something wrong, nothing is lost. The downside is that your
  branch ends up with "Merge branch 'dev'…" commits in its history.
- **Rebase** produces a cleaner history but requires `git push --force`
  (technically `--force-with-lease`), and getting it wrong on a shared
  branch can cause people to lose work. Conflicts also have to be
  resolved per commit instead of once, which can be brutal on long-lived
  branches.

Because we **squash-merge** PRs into `dev` (more on that below), the messy
merge commits in your feature branch get thrown away anyway. So we get the
clean history benefit *without* the rebase risk. That's why merge is the
right call here.

Once you've shipped a handful of PRs and you're comfortable with git, learn
rebase — it's a powerful tool and you'll want it eventually. Just not on
day one.

---

## How PRs land in `dev`

When your PR is approved, we **squash-merge** it. This means:

- All your commits on the feature branch get combined into a single commit on `dev`.
- The commit message on `dev` will be your PR title.
- `dev`'s history stays linear and readable — one commit per PR.

What this means for you in practice:

- Commit as often and as messily as you like on your feature branch. "fix typo",
  "wip", "actually fix it now" — all fine. They get squashed away.
- Your **PR title** is what ends up in `dev`'s history forever. Take a few
  seconds to make it good.

---

## A few extra tips

- **Pull before you start work each day.** Saves you from a painful merge later.
- **Push often.** Pushed code is backed up; unpushed code lives only on your laptop.
- **Open PRs in draft mode** if you want early feedback before the work is
  done. GitHub has a "Create draft pull request" option for this.
- **Keep PRs small.** A PR with 50 lines of change gets reviewed in 10 minutes.
  A PR with 500 lines of change gets a rubber-stamp review or sits for days.
  If you find yourself with a huge PR, see if it can be split.
- **If you're stuck on git, ask.** Git problems compound fast, and the
  recovery is usually much easier when caught early. No one will judge you
  for asking.

---

## Quick reference

```bash
# Start new work
git checkout dev
git pull origin dev
git checkout -b feat/your-feature

# Save progress
git add .
git commit -m "message"
git push

# Update from dev while working
git fetch origin
git merge origin/dev

# Ready for review
# → push, then open PR on GitHub targeting `dev`
```
