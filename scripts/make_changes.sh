#!/bin/bash

CONFIG_PATH="website/config.toml"
CURRENT_VERSION=$(cat $CONFIG_PATH | grep -Po '(?<=version = ")\d{1,4}.\d{1,4}.\d{1,4}') 
NEW_VERSION=$CURRENT_VERSION

# Usage: increment_version <version> [<position>]
# Accepts a version string and prints it incremented by one.
# Usage: increment_version <version> [<position>] [<leftmost>]
# https://wiki.contribs.org/Increment_version_number
increment_version() {
    local usage=" USAGE: $FUNCNAME [-l] [-t] <version> [<position>] [<leftmost>]
            -l : remove leading zeros
            -t : drop trailing zeros
    <version> : The version string.
    <position> : Optional. The position (starting with one) of the number 
                within <version> to increment.  If the position does not 
                exist, it will be created.  Defaults to last position.
    <leftmost> : The leftmost position that can be incremented.  If does not
                exist, position will be created.  This right-padding will
                occur even to right of <position>, unless passed the -t flag."

    # Get flags.
    local flag_remove_leading_zeros=0
    local flag_drop_trailing_zeros=0
    while [ "${1:0:1}" == "-" ]; do
        if [ "$1" == "--" ]; then shift; break
        elif [ "$1" == "-l" ]; then flag_remove_leading_zeros=1
        elif [ "$1" == "-t" ]; then flag_drop_trailing_zeros=1
        else echo -e "Invalid flag: ${1}\n$usage"; return 1; fi
        shift; done

    # Get arguments.
    if [ ${#@} -lt 1 ]; then echo "$usage"; return 1; fi
    local v="${1}"             # version string
    local targetPos=${2-last}  # target position
    local minPos=${3-${2-0}}   # minimum position

    # Split version string into array using its periods. 
    local IFSbak; IFSbak=IFS; IFS='.' # IFS restored at end of func to                     
    read -ra v <<< "$v"               #  avoid breaking other scripts.

    # Determine target position.
    if [ "${targetPos}" == "last" ]; then 
        if [ "${minPos}" == "last" ]; then minPos=0; fi
        targetPos=$((${#v[@]}>${minPos}?${#v[@]}:$minPos)); fi
    if [[ ! ${targetPos} -gt 0 ]]; then
        echo -e "Invalid position: '$targetPos'\n$usage"; return 1; fi
    (( targetPos--  )) || true # offset to match array index

    # Make sure minPosition exists.
    while [ ${#v[@]} -lt ${minPos} ]; do v+=("0"); done;

    # Increment target position.
    v[$targetPos]=`printf %0${#v[$targetPos]}d $((${v[$targetPos]}+1))`;

    # Remove leading zeros, if -l flag passed.
    if [ $flag_remove_leading_zeros == 1 ]; then
        for (( pos=0; $pos<${#v[@]}; pos++ )); do
        v[$pos]=$((${v[$pos]}*1)); done; fi

    # If targetPosition was not at end of array, reset following positions to
    #   zero (or remove them if -t flag was passed).
    if [[ ${flag_drop_trailing_zeros} -eq "1" ]]; then
        for (( p=$((${#v[@]}-1)); $p>$targetPos; p-- )); do unset v[$p]; done
    else for (( p=$((${#v[@]}-1)); $p>$targetPos; p-- )); do v[$p]=0; done; fi

    echo "${v[*]}"
    IFS=IFSbak
    return 0
}

push_changes_dev() {
    make hugo_new_post

    NEW_VERSION=$(increment_version $CURRENT_VERSION)
    bump_version

    make hogo_build_dev
}

push_changes_stage() {
    NEW_VERSION=$(increment_version $CURRENT_VERSION 2)
    bump_version

    make hogo_build_stage TAG=$NEW_VERSION
}

bump_version() {
    perl -pi -e  "s/${CURRENT_VERSION}/${NEW_VERSION}/g"  $CONFIG_PATH
}

# This script can be run on local but meant to be run in a box;
# Please execute it from the project root repository
main() {
    local usage=" USAGE: make_changes <env>
    <env> : Environment parameter (either dev or stage)"
    
    # Get environment argument.
    if [ $# -eq 0 ]; then echo "$usage"; return 1; fi 
    local env="${1}"    # environment string

    push_changes_$env
} 

main "$@"