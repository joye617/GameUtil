#!/bin/bash

echo -e "\033[41;36m 确认config.propertise中gameConstVersion号 \033[0m"
echo -e "\033[41;36m 确认config.propertise中gameResVersion号 \033[0m"
echo -e "\033[41;36m 确认无误输入yes \033[0m"

read INPUT

if [[ $INPUT != "yes" ]]; then
	exit;
fi

# Lua代码加密
cd ..
./bin/encrypt.sh

# 生成version
cd bin
java -jar ManifestGen.jar genLocalVersion:true testMode:true

# 编译iOS项目
cd ../frameworks/runtime-src/proj.ios_mac
xcodebuild clean -workspace blackjack.xcworkspace -scheme blackjack -configuration Release
xcodebuild archive -workspace blackjack.xcworkspace -scheme blackjack -configuration Release

# Lua代码解密
cd ../../..
./bin/decrypt.sh

# 删除version
rm -rf res/version
