package SYMM::SMIL::UnanchoredMedia;

$VERSION = "0.5";

use SYMM::SMIL::XMLTag;
use SYMM::SMIL::MediaAttributes;

@ISA = qw( SYMM::SMIL::XMLTag );

my $media_type = 'type';

sub init {
    my $self = shift;
    my %hash = @_;
    
    my $type = $hash{ $media_type };
    $self->SUPER::init( $type ? $type : "ref" );
    
    my %attrs = $self->createValidAttributes( { %hash },
					     [@mediaAttributes] );
    
    $self->setAttributes( %attrs );
}

1;
