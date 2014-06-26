# ABSTRACT:

=head1 NAME

WebColors

=head1 SYNOPSIS

    use 5.10.0 ;
    use strict ;
    use warnings ;
    use WebColors;

    my ($r, $g, $b) = colorname_to_rgb( 'goldenrod') ;

=head1 DESCRIPTION

Get either the hex triplet value or the rgb values for a HTML named color.

Values have been taken from https://en.wikipedia.org/wiki/HTML_color_names#HTML_color_names

For me I want this module so that I can use the named colours to 
extend Device::Hynpocube so that it can use the full set of named colors it will
also be used if I get around to creating Device::BlinkStick

See Also 

=cut

package WebColors;

use 5.0.4;
use warnings;
use strict;
use Exporter;
use vars qw( @EXPORT @ISA);

@ISA = qw(Exporter);

# this is the list of things that will get imported into the loading packages
# namespace
@EXPORT = qw(
    list_webcolors
    colorname_to_hex
    colorname_to_rgb
    colorname_to_rgb_percent
    rgb_to_colorname
    hex_to_colorname
    rgb_percent_to_colorname
);

# ----------------------------------------------------------------------------

my %web_colors = (

    # basic
    black   => [ 0,   0,   0 ],
    silver  => [ 192, 192, 192 ],
    gray    => [ 128, 128, 128 ],
    white   => [ 255, 255, 255 ],
    maroon  => [ 128, 0,   0 ],
    red     => [ 255, 0,   0 ],
    purple  => [ 128, 0,   128 ],
    fuchsia => [ 255, 0,   255 ],
    green   => [ 0,   128, 0 ],
    lime    => [ 0,   255, 0 ],
    olive   => [ 128, 128, 0 ],
    yellow  => [ 255, 255, 0 ],
    navy    => [ 0,   0,   128 ],
    blue    => [ 0,   0,   255 ],
    teal    => [ 0,   128, 128 ],
    aqua    => [ 0,   255, 255 ],

    # extended
    aliceblue            => [ 240, 248, 255 ],
    antiquewhite         => [ 250, 235, 215 ],
    aqua                 => [ 0,   255, 255 ],
    aquamarine           => [ 127, 255, 212 ],
    azure                => [ 240, 255, 255 ],
    beige                => [ 245, 245, 220 ],
    bisque               => [ 255, 228, 196 ],
    black                => [ 0,   0,   0 ],
    blanchedalmond       => [ 255, 235, 205 ],
    blue                 => [ 0,   0,   255 ],
    blueviolet           => [ 138, 43,  226 ],
    brown                => [ 165, 42,  42 ],
    burlywood            => [ 222, 184, 135 ],
    cadetblue            => [ 95,  158, 160 ],
    chartreuse           => [ 127, 255, 0 ],
    chocolate            => [ 210, 105, 30 ],
    coral                => [ 255, 127, 80 ],
    cornflowerblue       => [ 100, 149, 237 ],
    cornsilk             => [ 255, 248, 220 ],
    crimson              => [ 220, 20,  60 ],
    cyan                 => [ 0,   255, 255 ],
    darkblue             => [ 0,   0,   139 ],
    darkcyan             => [ 0,   139, 139 ],
    darkgoldenrod        => [ 184, 134, 11 ],
    darkgray             => [ 169, 169, 169 ],
    darkgreen            => [ 0,   100, 0 ],
    darkgrey             => [ 169, 169, 169 ],
    darkkhaki            => [ 189, 183, 107 ],
    darkmagenta          => [ 139, 0,   139 ],
    darkolivegreen       => [ 85,  107, 47 ],
    darkorange           => [ 255, 140, 0 ],
    darkorchid           => [ 153, 50,  204 ],
    darkred              => [ 139, 0,   0 ],
    darksalmon           => [ 233, 150, 122 ],
    darkseagreen         => [ 143, 188, 143 ],
    darkslateblue        => [ 72,  61,  139 ],
    darkslategray        => [ 47,  79,  79 ],
    darkslategrey        => [ 47,  79,  79 ],
    darkturquoise        => [ 0,   206, 209 ],
    darkviolet           => [ 148, 0,   211 ],
    deeppink             => [ 255, 20,  147 ],
    deepskyblue          => [ 0,   191, 255 ],
    dimgray              => [ 105, 105, 105 ],
    dimgrey              => [ 105, 105, 105 ],
    dodgerblue           => [ 30,  144, 255 ],
    firebrick            => [ 178, 34,  34 ],
    floralwhite          => [ 255, 250, 240 ],
    forestgreen          => [ 34,  139, 34 ],
    fuchsia              => [ 255, 0,   255 ],
    gainsboro            => [ 220, 220, 220 ],
    ghostwhite           => [ 248, 248, 255 ],
    gold                 => [ 255, 215, 0 ],
    goldenrod            => [ 218, 165, 32 ],
    gray                 => [ 128, 128, 128 ],
    green                => [ 0,   128, 0 ],
    greenyellow          => [ 173, 255, 47 ],
    grey                 => [ 128, 128, 128 ],
    honeydew             => [ 240, 255, 240 ],
    hotpink              => [ 255, 105, 180 ],
    indianred            => [ 205, 92,  92 ],
    indigo               => [ 75,  0,   130 ],
    ivory                => [ 255, 255, 240 ],
    khaki                => [ 240, 230, 140 ],
    lavender             => [ 230, 230, 250 ],
    lavenderblush        => [ 255, 240, 245 ],
    lawngreen            => [ 124, 252, 0 ],
    lemonchiffon         => [ 255, 250, 205 ],
    lightblue            => [ 173, 216, 230 ],
    lightcoral           => [ 240, 128, 128 ],
    lightcyan            => [ 224, 255, 255 ],
    lightgoldenrodyellow => [ 250, 250, 210 ],
    lightgray            => [ 211, 211, 211 ],
    lightgreen           => [ 144, 238, 144 ],
    lightgrey            => [ 211, 211, 211 ],
    lightpink            => [ 255, 182, 193 ],
    lightsalmon          => [ 255, 160, 122 ],
    lightseagreen        => [ 32,  178, 170 ],
    lightskyblue         => [ 135, 206, 250 ],
    lightslategray       => [ 119, 136, 153 ],
    lightslategrey       => [ 119, 136, 153 ],
    lightsteelblue       => [ 176, 196, 222 ],
    lightyellow          => [ 255, 255, 224 ],
    lime                 => [ 0,   255, 0 ],
    limegreen            => [ 50,  205, 50 ],
    linen                => [ 250, 240, 230 ],
    magenta              => [ 255, 0,   255 ],
    maroon               => [ 128, 0,   0 ],
    mediumaquamarine     => [ 102, 205, 170 ],
    mediumblue           => [ 0,   0,   205 ],
    mediumorchid         => [ 186, 85,  211 ],
    mediumpurple         => [ 147, 112, 219 ],
    mediumseagreen       => [ 60,  179, 113 ],
    mediumslateblue      => [ 123, 104, 238 ],
    mediumspringgreen    => [ 0,   250, 154 ],
    mediumturquoise      => [ 72,  209, 204 ],
    mediumvioletred      => [ 199, 21,  133 ],
    midnightblue         => [ 25,  25,  112 ],
    mintcream            => [ 245, 255, 250 ],
    mistyrose            => [ 255, 228, 225 ],
    moccasin             => [ 255, 228, 181 ],
    navajowhite          => [ 255, 222, 173 ],
    navy                 => [ 0,   0,   128 ],
    oldlace              => [ 253, 245, 230 ],
    olive                => [ 128, 128, 0 ],
    olivedrab            => [ 107, 142, 35 ],
    orange               => [ 255, 165, 0 ],
    orangered            => [ 255, 69,  0 ],
    orchid               => [ 218, 112, 214 ],
    palegoldenrod        => [ 238, 232, 170 ],
    palegreen            => [ 152, 251, 152 ],
    paleturquoise        => [ 175, 238, 238 ],
    palevioletred        => [ 219, 112, 147 ],
    papayawhip           => [ 255, 239, 213 ],
    peachpuff            => [ 255, 218, 185 ],
    peru                 => [ 205, 133, 63 ],
    pink                 => [ 255, 192, 203 ],
    plum                 => [ 221, 160, 221 ],
    powderblue           => [ 176, 224, 230 ],
    purple               => [ 128, 0,   128 ],
    red                  => [ 255, 0,   0 ],
    rosybrown            => [ 188, 143, 143 ],
    royalblue            => [ 65,  105, 225 ],
    saddlebrown          => [ 139, 69,  19 ],
    salmon               => [ 250, 128, 114 ],
    sandybrown           => [ 244, 164, 96 ],
    seagreen             => [ 46,  139, 87 ],
    seashell             => [ 255, 245, 238 ],
    sienna               => [ 160, 82,  45 ],
    silver               => [ 192, 192, 192 ],
    skyblue              => [ 135, 206, 235 ],
    slateblue            => [ 106, 90,  205 ],
    slategray            => [ 112, 128, 144 ],
    slategrey            => [ 112, 128, 144 ],
    snow                 => [ 255, 250, 250 ],
    springgreen          => [ 0,   255, 127 ],
    steelblue            => [ 70,  130, 180 ],
    tan                  => [ 210, 180, 140 ],
    teal                 => [ 0,   128, 128 ],
    thistle              => [ 216, 191, 216 ],
    tomato               => [ 255, 99,  71 ],
    turquoise            => [ 64,  224, 208 ],
    violet               => [ 238, 130, 238 ],
    wheat                => [ 245, 222, 179 ],
    white                => [ 255, 255, 255 ],
    whitesmoke           => [ 245, 245, 245 ],
    yellow               => [ 255, 255, 0 ],
    yellowgreen          => [ 154, 205, 50 ],
);

=head1 Public Functions

=over 4

=cut

# ----------------------------------------------------------------------------

=item list_webcolors

list the colors covered in this module

    my @colors = list_colors() ;

=cut

sub list_webcolors {
    return sort keys %web_colors ;
}

# ----------------------------------------------------------------------------

=item colorname_to_rgb

get the rgb values 0..255 to match a color

    my ($r, $g, $b) = colorname_to_rgb( 'goldenrod') ;

entries will be null if there is no match

=cut

sub colorname_to_rgb {
    my ($name) = @_;

    # deref the arraryref
    my $rgb = $web_colors{ lc($name) };

    $rgb = [ undef, undef, undef ] if ( !$rgb );
    return @$rgb;
}

# ----------------------------------------------------------------------------

=item colorname_to_hex

get the color value as a hex triplet '12ffee' to match a color

    my $hex => colorname_to_hex( 'darkslategray') ;

entries will be null if there is no match

=cut

sub colorname_to_hex {
    my ($name) = @_;
    my @c = colorname_to_rgb($name);
    my $str;
    $str = sprintf( "%02x%02x%02x", $c[0], $c[1], $c[2] ) if ( defined $c[0] );
    return $str;
}

# ----------------------------------------------------------------------------

=item colorname_to_rgb_percent

get the rgb values as an integer percentage 0..100% to match a color

    my ($r, $g, $b) = colorname_to_percent( 'goldenrod') ;

entries will be null if there is no match

=cut

sub colorname_to_rgb_percent {
    my ($name) = @_;

    my @c = colorname_to_rgb($name);

    if ( defined $c[0] ) {
        for ( my $i = 0; $i < scalar(@c); $i++ ) {
            $c[$i] = int( $c[$i] * 100 / 255 );
        }
    }
    return @c;
}

# ----------------------------------------------------------------------------
# test if a value is almost +/- 1 another value
sub _almost {
    my ($a, $b) = @_ ;

    ( $a == $b || ($a+1) == $b || ($a-1 == $b)) ? 1 : 0 ;
}

# ----------------------------------------------------------------------------

=item rgb_to_colorname

match a name from a rgb triplet, matches within +/-1 of the values

    my $name = rgb_to_colorname( 255, 0, 0) ;

returns null if there is no match

=cut

sub rgb_to_colorname {
    my ($r, $g, $b) = @_ ;

    my $color ;
    foreach my $c (sort keys %web_colors) {
        # no need for fancy compares
        my ($r1, $g1, $b1) = @{$web_colors{$c}} ;
        # next if(  $r != $r1) ;
        # next if(  $g != $g1) ;
        # if blue matches then we are all done
        # if(  $b == $b1) {
        if( _almost( $r, $r1) && _almost( $g, $g1) && _almost( $b, $b1)) {
            $color = $c ;
            last ;
        }
    }

    return $color ;
}

# ----------------------------------------------------------------------------

=item rgb_percent_to_colorname

match a name from a rgb_percet triplet, matches within +/-1 of the value

    my $name = rgb_percent_to_colorname( 100, 0, 100) ;

returns null if there is no match

=cut

sub rgb_percent_to_colorname {
    my ($r, $g, $b) = @_ ;

    return rgb_to_colorname( int($r * 255/100), int($g * 255/100), int($b * 255/100)) ;
}

# ----------------------------------------------------------------------------

=item hex_to_colorname

match a name from a hex triplet, matches within +/-1 of the value

    my $name = hex_to_colorname( 'ff0000') ;

returns null if there is no match

=cut

sub hex_to_colorname {    my ($hex) = @_ ;

    $hex =~ s/^#// ;
    $hex = lc( $hex) ;
    my ($r, $g, $b) = split( /[0-9A-F]{2}/, $hex) ;

    return rgb_to_colorname( hex($r), hex($g), hex($b)) ;
}

=back

=cut

# ----------------------------------------------------------------------------

1;
