#!/bin/bash

# to prevent the script from running more than once
if [ -f "/var/log/startup-script-ran" ]; then
    exit 0
fi

sudo apt update -y && sudo apt upgrade -y

# TODO
# - install docker and docker-compose
# - auto setup postgresql using docker-compose

touch "/var/log/startup-script-ran"