# skills

James Cauwelier's collection of [Claude Code](https://code.claude.com) agent skills,
distributed as a plugin marketplace.

## Install

Add the marketplace once, then install whichever plugins you want:

```
/plugin marketplace add james-prophetic/skills
/plugin install plan@jamescauwelier
/plugin install review@jamescauwelier
```

Or from the CLI:

```bash
claude plugin marketplace add james-prophetic/skills
claude plugin install plan@jamescauwelier
claude plugin install review@jamescauwelier
```

After installing, reload to pick the skills up:

```
/reload-plugins
```

Skills are invoked as `/<plugin>:<skill-name>`, e.g. `/plan:grill-me` and
`/review:review-docs`.

## Layout

The repo root is a **marketplace** that catalogs two **plugins**, each under
`plugins/<plugin>/`. Within a plugin, skills live **one level deep** under
`skills/<skill-name>/SKILL.md` and are auto-discovered — no manifest edits are needed
when adding a new skill to an existing plugin.

```
.claude-plugin/marketplace.json   # catalogs the plugins below
plugins/
├── plan/
│   ├── .claude-plugin/plugin.json
│   └── skills/grill-me/SKILL.md
└── review/
    ├── .claude-plugin/plugin.json
    └── skills/review-docs/SKILL.md
```

> **Note:** Claude Code's skill discovery only scans `skills/<skill-name>/SKILL.md`
> within a plugin. Do not nest skills in extra subfolders (e.g.
> `skills/engineering/review-docs/`) — the extra directory level hides them. Group
> related skills by putting them in the same plugin instead.

## Adding a plugin or skill

- **New skill in an existing plugin:** drop `plugins/<plugin>/skills/<name>/SKILL.md`.
  No manifest change needed, but a reinstall is required (see Local installs).
- **New plugin:** create `plugins/<plugin>/.claude-plugin/plugin.json`, add its
  `skills/`, and add an entry to the `plugins` array in `marketplace.json` with
  `"source": "./plugins/<plugin>"` (the `./` prefix is required).

## Plugin configuration

- `.claude-plugin/marketplace.json` — the marketplace catalog listing each plugin and its `source`.
- `plugins/<plugin>/.claude-plugin/plugin.json` — one manifest per plugin.

## Local installs

To use the skills without pulling from GitHub, add the marketplace from a local path.
This exercises the real plugin flow against your working copy, so it's the best way to
test changes to `marketplace.json`, `plugin.json`, or a skill before pushing:

```
/plugin marketplace add /Users/jamescauwelier/Documents/Projects/skills
/plugin install plan@jamescauwelier
/plugin install review@jamescauwelier
/reload-plugins
```

From the CLI:

```bash
claude plugin marketplace add /local/path/to/skills
claude plugin install plan@jamescauwelier
claude plugin install review@jamescauwelier
```

Editing the *contents* of an existing `SKILL.md` only needs `/reload-plugins`. But the
installed plugin is copied into a version-keyed cache, so **adding, moving, or removing
a skill — or changing `marketplace.json` — requires a reinstall**, not just a reload:

```
/plugin marketplace update jamescauwelier
/plugin uninstall plan@jamescauwelier && /plugin install plan@jamescauwelier
```

To switch back to the GitHub source later, remove the local one and re-add by repo:

```
/plugin marketplace remove jamescauwelier
/plugin marketplace add james-prophetic/skills
```
