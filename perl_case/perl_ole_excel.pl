use strict;
use warnings;
use Win32::OLE;   #����win32 OLE��
use File::Copy; #�����ļ�����ģ��
# my $dir = 'c:\\MyPerl\\Excel\\';  #�ڴ�Ŀ¼���½�EXCEL�ļ�

my $src_name = "test1"."\.xls";
my $dst_name = "test2"."\.xls";
my $nowstr;
#�½�һ��EXCELӦ�ö���Ȼ�����ǾͿ��Զ�excel���в�����
my $app_xls = Win32::OLE->new('Excel.Application', sub{$_[0]->Quit})
or die "Excel ��ʼ��ʧ�ܣ������û�а�װExcel��";
$app_xls->{DisplayAlerts} = 'False';    #�ص�excel����ʾ�������Ƿ񱣴��޸�֮���
#�½�һ���յ�Excel�ļ���Ȼ�󱣴�
my $book = $app_xls->WorkBooks->Add; #�½�һ��������
$book->SaveAs("myxls\.xls") or die "Save failer."; #��������������ļ�
undef $book; #�����˾������������������
copy("myxls\.xls",$src_name);
copy("myxls\.xls",$dst_name);
 
#��һ��EXCEL�ļ�
my $src_book = $app_xls->WorkBooks->Open($src_name);
my $src_sheet = $src_book->Worksheets(1); #ѡ��һ������
$nowstr = $src_sheet->Cells(1,1)->{Value};  #ȡ��һ��Ԫ��������
print $nowstr; #���ű��иñ�����ֵΪδ���� undef
$src_sheet->Cells(1,1)->{Value}="change";  #�޸�һ��Ԫ��������
my $dst_book = $app_xls->WorkBooks->Open($dst_name);
my $dst_sheet = $dst_book->Worksheets(1); #ѡ��һ������

#��һ��excel�︴��һ��������һexcel��
$src_book->Worksheets(1)->Copy($dst_book->Worksheets(1));
$dst_book->Worksheets(3)->Delete;#ɾ��һ������
$dst_book->Save;  #���������޸�
$src_book->Save;
$app_xls->{DisplayAlerts} = 'True'; #�ָ���ʾ
#<STDIN>;
undef $src_book; #�����˾������������������
undef $dst_book; #�����˾������������������
undef $app_xls;  #�ص����򿪵�excelӦ��
