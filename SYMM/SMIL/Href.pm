package SYMM::SMIL::Href;

$VERSION = "0.5";

use SYMM::SMIL::UnanchoredMedia;

@ISA = ( SYMM::SMIL::XMLContainer );

my @validHrefAttrs = ( 'href' );
my $media = 'media';

sub init {
    my $self = shift;
    my %hash = @_;
    $self->SUPER::init( "a" );
    
    my $ref = new SYMM::SMIL::UnanchoredMedia( @_ );
    $self->setAttributes( 'href' => $hash{ 'href' } );
    $self->setTagContents( $media => $ref );
}
