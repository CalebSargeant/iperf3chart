# echo $(( ... ))
  # allows for arithmetic https://stackoverflow.com/questions/1088098/how-do-i-divide-in-the-linux-console
# cat *.json | jq '.end.sum_sent.bits_per_second / 8'
  # returns output of sent.bits from each json file
# awk '{sum+=$0} END{print sum}'
  # adds all the output up https://stackoverflow.com/questions/52065570/how-do-i-sum-all-numbers-from-output-of-jq
# awk '{ print sprintf("%.0f", $1); }'
  # changes to normal notation from scientific https://unix.stackexchange.com/questions/104332/remove-scientific-notation-bash-script  and  https://stackoverflow.com/questions/8356698/how-to-remove-decimal-from-a-variable
echo $(( $(cat *.json | jq '.end.sum_sent.bits_per_second / 8' | awk '{sum+=$0} END{print sum}' | awk '{ print sprintf("%.0f", $1); }') / 1 ))

# exec 5>&1
  # Duplicate &1 in your shell (in my examle to 5) and use &5 in the subshell (so that you will write to stdout (&1) of the parent shell) https://stackoverflow.com/questions/12451278/capture-stdout-to-a-variable-but-still-display-it-in-the-console
# tee >(wc -l)
  # Counts the number of lines of output https://unix.stackexchange.com/questions/72819/count-number-of-lines-of-output-from-previous-program
exec 5>&1
divisor=$(cat *.json | jq '.end.sum_sent.bits_per_second / 8' | tee >(wc -l) >&5)


echo $(( divisor=$(cat *.json | jq '.end.sum_sent.bits_per_second / 8' | tee >(wc -l) >&5) | awk '{sum+=$0} END{print sum}' | awk '{ print sprintf("%.0f", $1); }') / "$divisor" ))





hsent=$(cat *.json | jq '.end.sum_sent.bits_per_second')
dividend=$(echo $hsent | awk '{sum+=$0} END{print sum}' | awk '{ print sprintf("%.0f", $1); }')
dividend=$(echo $hsent | awk '{s+=$1} END {printf "%.0f", s}')
divisor=$(echo $hsent | wc -w)
quotient=$(echo $(( $(echo $dividend) / $(echo $divisor) /8 )) )


for line in $(echo "$hsent")
  do
    printf "$line\n" | awk '{s+=$1} END {printf "%.0f", s}'
  done

sent2=$(for line in $(cat *.json | jq '.end.sum_sent.bits_per_second'); do printf "\n$line\n" | awk '{s+=$1} END {printf "%.0f", s}'; done)
