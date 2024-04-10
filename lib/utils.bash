#!/usr/bin/env bash

set -euo pipefail

GH_REPO="https://github.com/golang/go"
TOOL_NAME="go"
TOOL_TEST="go version"

fail() {
	echo -e "asdf-$TOOL_NAME: $*"
	exit 1
}

curl_opts=(-fsSL)

# NOTE: You might want to remove this if go is not hosted on GitHub releases.
if [ -n "${GITHUB_API_TOKEN:-}" ]; then
	curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

sort_versions() {
	awk -F/go '{ print $2 }' |
		uniq |
		sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n |
		grep -v '^1\($\|\.0\|\.0\.[0-9]\|\.1\|\.1rc[0-9]\|\.1\.[0-9]\|.2\|\.2rc[0-9]\|\.2\.1\|.8.5rc5\)$' |
		tr '\n' ' '
}

list_all_versions() {
	git ls-remote --tags --refs "$GH_REPO" "go*"
}

download_release() {
	local version filename url
	version="$1"
	filename="$2"
	local platform=""
	local arch=""

	platform=$(get_platform)
	arch=$(get_arch)

	url="https://dl.google.com/go/go${version}.${platform}-${arch}.tar.gz"

	echo "* Downloading $TOOL_NAME release $version..."
	curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"
}

install_version() {
	local install_type="$1"
	local version="$2"
	local install_path="${3%/bin}"

	if [ "$install_type" != "version" ]; then
		fail "asdf-$TOOL_NAME supports release installs only"
	fi

	(
		mkdir -p "$install_path"
		cp -r "$ASDF_DOWNLOAD_PATH"/* "$install_path"

		local tool_cmd
		tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"
		test -x "$install_path/bin/$tool_cmd" || fail "Expected $install_path/$tool_cmd to be executable."

		echo "$TOOL_NAME $version installation was successful!"
	) || (
		rm -rf "$install_path"
		fail "An error occurred while installing $TOOL_NAME $version."
	)
}

get_platform() {
	local platform=""

	platform="$(uname | tr '[:upper:]' '[:lower:]')"

	case "$platform" in
	linux | darwin | freebsd) ;;
	*)
		fail "Platform '${platform}' not supported!"
		;;
	esac

	printf "%s" "$platform"
}

get_arch() {
	local arch=""
	local arch_check=${ASDF_GOLANG_OVERWRITE_ARCH:-"$(uname -m)"}
	case "${arch_check}" in
	x86_64 | amd64) arch="amd64" ;;
	i686 | i386 | 386) arch="386" ;;
	armv6l | armv7l) arch="armv6l" ;;
	aarch64 | arm64) arch="arm64" ;;
	ppc64le) arch="ppc64le" ;;
	*)
		fail "Arch '${arch_check}' not supported!"
		;;
	esac

	printf "%s" "$arch"
}
