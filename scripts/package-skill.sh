#!/usr/bin/env bash
# Builds script-writer.zip for upload to claude.ai (Settings → Capabilities →
# Skills). The zip must contain the skill folder itself so SKILL.md sits at
# script-writer/SKILL.md inside the archive.
set -euo pipefail

cd "$(dirname "$0")/../skills"
rm -f ../script-writer.zip
zip -r ../script-writer.zip script-writer -x '*.DS_Store'
echo "Built $(cd .. && pwd)/script-writer.zip"
