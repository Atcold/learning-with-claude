#!/usr/bin/env bash
set -euo pipefail

# The style installs itself: alfdoc ships the one copy of this logic, and every consumer
# of the style fetches and runs it, so the texmf path lives in exactly one repo.
curl -fsSL https://raw.githubusercontent.com/Atcold/alfdoc/master/install.sh | bash
