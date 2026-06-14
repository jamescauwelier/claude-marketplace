# Issue Tracker

The issues for this project are sourced from Linear and the MCP connector to Linear must be used. There are many more issues available than relevant for this project, and so we'll only query and manipulate those as constrained by the parameters in this table:

## How to query?

The steps to identify relevant issues are:

1. Find which projects are relevant?
2. Within those projects, find which issues are relevant?

### Find Relevant Projects

The projects that are relevant can be queried by requiring each of these properties to have any one of the values specified:

| Filter name    | Skipped | Allowed values (if not skipped) |
|----------------|---------|---------------------------------|
| Team           | `no`    | `Engineering`                   |
| Initiatives    | `no`    | `ZoneAI`                        |
| Project status | `no`    | `Planned`, `In Progress`        |

### Find Relevant Issues

The issues that are relevant can be queried by requiring each of these properties to have any one of the values specified, BUT they MUST also be part of the relevant projects that were identified:

| Filter name | Skipped | Allowed values (if not skipped)             |
|-------------|---------|---------------------------------------------|
| Status      | `no`    | `In Progress`, `Todo`                       |
| Assignees   | `no`    | `No assignee`, `james@propheticsoftware.ai` |
