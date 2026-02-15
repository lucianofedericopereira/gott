use strict;
use warnings;
use Test::More tests => 5;

my $perl = $^X;

my $out = `$perl gott help 2>&1`;
like( $out, qr/gott/,            'help mentions gott' );
like( $out, qr/Local workflow/,  'help has Local workflow section' );
like( $out, qr/Git interop/i,    'help has Git interoperability section' );
like( $out, qr/stash/,           'help lists stash command' );
like( $out, qr/git-push/,        'help lists git-push command' );
