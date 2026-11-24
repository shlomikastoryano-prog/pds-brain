#!/usr/bin/env bash
# Builds the skills and packs them with the installer into dist/pds-skills.zip to send to the team.
set -euo pipefail
cd "$(dirname "$0")/.."
./scripts/build-skills.sh >/dev/null
rm -rf dist/pack && mkdir -p dist/pack
cp -R skills dist/pack/skills
cp scripts/install-skills.sh scripts/install-skills.command INSTALL-SKILLS.html dist/pack/
rm -f dist/pds-skills.zip
(cd dist/pack && zip -qr ../pds-skills.zip .)
rm -rf dist/pack
echo "created dist/pds-skills.zip"
