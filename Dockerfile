FROM ubuntu:trusty-20180123

RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    pkg-config \
    build-essential \
    git 

RUN wget "https://julialang-s3.julialang.org/bin/linux/x64/0.6/julia-0.6.2-linux-x86_64.tar.gz" && \
   tar xzf julia-0.6.2-linux-x86_64.tar.gz && \
   rm julia-0.6.2-linux-x86_64.tar.gz && \
   ln -s `pwd`/julia-d386e40c17/bin/julia /usr/local/bin/julia

ADD ./DrakeVisualizer.jl /DrakeVisualizer
WORKDIR /DrakeVisualizer

ENV DEBIAN_FRONTEND=noninteractive
RUN echo 'APT::Get::Assume-Yes "true";' >> /etc/apt/apt.conf
RUN echo 'APT::Get::force-yes "true";' >> /etc/apt/apt.conf

RUN julia -e "Pkg.clone(pwd())"
RUN julia -e "Pkg.build(\"DrakeVisualizer\")"
