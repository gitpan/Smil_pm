package SYMM::SMIL::XMLBase;

$VERSION = "0.5";

$ZERO_STRING = "ZERO_STRING";

use SYMM::SMIL::MediaAttributes;

my $debug = 1;

my @tabBuffer = ();

my $tab_count = 4;
my $TAB = " " x $tab_count;
my $check_errors = 1;

sub enableErrorChecking {
    $check_errors = 1;
}

sub disableErrorChecking {
    $check_errors = 0;
}

sub increaseTabBuffer {
    my $self = shift;
    push @tabBuffer, $TAB;
}

sub decreaseTabBuffer {
    pop @tabBuffer;
}

sub getTabBuffer {
    return( join "", @tabBuffer );
}

sub new {
    my $type = shift;
    my $self = {};
    bless $self, $type;

    $self->init( @_ );
    return $self;
}

sub setTag {
    my $self = shift;
    my $tag = shift;
    $self->{_tag} = $tag;
}

sub getTag {
    my $self = shift;
    return $self->{_tag};
}

sub setAttributes {
    my $self = shift;
    $self->{_attributes} = { @_ };
}

sub setAttribute {
    my $self = shift;
    my $attrib = shift;
    my $value = shift;
    my $attribs = $self->{_attributes};
    $$attribs{ $attrib } = $value;
}

sub getAttributes {
    my $self = shift;
    return $self->{_attributes};
}

sub getAttribute {
    my $self = shift;
    my $attrib = shift;
    return $self->{_attributes}->{$attrib};
}

sub createValidAttributes {
    my $self = shift;
    my $arg_hash_ref = shift;
    my $valid_arr_ref = shift;
    my %return_hash = ();

    foreach $item ( @$valid_arr_ref ) {
	$return_hash{ $item } = $$arg_hash_ref{ $item } 
	if( $$arg_hash_ref{ $item } || 
	    # Allow namespaces...
	    $item =~ /:/ );
    }

    # Respect namespaces
    foreach $item ( keys %$arg_hash_ref ) {
	$return_hash{ $item } = $$arg_hash_ref{ $item } 
	if $item =~ /:/;
    }

    foreach $time_attribute ( @timeAtts ) {
	# Special cases are handled here:
	if( $return_hash{ $time_attribute } &&
	    $return_hash{ $time_attribute } !~ /s$/ && 
	    $return_hash{ $time_attribute } !~ /:\d+\.\d+$/   ) {
	    $return_hash{ $time_attribute } .= "s";
	}
    }

    return %return_hash;
}

sub _build_attributes {
    my $return_string = "";
    my $self = shift;
    my $hash_ref = $self->{_attributes};
    foreach $key ( keys %$hash_ref ) {
	my $value = $$hash_ref{ $key };
	$value = "0" if $value && $value =~ /ZERO_STRING/;
	$return_string .= " " . $key . "=\"" . $value . "\""
	if $$hash_ref{ $key };
    }
    return $return_string;
}

sub init {
    my $self = shift;
    my $tag = shift;
#    print "Setting tag to: $tag : " . ref( $self ) . "\n" if $debug;
    $self->setTag( $tag );
}

1;

