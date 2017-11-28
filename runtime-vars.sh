#!/bin/sh

COMMIT="$(git rev-parse HEAD)"
URL="$(git config --get remote.origin.url)"

jq -n --arg branch "$BRANCH_NAME" --arg commit "$COMMIT" --arg url "$URL" '{"git_branch":$branch, "git_commit":$commit, "git_url":$url, }' > runtime-vars.json
