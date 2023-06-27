#!/bin/bash

if [ ! -d "$1" ]; then
  echo "Usage: $0 LIBDIR"
  exit 1
fi

LIBDIR="$1"
AWK_LIB_PREFIX=$(echo "$LIBDIR" | sed -e 's/\//\\\//g')

find bin lib libexec -type file | while read -r FILE; do
  if [ $(file -b --mime-type "${FILE}") != "application/x-mach-binary" ]; then
    continue
  fi

  HAS_CHANGED=false
  while read LINK; do
    LINK_NAME=$(basename "${LINK}")
    if [ -z "${LINK}" ] || [ $(basename "$FILE") = "${LINK_NAME}" ]; then
      continue
    fi
    install_name_tool -change "${LINK}" "@rpath/${LINK_NAME}" "${FILE}"
    HAS_CHANGED=true
  done <<<"$(otool -LX ${FILE} | awk /${AWK_LIB_PREFIX}/'{ print $1 }')"

  if [ "$HAS_CHANGED" = true ]; then
    if [ $(dirname "${FILE}") != "lib" ]; then
      install_name_tool -add_rpath "@loader_path/$(dirname ${FILE} | sed -e 's/[^/]*/../g')/lib" "${FILE}"
    fi
    echo "Patched ${FILE}"
  fi
done
