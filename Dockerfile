FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
    software-properties-common \
    git \
    build-essential \
    python3 \
    python3-pip \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*
RUN add-apt-repository ppa:swi-prolog/devel && \
    apt-get update && apt-get install -y swi-prolog swi-prolog-nox
RUN pip3 install janus-swi
WORKDIR /app
CMD ["/bin/bash"]
