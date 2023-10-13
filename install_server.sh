#!/bin/sh
# Thanks to https://serverjars.com/
# Docs: https://serverjars.com/documentation

set -eu

download() {
	mc_version="${MC_VERSION}"
	if [ "$mc_version" = "latest" ]; then
		mc_version="$(curl -s "https://serverjars.com/api/fetchLatest/${typeName}/${catNameLower}" | jq -r '.response.version')"
	fi

	printf "\033[0;31mDownloading %s version %s\033[0m\n" "${catName}" "${mc_version}"
	curl -s "https://serverjars.com/api/fetchJar/${typeName}/${catNameLower}/${mc_version}" -Jo /server
}

catNameLower="$(printf "%s" "${SERVER_PROVIDER}" | awk '{print tolower($0)}')"

case "${catNameLower}" in
# modded
"mohist")
	typeName="modded"
	;;
"fabric")
	typeName="modded"
	;;
"forge")
	typeName="modded"
	;;
"catserver")
	typeName="modded"
	;;
# servers
"paper")
	typeName="servers"
	;;
"purpur")
	typeName="servers"
	;;
"sponge")
	typeName="servers"
	;;
# vanilla
"vanilla")
	typeName="vanilla"
	;;
"snapshot")
	typeName="vanilla"
	;;
*)
	printf "\033[0;31mUnsupported server provider: %s. Exiting...\033[0m\n" "$SERVER_PROVIDER"
	exit 1
	;;
esac

catName="$(printf "%s" "$catNameLower" | sed 's/./\U&/')"

download
