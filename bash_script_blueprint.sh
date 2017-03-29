#!/usr/bin/env bash
################################################################################
# Author: René Kray <rene@kray.info>
# Date: 2017-03-29
# Purpose:
#   genreal blueprint for bash scripts
################################################################################

# ToDo
# - signal handling
# - cleanup


LOGFILE=/tmp/$(basename ${0%.sh})_$(date "+%F").log

################################################################################
# helper function for the log function
################################################################################
function log_line(){
    date=$(date "+%F_%T")
    msg="${date} [$(basename ${0%.sh})] ${*}"
    echo $msg >> $LOGFILE
    [ -v VERBOSE ] && echo $msg
}

################################################################################
# How to use it: 
#   log message to log
#   free | VERBOSE=1 log
################################################################################
function log(){
    [ ${#*} == 0 ] && (
        while read line; do log_line $line; done
    ) || (
        log_line ${*}
    )
}

################################################################################
# main script function
################################################################################
function main(){
    echo main function
    [ -v option ] && echo "option: ${option}"
    [ -v flag ]   && echo "flag setted"
}

################################################################################
# 
################################################################################
function help(){
    help=(
        "  $(basename $0) -[of]"
        "    -o ARGUMENT - option with argument"
        "    -f          - flag"
        "    -h          - show this help"
        ""
    )
    for line in "${help[@]}"; do echo "${line}"; done
}

while getopts o:fh?v o
do	case "$o" in
	o)   option="$OPTARG";;
	f)   flag=1;;
	v)   VERBOSE=1;;
	[?]) help;;
	[h]) help;;
    *)   echo "unknown option ${o}";help;exit ;;
	esac
done
[ -v OPTARG ] && shift $OPTIND-1

main | log
