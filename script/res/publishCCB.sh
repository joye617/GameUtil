#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR

OUT_PATH="/Users/joye/Documents/project/project/blackjack/res/ccbi"

TEMP_OUT_PATH="/Users/joye/Documents/project/project/ccbTemp"

echo "export ccbi to temp file"
if [[ -d $TEMP_OUT_PATH ]];then
	rm -rf $TEMP_OUT_PATH/*
else
	mkdir $TEMP_OUT_PATH
fi

#遍历所有ccb文件 并发布
for file in $DIR/Resources/*
do
	temp_file=`basename $file`
	if [[ $temp_file =~ .*\_ccb ]] 
	then

		mkdir $TEMP_OUT_PATH/$temp_file

		for ccbFile in $DIR/Resources/$temp_file/*
		do
			ccbFileName=`basename ${ccbFile%\.ccb}`
			outFile="${TEMP_OUT_PATH}/$temp_file/${ccbFileName}.ccbi"
			echo $outFile
			$DIR/ccbpublish -o $outFile $ccbFile
		done
	fi
done

echo "move temp file to out file"

rm -rf $OUT_PATH/

mv $TEMP_OUT_PATH/ $OUT_PATH/

rm -rf $TEMP_OUT_PATH

echo "public done"