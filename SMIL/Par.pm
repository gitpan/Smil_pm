package SYMM::SMIL::Par;

$VERSION = "0.5";

use SYMM::SMIL::TimelineBase;
use SYMM::SMIL::SystemSwitches;
use SYMM::SMIL::XMLContainer;

@ISA = qw( SYMM::SMIL::XMLContainer ); 

sub init {
    my $self = shift;
    my %hash = @_;
    $self->SUPER::init( "par" );

    my %attrs = $self->createValidAttributes( { %hash },
					     [@timelineAttributes, 
					      @systemSwitchAttributes] );

    $self->setAttributes( %attrs );

}

