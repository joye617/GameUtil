# # encoding: utf-8

import sys
import os
import re 
import xdrlib,xlrd

reload(sys)
sys.setdefaultencoding("utf-8")

OUT_DIR = os.getcwd() #获取当前文件夹的路径
print(OUT_DIR)



#打开excel
def open_excel(file= 'file.xls'):
    try:
        data = xlrd.open_workbook(file)
        return data
    except Exception,e:
        print str(e)

#读取excel中的数据
def read_excel_data(file,rowStart=1,sheet=0):
	data = open_excel(file)
	table = data.sheets()[sheet]
	nrows = table.nrows
	ncols = table.ncols
	print('rows:'+str(nrows))
	print('cols:'+str(ncols))
	excellist = []
	#逐列读取数据
	for colnum in range(ncols):
		coldata = table.col_values(colnum)
		# print(coldata)
		if coldata:
			rowlist = []
			for i in range(rowStart,nrows):
				rowlist.append(coldata[i])
			excellist.append(rowlist)
	return excellist

#将excel数据写入lua并保存
def write_lua_table(file,data):
	toluafile = file[0:file.find(".")].strip()
	content = "--[[\n 	礼物配置信息 \n 	]]\n\n"
	content = content+"local "+toluafile+" = { } \n\n\n"
	content = content + toluafile+".config = { \n"

	keyName = ""
	keyArr = []
	for key in range(len(data[1])):
		# print('key:'+str(data[1][key]))
		if keyName != data[1][key]:
			content = content +"	"+ data[1][key] + ","
			keyName = data[1][key]
			keyArr.append(keyName)
	content = content +"\n } \n\n\n"

	rowNum = 0
	for i in range(len(keyArr)):
		content = content + keyArr[i] + " = { \n"
		
		print keyArr[i],rowNum
		for colindex in range(len(data)):
			#校准行号 暂且这样处理
			if colindex == 0 and rowNum != 0:
				rowNum = rowNum-1
			for rowindex in range(rowNum,len(data[colindex])):
				if colindex == 0:
					rowNum = rowNum +1
				if data[1][rowindex] != keyArr[i]:
					break
				gidBuf = data[0][rowindex]
				nameBuf = data[2][rowindex]
				priceBuf = data[3][rowindex]
				timeBuf = data[4][rowindex]
				content = content +"		{ gid = %s, name =  \"%s\", price =  %s, time =  %s }, \n "%(gidBuf,nameBuf,priceBuf,timeBuf)
			else:
				print 
		else:
			print 
		content = content + "} \n"
		content = content + toluafile+".config."+keyArr[i]+" = "+keyArr[i]+"\n"

	content = content + "return "+toluafile


	# print('content:'+content)

	toluafile = OUT_DIR+"/"+toluafile+".lua"
	# print('outdir:'+toluafile)
	file_g = open(toluafile, 'w')
	file_g.write(content)
	file_g.close()


def main(arg):
	file = arg[1]
	
	datalist = read_excel_data(file)

	write_lua_table(file,datalist)


if __name__=="__main__":
    main(sys.argv)