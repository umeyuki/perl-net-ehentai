#/usr/bin/env perl
use strict;
use warnings;
use Findbin;
use lib "$FindBin::Bin/../lib";
use Net::Ehentai;
use Getopt::Long qw(:config posix_default no_ignore_case gnu_compat);
use Carp;
use utf8;

my $prefix = '';
my $url = '';

GetOptions(
    "prefix|p=s" => \$prefix,
    "url|u=s" => \$url,
);

my $ne = Net::Ehentai->new(
     prefix => $prefix,
     url    => $url
);

unless ( $prefix ) {
    $prefix = 'hentai';
}

mkdir $prefix unless -d $prefix;

sub main {
    $ne->download();
}

&main();
