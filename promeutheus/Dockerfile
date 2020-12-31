FROM python:3.8

WORKDIR /app/

COPY requirements.txt /app/requirements.txt
RUN pip install -r requirements.txt

COPY ./src/ /app/
ENV FLASK_APP=app.py

CMD flask run -h 0.0.0 -p 5000
