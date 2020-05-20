#!/bin/bash
# Thanks to http://mywiki.wooledge.org/BashFAQ & the guys on #bash Freenode IRC

shopt -s globstar
opwd=$(pwd)
exists() { [[ -e $1 ]]; }

for i in **/$1*
do
	cd "$i" || continue
	if exists ./*.json
	then
		echo Processing directory $i
		svg=$(echo "${i%/}" | tr / _).svg
		test -s "$opwd"/"$svg" ||
		"$opwd"/plot2.sh | gnuplot > "$opwd"/"$svg"
	fi
	cd "$opwd" || exit
done
