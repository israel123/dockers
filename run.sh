#!/bin/bash

case $1 in
    build)
        bash ./bin/build.sh
    ;;
    unbuild)
        bash ./bin/unbuild.sh
    ;;
    install)
        bash ./bin/install.sh
    ;;
    uninstall)
        bash ./bin/uninstall.sh
    ;;
    start)
        bash ./bin/start.sh
    ;;
    stop)
        bash ./bin/stop.sh
    ;;
    *)
        echo don\'t know
    ;;
esac