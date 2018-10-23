#!/bin/bash

cleanup_and_exit() {
    docker kill $server > /dev/null
    exit ${1:-1}
}

set -e
trap cleanup_and_exit SIGINT ERR

# Launch the Python service
server=$(docker run --rm -p 5000:5000 --detach pisadns)

# Run Apache Benchmark tool "ab".
# Launch multiple "ab" processes in parallel to ensure they
# do not become the scaling bottleneck themselves.
# You will need to manually add up the results!
docker run --ulimit nofile=11000 --link $server:server --rm --entrypoint /usr/local/apache2/bin/ab httpd:2.4 -n 500000 -c 1000 -k http://server:5000/ &
docker run --ulimit nofile=11000 --link $server:server --rm --entrypoint /usr/local/apache2/bin/ab httpd:2.4 -n 500000 -c 1000 -k http://server:5000/

wait
cleanup_and_exit 0
