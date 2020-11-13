FROM alpine:3.12.1

ARG PHP_VER=php7

ARG DEPS="\
    bash                              \
    tar                               \
    wget                              \
    curl                              \
    tzdata                            \
    openssl                           \
    net-tools                         \
    unzip                             \
    mysql-client                      \
    $PHP_VER                          \
    $PHP_VER-common                   \
    $PHP_VER-mysqli                   \
    $PHP_VER-opcache                  \
    $PHP_VER-curl                     \
    $PHP_VER-json                     \
    $PHP_VER-imagick                  \
    $PHP_VER-redis                    \
    $PHP_VER-memcached                \
    $PHP_VER-intl                     \
    $PHP_VER-litespeed                \
"

RUN apk update && apk add $DEPS 


EXPOSE 7080 80 443

WORKDIR /temp-lts-install-dir

COPY . .

RUN apk --no-cache add ca-certificates && \
wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub && \
wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.28-r0/glibc-2.28-r0.apk && \
apk add glibc-2.28-r0.apk

RUN chmod +x ./configs/lsws-install.sh && bash ./configs/lsws-install.sh 
RUN chmod +x ./configs/wp-install.sh && bash ./configs/wp-install.sh

COPY ./configs/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
WORKDIR /var/www/vhosts/ 

