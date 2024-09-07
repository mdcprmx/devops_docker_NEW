FROM nginx:stable

ENV DOCKER_CONTENT_TRUST=1

USER root

COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./p3_server_src.c /etc/nginx/p3_server_src.c
COPY ./start.sh /etc/nginx/start.sh

RUN apt-get update && \
    apt-get install -y gcc && \
    apt-get install -y spawn-fcgi && \
    apt-get install -y libfcgi-dev && \
    useradd myuser && \
    chown -R myuser:myuser /etc/nginx/nginx.conf && \
    chown -R myuser:myuser /etc/nginx/ && \
    chown -R myuser:myuser /var/cache/nginx/ && \
    touch /var/run/nginx.pid && \
    chown -R myuser:myuser /var/run/nginx.pid && \
    chmod u-s /usr/bin/chsh && \
    chmod u-s /usr/bin/mount && \
    chmod u-s /usr/bin/passwd && \
    chmod u-s /usr/bin/su && \
    chmod u-s /usr/sbin/unix_chkpwd && \
    chmod u-s /usr/bin/chfn && \
    chmod u-s /usr/bin/gpasswd && \
    chmod u-s /usr/bin/expiry && \
    chmod u-s /usr/bin/newgrp && \
    chmod u-s /usr/bin/chage && \
    chmod u-s /usr/bin/umount && \
    rm -rf /var/lib/apt/lists

USER myuser

# yep, this directive must be here for successfull gcc compilation
WORKDIR /etc/nginx/

RUN gcc p3_server_src.c -lfcgi -o server.o && \
    chmod +x ./start.sh

HEALTHCHECK --interval=5m --timeout=3s CMD curl -f http://localhost:81 || exit 1

ENTRYPOINT ["./start.sh"]