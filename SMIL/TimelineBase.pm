package SYMM::SMIL::TimelineBase;

$VERSION = "0.5";

require Exporter;
@ISA = qw( Exporter );
@EXPORT = qw( @timelineAttributes );

@timelineAttributes = ( "id", "begin", "endsync", "end" );

