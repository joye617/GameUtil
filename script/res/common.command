#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR

./pack_plist.sh "common/plist_country" "common_flag" "common"
./pack_plist.sh "common/guide_plist" "guide_plist" "common"
./pack_plist.sh "common/plist" "common" "common"
./pack_plist.sh "common/plist_button" "common_button" "common"
./pack_plist.sh "common/plist_achieve" "common_achieve" "common"
./pack_plist.sh "common/plist_vip" "common_vip" "common"
./pack_plist.sh "common/plist_chip" "common_chip" "common"
./copy_res.sh "common" "common"
