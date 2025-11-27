FROM ubuntu:24.04

RUN apt update && \
    apt install -y python3 &&\
    apt install -y python3-pip &&\
    ln -s /usr/bin/python3 /usr/bin/python &&\
    pip install apache-flink --break-system-packages

WORKDIR /workspace

COPY ./jdk-11.0.0.2 ./java
ENV JAVA_HOME=/workspace/java
ENV PATH=$PATH:$JAVA_HOME/bin

COPY ./flink ./flink
RUN mkdir -p /workspace/flink/connector
COPY ./flink-sql-connector-kafka-4.0.0-2.0.jar /workspace/flink/connector/flink-sql-connector-kafka-4.0.0-2.0.jar

ENV FLINK_HOME=/workspace/flink
ENV PATH=$PATH:$FLINK_HOME/bin
WORKDIR /workspace
