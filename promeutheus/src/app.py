import time
from random import randint

from flask import Flask, request, Response
import prometheus_client 
from prometheus_client import Counter, Histogram


app = Flask(__name__)

stats = {}

stats['counter'] = Counter('request_operations_total', 'Total number of processed requests')
stats['histogram'] = Histogram('request_duration_seconds',
    'Histogram for the duration in seconds.', buckets=(1, 2, 5, 6, 10, float('inf')))

@app.route('/')
def ping():
    start = time.time()
    time.sleep(randint(0, 5))
    end = time.time()

    stats['counter'].inc()
    stats['histogram'].observe(end - start)

    return 'Pinged!'


@app.route("/metrics")
def requests_count():
    res = []
    for v in stats.values():
        res.append(prometheus_client.generate_latest(v))

    return Response(res, mimetype="text/plain")
