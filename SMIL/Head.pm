package SYMM::SMIL::Head;

my $debug = 0;

$VERSION = "0.5";

use SYMM::SMIL::XMLContainer;
use SYMM::SMIL::XMLTag;
use SYMM::SMIL::Layout;
use SYMM::SMIL::Meta;

@ISA = qw( SYMM::SMIL::XMLContainer );

my $layout = "layout";
my $metas = "metas";
my $meta = "meta";

sub init {
    my $self = shift;
    my %hash = @_;
    $self->SUPER::init( "head" );    
    if( $hash{ 'height' } && $hash{ 'width' } ) {
	$self->initLayout( @_ ) ;
	print "Setting layout" if $debug;
    }
    $self->initMetas( @_ ) if( $hash{ 'meta' } );
}

sub getRootHeight {
    my $self = shift;
    my $ly = $self->getContentObjectByName( $layout );
    return $ly ? $ly->getRootHeight() : 0;    
}

sub getRootWidth {
    my $self = shift;
    my $ly = $self->getContentObjectByName( $layout );
    return $ly ? $ly->getRootWidth() : 0;    
}



sub initLayout {
    my $self = shift;
    $self->{$layout} = new SYMM::SMIL::Layout( @_ );
    $self->setTagContents( $layout => $self->{$layout} );
}

sub initMetas {
    my $self = shift;
    my %hash = @_;

    if( $hash{ $meta } ) {
	$self->setMeta( $hash{ $meta } );
    }
}

sub setMeta {

    my $self = shift;
    my $hash_ref = shift;
    my $meta_tags_ref = $self->getContentObjectByName( $metas );

    if( !( $meta_tags_ref && @$meta_tags_ref ) ) {
	$meta_tags_ref = [];
    }
    
    # Extract the meta tags
    foreach $name ( keys %$hash_ref ) {
	my $meta = new SYMM::SMIL::Meta( $name, $$hash_ref{ $name } );
	# Now, push it on the stack of meta tags
	push @$meta_tags_ref, $meta;
    }

    $self->{$metas} = $meta_tags_ref;
    $self->setTagContents( $metas => $meta_tags_ref );
}

sub addRegion {
    my $self = shift;
    $self->{$layout} = new SYMM::SMIL::Layout( @_ )
	unless $self->getContentObjectByName( $layout );
    $self->getContentObjectByName( $layout )->addRegion( @_ );
}

my $switch = 'switch';
my $layouts = 'layouts';

sub setSwitchedLayout {
    my $self = shift;
    my %hash = @_;
    
    # Extract the switch attribute
    my $switch_attribute = $hash{ $switch };
    my $thelayout = $hash{ $layouts };
    
    my $switch_obj = new SYMM::SMIL::Switch( $switch_attribute, $thelayout );
    $self->setTagContents( $layout => $switch_obj );
}
