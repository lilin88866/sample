#!/usr/bin/perl -w
 
 
# BEGIN                                                                           
# {                                                                               
    # push @INC, "./";                                                            
# }; #这里是用来将该路径下的pm文件包含进去；   


use strict;
use warnings;
use Cwd;
use IO::File;
my $files = "D:/works/perl_case/eval.pl"; 
&file($files);
sub file 
{
	my $file=shift; #取得文件名
	my $fh=IO::File ->new($file); #打开文件
	my $line=<$fh>; #读取第一行
	print $line; #打印出来
	#打印整个文件内容
	while (<$fh>){ #用while 方法读取文件句柄
		 print;    #打印，实际上是 print $_; $_可以省略
	}
}

my @files = <*>;

## <*> 很重要，也很强大！

# <*> 相当于把当前默认下的所有非隐藏文件文件抓出。

# 如果你要抓取其他路径，或者过滤某些文件类型，你可以这么写：

#</home/dcai/*.txt> 相当于把/home/dcai下的所有.txt文件抓出，这时抓取的文件含有绝对路径。

#foreach $file (@files) {

#可选：对获取的文件名处理，例如获取perl文件的名称(不包含扩展名'.pl')
print "\n\n\n\n";
my $filename = "";
# for (my $i; $i<@files;$i++)
# {
&readfile(@files);
# }
sub readfile
{
	my @file=shift;
	print "lilin\n@file\nlilin\n";
	if(@_ =~ m/(.*).pl/)
	{
		$filename = $1;
	}
	print "filename=$filename\n";
}

