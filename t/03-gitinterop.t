use strict;
use warnings;
use Test::More tests => 4;

my $perl = $^X;

# patch without worktree exits non-zero
{
    local $ENV{HOME} = '/tmp';
    my $out = `cd /tmp && $perl ${\abs_path('gott')} patch 2>&1`;
    my $rc  = $? >> 8;
    isnt( $rc, 0, 'patch outside worktree exits non-zero' );
}

# apply without file argument exits non-zero
{
    my $out = `$perl gott apply 2>&1`;
    my $rc  = $? >> 8;
    isnt( $rc, 0,                         'apply without file exits non-zero' );
    like( $out, qr/Usage:.*apply/i,       'apply without file prints usage' );
}

# sync outside worktree exits non-zero
{
    local $ENV{HOME} = '/tmp';
    my $out = `cd /tmp && $perl ${\abs_path('gott')} sync 2>&1`;
    my $rc  = $? >> 8;
    isnt( $rc, 0, 'sync outside worktree exits non-zero' );
}

sub abs_path {
    require Cwd;
    return Cwd::abs_path( $_[0] );
}
