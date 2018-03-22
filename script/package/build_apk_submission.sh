#!/bin/bash

echo -e "\033[41;36m 确认config.propertise中gameConstVersion号 \033[0m"
echo -e "\033[41;36m 确认config.propertise中gameResVersion号 \033[0m"
echo -e "\033[41;36m 确认无误输入yes \033[0m"

read INPUT

if [[ $INPUT != "yes" ]]; then
	exit;
fi

# 代码加密
cd ..
./bin/encrypt.sh

# 生成version
cd bin
java -jar ManifestGen.jar genLocalVersion:true

# 拷贝文件，编译C++代码
cd ../frameworks/runtime-src/proj.android_studio/projandroid_no_anysdk/src/main
./build_native_release.sh

# 编译Android项目
cd ../../..
./gradlew assembleRelease

# 代码解密
cd ../../..
./bin/decrypt.sh

# 删除version
rm -rf res/version
