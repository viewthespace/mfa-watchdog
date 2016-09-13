[![CircleCI](https://circleci.com/gh/viewthespace/mfa-watchdog.svg?style=svg)](https://circleci.com/gh/viewthespace/mfa-watchdog)

Thor task for checking organization users for 2-factor auth enablement.

Checks GitHub organization and Heroku organization users and posts messages to Slack (or log to CLI) for users who do not have 2FA enabled.
