FROM python:latest

RUN apt-get update && apt-get install --no-install-recommends -y  \
    git \
    build-essential \
    cmake \
    libbz2-dev \
    liblzma-dev \
    libeigen3-dev \
    libboost-all-dev \
    zlib1g-dev \
    wget  && \
    apt-get clean && \
    apt-get autoclean && \
    apt-get autoremove -y

WORKDIR /opt

RUN git clone https://github.com/kpu/kenlm.git && \
    cd kenlm && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make

WORKDIR /opt

RUN pip install pyparsing && \
    git clone https://github.com/cslysy/JSGFTools.git

RUN pip3 install deepspeech

WORKDIR /opt

RUN mkdir deepspeech-native-client && \
    cd deepspeech-native-client && \
    curl -O -J -L https://index.taskcluster.net/v1/task/project.deepspeech.deepspeech.native_client.cpu.0100d2c53f886f37d67aed3dc9688764866a61c1/artifacts/public/native_client.tar.xz && \
    tar xf native_client.tar.xz && \
    rm native_client.tar.xz

    