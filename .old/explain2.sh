
## Working out the average
hsent=$(cat *.json | jq '.end.sum_sent.bits_per_second / 8')

dividend=$(
  for line in $(echo "$hsent")
    do
      # "awk '{ print sprintf("%.0f", $1); }'" rounds down the values to remove decimals to be able to sum
      echo "$line" | awk '{ print sprintf("%.0f", $1); }'
    # "awk '{sum+=$0} END{print sum}'" sums the output values
    done | awk '{sum+=$0} END{print sum}')

divisor=$(echo $hsent | wc -w)

quotient=$(echo $(( $(echo $dividend) / $(echo $divisor) )) )
