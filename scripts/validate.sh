#!/bin/bash
# Validate n8n workflow JSON files for structural correctness
set -e

ERRORS=0
TOTAL=0

echo "Validating n8n workflow files..."
echo ""

for file in workflows/**/*.json; do
  TOTAL=$((TOTAL + 1))

  # Check valid JSON
  if ! python3 -m json.tool "$file" > /dev/null 2>&1; then
    echo "❌ INVALID JSON: $file"
    ERRORS=$((ERRORS + 1))
    continue
  fi

  # Check required fields (nodes, connections)
  NODES=$(python3 -c "
import json, sys
d = json.load(open('$file'))
nodes = d.get('nodes', [])
conns = d.get('connections', {})
if not nodes:
    print('ERROR: no nodes')
    sys.exit(1)
if not conns:
    print('ERROR: no connections')
    sys.exit(1)
# Check each node has required fields
for n in nodes:
    if 'type' not in n:
        print(f'ERROR: node missing type')
        sys.exit(1)
    if 'name' not in n:
        print(f'ERROR: node missing name')
        sys.exit(1)
print(f'{len(nodes)} nodes, {len(conns)} connections')
" 2>&1)

  if [ $? -ne 0 ]; then
    echo "❌ INVALID: $file — $NODES"
    ERRORS=$((ERRORS + 1))
  else
    echo "✅ $file — $NODES"
  fi
done

echo ""
echo "Validated $TOTAL workflows, $ERRORS errors"

if [ $ERRORS -gt 0 ]; then
  exit 1
fi

echo "All workflows valid!"
