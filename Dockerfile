FROM ubuntu:20.04

COPY . /opt/ZimmermanTools-Ubuntu

WORKDIR /opt/ZimmermanTools-Ubuntu

VOLUME ["/data"]

RUN apt-get update && \
      apt-get -y install sudo

RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get -y install tzdata locales

# Set terminal to UTF-8 by default
RUN locale-gen en_US.UTF-8 && update-locale LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN chmod +x \
      Get-ZimmermanTools-Ubuntu.sh \
      zimmermantools-switch.sh
RUN ./Get-ZimmermanTools-Ubuntu.sh

ENTRYPOINT ["/opt/ZimmermanTools-Ubuntu/zimmermantools-switch.sh"]