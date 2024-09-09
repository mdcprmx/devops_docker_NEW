#!/bin/bash

service nginx start
spawn-fcgi -p 8080 ./server.o

# why use tail? it's a failsafe way to make sure that docker wont go sleep
tail -f /dev/null