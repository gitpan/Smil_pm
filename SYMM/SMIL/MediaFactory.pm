package SYMM::SMIL::MediaFactory;

$VERSION = "0.5";

require Exporter;
@ISA = qw( Exporter );
@EXPORT = qw( getMediaObject );

use SYMM::SMIL::Href;
use SYMM::SMIL::AnchoredMedia;
use SYMM::SMIL::UnanchoredMedia;

my $href = 'href';
my $layout = 'layout';
my $anchors = 'anchors';
my $switch = 'switch';
my $switch_target = 'switch-target';


sub getMediaObject {
 
    my %hash = @_ ;
    # check here to see if we have a 'href', if so create Href object,
    # otherwise create either Unanchored or Anchored media depending
    # on existence of 'anchors' element
    my $ref;

    # Look for the switch parameter
    my $switch_param  = $hash{ $switch };
    if( $switch_param ) {
	# Ok, look for the 'switch-target' item in the hash and put that 
	# as the switch element
	$hash{ $switch_param } = $hash{ $switch_target };
    }

    @_ = %hash;

    if( $hash{ $href } ) {
	$ref = new SYMM::SMIL::Href( @_ );
    }
    elsif( $hash{ $anchors } )  {
	$ref = new SYMM::SMIL::AnchoredMedia( @_ );
    }
    elsif( $hash{ $layout } ) {
	$ref = new SYMM::SMIL::Layout( @_ );
    }
    else {  # No anchors or hrefs or layouts, create normal media object
	$ref = new SYMM::SMIL::UnanchoredMedia( @_ ); 
    }

    return $ref;
}

1;

