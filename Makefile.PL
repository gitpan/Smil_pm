# This is the makefile for installation of SYMM::Smil
#
# Chris Dawson 
# cdawson@real.com 
# cdawson@webiphany.com

my $symm_directory = "SYMM";
my $smil_directory = "SMIL";

# Figure out where we are going to put everything
# I think it is best to place in the "site" dir rather than the base
# since it isn't a default module now
my $install_directory;
$install_directory = $ARGV[ 0 ] if $ARGV[ 0 ];

if( !$install_directory ) {
    foreach $item ( @INC ) {
	if( $item =~ /site[^\/]*/ ) {
	    $install_directory = $item;
	}
    }
}

die "Couldn't determine installation path (looked for site directory), " .
    "please specify a directory to install to" unless $install_directory;

my $smil_install = $install_directory . "/" . 
    $symm_directory . "/" . $smil_directory . "/";
my $symm_install = $install_directory . "/" . 
    $symm_directory . "/";

# Make sure that the directory is there and if not create it
die "You don't have privileges to install this module into $symm_install,\nPlease view the README for alternatives" 
unless ( -d $symm_install or mkdir $symm_install, 0777 );

die "You don't have privileges to install this module into $smil_install\n" .
"Please view the README for alternatives" 
unless ( -d $smil_install or mkdir $smil_install, 0777 );

print "Installation into $symm_install\n";

# Get a list of all the files in the SMIL module directory
die "Can't find $smil_directory directory" unless (chdir $smil_directory and opendir DIR, "." );
my @files = grep /\.pm$/, readdir DIR;
close DIR;

my $contents;
undef $/;

# Now copy each file to our install place
foreach $file ( @files ) {

	# Read in the file	
	die "Can't open $file for copying!" unless( open FILE, "./$file" );
	my $contents = <FILE>;
	close FILE;

	# Write it to our new place
	die "Can't write $install_directory$file" 
                 unless( open FILE, ">$smil_install$file" );
	print FILE $contents;
	close FILE;

	print "Wrote $file to $smil_install\n";
}

chdir "..";

# Also, place the SMIL.PM module in the right place.
die "Can't read in Smil.pm" unless open FILE, "./Smil.pm";
$content = <FILE>;
close FILE;

die "Can't write Smil.pm" unless open FILE, ">$symm_install/Smil.pm";
print FILE $content;
close FILE;
print "Wrote Smil.pm\n";

print "Done\n";


