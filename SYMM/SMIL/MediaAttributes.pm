package SYMM::SMIL::MediaAttributes;

use SYMM::SMIL::SystemSwitches;

$VERSION = "0.5";

require Exporter;
@ISA = qw( Exporter );
@EXPORT = qw( @mediaAttributes @timeAtts );

@timeAtts = ( "begin", "end", "clip-end", "start", "dur", "clip-begin" );
@mediaAttributes = ( @timeAtts, @systemSwitchAttributes,
		     "fill", "src", "region", "id", );

1;

