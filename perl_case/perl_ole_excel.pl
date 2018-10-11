use strict;
use warnings;
use Win32::OLE;   #导入win32 OLE包
use File::Copy; #导入文件复制模块
# my $dir = 'c:\\MyPerl\\Excel\\';  #在此目录下新建EXCEL文件

my $src_name = "test1"."\.xls";
my $dst_name = "test2"."\.xls";
my $nowstr;
#新建一个EXCEL应用对象，然后我们就可以对excel进行操作。
my $app_xls = Win32::OLE->new('Excel.Application', sub{$_[0]->Quit})
or die "Excel 初始化失败，你可能没有安装Excel！";
$app_xls->{DisplayAlerts} = 'False';    #关掉excel的提示，比如是否保存修改之类的
#新建一个空的Excel文件，然后保存
my $book = $app_xls->WorkBooks->Add; #新建一个工作簿
$book->SaveAs("myxls\.xls") or die "Save failer."; #保存这个工作部文件
undef $book; #不用了就销毁这个变量的内容
copy("myxls\.xls",$src_name);
copy("myxls\.xls",$dst_name);
 
#打开一个EXCEL文件
my $src_book = $app_xls->WorkBooks->Open($src_name);
my $src_sheet = $src_book->Worksheets(1); #选中一工作表
$nowstr = $src_sheet->Cells(1,1)->{Value};  #取得一单元格中数据
print $nowstr; #本脚本中该变量的值为未定义 undef
$src_sheet->Cells(1,1)->{Value}="change";  #修改一单元格中数据
my $dst_book = $app_xls->WorkBooks->Open($dst_name);
my $dst_sheet = $dst_book->Worksheets(1); #选中一工作表

#从一个excel里复制一工作表到另一excel中
$src_book->Worksheets(1)->Copy($dst_book->Worksheets(1));
$dst_book->Worksheets(3)->Delete;#删除一工作表
$dst_book->Save;  #保存所做修改
$src_book->Save;
$app_xls->{DisplayAlerts} = 'True'; #恢复提示
#<STDIN>;
undef $src_book; #不用了就销毁这个变量的内容
undef $dst_book; #不用了就销毁这个变量的内容
undef $app_xls;  #关掉所打开的excel应用
