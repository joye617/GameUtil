CURRENT_DIR    := $(shell pwd)

PROTO_DIR := ./proto
PROTO_CMD_NAME := buildProto.command

UIRES_PATH := ./cocosbuilder/UIRes
UIRES_CMD_NAME := run.command

FONT_PATH := ./cocosbuilder/FontRes
FONT_CMD_NAME := copy_res.sh

XCODE_PRO_DIR := ./frameworks/runtime-src/proj.ios_mac
EXPROT_CMD_NAM := package.sh

CCB_GIT_DIR :=./cocosbuilder
CCB_PATH :=./cocosbuilder/ccbProject/blackjack
PUBLISH_CCB_CMD := publishCCB.sh


all: publishCCB buildProto buildPackage


.PHONY: publishRes publishCCB copyFont buildProto buildPackage update
publishRes:
	@echo "### 开始打包发布图片资源."
	cd $(UIRES_PATH) && sh $(UIRES_CMD_NAME)

publishCCB:
	@echo "### 开始发布ccb资源."
	cd $(CCB_PATH) && sh $(PUBLISH_CCB_CMD)

copyFont:
	@echo "### 开始拷贝字体文件"
	cd $(FONT_PATH) && sh $(FONT_CMD_NAME)

buildProto:
	@echo "### 开始生成新的协议proto文件"
	cd $(PROTO_DIR) && sh $(PROTO_CMD_NAME)

buildPackage:
	@echo "### 开始打包ipa 文件"
	cd $(XCODE_PRO_DIR) && sh $(EXPROT_CMD_NAM)

update:
	@echo "### 从git 更新最新项目"
	cd $(CURRENT_DIR) && git pull
	cd $(PROTO_DIR) && git pull
	cd $(CCB_GIT_DIR) && git pull

help:
	@echo make publishRes            -- 打包发布图片资源.
	@echo make publishCCB            -- 发布ccbi文件到项目.
	@echo make copyFont    			 -- 拷贝字体资源到项目.
	@echo make buildProto            -- 生成新的proto协议pb文件.
	@echo make buildPackage			 -- 项目打包成ipa并上传fir.
	@echo make update				 -- 从git更新最新项目
	@echo make all            		 -- 依次执行以上所有命令.
