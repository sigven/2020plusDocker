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
ENV PACKAGE_DEV_TOOLS="debconf-utils build-essential gcc-multilib gfortran autoconf apt-utils zlib1g-dev wget git sudo pkg-config"
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

# Install Probabilistic2020
RUN git clone git://github.com/KarchinLab/probabilistic2020.git
RUN sudo -H pip install numpy
RUN sudo -H pip install scipy
RUN sudo -H pip install pandas>=0.17.0
RUN sudo -H pip install pysam
RUN cd /probabilistic2020 && \
make build && \
ln -s /probabilistic2020/prob2020/console/probabilistic2020.py /usr/local/bin/probabilistic2020.py

# Install 2020plus
RUN git clone git://github.com/KarchinLab/2020plus.git
RUN sudo -H pip install scikit-learn
RUN sudo -H pip install rpy2==2.8.2
RUN sudo -H pip install probabilistic2020
RUN cd /2020plus && \
ln -s /2020plus/2020plus.py /usr/local/bin/2020plus.py

# Install Python3 and Snakemake
ENV PACKAGE_PY3="python3-dev python3-pip"
RUN apt-get install --yes --no-install-recommends $PACKAGE_PY3
RUN sudo -H pip3 install --upgrade pip
RUN sudo -H pip3 install -U setuptools
RUN sudo -H pip3 install -U snakemake

# Clean up
#RUN apt-get remove --yes --purge $PACKAGE_DEV_TOOLS
RUN apt-get clean autoclean
RUN apt-get autoremove -y
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN rm -rf /var/lib/{dpkg,cache,log}
