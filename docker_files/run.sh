#!/bin/bash

if [ -z "$KAFKA_JAVA_OPTS" ]; then
	JAVA_OPTS="-Xmx512M -server  -Dlog4j.configuration=file:/etc/kafka/conf/log4j.properties"
fi

/usr/lib/kafka/bin/kafka-server-start.sh /etc/kafka/conf/server.properties 
