#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR

#cocos buildeer 项目路径
CCB_ROOT="$../ccbProject/blackjack/Resources"

FNT_PATH="$DIR/fnt"

TTF_PATH="$DIR/ttf"


#拷贝到ccb
mkdir "$CCB_ROOT"/common/font
rm -rf "$CCB_ROOT"/common/font
cp -r ${FNT_PATH} "$CCB_ROOT"/common/font
cp -r ${TTF_PATH} "$CCB_ROOT"/common/font