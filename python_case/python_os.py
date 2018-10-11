import os

a=[{path:files} for path,filename,files in os.walk(os.getcwd())]
# print a

print os.path.abspath(os.path.dirname(__file__))
print os.path.exists(r"D:\study\python_case")
print os.path.abspath(r"D:\study\python_case")
print os.path.basename(r"D:\study\python_case\python_os.py")
print os.path.split(r"D:\study\python_case\python_os.py")
print os.path.isfile(r"D:\study\python_case\python_os.py")
print os.path.isdir(r"D:\study\python_case\python_os.py")

os.path.abspath(path) #返回绝对路径
os.path.basename(path) #返回文件名
os.path.commonprefix(list) #返回list(多个路径)中，所有path共有的最长的路径。
os.path.dirname(path) #返回文件路径
os.path.exists(path)  #路径存在则返回True,路径损坏返回False
os.path.lexists  #路径存在则返回True,路径损坏也返回True
os.path.expanduser(path)  #把path中包含的"~"和"~user"转换成用户目录
os.path.expandvars(path)  #根据环境变量的值替换path中包含的”$name”和”${name}”
os.path.getatime(path)  #返回最后一次进入此path的时间。
os.path.getmtime(path)  #返回在此path下最后一次修改的时间。
os.path.getctime(path)  #返回path的大小
os.path.getsize(path)  #返回文件大小，如果文件不存在就返回错误
os.path.isabs(path)  #判断是否为绝对路径
os.path.isfile(path)  #判断路径是否为文件
os.path.isdir(path)  #判断路径是否为目录
os.path.islink(path)  #判断路径是否为链接
os.path.ismount(path)  #判断路径是否为挂载点（）
os.path.join(path1[, path2[, ...]])  #把目录和文件名合成一个路径
os.path.normcase(path)  #转换path的大小写和斜杠
os.path.normpath(path)  #规范path字符串形式
os.path.realpath(path)  #返回path的真实路径
os.path.relpath(path[, start])  #从start开始计算相对路径
os.path.samefile(path1, path2)  #判断目录或文件是否相同
os.path.sameopenfile(fp1, fp2)  #判断fp1和fp2是否指向同一文件
os.path.samestat(stat1, stat2)  #判断stat tuple stat1和stat2是否指向同一个文件
os.path.split(path)  #把路径分割成dirname和basename，返回一个元组
os.path.splitdrive(path)   #一般用在windows下，返回驱动器名和路径组成的元组
os.path.splitext(path)  #分割路径，返回路径名和文件扩展名的元组
os.path.splitunc(path)  #把路径分割为加载点与文件
os.path.walk(path, visit, arg)  #遍历path，进入每个目录都调用visit函数，visit函数必须有
3个参数(arg, dirname, names)，dirname表示当前目录的目录名，names代表当前目录下的所有
文件名，args则为walk的第三个参数
os.path.supports_unicode_filenames  #设置是否支持unicode路径名


python之OS模块详解

os.sep:取代操作系统特定的路径分隔符
os.name:指示你正在使用的工作平台。比如对于Windows，它是'nt'，而对于Linux/Unix用户，它是'posix'。
os.getcwd:得到当前工作目录，即当前python脚本工作的目录路径。
os.getenv()和os.putenv:分别用来读取和设置环境变量
os.listdir():返回指定目录下的所有文件和目录名
os.remove(file):删除一个文件
os.stat（file）:获得文件属性
os.chmod(file):修改文件权限和时间戳
os.mkdir(name):创建目录
os.rmdir(name):删除目录
os.removedirs（r“c：\python”）:删除多个目录
os.system():运行shell命令
os.exit():终止当前进程
os.linesep:给出当前平台的行终止符。例如，Windows使用'\r\n'，Linux使用'\n'而Mac使用'\r'
os.path.split():返回一个路径的目录名和文件名
os.path.isfile()和os.path.isdir()分别检验给出的路径是一个目录还是文件
os.path.existe():检验给出的路径是否真的存在
os.listdir(dirname):列出dirname下的目录和文件
os.getcwd():获得当前工作目录
os.curdir:返回当前目录（'.'）
os.chdir(dirname):改变工作目录到dirname
os.path.isdir(name):判断name是不是目录，不是目录就返回false
os.path.isfile(name):判断name这个文件是否存在，不存在返回false
os.path.exists(name):判断是否存在文件或目录name
os.path.getsize(name):或得文件大小，如果name是目录返回0L
os.path.abspath(name):获得绝对路径
os.path.isabs():判断是否为绝对路径
os.path.normpath(path):规范path字符串形式
os.path.split(name):分割文件名与目录（事实上，如果你完全使用目录，它也会将最后一个目录作为文件名而分离，同时它不会判断文件或目录是否存在）
os.path.splitext():分离文件名和扩展名
os.path.join(path,name):连接目录与文件名或目录
os.path.basename(path):返回文件名
os.path.dirname(path):返回文件路径
os.mkdir("file")                   创建目录

