got="$(cat $1)"
expected="name: YTT
default: default value
static: 1
image: repo/image@sha256:ae59f3b71bffe15917f1b4e94218d1d46f21938ff1d1b2a04dfdf77f3763224e"

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
