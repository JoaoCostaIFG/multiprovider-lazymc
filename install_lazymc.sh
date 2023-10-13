#!/bin/sh

set -eu

if [ "$LAZYMC_VERSION" = "latest" ]; then
	printf "\033[0;31mInstalling latest LazyMC\033[0m\n"
	url="$(curl -s 'https://api.github.com/repos/timvisee/lazymc/releases/latest' | grep 'browser_' | cut -d\" -f4 | grep "\-${CPU_ARCHITECTURE}\$")"
else
	printf "\033[0;31mInstalling LazyMC version %s\033[0m\n" "$LAZYMC_VERSION"
	url="https://github.com/timvisee/lazymc/releases/download/v${LAZYMC_VERSION}/lazymc-v${LAZYMC_VERSION}-linux-${CPU_ARCHITECTURE}"
fi

curl -s "$url" -Lo /lazymc && chmod +x /lazymc
