FROM python:3.8 as base

COPY ./requirements.txt /app/requirements.txt
RUN pip3 install -r /app/requirements.txt

COPY src /app/src

FROM base as dev
RUN pip install ptvsd

ENV FLASK_APP=app.py
WORKDIR /app/src

CMD python -m ptvsd --host 0.0.0.0 --port 5678 --wait --multiprocess -m flask run -h 0.0.0.0 -p 5000

FROM base as prod

RUN apt-get update
RUN apt-get install -y --no-install-recommends libatlas-base-dev gfortran nginx supervisor

RUN pip3 install uwsgi

RUN useradd --no-create-home nginx

RUN rm /etc/nginx/sites-enabled/default
RUN rm -r /root/.cache

COPY conf/nginx.conf /etc/nginx/
COPY conf/flask-site-nginx.conf /etc/nginx/conf.d/
COPY conf/uwsgi.ini /etc/uwsgi/
COPY conf/supervisord.conf /etc/supervisor/

WORKDIR /app

CMD ["/usr/bin/supervisord"]
