package SYMM::SMIL::AnchoredMedia;

$VERSION = "0.5";

use SYMM::SMIL::MediaAttributes;
use SYMM::SMIL::Anchor;
use Carp;

@ISA = qw( SYMM::SMIL::XMLContainer );

my $anchors = 'anchors';
my $anchors_index = 'index';
my $media_type = "type";

sub init {
    my $self = shift;
    my %hash = @_;
    
    my $type = $hash{ $media_type };
    $self->SUPER::init( $type ? $type : "ref" );
    
    # Process the anchors here
    my $anchors = $hash{ $anchors };
    
    croak "Creating anchor tag without any anchors, REALLY BAD!\n" 
	unless $anchors;
    
    foreach $anchor ( @$anchors ) {
	$anch = new SYMM::SMIL::Anchor( $anchor );
	$self->setTagContents( $self->{$anchors_index}++ => $anch );
    }
    
    my %attrs = $self->createValidAttributes( { %hash },
					     [@mediaAttributes] );
    
    $self->setAttributes( %attrs );
}

1;
