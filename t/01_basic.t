
#!/usr/bin/perl -w

=head1 NAME

01_basic.t

=head1 DESCRIPTION

test App::Basis::ConvertText2::UtfTransform

=head1 AUTHOR

kevin mulholland, moodfarm@cpan.org

=cut

use v5.10;
use strict;
use warnings;
use Test::More tests => 14;

BEGIN { use_ok('WebColors'); }

my @colors = list_webcolors() ;
ok( scalar(@colors) > 100, 'There are lots of colors') ;

my ($r, $g, $b) = colorname_to_rgb( 'black') ;
ok( "$r-$g-$b" eq "0-0-0", "rgb black is OK") ;
($r, $g, $b) = colorname_to_rgb( 'white') ;
ok( "$r-$g-$b" eq "255-255-255", "rgb white is OK") ;
($r, $g, $b) = colorname_to_rgb( 'whiterthanwhite') ;
ok( !defined $r, "missing colour is undef") ;

my $hex = colorname_to_hex( 'red') ;
ok( lc($hex) eq "ff0000", "hex red is OK") ;
$hex = colorname_to_hex( 'green') ;
ok( lc($hex) eq "008000", "hex green is OK") ; # lime is 00ff00
$hex = colorname_to_hex( 'bluered') ;
ok( !defined $hex, "missing colour is undef") ;

($r, $g, $b) = colorname_to_rgb_percent( 'gray') ;
ok( "$r-$g-$b" eq "50-50-50", "% black is OK") ;
($r, $g, $b) = colorname_to_rgb_percent( 'lime') ;
ok( "$r-$g-$b" eq "0-100-0", "% lime is OK") ;

my $name = rgb_to_colorname( 0, 255, 255) ;
ok( $name eq "aqua", "rgb to aqua is OK") ;
$name = hex_to_colorname( '00ff00') ;
ok( $name eq "lime", "rgb to lime is OK") ;
$name = rgb_percent_to_colorname( 100, 100, 0) ;
ok( $name eq "yellow", "% yellow is OK") ;

# lets use the actual percentages from [ 50,  205, 50 ]
$name = rgb_percent_to_colorname( 19.6, 80.39, 19.6) ;  
ok( $name eq "limegreen", "% likegreen is OK") ;
