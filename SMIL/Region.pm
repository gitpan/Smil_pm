package SYMM::SMIL::Region;

$VERSION = "0.5";

@ISA = qw( SYMM::SMIL::XMLTag );

sub init {
    my $self = shift;
    $self->SUPER::init( "region" );    
}
