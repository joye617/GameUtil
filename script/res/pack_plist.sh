#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR

TP="/usr/local/bin/TexturePacker"


#项目res路径
DIR_ROOT="$DIR/../../res"
#cocos buildeer 项目路径
CCB_ROOT="$DIR/../ccbProject/blackjack/Resources"


# #本地路径名
Local_DIR=${1}
# #文件名称
File_Name=${2}
##文件夹名称
Dir_Name=${3}

echo $Local_DIR
echo $File_Name
echo $Dir_Name

PLIST_FILES="$Local_DIR"/*.png

DIR_PLIST_FILE="$DIR_ROOT"/"$Dir_Name"/"$File_Name".plist
DIR_SHEET_FILE="$DIR_ROOT"/"$Dir_Name"/"$File_Name".pvr.ccz

CCB_PLIST_FILE="$CCB_ROOT"/"$Dir_Name"/"$File_Name".plist
CCB_SHEET_FILE="$CCB_ROOT"/"$Dir_Name"/"$File_Name".png

ENCRYPT_KEY=223c61d9e457c4f3c3c68c4e80434868

# --premultiply-alpha \ 这个参数可以消除白边，但对白色透明变黑
# --dither-atkinson-alpha \
# --content-protection 5abc11740879b2ff6d36f2c9d4d7d088 \ 资源加密

#生成到project
echo "building to project"
rm -rf DIR_PLIST_FILE DIR_SHEET_FILE
${TP} --smart-update \
--texture-format pvr2ccz \
--format cocos2d \
--enable-rotation \
--padding 2 \
--shape-padding 2 \
--trim-mode None \
--scale 1.0 \
--extrude 2 \
--max-width 4096 \
--max-height 4096 \
--size-constraints NPOT \
--data  ${DIR_PLIST_FILE} \
--sheet ${DIR_SHEET_FILE} \
--opt RGBA8888 \
--premultiply-alpha \
--content-protection ${ENCRYPT_KEY} \
${PLIST_FILES}


#生成到ccb路径中
echo "building to ccb..."
rm -rf CCB_PLIST_FILE CCB_SHEET_FILE
${TP} --smart-update \
--texture-format png \
--format cocos2d \
--enable-rotation \
--padding 2 \
--shape-padding 2 \
--max-width 4096 \
--max-height 4096 \
--trim-mode None \
--scale 1.0 \
--extrude 2 \
--size-constraints NPOT \
--data  ${CCB_PLIST_FILE} \
--sheet ${CCB_SHEET_FILE} \
--opt RGBA8888 \
--premultiply-alpha \
${PLIST_FILES}



