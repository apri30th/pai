# Copyright (c) Microsoft Corporation
# All rights reserved.
#
# MIT License
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
# documentation files (the "Software"), to deal in the Software without restriction, including without limitation
# the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and
# to permit persons to whom the Software is furnished to do so, subject to the following conditions:
# The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED *AS IS*, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING
# BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
# DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

FROM nvidia/cuda:9.1-cudnn7-devel-ubuntu16.04

ENV STAGE_DIR=/root/drivers \
    PYTHONPATH=/modules

RUN apt-get -y update && \
    apt-get -y install \
        build-essential \
        gcc \
        g++ \
        binutils \
        pciutils \
        bind9-host \
        bc \
        libssl-dev \
        software-properties-common \
        git \
        vim \
        wget \
        curl \
        make \
        jq \
        psmisc \
        python \
        python-dev \
        python-yaml \
        python-jinja2 \
        python-urllib3 \
        python-tz \
        python-nose \
        python-prettytable \
        python-netifaces \
        python-pip \
        realpath \
        gawk \
        module-init-tools && \
    pip install subprocess32 && \
    add-apt-repository -y ppa:ubuntu-toolchain-r/test && \
    mkdir -p $STAGE_DIR

WORKDIR $STAGE_DIR

ENV NVIDIA_VERSION=410.73

RUN wget --no-verbose http://us.download.nvidia.com/XFree86/Linux-x86_64/$NVIDIA_VERSION/NVIDIA-Linux-x86_64-$NVIDIA_VERSION.run && \
    chmod 750 ./NVIDIA-Linux-x86_64-$NVIDIA_VERSION.run && \
    ./NVIDIA-Linux-x86_64-$NVIDIA_VERSION.run --extract-only && \
    rm ./NVIDIA-Linux-x86_64-$NVIDIA_VERSION.run

COPY build/* $STAGE_DIR/

CMD /bin/bash install-all-drivers
