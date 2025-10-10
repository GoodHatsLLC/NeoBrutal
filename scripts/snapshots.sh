#!/usr/bin/env bash

cd $(git rev-parse --show-toplevel)

swift run NeoBrutalistSnapshots
pushd scripts;
bun install;
popd;
./scripts/capture-demo.sh Snapshots/window.png
