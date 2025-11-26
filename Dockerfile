FROM ubuntu:24.04

RUN apt update &&\
    apt install -y wget
RUN useradd -ms /bin/bash admin
RUN mkdir /workspace && chown admin:admin /workspace

WORKDIR /workspace
USER admin

RUN wget https://download.java.net/openjdk/jdk11.0.0.2/ri/openjdk-11.0.0.2_linux-x64.tar.gz &&\
    tar -xzvf openjdk-11.0.0.2_linux-x64.tar.gz &&\
    mv jdk-11.0.0.2 java &&\
    rm openjdk-11.0.0.2_linux-x64.tar.gz

ENV JAVA_HOME=/workspace/java
ENV PATH=$PATH:$JAVA_HOME/bin

RUN wget https://dlcdn.apache.org/flink/flink-2.1.1/flink-2.1.1-bin-scala_2.12.tgz  &&\
    tar -xzvf flink-2.1.1-bin-scala_2.12.tgz &&\
    mv flink-2.1.1 flink &&\
    rm flink-2.1.1-bin-scala_2.12.tgz &&\
    cd flink &&\
    mkdir connector &&\
    cd connector &&\
    wget https://repo.maven.apache.org/maven2/org/apache/flink/flink-sql-connector-kafka/4.0.0-2.0/flink-sql-connector-kafka-4.0.0-2.0.jar

RUN chmod -R 755 /workspace/flink
ENV FLINK_HOME=/workspace/flink
ENV PATH=$PATH:$FLINK_HOME/bin