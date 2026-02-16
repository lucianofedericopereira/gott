use strict;
use warnings;
use Test::More tests => 6;
use File::Temp qw(tempdir);

# Fake 'got' stub so got_required() passes
my $tmpbin = tempdir( CLEANUP => 1 );
open( my $fh, '>', "$tmpbin/got" ) or die $!;
print $fh "#!/bin/sh\nexit 0\n";
close $fh;
chmod 0755, "$tmpbin/got";
local $ENV{PATH} = "$tmpbin:$ENV{PATH}";

my $perl = $^X;

# unknown command exits non-zero
{
    my $out = `$perl gott xyzzy 2>&1`;
    my $rc  = $? >> 8;
    isnt( $rc, 0,                     'unknown command exits non-zero' );
    like( $out, qr/Unknown command/i, 'unknown command prints message' );
}

# new without name exits non-zero
{
    my $out = `$perl gott new 2>&1`;
    my $rc  = $? >> 8;
    isnt( $rc, 0,               'new without name exits non-zero' );
    like( $out, qr/Usage:.*new/i, 'new without name prints usage' );
}

# nb without name exits non-zero
{
    my $out = `$perl gott nb 2>&1`;
    my $rc  = $? >> 8;
    isnt( $rc, 0,              'nb without name exits non-zero' );
    like( $out, qr/Usage:.*nb/i, 'nb without name prints usage' );
}
