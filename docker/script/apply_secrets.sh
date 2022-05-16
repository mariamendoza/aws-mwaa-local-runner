#!/usr/bin/env bash

env_file=${1}
json_file=${2}

set -o allexport
. ${env_file}

clean_exit() {
    set +o allexport
}
trap clean_exit EXIT

# check file is a valid json
jq -e . ${json_file} > /dev/null 2>&1

if [[ $? -eq 0 ]]
then
    json_string=$(cat ${json_file})
    tmp_file=${json_file%.*}.$$.json
    eval "echo \"$(echo ${json_string}|tr '"' "'")\""|tr "'" '"' > ${tmp_file}
    echo ${tmp_file}
else
    echo "Invalid json file: ${json_file}"
fi