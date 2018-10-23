FROM ubuntu:18.10

RUN apt update && apt upgrade -y && apt install -y python3-gevent

COPY server.py /
ENTRYPOINT /server.py

EXPOSE 5000
