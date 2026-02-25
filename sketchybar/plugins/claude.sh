#!/bin/bash
export PATH="/opt/homebrew/bin:$PATH"

RESULT=$(npx --yes ccusage blocks --json --order desc 2>/dev/null | python3 -c "
import json, sys
from datetime import datetime, timezone, timedelta

data = json.load(sys.stdin)
blocks = [b for b in data.get('blocks', []) if not b.get('isGap')]

if not blocks:
    print('--')
    sys.exit()

max_tokens = max(b['tokenCounts']['outputTokens'] for b in blocks)
active = next((b for b in blocks if b.get('isActive')), None)

if active:
    total = active['tokenCounts']['outputTokens']
    remaining_min = int(active['projection']['remainingMinutes'])
    pct = min(round(total / max_tokens * 100), 100) if max_tokens else 0
    h, m = remaining_min // 60, remaining_min % 60
    countdown = f'{h}h{m:02d}m' if h > 0 else f'{m}m'
    print(f'{pct}% {countdown}')
else:
    last = blocks[0]
    cost = last['costUSD']
    now = datetime.now(timezone.utc)
    current_slot = (now.hour // 5) * 5
    next_slot = current_slot + 5
    next_block = now.replace(hour=next_slot % 24, minute=0, second=0, microsecond=0)
    if next_slot >= 24:
        next_block += timedelta(days=1)
    if next_block <= now:
        next_block += timedelta(hours=5)
    diff_min = int((next_block - now).total_seconds() / 60)
    h, m = diff_min // 60, diff_min % 60
    print(f'\${cost:.2f} reset {h}h{m:02d}m' if h > 0 else f'\${cost:.2f} reset {m}m')
" 2>/dev/null)

if [ -z "$RESULT" ]; then
  sketchybar --set "$NAME" label="--"
else
  sketchybar --set "$NAME" label="$RESULT"
fi
