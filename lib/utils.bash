#!/usr/bin/env bash

set -euo pipefail

GH_REPO="https://github.com/transifex/cli"
TOOL_NAME="tx"
TOOL_TEST="tx --help"

fail() {
  echo -e "asdf-$TOOL_NAME: $*"
  exit 1
}

curl_opts=(-fsSL)

sort_versions() {
  sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
    LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_github_tags() {
  git ls-remote --tags --refs "$GH_REPO" |
    grep -o 'refs/tags/.*' | cut -d/ -f3- |
    sed 's/^v//'
}

list_all_versions() {
  list_github_tags
}

download_release() {
  local -r platform="$(get_platform)"
  local -r version="$1"
  local -r filename="$2"

  local -r url="$GH_REPO/releases/download/v${version}/tx-${platform}-arm64.tar.gz"

  echo "* Downloading $TOOL_NAME release $version..."
  curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"
}

get_platform() {
  local -r kernel="$(uname -s)"
  if [[ $OSTYPE == "msys" || $kernel == "CYGWIN"* || $kernel == "MINGW"* ]]; then
    fail "tx supports MacOS and Linux only."
  else
    uname | tr '[:upper:]' '[:lower:]'
  fi
}

install_version() {
  local install_type="$1"
  local version="$2"
  local install_path="$3"

  if [ "$install_type" != "version" ]; then
    fail "asdf-$TOOL_NAME supports release installs only"
  fi

  (
    mkdir -p "$install_path/bin/"
    cp -r "$ASDF_DOWNLOAD_PATH"/* "$install_path/bin/"

    local -r tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"
    chmod +x "$install_path/bin/$tool_cmd"
    test -x "$install_path/bin/$tool_cmd" || fail "Expected $install_path/bin/$tool_cmd to be executable."

    echo "$TOOL_NAME $version installation was successful!"
  ) || (
    rm -rf "$install_path"
    fail "An error ocurred while installing $TOOL_NAME $version."
  )
}
