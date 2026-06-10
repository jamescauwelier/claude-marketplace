---
name: setup-env
description: Configures the environment with the necessary data to run skills in this plugin. Other skills will express their dependency on this skill at which point it should be triggered per their specification.
---

This outlines the different configuration steps needed to make the skills in this plugin work.

## How to use the setup configuration

Different items may need configuration. Each of the "Setup Steps" need to be run. However, when re-running this skill, after it has already written all `.setup/<config>.md` files, provide the option to update an existing configuration.

If running for the first time, go over each setup step, one by one, and follow instructions there.

Be extremely verbose. Drop all prose. Use lists and select boxes everywhere possible for selection. Do not explain anything, just ask for the values of configuration options and visualize valid options. Error messages, if any, should be 
extremely concise.

## Setup Steps

### Issue Tracker

To get access to issues, we need a ticket tracker. Only one option is available, namely Linear. Follow the instructions in `SETUP-LINEAR.md` to properly compose a ticket tracking solution.