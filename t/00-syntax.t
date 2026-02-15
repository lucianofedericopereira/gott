use strict;
use warnings;
use Test::More tests => 1;

my $rc = system( $^X, '-c', 'gott' );
is( $rc, 0, 'gott compiles without errors' );
