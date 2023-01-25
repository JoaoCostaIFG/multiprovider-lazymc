#!/bin/sh -eu

remote="joaocostaifg/multiprovider-lazymc"
lazymc_version="0.2.7"

echo "LazyMC version: $lazymc_version"

for server_provider in purpur paper fabric; do
	for mc_version in 1.14.4 1.15.2 1.16.5 1.17.1 1.18.2 1.19.3; do
		echo "Minecraft version: $mc_version"

		# aarch64 armv7 x64 x64-static
		for cpu_arch in x64 x64-static; do
			echo "Building for $cpu_arch"
			tag="${mc_version}-lazymc${lazymc_version}${cpu_arch}-${server_provider}"
			remote_tag="${remote}:${tag}"
			docker build --build-arg LAZYMC_VERSION="$lazymc_version" --build-arg MC_VERSION="$mc_version" --build-arg CPU_ARCHITECTURE="$cpu_arch" --build-arg SERVER_PROVIDER="$server_provider" -t "$remote_tag" .
			docker push "$remote_tag"
		done
	done
done
