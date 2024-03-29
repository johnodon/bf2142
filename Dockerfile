FROM ubuntu

MAINTAINER johnodon

RUN echo "deb http://us.archive.ubuntu.com/ubuntu/ bionic multiverse" >> /etc/apt/source.list
RUN echo "deb-src http://us.archive.ubuntu.com/ubuntu/ bionic multiverse">> /etc/apt/source.list
RUN echo "deb http://us.archive.ubuntu.com/ubuntu/ bionic-updates multiverse" >> /etc/apt/source.list
RUN echo "deb-src http://us.archive.ubuntu.com/ubuntu/ bionic-updates multiverse" >> /etc/apt/source.list
RUN apt-get update && apt-get -y dist-upgrade
RUN apt-get -y install wget screen unzip curl expect unrar

ENV DATA_DIR="/serverfiles"
ENV SERVER_DIR="/serverfiles/bf2142"
ENV SCRIPTS_DIR="/opt/scripts"
ENV UID=99
ENV GID=100

RUN mkdir /serverfiles
RUN useradd -d $DATA_DIR -s /bin/bash --uid $UID --gid $GID bf2142

ADD /scripts/ /opt/scripts/

RUN chmod -R 770 /opt/scripts/
RUN chown -R bf2142 /opt/scripts
RUN chown -R bf2142 $DATA_DIR

USER bf2142

#Server Start
ENTRYPOINT ["/opt/scripts/setup.sh"]
