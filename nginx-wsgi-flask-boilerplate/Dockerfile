FROM python:3.8

RUN apt-get update
RUN apt-get install -y --no-install-recommends libatlas-base-dev gfortran nginx supervisor

RUN pip3 install uwsgi

COPY ./requirements.txt /app/requirements.txt

RUN pip3 install -r /app/requirements.txt

RUN useradd --no-create-home nginx

RUN rm /etc/nginx/sites-enabled/default
RUN rm -r /root/.cache

COPY conf/nginx.conf /etc/nginx/
COPY conf/flask-site-nginx.conf /etc/nginx/conf.d/
COPY conf/uwsgi.ini /etc/uwsgi/
COPY conf/supervisord.conf /etc/supervisor/

COPY src /app/src

WORKDIR /app

CMD ["/usr/bin/supervisord"]
