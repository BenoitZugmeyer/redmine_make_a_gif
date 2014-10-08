#!/bin/sh

set -euo pipefail

SCRIPTDIR=$(cd "$(dirname "$0")"; pwd)

# Tmpdir creation / deletion
TMPDIR=$(mktemp -d)
on_exit () {
    rm -rf "$TMPDIR"
}
trap on_exit EXIT

cd "$TMPDIR"

set -x

git clone https://github.com/yahoo/gifshot.git .

npm install

node_modules/.bin/gulp custom-build --webcam

cp build/custom/gifshot.custom.min.js "$SCRIPTDIR/assets/javascripts/gifshot.js"

set +x
