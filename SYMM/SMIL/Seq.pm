package SYMM::SMIL::Seq;

$VERSION = "0.5";

use SYMM::SMIL::TimelineBase;
use SYMM::SMIL::XMLContainer;

@ISA = qw( SYMM::SMIL::XMLContainer ); 

sub init {
    my $self = shift;
    my %hash = @_;
    $self->SUPER::init( "seq" );
    
    my %attrs = $self->createValidAttributes( { %hash },
					      [@timelineAttributes] );
    $self->setAttributes( %attrs );
}
