#!/bin/sh -eu

if [ ! -e eula.txt ] || grep -q 'eula=false' eula.txt; then
	# generate EULA stuff
	java -jar /purpur
	exit 1
fi

if [ ! -e lazymc.toml ]; then
	# generate config
	/lazymc config generate
fi

java_opts="-Xms${MC_RAM_MIN} -Xmx${MC_RAM_MAX} --add-modules=jdk.incubator.vector $*"
echo "Java opts: $java_opts"

sed -i "s~^command = .*~command = 'java $java_opts -jar /purpur --nogui'~" lazymc.toml

/lazymc start
