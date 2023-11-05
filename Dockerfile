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
ARG AVR_GCC_DIR=/opt/avr_gcc
ARG AVR_GCC_TOOLCHAIN_REMOTE=https://ww1.microchip.com/downloads/aemDocuments/documents/DEV/ProductDocuments/SoftwareTools/avr8-gnu-toolchain-3.7.0.1796-linux.any.x86_64.tar.gz
ARG AVR_GCC_TOOLCHAIN_DIR=$AVR_GCC_DIR/avr8-gcc-3.7.0
ARG AVR_LIBC_REMOTE=http://download.savannah.gnu.org/releases/avr-libc/avr-libc-2.1.0.tar.bz2
ARG AVR_LIBC_DIR=$AVR_GCC_DIR/avr-libc
ARG SIMUL_AVR_ENABLE=false
ARG LIBSIM_REMOTE=http://download.savannah.nongnu.org/releases/simulavr/libsim_1.1.0_amd64.deb
ARG SIMUL_AVR_REMOTE=http://download.savannah.nongnu.org/releases/simulavr/simulavr-vpi_1.1.0_amd64.deb
ARG SIMUL_AVR_DIR=$AVR_GCC_DIR/simul-avr-1.0.0

#Install Prerequisites
RUN apt-get update -y
RUN apt-get install -y make libncurses-dev binutils flex bison gperf curl bzip2 autotools-dev autoconf

#Download Toolchain and install
RUN curl -L -o /tmp/avr8-gcc-3.7.0.tar.gz ${AVR_GCC_TOOLCHAIN_REMOTE}
RUN mkdir -p $AVR_GCC_TOOLCHAIN_DIR 
WORKDIR $AVR_GCC_TOOLCHAIN_DIR
RUN tar -xvf /tmp/avr8-gcc-3.7.0.tar.gz --strip-components 1
RUN curl -L -o /tmp/avr-libc-2.1.0.tar.bz2 ${AVR_LIBC_REMOTE}

#Export Toolchain path to ENV
ENV PATH="${PATH}:${AVR_GCC_TOOLCHAIN_DIR}/bin"

#Download avr-libc and install
RUN mkdir -p $AVR_LIBC_DIR
WORKDIR $AVR_LIBC_DIR/source
RUN bunzip2 -c /tmp/avr-libc-2.1.0.tar.bz2 | tar -xf - --strip-components 1
RUN ./bootstrap
RUN ./configure --prefix=$AVR_LIBC_DIR --build=`./config.guess` --host=avr && \
make && \
make install

#Download simavr and install
RUN if [ "$SIMUL_AVR_ENABLE" = "true" ]; then \
curl -Lv -o /tmp/libsim-avr-1.1.0.deb ${LIBSIM_REMOTE} && dpkg -i /tmp/libsim-avr-1.1.0.deb; \
curl -Lv -o /tmp/simul-avr-1.1.0.deb ${SIMUL_AVR_REMOTE} && dpkg -i /tmp/simul-avr-1.1.0.deb; \
fi
ENV PATH="${PATH}:${SIMUL_AVR_DIR}/install/bin"

#Install Binutils, Programmer & GDB
RUN apt-get install -y avrdude gdb-avr
WORKDIR $AVR_GCC_DIR

#Cleanup Download
RUN rm -rf /tmp/avr8-gcc-3.7.0.tar.gz
RUN rm -rf /tmp/libsim-avr-1.1.0.deb
RUN rm -rf /tmp/simul-avr-1.1.0.deb



