#!/usr/bin/env bash
# Double-click on a Mac to install the pds-* skills (runs install-skills.sh next to it).
cd "$(dirname "$0")"
./install-skills.sh
echo
read -n 1 -s -r -p "Done. Press any key to close."
