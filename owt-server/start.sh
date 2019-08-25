#!/usr/bin/env bash

service rabbitmq-server start \
    && cd /owt-server/dist/bin \
    && cp /config/portal.toml /owt-server/dist/portal/portal.toml \
    && cp /config/management_api.toml /owt-server/dist/management_api/management_api.toml \
    && cp /config/management_console.toml /owt-server/dist/management_console/management_console.toml \
    && /owt-server/dist/management_api/init.sh --dburl=mongo/owtdb \
    && ./start-all.sh \
    && sleep infinity
