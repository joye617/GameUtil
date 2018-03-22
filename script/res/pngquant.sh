DIR="$( cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd $DIR
echo "开始压缩png 图片"
count=1
function getdir(){
   
    for element in `ls $1`
    do  
        dir_or_file=$1"/"$element
        if [ -d $dir_or_file ]
        then 
            getdir $dir_or_file
        else
            if [[ $dir_or_file =~ .*\.png ]]
			then
				echo $dir_or_file

				pngquant -f -skip-if-larger -o $dir_or_file  $dir_or_file
                let count+=1
			fi
        fi  
    done
}
getdir $DIR

echo "压缩结束:${count}"