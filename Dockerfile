# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Install system dependencies and virtualenv
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    wget \
    unzip \
    libprotobuf-dev \
    libleveldb-dev \
    libsnappy-dev \
    libopencv-dev \
    libhdf5-serial-dev \
    protobuf-compiler \
    libgflags-dev \
    libgoogle-glog-dev \
    liblmdb-dev \
    python3-dev \
    libboost-all-dev \
    libatlas-base-dev \
    libopenblas-dev \
    liblapack-dev \
    libopenmpi-dev \
    libjpeg-dev \
    zlib1g-dev && \
    rm -rf /var/lib/apt/lists/*

# Install virtualenv
RUN pip install virtualenv

# Copy the requirements.txt from the src folder in the host to the container
COPY src/requirements.txt ./src/requirements.txt

# Install Python dependencies from requirements.txt
RUN pip install --upgrade pip && pip install -r ./src/requirements.txt

# Set the entry point to be bash so you can run commands
CMD ["bash"]
