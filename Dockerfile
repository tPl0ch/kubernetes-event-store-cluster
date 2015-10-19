# Container running Event Store
#
# VERSION               0.1
FROM ubuntu:trusty

# That's me :)
MAINTAINER Thomas Ploch "thomas.ploch@tp-solutions.de"

# Set up required env vars
ENV EVENTSTORE_PACKAGE_VERSION=3.3.0 \
  DEBIAN_FRONTEND=noninteractive

# Install wget and https transport for apt
RUN apt-get update && apt-get install -y \
  apt-transport-https \
  wget

# Install the eventstore key and the apt repository
RUN wget -O - https://apt-oss.geteventstore.com/eventstore.key | apt-key add - && \
  echo "deb [arch=amd64] https://apt-oss.geteventstore.com/ubuntu/ trusty main" > /etc/apt/sources.list.d/eventstore.list && \
  apt-get update

# make sure the package repository is up to date
RUN apt-get install -y eventstore-oss=$EVENTSTORE_PACKAGE_VERSION

# Default directories
ENV EVENTSTORE_LOG=/var/log/eventstore \
  EVENTSTORE_DB=/var/lib/eventstore \
  EVENTSTORE_INT_HTTP_PREFIXES=http://127.0.0.1:2112/ \
  EVENTSTORE_EXT_HTTP_PREFIXES=http://*:2113/ \
  EVENTSTORE_INT_IP=127.0.0.1 \
  EVENTSTORE_EXT_IP=0.0.0.0

# Expose the public/internal ports
EXPOSE 2113 1113 2112 1112

# Create the volumes
VOLUME $EVENTSTORE_DB $EVENTSTORE_LOG

# Run as eventstore user
USER eventstore

# set entry point to eventstore executable
ENTRYPOINT ["eventstored"]
