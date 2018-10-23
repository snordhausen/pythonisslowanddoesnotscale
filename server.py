#!/usr/bin/env python3
import multiprocessing

from gevent.pywsgi import WSGIServer

DATA = b"X" * 10000


def application(env, start_response):
    start_response('200 OK', [('Content-Type', 'application/text')])
    return [DATA]


server = WSGIServer(('0.0.0.0', 5000), application)
server.init_socket()
for _ in range(multiprocessing.cpu_count()):
    multiprocessing.Process(target=server.serve_forever).start()
