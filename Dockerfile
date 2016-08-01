# Pull base image.
FROM bigboards/cdh-base-__arch__

MAINTAINER bigboards
USER root 

ADD docker_files/cdh_kafka.list /etc/apt/sources.list.d/
ADD docker_files/archive.key /tmp/
ADD docker_files/run.sh /apps/run.sh
RUN chmod a+x /apps/run.sh

RUN apt-key add /tmp/archive.key \
 && apt-get update \
 && apt-get -y install kafka kafka-server \
 && apt-get clean \
 && apt-get autoclean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/apt/archives/*.deb

# declare the volumes
RUN mkdir -p /etc/hadoop/conf.bb && \
    update-alternatives --install /etc/hadoop/conf hadoop-conf /etc/hadoop/conf.bb 1 && \
    update-alternatives --set hadoop-conf /etc/hadoop/conf.bb
VOLUME /etc/hadoop/conf.bb

#RUN mkdir -p /etc/kafka/conf && \
#    update-alternatives --install /etc/flume-ng/conf flume-ng-conf /etc/flume-ng/conf.bb 1 && \
#    update-alternatives --set flume-ng-conf /etc/flume-ng/conf.bb
#VOLUME /etc/flume-ng/conf.bb

# external ports
EXPOSE 9393 9092 9093 24042

CMD ["/apps/run.sh"]
