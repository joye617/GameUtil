#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR

OUT_PATH="$DIR/test"


rm -rf $OUT_PATH/*
#遍历所有字体工程文件 并发布
for file in $DIR/fnt/*; do
	temp_file=`basename $file`
	if [[ $temp_file =~ .*\.GlyphProject ]] 
	then
		
		GDCL $DIR/fnt/$temp_file $OUT_PATH/${temp_file%%.*} -fo PlainText-txt -v
		echo ${temp_file%%.*}
	fi
done