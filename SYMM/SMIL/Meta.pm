package SYMM::SMIL::Meta;

$VERSION = "0.5";

use SYMM::SMIL::XMLTag;

@ISA = qw( SYMM::SMIL::XMLTag );

my @validMetaAttrs = ( 'name', 'content' );

sub init {
    my $self = shift;
    $self->SUPER::init( "meta" );
    
    my $name = shift;
    my $content = shift;

    $self->setAttributes( 'name' => $name,
			 'content' => $content );
}

