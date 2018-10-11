#!/usr/bin/perl -w

# 使用bless可以进行对象的copy。

package employee;

use Data::Dumper;

my $reg=&regule("lilin","12");
my $exite=&exite("lijin","30");
my $copy=$reg->regule("li","90");
print Dumper(\$reg);
# $VAR1 = \bless( {
                   # 'month' => '12',
                   # 'name' => 'lilin'
                 # }, 'employee' );
                 
print Dumper(\$exite);
# $VAR1 = \{
            # 'month' => '',
            # 'day' => '30',
            # 'name' => 'lijin'
          # };

print Dumper(\$copy);
# $VAR1 = \bless( {
                   # 'month' => '',
                   # 'name' => 'employee=HASH(0x14f801c)'
                 # }, 'employee' );


sub regule
{
    my ($name,$month)=@_;
    my $employee = {name=>"$name",month=>"$month"};
    bless $employee,"employee";
    return $employee
}

sub exite
{
    my ($name,$day)=@_;
    my $employee = {name=>"$name",month=>"",day=>"$day"};
    return $employee
}