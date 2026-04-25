#!/bin/bash
cd "$(dirname "$0")/.."
firebase emulators:start \
  --only auth,firestore \
  --import=./emulator-data \
  --export-on-exit=./emulator-data
