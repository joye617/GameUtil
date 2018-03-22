#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR

CFG_FILE="countryConfig.xlsx"

OUT_DIR="../src/app/config/"

FILE_NAME="countryConfig.lua"

#根据服务端协议生成Lua文件
python countryToLua.py $CFG_FILE


#文件拷贝
rm -rf "$OUT_DIR"/"$FILE_NAME"
cp -r ${DIR}/${FILE_NAME} "$OUT_DIR"/"$FILE_NAME"

echo "完成"
