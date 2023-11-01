# AVR_GCC_Docker
Dockerized containter for AVR GCC toolchain

---
[![size](https://img.shields.io/github/repo-size/brinth/AVR_GCC_Docker)](https://github.com/brinth/AVR_GCC_Docker)
[![lang](https://img.shields.io/github/languages/top/brinth/AVR_GCC_Docker)](https://github.com/brinth/AVR_GCC_Docker)
[![commits](https://img.shields.io/github/commit-activity/t/brinth/AVR_GCC_Docker)](https://github.com/brinth/AVR_GCC_Docker)
[![contributers](https://img.shields.io/github/contributors/brinth/AVR_GCC_Docker)](https://github.com/brinth/AVR_GCC_Docker)
[![pulls](https://img.shields.io/docker/pulls/brinth/avr_gcc)](https://github.com/brinth/AVR_GCC_Docker)
[![forks](https://img.shields.io/github/forks/brinth/AVR_GCC_Docker)](https://github.com/brinth/AVR_GCC_Docker)
[![star](https://img.shields.io/github/stars/brinth/AVR_GCC_Docker)](https://github.com/brinth/AVR_GCC_Docker)
[![open issues](https://img.shields.io/github/issues-raw/brinth/AVR_GCC_Docker)](https://github.com/brinth/AVR_GCC_Docker)
[![closed issues](https://img.shields.io/github/issues-closed/brinth/AVR_GCC_Docker)](https://github.com/brinth/AVR_GCC_Docker)
[![pull requests](https://img.shields.io/github/issues-pr/brinth/AVR_GCC_Docker)](https://github.com/brinth/AVR_GCC_Docker)

---
### Requirements
* Docker [install](https://docs.docker.com/get-docker/)

---
### Building AVR GCC Project
- **Step 1:** Clone this repository 
```bash
git clone git@github.com:brinth/AVR_GCC_Docker.git
```
- **Step 2:** cd to cloned directory & Build Docker image
```bash
docker build -t <image name> .
```
Replace `<image name>` with any readable name
- **Step 3:** cd to your AVR GCC project dir and Run Docker container with previously build Docker image
```bash
docker run -it --rm -v $PWD:/project -w /project <image name>  make
```

---
### Flashing AVR GCC Project
Run Command
```bash
docker run -it --rm --privileged -v $PWD:/project -v <local device file>:/dev/ttyUSB0 -w /project <image name> avrdude <args> 
```
Replace `<local device file>` with the enumerated device file name like `/dev/ttyUSB0`

---
