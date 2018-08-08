#!/bin/bash

SERVICE_NAME=${SERVICE_NAME:-php-fpm}
CONSUL=${CONSUL:-consul}

preStart() {
        echo "php-fpm preStart"
        consul-template \
            -once \
            -dedup \
            -template "/etc/php-fpm/php-fpm.conf.ctmpl:/usr/local/etc/php-fpm.conf"
}

onChange() {
    echo "php-fpm onChange"
}


help() {
    echo "Usage: ./reload.sh preStart  => first-run configuration for php-fpm"
    echo "       ./reload.sh onChange  => [default] update php-fom config on upstream changes"
}

until
    cmd=$1
    if [ -z "$cmd" ]; then
        onChange
    fi
    shift 1
    $cmd "$@"
    [ "$?" -ne 127 ]
do
    onChange
    exit
done
