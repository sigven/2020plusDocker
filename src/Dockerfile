############################################################
# Dockerfile to build 2020plus - based on debian
############################################################

# use Debian as base image
FROM ubuntu:16.04

# set non interactive
#ENV DEBIAN_FRONTEND=noninteractive

# Update the repository sources list
RUN apt-get update
# Install tools used for compilation
ENV PACKAGE_DEV_TOOLS="debconf-utils build-essential gcc-multilib gfortran autoconf apt-utils zlib1g-dev wget git sudo pkg-config curl"
ENV PACKAGE_LIB="libblas-dev liblapack-dev libreadline6-dev libfreetype6 libfreetype6-dev libpcre++-dev liblzma-dev libbz2-dev"
RUN export DEBIAN_FRONTEND=noninteractive 
RUN apt-get install -y tzdata
RUN apt-get install --yes --no-install-recommends $PACKAGE_DEV_TOOLS $PACKAGE_LIB

# Install Rlang
ENV PACKAGE_RLANG="r-base r-cran-randomforest"
RUN apt-get install --yes --no-install-recommends $PACKAGE_RLANG

# Update Python2 and pip
ENV PACKAGE_PY2="python-dev python-pip"
RUN apt-get install --yes --no-install-recommends $PACKAGE_PY2
RUN sudo -H pip install --upgrade pip
RUN sudo -H pip install -U setuptools


ENV HOME=/usr/local
RUN curl -O https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
RUN bash Miniconda3-latest-Linux-x86_64.sh -b
ENV PATH=$PATH:/usr/local/miniconda3/bin:
RUN rm -rf /Miniconda3-latest-Linux-x86_64.sh

RUN git clone git://github.com/KarchinLab/2020plus.git
RUN cd /2020plus && conda env create -f environment_python.yml
RUN /bin/bash -c "source activate 2020plus"
RUN conda install r r-randomForest rpy2

ENV PATH=$PATH:/2020plus:


# # Clean up
RUN apt-get clean autoclean
RUN apt-get autoremove -y
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN rm -rf /var/lib/{dpkg,cache,log}
