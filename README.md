[![CircleCI](https://circleci.com/gh/viewthespace/mfa-watchdog.svg?style=svg)](https://circleci.com/gh/viewthespace/mfa-watchdog)

Thor task for checking organization users for 2-factor auth enablement. This is useful for services that do not have a way to enforce 2FA at an organization level.

Checks GitHub organization and Heroku organization users and posts messages to Slack (or log to CLI) for users who do not have 2FA enabled.
