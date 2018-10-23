#!/usr/bin/env python3
from gevent.pywsgi import WSGIServer

DATA = b"X" * 10000


def application(env, start_response):
    start_response('200 OK', [('Content-Type', 'application/text')])
    return [DATA]


server = WSGIServer(('0.0.0.0', 5000), application)
server.serve_forever()
