# skills

James Cauwelier's collection of [Claude Code](https://code.claude.com) agent skills,
distributed as a plugin marketplace.

## Install

After cloning this repository, install every plugin from your working copy:

```bash
./bin/install.sh
```

Then run `/reload-plugins` in your Claude Code session to pick up the skills. Remove
everything with `./bin/uninstall.sh`.

Skills are invoked as `/<plugin>:<skill-name>`, e.g. `/project:grill-me` and
`/review:review-docs`.

### Install without cloning

If you'd rather not clone the repo, add the published marketplace and install the
plugins directly with the Claude Code CLI:

```bash
claude plugin marketplace add jamescauwelier/claude-marketplace
claude plugin install project@jamescauwelier
claude plugin install review@jamescauwelier
```

Update later with `claude plugin marketplace update jamescauwelier`, then
`claude plugin install <plugin>@jamescauwelier` again to pick up changes. You can also
do all of this from inside a Claude Code session via the `/plugin` command.

## Layout

The repo root is a **marketplace** that catalogs two **plugins**, each under
`plugins/<plugin>/`. Within a plugin, skills live **one level deep** under
`skills/<skill-name>/SKILL.md` and are auto-discovered.

```
.claude-plugin/marketplace.json   # catalogs the plugins below
bin/                              # install.sh / uninstall.sh
plugins/
├── project/
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
- **New plugin:** create `plugins/<plugin>/.claude-plugin/plugin.json`, add its
  `skills/`, and add an entry to the `plugins` array in `marketplace.json` with
  `"source": "./plugins/<plugin>"` (the `./` prefix is required).

`install.sh` reads the plugin list from `marketplace.json`, so a new plugin needs no
script change.

## Local development

`./bin/install.sh` installs from this working copy, so local edits are picked up.
Re-run it any time to apply changes — it reinstalls each plugin, which is needed
after adding, moving, or removing a skill, or changing `marketplace.json`. Editing the
*contents* of an existing `SKILL.md` only needs `/reload-plugins`.
