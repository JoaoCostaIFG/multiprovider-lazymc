#!/bin/sh

set -eu

case "$SERVER_PROVIDER" in
"purpur")
	printf "\033[0;31mDownloading Purpur\033[0m\n"
	curl "https://api.purpurmc.org/v2/purpur/${MC_VERSION}/latest/download" -Jo /server
	;;
"paper")
	printf "\033[0;31mDownloading Paper\033[0m\n"
	latest_build="$(curl "https://papermc.io/api/v2/projects/paper/versions/${MC_VERSION}/builds/" | jq -r '.builds[-1]')"
	build_number=$(printf "%s" "$latest_build" | jq -r '.build')
	jar_name="$(printf "%s" "$latest_build" | jq -r '.downloads.application.name')"

	curl "https://api.papermc.io/v2/projects/paper/versions/${MC_VERSION}/builds/${build_number}/downloads/${jar_name}" -Jo /server
	;;
"fabric")
	printf "\033[0;31mDownloading Fabric\033[0m\n"
	latest_build="$(curl "https://meta.fabricmc.net/v2/versions/loader/${MC_VERSION}" | jq -r '.[0]')"
	loader_version="$(printf "%s" "$latest_build" | jq -r '.loader.version')"
	installer_version="$(curl 'https://meta.fabricmc.net/v2/versions/installer' | jq -r '.[0].version')"
	curl "https://meta.fabricmc.net/v2/versions/loader/${MC_VERSION}/${loader_version}/${installer_version}/server/jar" -Jo /server
	;;
*)
	printf "\033[0;31mUnsupported server provider: %s. Exiting...\033[0m\n" "$SERVER_PROVIDER"
	exit 1
	;;
esac
