package SYMM::SMIL::Href;

$VERSION = "0.6";

use SYMM::SMIL::UnanchoredMedia;
use SYMM::SMIL::SystemSwitches;

@ISA = ( SYMM::SMIL::XMLContainer );

my @validHrefAttrs = ( 'href' );
my $media = 'media';

sub init {
    my $self = shift;
    my %hash = @_;
    $self->SUPER::init( "a" );

    my %attrs = $self->createValidAttributes( { %hash },
					     [@validHrefAttrs
					#, @systemSwitchAttributes 
					] );
    $self->setAttributes( %attrs );

    # Remove the ones we used now...
#    foreach $used ( keys %attrs ) {
#	undef $hash{ $used };
 #   }
    
    my $ref = new SYMM::SMIL::UnanchoredMedia( %hash );
    $self->setTagContents( $media => $ref );
}
