#!/bin/bash 
set -e

function funShowHelpAndExit() {
  cat << __EOF
  Ussage:
  q "regex text pattern" [-n "<file_name_pattern>"] [-l level] [-I] 
__EOF
  exit 1
}
Q_LEVEL=${Q_LEVEL:-4}          # default value: up to file sub-dirs. in depth
Q_FILE_NAME=${Q_FILE_NAME:-*}  # default value: find in all files.
Q_NO_ICASE=0                   # default value: ignore case

readonly GREP_PATTERN=$1
shift 1

while [ $# -gt 1 ]; do
  ## Echo "ASDF" for any non-matching case.
  case "$1" in
    -n)
      readonly Q_FILE_NAME=${2}
      shift 2
      ;;
    -l)
      readonly Q_LEVEL=${2}
      shift 2
      ;;
    -I)
      readonly Q_NO_ICASE=1
      shift 1
      ;;
    *)
      funShowHelpAndExit
      ;;
  esac
done


if [[ GREP_PATTERN == "" ]] ; then
  exit 2
fi

THIS=$(basename $0)
GREP_OPTS=""
GREP_OPTS="${GREP_OPTS} --with-filename "
if [[ $Q_NO_ICASE == 0 ]] ; then
   GREP_OPTS="${GREP_OPTS} -i "
fi
readonly GREP_OPTS="${GREP_OPTS}"

# https://stackoverflow.com/questions/4210042/how-to-exclude-a-directory-in-find-command
find ./ \
   -maxdepth ${Q_LEVEL} \
   -type f \
   -not \( -path "**/node_modules/*" -prune \) \
   -not \( -path "**/.git/*" -prune \) \
   -not \( -path "**/build/*" -prune \) \
   -not \( -type d \) \
   -iname "${Q_FILE_NAME}" \
   -exec grep ${GREP_OPTS} "${GREP_PATTERN}" {} \;
