#!/usr/bin/env bash

cd $(git rev-parse --show-toplevel)

swift run NeoBrutalSnapshots
pushd scripts;
bun install;
popd;
./scripts/capture-demo.sh Snapshots/window.png
