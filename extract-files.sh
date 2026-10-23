#!/vendor/bin/sh
# Wrapper kept for compatibility - the python extract-utils is canonical.
exec "$(dirname "$0")/extract-files.py" "$@"
