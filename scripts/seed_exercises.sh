#!/bin/bash
# Seed exercises into Firebase Firestore EMULATOR
# Usage: ./scripts/seed_exercises.sh
# Requires emulator running on localhost:8080

set -e

PROJECT_ID="workout-diary-4d3d3"
EMULATOR_HOST="localhost:8080"
SEED_FILE="firebase/seed/exercises.json"

if [ ! -f "$SEED_FILE" ]; then
  echo "Error: $SEED_FILE not found"
  exit 1
fi

echo "Seeding exercises from $SEED_FILE into emulator..."

python3 <<PYEOF
import json
import urllib.request

with open("$SEED_FILE") as f:
    exercises = json.load(f)

for ex in exercises:
    ex_id = ex.pop("id")
    fields = {}
    for k, v in ex.items():
        if v is None:
            fields[k] = {"nullValue": None}
        elif isinstance(v, bool):
            fields[k] = {"booleanValue": v}
        elif isinstance(v, str):
            fields[k] = {"stringValue": v}

    body = json.dumps({"fields": fields}).encode()
    url = f"http://$EMULATOR_HOST/v1/projects/$PROJECT_ID/databases/(default)/documents/exercises/{ex_id}"
    req = urllib.request.Request(url, data=body, method="PATCH", headers={"Content-Type": "application/json"})
    try:
        urllib.request.urlopen(req)
        print(f"  OK {ex_id}")
    except Exception as e:
        print(f"  FAIL {ex_id}: {e}")

print("Done.")
PYEOF
