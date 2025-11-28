FROM ubuntu:24.04

RUN apt update && \
    apt install -y python3 &&\
    apt install -y python3-pip &&\
    ln -s /usr/bin/python3 /usr/bin/python &&\
    pip install apache-flink --break-system-packages

WORKDIR /workspace

COPY ./jdk ./java
ENV JAVA_HOME=/workspace/java
ENV PATH=$PATH:$JAVA_HOME/bin

COPY ./flink ./flink
RUN mkdir /workspace/flink/connectors

ENV FLINK_HOME=/workspace/flink
ENV PATH=$PATH:$FLINK_HOME/bin
ENV CLASSPATH=$CLASSPATH:/workspace/flink/connectors/*:.
ENV CLASSPATH=$CLASSPATH:/workspace/flink/lib/*:.
WORKDIR /workspace