#!/bin/sh

set -eux

# Verify correct branch
git checkout develop

# Build new binary
stack build

# Build new files
stack exec site clean
stack exec site build

# Get previous files
git fetch --all
git checkout -b master --track origin/master

# Make master up-to-date
git pull origin develop

# Overwrite existing files with new files
cp -a _site/. .

# Commit
git add -A
git commit -m "Publish."

# Push
git push origin master:master

# Restoration
git checkout develop
git branch -D master
