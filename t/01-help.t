use strict;
use warnings;
use Test::More tests => 5;
use File::Temp qw(tempdir);

# Put a fake 'got' stub first on PATH so got_required() passes
my $tmpbin = tempdir( CLEANUP => 1 );
open( my $fh, '>', "$tmpbin/got" ) or die $!;
print $fh "#!/bin/sh\nexit 0\n";
close $fh;
chmod 0755, "$tmpbin/got";
local $ENV{PATH} = "$tmpbin:$ENV{PATH}";

my $perl = $^X;
my $out  = `$perl gott help 2>&1`;

like( $out, qr/gott/,           'help mentions gott' );
like( $out, qr/Local workflow/, 'help has Local workflow section' );
like( $out, qr/Git interop/i,   'help has Git interoperability section' );
like( $out, qr/stash/,          'help lists stash command' );
like( $out, qr/git-push/,       'help lists git-push command' );
