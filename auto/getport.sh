#!/bin/sh
name=$1
docker inspect --format='{{(index (index .NetworkSettings.Ports "8080/tcp") 0).HostPort}}' lims${name}

