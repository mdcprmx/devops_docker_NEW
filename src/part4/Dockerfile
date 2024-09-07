FROM nginx

USER root

COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./p3_server_src.c /etc/nginx/p3_server_src.c
COPY ./start.sh /etc/nginx/start.sh

RUN apt-get update && \
    apt-get install -y gcc && \
    apt-get install -y spawn-fcgi && \
    apt-get install -y libfcgi-dev

# yep, this directive must be here for successfull gcc compilation
WORKDIR /etc/nginx/

RUN gcc p3_server_src.c -lfcgi -o server.o && \
    chmod +x ./start.sh

# then we just start sh script
ENTRYPOINT ["./start.sh"]