#!/usr/bin/perl

use SYMM::Smil;

my $obj = new SYMM::Smil( 'height' => 234, 'width' => 300,
		   'meta' => 
		   { "author" => "Chris Dawson",
		     "title" => "First Perl/SMIL",
		     "copyright" => "1999 RealNetworks"} );

# Set this to disable error checking
#$obj->disableErrorChecking;

my $region1 = "region1";
my $region2 = "region2";
my $region3 = "region3";

$obj->addRegion( "name" => $region1, "top" => 23, "left" => 45, 
		"height" => 200, "z-index" => 3, "width" => 250 );
$obj->addRegion(  "name" => $region2, "top" => 40, "left" => 85, 
		"height" => 200, "z-index" => 3, "width" => 250 );

$obj->addMedia( "type" => "audio",
	       "src" => "rtsp://moothra.prognet.com/g2audio.rm" );

$obj->startSequence();
$obj->addSwitchedMedia( "switch" => 'system-bitrate',
		       'medias' => 
		       [ { 'region' => $region1,
			   'switch-target' => 28000,
			   "src" => "rtsp://www.real.com/video.rm" },
			{ 'region' => $region1,
			  "src" => "rtsp://www.yahoo.com/radio.rm" } ] );
			 # 'switch-target' => 36000 } ] );
$obj->addMedia( "region" => $region1, 
	       'href' => "http://www.real.com",
	       "src" => "rtsp://moothra.prognet.com/g2video.rm" );
$obj->addMedia("region" => $region2, 
	       "anchors" => [ { 'href' => 'http://www.real.com', 
				'coords' => '0,0,23,0' } ],
	       "src" => "rtsp://moothra.prognet.com/g2video.rm" );
$obj->endSequence();

$cont = $obj->getAsString();

my $expected = <<END;
<smil>
    <head>
        <layout>
            <root-layout width="300" height="234"/>
            <region width="250" height="200" left="45" top="23" id="region1" z-index="3"/>
            <region width="250" height="200" left="85" top="40" id="region2" z-index="3"/>
        </layout>
        <meta name="copyright" content="1999 RealNetworks"/>
        <meta name="title" content="First Perl/SMIL"/>
        <meta name="author" content="Chris Dawson"/>
    </head>
    <body>
        <par>
            <audio src="rtsp://moothra.prognet.com/g2audio.rm"/>
            <seq>
                <switch>
                    <ref src="rtsp://www.real.com/video.rm" region="region1" system-bitrate="28000"/>
                    <ref src="rtsp://www.yahoo.com/radio.rm" region="region1"/>
                </switch>
                <a href="http://www.real.com">
                    <ref src="rtsp://moothra.prognet.com/g2video.rm" region="region1"/>
                </a>
                <ref src="rtsp://moothra.prognet.com/g2video.rm" region="region2">
                    <anchor coords="0,0,23,0" href="http://www.real.com"/>
                </ref>
            </seq>
        </par>
    </body>
</smil>
END
    
print "Installed successfully\n\n" if $expected =~ /$cont/;

