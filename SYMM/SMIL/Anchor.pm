package SYMM::SMIL::Anchor;

$VERSION = "0.5";

use SYMM::SMIL::XMLTag;

@ISA = qw( SYMM::SMIL::XMLTag );

my $href = 'href';
my $show = 'show';
my @validAttrs = ( 'begin', 'end', 'coords', $href, $show );

sub init {
    my $self = shift;
    my $hash = shift;
    $self->SUPER::init( "anchor" );

    my %attrs = $self->createValidAttributes( { %$hash }, 
					     [ @validAttrs ] );
    $self->setAttributes( %attrs );
}

1;
