#!/usr/bin/perl

use ExtUtils::MakeMaker;

WriteMakefile( NAME => "SYMM::Smil",
	       PMLIBDIRS => [ ( ".", "SMIL" ) ] );

package MY;

sub libscan
{ # Determine things that should *not* be installed
    my($self, $path) = @_;
    return '' if $path !~ m/\.pm/i;
    $path;
}

__END__
