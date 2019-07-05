#!/bin/bash

set -eou pipefail

studio_type=${1?studio type argument required}

sudo bio license accept
sudo bio pkg install core/expect
sudo bio pkg binlink core/expect expect 

pushd components/studio

test/"$studio_type"/test.sh
