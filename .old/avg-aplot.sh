#!/bin/bash
# Thanks to http://mywiki.wooledge.org/BashFAQ & the guys on #bash Freenode IRC

shopt -s globstar
opwd=$(pwd)
exists() { [[ -e $1 ]]; }

#svg=$(echo "${i%/}_$1.svg")

for o in $(ls -d */)
do
	svg="$($o-$1.svg | tr / _)"
	for i in **/$1*
	do
		cd "$i" || continue
		if exists ./*.json
		then
			echo Processing directory "$i"
			#svg="$(dirname "$i")-$1.svg"
			#svg=$(echo "${i%/}" | tr / _).svg
			test -s "$opwd"/"$svg" ||
			"$opwd"/avg-plot.sh #| gnuplot > "$opwd"/"$svg"
		fi
		cd "$opwd" || exit
	done
	gnuplot avg-graph.conf > "$svg"
	rm avg-data.log
done
