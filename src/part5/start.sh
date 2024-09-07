#!/bin/bash

# welp, self explainatory
service nginx start
# starting our server
spawn-fcgi -p 8080 ./server.o
# reloading nginx after spawn-fcgi server up
nginx -s reload

# why use tail? it's a failsafe way to make sure that docker wont go sleep
tail -f /dev/null