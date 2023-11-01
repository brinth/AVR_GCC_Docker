FROM ubuntu:22.04

#Set metadata
LABEL maintainer="Brinth Khanna <brinthkhanna@yahoo.com>"
LABEL version="1.0"
LABEL description="Docker image for AVR GCC Toolchain"
LABEL org.opencontainers.image.title="AVR GCC Toolchain"
LABEL org.opencontainers.image.version="v1.0"
LABEL org.opencontainers.image.description="AVR GCC Toolchain Environment"
LABEL org.opencontainers.image.source="https://github.com/brinth/AVR_GCC_Docker.git"
LABEL org.opencontainers.image.authors="Brinth Khanna"
LABEL org.opencontainers.image.licenses="Apache 2.0"

#Arguments
ARG AVR_GCC_DIR=/opt/avr_gcc/
ARG AVR_GCC_TOOLCHAIN_REMOTE=https://ww1.microchip.com/downloads/aemDocuments/documents/DEV/ProductDocuments/SoftwareTools/avr8-gnu-toolchain-3.7.0.1796-linux.any.x86_64.tar.gz
ARG AVR_GCC_TOOLCHAIN_DIR=$AVR_GCC_DIR/avr8-gcc-3.7.0

# Install Prerequisites
RUN apt-get update -y
RUN apt-get install -y make libncurses-dev flex bison gperf curl

#Download Toolchain and install
RUN curl -L -o /tmp/avr8-gcc-3.7.0.tar.gz ${AVR_GCC_TOOLCHAIN_REMOTE}
RUN mkdir -p $AVR_GCC_TOOLCHAIN_DIR
WORKDIR $AVR_GCC_TOOLCHAIN_DIR

RUN tar -xvf /tmp/avr8-gcc-3.7.0.tar.gz --strip-components 1

# Export Toolchain path to ENV
ENV PATH="${PATH}:${AVR_GCC_TOOLCHAIN_DIR}/bin"

#Install Programmer
RUN apt-get install -y avrdude

#Cleanup Download
RUN rm -rf /tmp/avr8-gcc-3.7.0.tar.gz



