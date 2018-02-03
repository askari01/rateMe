#!/bin/sh
if which sentry-cli >/dev/null; then
export SENTRY_ORG=askari
export SENTRY_PROJECT=rateme
export SENTRY_AUTH_TOKEN=6b6466dad02d49b1b993453b4681f12f0258e9c5bc7442d48cb30837b4d7c22e
ERROR=$(sentry-cli upload-dsym 2>&1 >/dev/null)
if [ ! $? -eq 0 ]; then
echo "warning: sentry-cli - $ERROR"
fi
else
echo "warning: sentry-cli not installed, download from https://github.com/getsentry/sentry-cli/releases"
fi
