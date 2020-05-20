#!/bin/bash


#opwd=$(pwd)
#shopt -s nullglob

### FUNCTIONS
#exists() { [[ -e $1 ]]; }

JSON_COLLECT() {
	cat "$w"*.json | jq ".end.sum_$1.bits_per_second"
}

DIVIDEND() {
	for line in $(echo "$1")
		do
			# "awk '{ print sprintf("%.0f", $1); }'" rounds down the values to remove decimals to be able to sum
			echo "$line" | awk '{ print sprintf("%.0f", $1); }'
		# "awk '{sum+=$0} END{print sum}'" sums the output values
		done | awk '{sum+=$0} END{print sum}'
}

DIVISOR() {
	echo "$1" | wc -w
}

DIVISOR=$(ls -hal | wc -l | tr -d '[:space:]')

QUOTIENT() {
	echo $(( $1 / $DIVISOR / 8 ))
}

PLOT() {
	SENT_HOURLY=$(JSON_COLLECT sent)
	SENT_DIVIDEND=$(DIVIDEND "$SENT_HOURLY")
	#SENT_DIVISOR=$(DIVISOR "$SENT_HOURLY")
	#SENT_QUOTIENT=$(QUOTIENT "$SENT_DIVIDEND / $SENT_DIVISOR")
	SENT_QUOTIENT=$(QUOTIENT "$SENT_DIVIDEND")

	RECEIVED_HOURLY=$(JSON_COLLECT received)
	RECEIVED_DIVIDEND=$(DIVIDEND "$RECEIVED_HOURLY")
	#RECEIVED_DIVISOR=$(DIVISOR "$RECEIVED_HOURLY")
	#RECEIVED_QUOTIENT=$(QUOTIENT "$RECEIVED_DIVIDEND / $RECEIVED_DIVISOR")
	RECEIVED_QUOTIENT=$(QUOTIENT "$RECEIVED_DIVIDEND")

	echo "$XLABEL" "$SENT_QUOTIENT" "$RECEIVED_QUOTIENT" >> avg-data.log
}

# For each parent directory
for q in $(ls -d */ | sed 's"/""g'); do
	#svg="$q-$1.svg"
	svg="$q.svg"
	echo Processing directory "$q/"
	# For each child directory
	for w in $(ls -d "$q"/*/); do
		XLABEL=$(basename "$w")
		echo Processing sub-directory "$w"
		# Remove empty directory
		rmdir "$w" 2>/dev/null
		# Find JSONs
		count=$(ls -1 *.json "$w" 2>/dev/null | wc -l)
		if [ $count != 0 ]; then
			echo JSONs FOUND
			# Delete error JSONs
			for j in $(ls -1 *.json "$w" 2>/dev/null | tail -n +2); do
				if jq -e '.error' < "$w$j"
				then
			    echo "$j has an error, deleting"
					rm "$w$j"
				fi
			done > /dev/null
			PLOT
		else
			echo NO JSONs FOUND
			continue
		fi
	done
	gnuplot avg-graph.conf > "$svg"
	rm avg-data.log
done
