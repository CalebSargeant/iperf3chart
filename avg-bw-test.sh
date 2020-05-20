opwd=$(pwd)

BW_TEST() {
  bash "$opwd/bw-test.sh" "$1" "$2"
}

declare -A HOSTS=(
  [bouygues.iperf.fr]=5202
  [ping.online.net]=5208
  #[speedtest.serverius.net]=5002
  #[iperf.eenet.ee]=5201
  #[iperf.viola.net]=5201
  #[iperf.it-north.net]=5208
  [iperf.biznetnetworks.com]=5202
  #[iperf.scottlinux.com]=5201
  [iperf.he.net]=5201
)

while true; do
  for i in "${!HOSTS[@]}"; do
    HOST="$i"
    PORT="${HOSTS[$HOST]}"

    echo TEST NUMBER $((n=n+1)) - "$HOST":"$PORT"
    BW_TEST "$HOST" "$PORT"
    sleep 1
  done
done
