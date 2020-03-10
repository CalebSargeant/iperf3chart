# iperf3 chart

<img src=http://s.natalian.org/2015-12-27/nuc.local_2015-12-27_wlp4s0.svg alt="LAN wifi">

**Requires** Bash >= 4, [Gnuplot](http://www.gnuplot.info/) >= 5, [iperf3](http://software.es.net/iperf/) & [jq](https://stedolan.github.io/jq/)

# Usage

	$ bash bw-test.sh example.com 5202 # do a bandwidth test to example.com on port 5202 that is running `iperf -s` (leave port blank if default)
	$ while true; do bash bw-test.sh example.com 5202; sleep 1; done # this is an example of constantly running `iperf` test
	$ bash aplot.sh # plot everything
	$ google-chrome-unstable example.com_2015-12-27_wlp4s0.svg


# Related projects

* <https://github.com/esnet/iperf/tree/master/contrib>
* <http://speed.dabase.com/>
