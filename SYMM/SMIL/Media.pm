package SYMM::SMIL::Media;

$VERSION = "0.5";

use SYMM::SMIL::XML_Tag;
#use SYMM::SMIL::Media_Base;

my @mediaAttributes = ( "begin", "end", "clip-end", "clip-begin", 
		       "start", "fill", "src", "region", "id", "dur" );

@ISA = qw( SYMM::SMIL::XML_Tag );
# Doesn't work right now
# Media_Base );

my $type = "type";

sub init {
    my $self = shift;
    my %hash = @_;
    
    my $tag = $hash{ $type } ? $hash{ $type } : "ref";
    $self->SUPER::init( $tag );

    my %mediaAttrs = $self->createValidAttributes( { %hash }, 
						  [ @mediaAttributes ] );
    $self->setAttributes( %mediaAttrs );
}
