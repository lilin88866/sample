#!/usr/bin/perl -w

use strict;
use Spreadsheet::ParseExcel;
use Spreadsheet::WriteExcel;
use OLE;
use Win32::OLE::Const "Microsoft Excel";
$Win32::OLE::Warn = 3; # Die on errors in Excel

my $excel_file = "test.xls";

my $parser = Spreadsheet::ParseExcel->new(); 
my $workbook = $parser->Parse($excel_file); 

# read excel cell values
for my $worksheet ( $workbook->worksheets() ) 
{ 
    my ( $row_min, $row_max ) = $worksheet->row_range(); 
    my ( $col_min, $col_max ) = $worksheet->col_range(); 

    for my $row ( $row_min .. $row_max )
    { 
        for my $col ( $col_min .. $col_max )
        {
            my $cell = $worksheet->get_cell( $row, $col ); 
            next unless $cell; 

            print "Row, Col = ($row, $col)\n"; 
            print "Value = ", $cell->value(), "\n"; 
            print "Unformatted = ", $cell->unformatted(), "\n"; 
            print "\n"; 
        } 
    } 
}

# read value from excel
my $workbook_read = $parser->Parse($excel_file);
for my $worksheet_read ( $workbook_read->worksheets())
{
    my $cell= $worksheet_read->get_cell( 1,1 );
    next unless $cell;    
    my $value = $cell->value();
    print "lilin=",$value,"\n";
}




# 创建一个新的EXCEL文件 
my $workbook_create = Spreadsheet::WriteExcel->new('test_create.xls'); 

# 添加一个工作表 
my $worksheet_create = $workbook_create->add_worksheet(); 

# 新建一个样式 
my $format;
$format = $workbook_create->add_format(); # Add a format 
$format->set_bold();#设置字体为粗体 
$format->set_color('red');#设置单元格前景色为红色 
$format->set_align('center');#设置单元格居中 

#使用行号及列号，向单元格写入一个格式化和末格式化的字符串 
my $col_create = 0;
my $row_create = 0;

$worksheet_create->write($row_create, $col_create, 'Hi Excel!', $format); 
$worksheet_create->write(1, $col_create, 'Hi Excel!'); 

# 使用单元格名称（例：A1），向单元格中写一个数字。 
$worksheet_create->write('A3', 1.2345); 


# write value into excel
my $write_parser = Spreadsheet::WriteExcel->new('test1.xls');
my $workbook_write = $write_parser->add_worksheet();
 for my $i (0 .. 9) 
{
    $workbook_write->write($i, 1,1.2345); 
}

# use ole modle write to excel
my ($workexcel_ole, $workbook_ole);
$workexcel_ole = CreateObject OLE 'Excel.Application';
$workexcel_ole->{Visible} = 0;

# get a new workbook
my $book = $workexcel_ole->Workbooks->Add();

# write to a particular cell
my $sheet = $book->Worksheets(2);
$sheet->Cells(1,1)->{Value} = "foo";

# write a 2 rows by 3 columns range
$sheet->Range("A8:C9")->{Value} = [[ undef, 'Xyzzy', 'Plugh' ],
                                   [ 42,    'Perl',  3.1415  ]];
 

# print "XyzzyPerl"
my $array = $sheet->Range("A8:C9")->{Value};
for (@$array) {
  for (@$_) {
      print defined($_) ? "$_|" : "<undef>|";
  }
  print "\n";
}

# save and exit
$book->SaveAs( 'test2.xls' );
undef $book;

$workbook_ole = $workexcel_ole->Workbooks->Open ( 'test1.xls' );
my $sheet_ole = $workbook_ole->Worksheets(1);

# write a row cell value
$sheet_ole->Cells(2,1)->{Value} = "fool";

#delete a row
$sheet_ole->Range("A8")->{EntireRow}->Delete();

#insert a value
my $cellVal = [ 43,    'Perl',  3.1415  ];
$sheet->Range("A8:C8")->{EntireRow}->Insert();  
$sheet->Range("A8:C8")->{Value}=$cellVal;


$workbook_ole->SaveAs( "test_ole.xls" );
undef $workbook_ole;