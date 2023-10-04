got="$(cat $1)"
expected="name: YTT
default: default value
static: 1"

if [ "$got" = "$expected" ]; then
  echo "Passed"
  exit 0
else
  echo "Failed"
  echo "=== expected ==="
  echo "$expected"
  echo "=== got ==="
  echo "$got"
  echo "====="
  exit 1
fi
