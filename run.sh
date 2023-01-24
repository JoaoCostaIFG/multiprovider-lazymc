#!/bin/sh

set -eu

if [ ! -e eula.txt ] || grep -q 'eula=false' eula.txt; then
	# generate EULA stuff
	java -jar /server
	exit 1
fi

if [ ! -e lazymc.toml ]; then
	# generate config
	/lazymc config generate
fi

java_opts="-Xms${MC_RAM_MIN:-512M} -Xmx${MC_RAM_MAX:-1G} --add-modules=jdk.incubator.vector ${JAVA_OPTS:-""}"
echo "Java opts: $java_opts"

sed -i "s~^command = .*~command = 'java $java_opts -jar /server --nogui'~" lazymc.toml

/lazymc start "$@"
