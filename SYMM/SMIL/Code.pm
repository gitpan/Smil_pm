package SYMM::SMIL::Code;

$VERSION = "0.6";

sub getAsString {
	my $self = shift;
	return $self->{code}; 
}

sub new {
    my $type = shift;
    my $self = {};
    bless $self, $type;

    $self->{code} = shift;
    return $self;
}


