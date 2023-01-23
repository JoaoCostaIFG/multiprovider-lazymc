#!/bin/sh -eu

remote="joaocostaifg/lazymc-purpur"
lazymc_version="0.2.7"

echo "LazyMC version: $lazymc_version"

for mc_version in 1.8.3 1.12.2 1.16.5 1.17.1i 1.18.2 1.19.3; do
	echo "Minecraft version: $mc_version"

	# aarch64 armv7 x64 x64-static
	for cpu_arch in x64 x64-static; do
		echo "Building for $cpu_arch"
		tag="${mc_version}-lazymc${lazymc_version}${cpu_arch}"
		remote_tag="${remote}:${tag}"
		docker build --build-arg LAZYMC_VERSION="$lazymc_version" --build-arg CPU_ARCHITECTURE="$cpu_arch" -t "$remote_tag" .
		docker push "$remote_tag"
	done
done
