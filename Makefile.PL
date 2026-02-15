use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME             => 'gott',
    AUTHOR           => 'Luciano Federico Pereira <lucianopereira@posteo.es>',
    VERSION_FROM     => 'gott',
    ABSTRACT         => 'Game of Trees companion CLI with git interop',
    LICENSE          => 'bsd',
    MIN_PERL_VERSION => '5.010',
    EXE_FILES        => ['gott'],
    PREREQ_PM        => {
        'File::Basename' => 0,
        'File::Path'     => '2.08',
        'POSIX'          => 0,
        'Cwd'            => 0,
    },
    TEST_REQUIRES => {
        'Test::More'   => '0.94',
        'Test::Output' => 0,
    },
    META_MERGE => {
        'meta-spec' => { version => 2 },
        resources   => {
            repository => {
                type => 'git',
                url  => 'https://github.com/lucianofedericopereira/gott.git',
                web  => 'https://github.com/lucianofedericopereira/gott',
            },
            bugtracker => {
                web => 'https://github.com/lucianofedericopereira/gott/issues',
            },
        },
    },
    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz' },
    clean => { FILES    => 'gott-*' },
);
