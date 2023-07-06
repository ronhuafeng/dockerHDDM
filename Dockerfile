ARG BASE_CONTAINER=jupyter/minimal-notebook:python-3.8
FROM $BASE_CONTAINER

LABEL authors="Hu Chuan-Peng <hcp4715@hotmail.com>,bef0rewind <ron.huafeng@gmail.com>"

# USER root

# RUN sudo apt-get update && \
#     sudo apt-get install -y --no-install-recommends apt-utils && \
#     sudo apt-get install -y --no-install-recommends ffmpeg dvipng && \
#     sudo apt-get install -y \
#     libatlas-base-dev \
#     gcc g++ gfortran zlib1g zlib1g-dev libnuma-dev m4 bzip2 wget flex libfl-dev bison python3 python3-dev cmake libblas-dev liblapack-dev r-base libboost-all-dev libopenblas-dev libxml2-dev \
#     doxygen libnlopt-dev libtbb-dev libmuparser-dev swig libceres-dev libcminpack-dev libgflags-dev python3-numpy python3-scipy python3-matplotlib \
#     gfortran \
#     libopenblas-dev \
#     liblapack-dev \
#     build-essential cmake \
#     curl gnupg git qemu-user \
#     libc6 libstdc++6 bison flex liblapack-dev libnlopt-dev libdlib-dev libboost-math-dev libxml2-dev libcminpack-dev libprimesieve-dev libnlopt-cxx-dev libceres-dev libmpfr-dev libmpc-dev libgoogle-glog-dev libgflags-dev libmetis-dev libeigen3-dev libpng-dev libsqlite3-dev libjpeg-dev swig \
#     libexpat1-dev zlib1g-dev python3-distutils libjs-sphinxdoc libbz2-1.0 libdb5.3 libncursesw6 libreadline8 libuuid1 && \
#     sudo rm -rf /var/lib/apt/lists/*

# USER $NB_UID

# ENV MAKEFLAGS -j8
# RUN git clone https://github.com/openturns/openturns.git && \
#     cd openturns && \
#     mkdir build && cd build && \
#     cmake -DCMAKE_INSTALL_PREFIX=~/.local \
#     -DCMAKE_UNITY_BUILD=ON -DCMAKE_UNITY_BUILD_BATCH_SIZE=32 \
#     -DPython_EXECUTABLE=/opt/conda/bin/python -DSWIG_COMPILE_FLAGS="-O1" .. && \
#     make install && \
#     make clean

# Install the required packages for pymc2
RUN apt-get update && apt-get install -y \
    gcc \
    libatlas-dev \
    libatlas-base-dev \
    liblapack-dev \
    gfortran && \
    rm -rf /var/lib/apt/lists/*

RUN pip install numpy==1.22.2 && pip install --no-cache-dir git+https://github.com/ronhuafeng/pymc2@master




# 
RUN pip install --no-cache-dir git+https://github.com//ronhuafeng/kabuki@master && \
    pip install --no-cache-dir git+https://github.com/hddm-devs/hddm && \
    fix-permissions "/home/${NB_USER}"
