package ObjectTemplate;
@ISA=qw/ObjectTemplate/;

# attributes qw/name,age/;


# my $reg=&regule("lilin","12");
# my $exite=&exite("lijin","30");
# my $copy=$reg->regule("li","90");


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

1