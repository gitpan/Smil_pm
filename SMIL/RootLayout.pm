package SYMM::SMIL::RootLayout;

$VERSION = "0.5";

use SYMM::SMIL::XMLTag;

@ISA = qw( SYMM::SMIL::XMLTag );

sub init {
    my $self = shift;
    $self->SUPER::init( "root-layout" );
}

sub getRootHeight {
    my $self = shift;
    return $self->getAttribute( height );
}

sub getRootWidth {
    my $self = shift;
    return $self->getAttribute( width );
}

