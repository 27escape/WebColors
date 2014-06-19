
# ABSTRACT: 

=head1 NAME

WebColors

=head1 SYNOPSIS

    use 5.10.0 ;
    use strict ;
    use warnings ;
    use WebColors;

    my $object = WebColors->new() ;

=head1 DESCRIPTION

See Also 

=cut

package WebColors;

use 5.014;
use warnings;
use strict;
use Moo ;

has basic => ( is => 'ro') ;

# ----------------------------------------------------------------------------
1;

