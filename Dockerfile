FROM ubuntu:20.04

ARG version
ENV v8_version=$version

RUN apt update
RUN apt install git curl python python3 lsb-release sudo -y
RUN git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
RUN export PATH=/depot_tools:$PATH
ENV PATH=/depot_tools:$PATH

# RUN gclient

RUN mkdir ~/v8 && cd ~/v8
RUN fetch v8
RUN cd v8


RUN git checkout $version
RUN gclient sync

RUN curl https://raw.githubusercontent.com/DanielDKing/install-build-deps/main/install-build-deps.sh -o install-build-deps.sh
RUN chmod +x install-build-deps.sh
RUN ./install-build-deps.sh
