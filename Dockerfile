FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu22.04 as base

# Set insatllation process to non-interactive mode
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt update && apt install -y software-properties-common

# Add the repositories
RUN add-apt-repository ppa:deadsnakes/ppa

# Install base python and python pip
RUN apt install -y \
    linux-libc-dev \
    linux-headers-generic \
    build-essential \
    cmake \
    binutils \
    libproj-dev \
    libgdal-dev \
    libcairo2-dev \
    libjpeg-dev \
    libgif-dev \
    gdal-bin \
    r-base \
    r-base-dev \
    python3 \
    python3-pip \
    python3-dev

# Copy the python requirements
COPY requirements.txt ./requirements.txt

# Intall the requirements
RUN python3 -m pip install --no-cache-dir -r ./requirements.txt

#RUN apt install -y nvidia-cuda-toolkit
# clean up
# remove the apt package meta data which is not necessary for the container
RUN rm -rf ./requirements.txt
RUN rm -rf /var/lib/apt/lists/*