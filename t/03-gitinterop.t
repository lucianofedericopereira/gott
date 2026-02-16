use strict;
use warnings;
use Test::More tests => 4;
use File::Temp qw(tempdir);
use Cwd        qw(abs_path);

# Fake 'got' stub so got_required() passes
my $tmpbin = tempdir( CLEANUP => 1 );
open( my $fh, '>', "$tmpbin/got" ) or die $!;
print $fh "#!/bin/sh\nexit 0\n";
close $fh;
chmod 0755, "$tmpbin/got";
local $ENV{PATH} = "$tmpbin:$ENV{PATH}";

my $perl = $^X;
my $gott = abs_path('gott');

# patch outside a worktree exits non-zero
{
    my $out = `cd /tmp && $perl $gott patch 2>&1`;
    my $rc  = $? >> 8;
    isnt( $rc, 0, 'patch outside worktree exits non-zero' );
}

# apply without file argument exits non-zero
{
    my $out = `$perl $gott apply 2>&1`;
    my $rc  = $? >> 8;
    isnt( $rc, 0,                   'apply without file exits non-zero' );
    like( $out, qr/Usage:.*apply/i, 'apply without file prints usage' );
}

# sync outside worktree exits non-zero
{
    my $out = `cd /tmp && $perl $gott sync 2>&1`;
    my $rc  = $? >> 8;
    isnt( $rc, 0, 'sync outside worktree exits non-zero' );
}
