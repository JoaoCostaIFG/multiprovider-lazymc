#!/bin/sh

chown -R minecraft:minecraft /data
exec runuser -u minecraft -- /run.sh
