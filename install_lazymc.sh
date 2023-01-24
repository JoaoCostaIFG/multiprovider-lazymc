#!/bin/sh

set -eu

if [ "$LAZYMC_VERSION" = "latest" ]; then
	url="$(curl -s 'https://api.github.com/repos/timvisee/lazymc/releases/latest' | grep 'browser_' | cut -d\" -f4 | grep "\-${CPU_ARCHITECTURE}\$")"
else
	url="https://github.com/timvisee/lazymc/releases/download/v${LAZYMC_VERSION}/lazymc-v${LAZYMC_VERSION}-linux-${CPU_ARCHITECTURE}"
fi

wget "$url" -qO /lazymc && chmod +x /lazymc
