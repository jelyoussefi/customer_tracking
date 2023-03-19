FROM intel/dlstreamer:devel
ENV DEBIAN_FRONTEND noninteractive

USER root

RUN rm /etc/apt/sources.list.d/intel-openvino.list

RUN apt-get update -y
RUN apt-get -y install \
    libcanberra-gtk-module \
    libcanberra-gtk3-module
RUN apt-get clean

RUN pip3 install  prometheus_client 

RUN mkdir /workspace
COPY models.lst /workspace
RUN mkdir /workspace/models/

WORKDIR /workspace

RUN omz_downloader --list ./models.lst -o /workspace/models/ && \
    omz_converter  --list ./models.lst -o /workspace/models/ -d /workspace/models/

COPY customer_tracking.py /workspace
COPY customer_tracking.sh /workspace
COPY model_proc /workspace


