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
	content = "--[[\n 	国家列表配置信息 \n 	]]\n\n"
	content = content+"local "+toluafile+" = { } \n\n\n"
	content = content + toluafile+".short = {"
	for key in range(len(data[2])):
		content = content+"\"%s\","%(data[2][key])

	content = content +" } \n\n"

	content = content + toluafile+".config = { \n"
	keyName = ""
	keyArr = []

	for key in range(len(data[0])):
		idBuf = int(data[0][key])
		countryBuf = data[1][key]
		shortBuf = data[2][key]
		content = content+"		{ id = %d, country =  \"%s\", short = \"%s\" }, \n "%(idBuf,countryBuf,shortBuf)

	content = content + " } \n\n"
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