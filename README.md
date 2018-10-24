# Python is slow and does not scale
Python is slow and does not scale, right?


## Requirements
To get things running, you need
* docker
* the `make` command, e.g. by installing `apt install make`

## Running the benchmark
First, build the container with the service by running `make build`.

To run the benchmark, run `make bench`, which launches the benchmark.sh script.

Note that `benchmark.sh` launches multiple `ab` (Apache Benchmark) processes. This
happens because `ab` does not scale over multiple cores and would otherwise become
a bottleneck itself. You need to manually add up the results. On powerful machines
(~8 CPU cores) you need to launch a third `ab` process. Edit `benchmark.sh` to do
this (or to change any of the other benchmark parameters).

Since `ab` is runs on the same machine as the web server itself, part of the system's
resources are spent on on `ab`. However, this facilitates 

## Benchmark Results
AWS instance type | concurrent connections | vCPUs | physical cores | requests / seconds
------------------|------------------------|-------|----------------|-------------------
c5.large | 1250 | 2 | 1 | 4000
c5.xlarge | 2500 | 4 | 2 | 8300
c5.2xlarge | 5000 | 8 | 4 | 18000
c5.4xlarge | 10000 | 16 | 8 | 34500

Note that on c5.4xlarge, I had to start three `ab` processes.

## Links
[gevent](https://github.com/gevent/gevent), a coroutine-based concurrency library for Python
