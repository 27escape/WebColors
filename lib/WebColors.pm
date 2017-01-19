# ABSTRACT:

=head1 NAME

WebColors - Library for WebColors.

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
extend Device::Hynpocube so that it can use the full set of named colors it 
is also used in Device::BlinkStick

Google material colors have spaces removed and their numerical values added, so

Red 400 becomes red400, with accents Deep Purple A100 becomes deeppurplea100

See Also 

Google material colors L<http://www.google.com/design/spec/style/color.html>

=cut

package WebColors ;

use 5.0.4 ;
use warnings ;
use strict ;
use Exporter ;
use vars qw( @EXPORT @ISA) ;

@ISA = qw(Exporter) ;

# this is the list of things that will get imported into the loading packages
# namespace
@EXPORT = qw(
    list_webcolors
    to_rgb
    colorname_to_hex
    colorname_to_rgb
    colorname_to_rgb_percent
    rgb_to_colorname
    hex_to_colorname
    rgb_percent_to_colorname
    inverse_rgb
    luminance
    ) ;

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
    rebeccapurple        => [ 102, 51,  153 ],
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

    red50   => [ 0xff, 0xeb, 0xee ],
    red100  => [ 0xff, 0xcd, 0xd2 ],
    red200  => [ 0xef, 0x9a, 0x9a ],
    red300  => [ 0xe5, 0x73, 0x73 ],
    red400  => [ 0xef, 0x53, 0x50 ],
    red500  => [ 0xf4, 0x43, 0x36 ],
    red600  => [ 0xe5, 0x39, 0x35 ],
    red700  => [ 0xd3, 0x2f, 0x2f ],
    red800  => [ 0xc6, 0x28, 0x28 ],
    red900  => [ 0xb7, 0x1c, 0x1c ],
    reda100 => [ 0xff, 0x8a, 0x80 ],
    reda200 => [ 0xff, 0x52, 0x52 ],
    reda400 => [ 0xff, 0x17, 0x44 ],
    reda700 => [ 0xd5, 0x00, 0x00 ],

    pink50   => [ 0xfc, 0xe4, 0xec ],
    pink100  => [ 0xf8, 0xbb, 0xd0 ],
    pink200  => [ 0xf4, 0x8f, 0xb1 ],
    pink300  => [ 0xf0, 0x62, 0x92 ],
    pink400  => [ 0xec, 0x40, 0x7a ],
    pink500  => [ 0xe9, 0x1e, 0x63 ],
    pink600  => [ 0xd8, 0x1b, 0x60 ],
    pink700  => [ 0xc2, 0x18, 0x5b ],
    pink800  => [ 0xad, 0x14, 0x57 ],
    pink900  => [ 0x88, 0x0e, 0x4f ],
    pinka100 => [ 0xff, 0x80, 0xab ],
    pinka200 => [ 0xff, 0x40, 0x81 ],
    pinka400 => [ 0xf5, 0x00, 0x57 ],
    pinka700 => [ 0xc5, 0x11, 0x62 ],

    purple50   => [ 0xf3, 0xe5, 0xf5 ],
    purple100  => [ 0xe1, 0xbe, 0xe7 ],
    purple200  => [ 0xce, 0x93, 0xd8 ],
    purple300  => [ 0xba, 0x68, 0xc8 ],
    purple400  => [ 0xab, 0x47, 0xbc ],
    purple500  => [ 0x9c, 0x27, 0xb0 ],
    purple600  => [ 0x8e, 0x24, 0xaa ],
    purple700  => [ 0x7b, 0x1f, 0xa2 ],
    purple800  => [ 0x6a, 0x1b, 0x9a ],
    purple900  => [ 0x4a, 0x14, 0x8c ],
    purplea100 => [ 0xea, 0x80, 0xfc ],
    purplea200 => [ 0xe0, 0x40, 0xfb ],
    purplea400 => [ 0xd5, 0x00, 0xf9 ],
    purplea700 => [ 0xaa, 0x00, 0xff ],

    deeppurple50   => [ 0xed, 0xe7, 0xf6 ],
    deeppurple100  => [ 0xd1, 0xc4, 0xe9 ],
    deeppurple200  => [ 0xb3, 0x9d, 0xdb ],
    deeppurple300  => [ 0x95, 0x75, 0xcd ],
    deeppurple400  => [ 0x7e, 0x57, 0xc2 ],
    deeppurple500  => [ 0x67, 0x3a, 0xb7 ],
    deeppurple600  => [ 0x5e, 0x35, 0xb1 ],
    deeppurple700  => [ 0x51, 0x2d, 0xa8 ],
    deeppurple800  => [ 0x45, 0x27, 0xa0 ],
    deeppurple900  => [ 0x31, 0x1b, 0x92 ],
    deeppurplea100 => [ 0xb3, 0x88, 0xff ],
    deeppurplea200 => [ 0x7c, 0x4d, 0xff ],
    deeppurplea400 => [ 0x65, 0x1f, 0xff ],
    deeppurplea700 => [ 0x62, 0x00, 0xea ],

    indigo50   => [ 0xe8, 0xea, 0xf6 ],
    indigo100  => [ 0xc5, 0xca, 0xe9 ],
    indigo200  => [ 0x9f, 0xa8, 0xda ],
    indigo300  => [ 0x79, 0x86, 0xcb ],
    indigo400  => [ 0x5c, 0x6b, 0xc0 ],
    indigo500  => [ 0x3f, 0x51, 0xb5 ],
    indigo600  => [ 0x39, 0x49, 0xab ],
    indigo700  => [ 0x30, 0x3f, 0x9f ],
    indigo800  => [ 0x28, 0x35, 0x93 ],
    indigo900  => [ 0x1a, 0x23, 0x7e ],
    indigoa100 => [ 0x8c, 0x9e, 0xff ],
    indigoa200 => [ 0x53, 0x6d, 0xfe ],
    indigoa400 => [ 0x3d, 0x5a, 0xfe ],
    indigoa700 => [ 0x30, 0x4f, 0xfe ],

    blue50   => [ 0xe3, 0xf2, 0xfd ],
    blue100  => [ 0xbb, 0xde, 0xfb ],
    blue200  => [ 0x90, 0xca, 0xf9 ],
    blue300  => [ 0x64, 0xb5, 0xf6 ],
    blue400  => [ 0x42, 0xa5, 0xf5 ],
    blue500  => [ 0x21, 0x96, 0xf3 ],
    blue600  => [ 0x1e, 0x88, 0xe5 ],
    blue700  => [ 0x19, 0x76, 0xd2 ],
    blue800  => [ 0x15, 0x65, 0xc0 ],
    blue900  => [ 0x0d, 0x47, 0xa1 ],
    bluea100 => [ 0x82, 0xb1, 0xff ],
    bluea200 => [ 0x44, 0x8a, 0xff ],
    bluea400 => [ 0x29, 0x79, 0xff ],
    bluea700 => [ 0x29, 0x62, 0xff ],

    lightblue50   => [ 0xe1, 0xf5, 0xfe ],
    lightblue100  => [ 0xb3, 0xe5, 0xfc ],
    lightblue200  => [ 0x81, 0xd4, 0xfa ],
    lightblue300  => [ 0x4f, 0xc3, 0xf7 ],
    lightblue400  => [ 0x29, 0xb6, 0xf6 ],
    lightblue500  => [ 0x03, 0xa9, 0xf4 ],
    lightblue600  => [ 0x03, 0x9b, 0xe5 ],
    lightblue700  => [ 0x02, 0x88, 0xd1 ],
    lightblue800  => [ 0x02, 0x77, 0xbd ],
    lightblue900  => [ 0x01, 0x57, 0x9b ],
    lightbluea100 => [ 0x80, 0xd8, 0xff ],
    lightbluea200 => [ 0x40, 0xc4, 0xff ],
    lightbluea400 => [ 0x00, 0xb0, 0xff ],
    lightbluea700 => [ 0x00, 0x91, 0xea ],

    cyan50   => [ 0xe0, 0xf7, 0xfa ],
    cyan100  => [ 0xb2, 0xeb, 0xf2 ],
    cyan200  => [ 0x80, 0xde, 0xea ],
    cyan300  => [ 0x4d, 0xd0, 0xe1 ],
    cyan400  => [ 0x26, 0xc6, 0xda ],
    cyan500  => [ 0x00, 0xbc, 0xd4 ],
    cyan600  => [ 0x00, 0xac, 0xc1 ],
    cyan700  => [ 0x00, 0x97, 0xa7 ],
    cyan800  => [ 0x00, 0x83, 0x8f ],
    cyan900  => [ 0x00, 0x60, 0x64 ],
    cyana100 => [ 0x84, 0xff, 0xff ],
    cyana200 => [ 0x18, 0xff, 0xff ],
    cyana400 => [ 0x00, 0xe5, 0xff ],
    cyana700 => [ 0x00, 0xb8, 0xd4 ],

    teal50   => [ 0xe0, 0xf2, 0xf1 ],
    teal100  => [ 0xb2, 0xdf, 0xdb ],
    teal200  => [ 0x80, 0xcb, 0xc4 ],
    teal300  => [ 0x4d, 0xb6, 0xac ],
    teal400  => [ 0x26, 0xa6, 0x9a ],
    teal500  => [ 0x00, 0x96, 0x88 ],
    teal600  => [ 0x00, 0x89, 0x7b ],
    teal700  => [ 0x00, 0x79, 0x6b ],
    teal800  => [ 0x00, 0x69, 0x5c ],
    teal900  => [ 0x00, 0x4d, 0x40 ],
    teala100 => [ 0xa7, 0xff, 0xeb ],
    teala200 => [ 0x64, 0xff, 0xda ],
    teala400 => [ 0x1d, 0xe9, 0xb6 ],
    teala700 => [ 0x00, 0xbf, 0xa5 ],

    green50   => [ 0xe8, 0xf5, 0xe9 ],
    green100  => [ 0xc8, 0xe6, 0xc9 ],
    green200  => [ 0xa5, 0xd6, 0xa7 ],
    green300  => [ 0x81, 0xc7, 0x84 ],
    green400  => [ 0x66, 0xbb, 0x6a ],
    green500  => [ 0x4c, 0xaf, 0x50 ],
    green600  => [ 0x43, 0xa0, 0x47 ],
    green700  => [ 0x38, 0x8e, 0x3c ],
    green800  => [ 0x2e, 0x7d, 0x32 ],
    green900  => [ 0x1b, 0x5e, 0x20 ],
    greena100 => [ 0xb9, 0xf6, 0xca ],
    greena200 => [ 0x69, 0xf0, 0xae ],
    greena400 => [ 0x00, 0xe6, 0x76 ],
    greena700 => [ 0x00, 0xc8, 0x53 ],

    lightgreen50   => [ 0xf1, 0xf8, 0xe9 ],
    lightgreen100  => [ 0xdc, 0xed, 0xc8 ],
    lightgreen200  => [ 0xc5, 0xe1, 0xa5 ],
    lightgreen300  => [ 0xae, 0xd5, 0x81 ],
    lightgreen400  => [ 0x9c, 0xcc, 0x65 ],
    lightgreen500  => [ 0x8b, 0xc3, 0x4a ],
    lightgreen600  => [ 0x7c, 0xb3, 0x42 ],
    lightgreen700  => [ 0x68, 0x9f, 0x38 ],
    lightgreen800  => [ 0x55, 0x8b, 0x2f ],
    lightgreen900  => [ 0x33, 0x69, 0x1e ],
    lightgreena100 => [ 0xcc, 0xff, 0x90 ],
    lightgreena200 => [ 0xb2, 0xff, 0x59 ],
    lightgreena400 => [ 0x76, 0xff, 0x03 ],
    lightgreena700 => [ 0x64, 0xdd, 0x17 ],

    lime50   => [ 0xf9, 0xfb, 0xe7 ],
    lime100  => [ 0xf0, 0xf4, 0xc3 ],
    lime200  => [ 0xe6, 0xee, 0x9c ],
    lime300  => [ 0xdc, 0xe7, 0x75 ],
    lime400  => [ 0xd4, 0xe1, 0x57 ],
    lime500  => [ 0xcd, 0xdc, 0x39 ],
    lime600  => [ 0xc0, 0xca, 0x33 ],
    lime700  => [ 0xaf, 0xb4, 0x2b ],
    lime800  => [ 0x9e, 0x9d, 0x24 ],
    lime900  => [ 0x82, 0x77, 0x17 ],
    limea100 => [ 0xf4, 0xff, 0x81 ],
    limea200 => [ 0xee, 0xff, 0x41 ],
    limea400 => [ 0xc6, 0xff, 0x00 ],
    limea700 => [ 0xae, 0xea, 0x00 ],

    yellow50   => [ 0xff, 0xfd, 0xe7 ],
    yellow100  => [ 0xff, 0xf9, 0xc4 ],
    yellow200  => [ 0xff, 0xf5, 0x9d ],
    yellow300  => [ 0xff, 0xf1, 0x76 ],
    yellow400  => [ 0xff, 0xee, 0x58 ],
    yellow500  => [ 0xff, 0xeb, 0x3b ],
    yellow600  => [ 0xfd, 0xd8, 0x35 ],
    yellow700  => [ 0xfb, 0xc0, 0x2d ],
    yellow800  => [ 0xf9, 0xa8, 0x25 ],
    yellow900  => [ 0xf5, 0x7f, 0x17 ],
    yellowa100 => [ 0xff, 0xff, 0x8d ],
    yellowa200 => [ 0xff, 0xff, 0x00 ],
    yellowa400 => [ 0xff, 0xea, 0x00 ],
    yellowa700 => [ 0xff, 0xd6, 0x00 ],

    amber50   => [ 0xff, 0xf8, 0xe1 ],
    amber100  => [ 0xff, 0xec, 0xb3 ],
    amber200  => [ 0xff, 0xe0, 0x82 ],
    amber300  => [ 0xff, 0xd5, 0x4f ],
    amber400  => [ 0xff, 0xca, 0x28 ],
    amber500  => [ 0xff, 0xc1, 0x07 ],
    amber600  => [ 0xff, 0xb3, 0x00 ],
    amber700  => [ 0xff, 0xa0, 0x00 ],
    amber800  => [ 0xff, 0x8f, 0x00 ],
    amber900  => [ 0xff, 0x6f, 0x00 ],
    ambera100 => [ 0xff, 0xe5, 0x7f ],
    ambera200 => [ 0xff, 0xd7, 0x40 ],
    ambera400 => [ 0xff, 0xc4, 0x00 ],
    ambera700 => [ 0xff, 0xab, 0x00 ],

    orange50   => [ 0xff, 0xf3, 0xe0 ],
    orange100  => [ 0xff, 0xe0, 0xb2 ],
    orange200  => [ 0xff, 0xcc, 0x80 ],
    orange300  => [ 0xff, 0xb7, 0x4d ],
    orange400  => [ 0xff, 0xa7, 0x26 ],
    orange500  => [ 0xff, 0x98, 0x00 ],
    orange600  => [ 0xfb, 0x8c, 0x00 ],
    orange700  => [ 0xf5, 0x7c, 0x00 ],
    orange800  => [ 0xef, 0x6c, 0x00 ],
    orange900  => [ 0xe6, 0x51, 0x00 ],
    orangea100 => [ 0xff, 0xd1, 0x80 ],
    orangea200 => [ 0xff, 0xab, 0x40 ],
    orangea400 => [ 0xff, 0x91, 0x00 ],
    orangea700 => [ 0xff, 0x6d, 0x00 ],

    deeporange50   => [ 0xfb, 0xe9, 0xe7 ],
    deeporange100  => [ 0xff, 0xcc, 0xbc ],
    deeporange200  => [ 0xff, 0xab, 0x91 ],
    deeporange300  => [ 0xff, 0x8a, 0x65 ],
    deeporange400  => [ 0xff, 0x70, 0x43 ],
    deeporange500  => [ 0xff, 0x57, 0x22 ],
    deeporange600  => [ 0xf4, 0x51, 0x1e ],
    deeporange700  => [ 0xe6, 0x4a, 0x19 ],
    deeporange800  => [ 0xd8, 0x43, 0x15 ],
    deeporange900  => [ 0xbf, 0x36, 0x0c ],
    deeporangea100 => [ 0xff, 0x9e, 0x80 ],
    deeporangea200 => [ 0xff, 0x6e, 0x40 ],
    deeporangea400 => [ 0xff, 0x3d, 0x00 ],
    deeporangea700 => [ 0xdd, 0x2c, 0x00 ],

    brown50  => [ 0xef, 0xeb, 0xe9 ],
    brown100 => [ 0xd7, 0xcc, 0xc8 ],
    brown200 => [ 0xbc, 0xaa, 0xa4 ],
    brown300 => [ 0xa1, 0x88, 0x7f ],
    brown400 => [ 0x8d, 0x6e, 0x63 ],
    brown500 => [ 0x79, 0x55, 0x48 ],
    brown600 => [ 0x6d, 0x4c, 0x41 ],
    brown700 => [ 0x5d, 0x40, 0x37 ],
    brown800 => [ 0x4e, 0x34, 0x2e ],
    brown900 => [ 0x3e, 0x27, 0x23 ],

    grey50  => [ 0xfa, 0xfa, 0xfa ],
    grey100 => [ 0xf5, 0xf5, 0xf5 ],
    grey200 => [ 0xee, 0xee, 0xee ],
    grey300 => [ 0xe0, 0xe0, 0xe0 ],
    grey400 => [ 0xbd, 0xbd, 0xbd ],
    grey500 => [ 0x9e, 0x9e, 0x9e ],
    grey600 => [ 0x75, 0x75, 0x75 ],
    grey700 => [ 0x61, 0x61, 0x61 ],
    grey800 => [ 0x42, 0x42, 0x42 ],
    grey900 => [ 0x21, 0x21, 0x21 ],

    bluegrey50  => [ 0xec, 0xef, 0xf1 ],
    bluegrey100 => [ 0xcf, 0xd8, 0xdc ],
    bluegrey200 => [ 0xb0, 0xbe, 0xc5 ],
    bluegrey300 => [ 0x90, 0xa4, 0xae ],
    bluegrey400 => [ 0x78, 0x90, 0x9c ],
    bluegrey500 => [ 0x60, 0x7d, 0x8b ],
    bluegrey600 => [ 0x54, 0x6e, 0x7a ],
    bluegrey700 => [ 0x45, 0x5a, 0x64 ],
    bluegrey800 => [ 0x37, 0x47, 0x4f ],
    bluegrey900 => [ 0x26, 0x32, 0x38 ],
) ;

=head1 Public Functions

=over 4

=cut

# ----------------------------------------------------------------------------

=item list_webcolors

list the colors covered in this module

    my @colors = list_colors() ;

=cut

sub list_webcolors
{
    return sort keys %web_colors ;
}


# ----------------------------------------------------------------------------

# get rgb values from a hex triplet

sub _hex_to_rgb
{
    my ($hex) = @_ ;

    $hex =~ s/^#// ;
    $hex = lc($hex) ;

    my ( $r, $g, $b ) ;
    if ( $hex =~ /^[0-9a-f]{6}$/ ) {
        ( $r, $g, $b ) = ( $hex =~ /(\w{2})/g ) ;
    } elsif ( $hex =~ /^[0-9a-f]{3}$/ ) {
        ( $r, $g, $b ) = ( $hex =~ /(\w)/g ) ;
        # double up to make the colors correct
        ( $r, $g, $b ) = ( "$r$r", "$g$g", "$b$b" ) ;
    } else {
        return ( undef, undef, undef ) ;
    }

    return ( hex($r), hex($g), hex($b) ) ;
}

# ----------------------------------------------------------------------------

=item to_rbg

get rgb for a hex triplet, or a colorname. if the hex value is only 3 characters
then it wil be expanded to 6

    my ($r,$g,$b) = to_rgb( 'ff00ab') ;
    ($r,$g,$b) = to_rgb( 'red') ;
    ($r,$g,$b) = to_rgb( 'abc') ;

entries will be null if there is no match

=cut

sub to_rgb
{
    my ($name) = @_ ;
    # first up try as hex
    my ( $r, $g, $b ) = _hex_to_rgb($name) ;

    # try as a name then
    if ( !defined $r ) {
        ( $r, $g, $b ) = colorname_to_rgb($name) ;
    }

    return ( $r, $g, $b ) ;
}

# ----------------------------------------------------------------------------

=item colorname_to_rgb

get the rgb values 0..255 to match a color

    my ($r, $g, $b) = colorname_to_rgb( 'goldenrod') ;

    # get a material color

    ($r, $g, $b) = colorname_to_rgb( 'bluegrey500') ;

entries will be null if there is no match

=cut

sub colorname_to_rgb
{
    my ($name) = @_ ;

    # deref the arraryref
    my $rgb = $web_colors{ lc($name) } ;

    $rgb = [ undef, undef, undef ] if ( !$rgb ) ;
    return @$rgb ;
}

# ----------------------------------------------------------------------------

=item colorname_to_hex

get the color value as a hex triplet '12ffee' to match a color

    my $hex => colorname_to_hex( 'darkslategray') ;

    # get a material color, accented red

    $hex => colorname_to_hex( 'reda300') ;

entries will be null if there is no match

=cut

sub colorname_to_hex
{
    my ($name) = @_ ;
    my @c = colorname_to_rgb($name) ;
    my $str ;
    $str = sprintf( "%02x%02x%02x", $c[0], $c[1], $c[2] )
        if ( defined $c[0] ) ;
    return $str ;
}

# ----------------------------------------------------------------------------

=item colorname_to_rgb_percent

get the rgb values as an integer percentage 0..100% to match a color

    my ($r, $g, $b) = colorname_to_percent( 'goldenrod') ;

entries will be null if there is no match

=cut

sub colorname_to_rgb_percent
{
    my ($name) = @_ ;

    my @c = colorname_to_rgb($name) ;

    if ( defined $c[0] ) {
        for ( my $i = 0; $i < scalar(@c); $i++ ) {
            $c[$i] = int( $c[$i] * 100 / 255 ) ;
        }
    }
    return @c ;
}

# ----------------------------------------------------------------------------
# test if a value is almost +/- 1 another value
sub _almost
{
    my ( $a, $b ) = @_ ;

    ( $a == $b || ( $a + 1 ) == $b || ( $a - 1 == $b ) ) ? 1 : 0 ;
}

# ----------------------------------------------------------------------------

=item rgb_to_colorname

match a name from a rgb triplet, matches within +/-1 of the values

    my $name = rgb_to_colorname( 255, 0, 0) ;

returns null if there is no match

=cut

sub rgb_to_colorname
{
    my ( $r, $g, $b ) = @_ ;

    my $color ;
    foreach my $c ( sort keys %web_colors ) {

        # no need for fancy compares
        my ( $r1, $g1, $b1 ) = @{ $web_colors{$c} } ;

        if ( _almost( $r, $r1 ) && _almost( $g, $g1 ) && _almost( $b, $b1 ) )
        {
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

sub rgb_percent_to_colorname
{
    my ( $r, $g, $b ) = @_ ;

    return rgb_to_colorname(
        int( $r * 255 / 100 ),
        int( $g * 255 / 100 ),
        int( $b * 255 / 100 )
    ) ;
}

# ----------------------------------------------------------------------------

=item hex_to_colorname

match a name from a hex triplet, matches within +/-1 of the value

    my $name = hex_to_colorname( 'ff0000') ;

returns null if there is no match

=cut

sub hex_to_colorname
{
    my ($hex) = @_ ;

    my ( $r, $g, $b ) = _hex_to_rgb($hex) ;

    return rgb_to_colorname( $r, $g, $b ) ;
}

# ----------------------------------------------------------------------------

=item inverse_rgb

Get the inverse of the RGB values

    my ($i_r, $i_g, $i_b) = inverse_rgb( 0xff, 0x45, 0x34) ;

=cut

sub inverse_rgb
{
    my ( $r, $g, $b ) = @_ ;

    return ( 255 - $r, 255 - $g, 255 - $b ) ;
}

# ----------------------------------------------------------------------------
# source was http://stackoverflow.com/questions/596216/formula-to-determine-brightness-of-rgb-color

=item luminance

Calculate the luminance of an rgb value

Rough calculation using Photometric/digital ITU-R:

Y = 0.2126 R + 0.7152 G + 0.0722 B

    my $luma = luminance( to_rgb( 'green')) ;

=cut

sub luminance
{
    my ( $r, $g, $b ) = @_ ;

    return int( ( 0.2126 * $r ) + ( 0.7152 * $g ) + ( 0.0722 * $b ) ) ;
}

# # ----------------------------------------------------------------------------

# =item approx_luminance

# Calculate the approximate luminance of an rgb value, rough/ready/fast

#     my $luma = approx_luminance( to_rgb( 'green')) ;

# =cut

# sub approx_luminance
# {
#     my ( $r, $g, $b ) = @_ ;

#     return int( ( ( 2 * $r ) + ( 3 * $g ) + ($b) ) / 6 ) ;
# }


=back

=cut

# ----------------------------------------------------------------------------

1 ;
