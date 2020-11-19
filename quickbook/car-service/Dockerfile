FROM python:3.8

ARG PROTOC_ZIP=protoc-3.7.1-linux-x86_64.zip

# RUN adduser -D joyvan
# WORKDIR /home/joyvan

# RUN apk add --update \
#     gcc \
#     g++ \
#     make \
#     musl-dev \
#     python3-dev \s
#     libc6-compat \  
#     && rm -rf /var/cache/apk/*

RUN curl -OL https://github.com/protocolbuffers/protobuf/releases/download/v3.7.1/$PROTOC_ZIP
RUN unzip -o $PROTOC_ZIP -d /usr/local bin/protoc
RUN unzip -o $PROTOC_ZIP -d /usr/local 'include/*'
RUN rm -f $PROTOC_ZIP

# COPY ./protos/ /quickbook/protos/
COPY ./ /home/quickbook/

ENV PYTHONPATH /home/quickbook/src

WORKDIR /home/quickbook

RUN pip3 install -r /home/quickbook/requirements.txt
RUN python -m grpc_tools.protoc -I./protos --python_out=./src --grpc_python_out=./src ./protos/*.proto
# RUN protoc --proto_path=proto proto/*.proto --go_out=plugins=grpc:target

# FROM base as dev

# WORKDIR /quickbook/src

CMD python src/server.py


# RUN pip install ptvsd

# WORKDIR /quickbook/src

# CMD python -m ptvsd --host 0.0.0.0 --port 5678 --wait --multiprocess -m flask run -h 0.0.0.0 -p 5000
