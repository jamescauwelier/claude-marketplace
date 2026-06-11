# Setup Linear

This outlines how to properly configure Linear as our ticket tracker. In order to display all the relevant issues, we need some information on what is relevant to the local user. 

## How to query for filters

When querying Linear through the MCP service, certain filters can be applied. These constrain what will be visualized through the skills in this plugin.

1. First iterate through all possible project filters, and for each variable:
    1.1 Query through the MCP the possible values of a filter 
    1.2 Ask the user to select one or multiple values of a filter while also offering to skip a filter (this is the first option)
    1.3 Save the answers in a `docs/agents/issue-tracker.md` file, following the `issue-tracker.example.md` example
2. Second, do the same for all possible issue filters:
    2.1 Query for possible values
    2.2 Ask the user to select one or multiple values of a filter while also offering to skip a filter (this is the first option
    2.3 Save the answers in a `docs/agents/issue-tracker.md` file, following the `issue-tracker.example.md` example
3. Make sure `docs/agents/issue-tracker.md` is linked to from the root `CLAUDE.md` file so that it gets picked up.

## Filter variables

### Project filters

| Filter name    | Description                          |
|----------------|--------------------------------------|
| Team           | What team(s) are you part of?        |
| Initiatives    | What initiatives should be included? |
| Project status | What project statuses are relevant?  |

### Issue filters

| Filter name    | Description                                                                |
|----------------|----------------------------------------------------------------------------|
| Status         | What issue status values are relevant?                                     |
| Assignees      | What assigness should be surfaced? (likely this is you, and `No assignee`) |

## Re-configure

If this skill is run when there already is a pre-existing `docs/agents/issue-tracker.md`:

- read the current values of the filters
- show an overview of the available project and issue filters 
- ask which needs to be changed, and then update their values

