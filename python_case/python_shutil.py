# python_shutil.py
import shutil,glob,fnmatch,md5
shutil.copy(".config",".config.bak")

shutil.copytree("ttt","ccc")
shutil.rmtree("ccc")

file=glob.glob(r"D:\BJ_TRUNK\C_Test\*\*\*.py")
print file
for filemane in file:
	if fnmatch.fnmatch(filemane,"*.py"):
		print "fnmatch===",filemane

print md5.md5(".config")


复制文件:

shutil.copyfile("oldfile","newfile")       oldfile和newfile都只能是文件

shutil.copy("oldfile","newfile")            oldfile只能是文件夹，newfile可以是文件，也可以是目标目录

shutil.copytree("olddir","newdir")        复制文件夹.olddir和newdir都只能是目录，且newdir必须不存在

os.rename("oldname","newname")       重命名文件（目录）.文件或目录都是使用这条命令

shutil.move("oldpos","newpos")   移动文件（目录）

os.rmdir("dir")       只能删除空目录

shutil.rmtree("dir")    空目录、有内容的目录都可以删

os.chdir("path")   