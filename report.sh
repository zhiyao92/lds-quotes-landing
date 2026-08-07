#!/bin/bash
# report.sh — fetch short.io clicks and format as a funnel report
# Run anytime: ./report.sh

set -e
KEY=$(cat ~/.config/shortio/api_key 2>/dev/null || { echo "Error: ~/.config/shortio/api_key not found"; exit 1; })

echo "Fetching short.io stats for weczem.s.gy/lds-quotes..."
STATS=$(curl -s -H "Authorization: $KEY" "https://statistics.short.io/statistics/link/link_84XJ_0342jpnJkJXKzI4CjZbqQO?period=total&tzOffset=480")

TOTAL=$(echo "$STATS" | python3 -c "import json,sys; d=json.load(sys.stdin); print(d.get('totalClicks',0))")
HUMAN=$(echo "$STATS" | python3 -c "import json,sys; d=json.load(sys.stdin); print(d.get('humanClicks',0))")
INSTA=$(echo "$STATS" | python3 -c "import json,sys; d=json.load(sys.stdin); soc=[x for x in d.get('social',[]) if x.get('social')=='Instagram']; print(soc[0].get('score',0) if soc else 0)")

cat <<EOF

╔════════════════════════════════════════════════════════════════╗
║          LDS QUOTES — INSTAGRAM LINK PERFORMANCE               ║
╚════════════════════════════════════════════════════════════════╝

📊 SHORT.IO LINK CLICKS
  Link:              weczem.s.gy/lds-quotes
  Total clicks:      $TOTAL
  Human clicks:      $HUMAN
  From Instagram:    $INSTA

🌍 GEOGRAPHY & DEVICES
EOF

echo "$STATS" | python3 -c "
import json,sys
d=json.load(sys.stdin)
countries = d.get('country', [])
os_list = d.get('os', [])
print('  Countries: ' + ', '.join([f\"{c['countryName']} ({c['score']})\" for c in countries[:3]]))
print('  OS: ' + ', '.join([f\"{x['os']} ({x['score']})\" for x in os_list[:3]]))
"

echo ""
echo "🔗 NEXT STEPS:"
echo "  1. Enable Cloudflare Web Analytics (if not already done)"
echo "     Dashboard → Analytics & Logs → Web Analytics"
echo "  2. Check App Store Connect → Analytics → Sources → Instagram campaign"
echo "     (This shows product-page views + installs from your buttons)"
echo ""
echo "📝 CONVERSION MATH (once Cloudflare is live):"
echo "  Short.io clicks → Cloudflare landing page views → /go button taps → App Store"
echo ""
echo "✓ Report generated at $(date)"
