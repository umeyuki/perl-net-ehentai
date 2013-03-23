#!perl

use strict;
use warnings;
use utf8;
use WWW::Mechanize;
use Web::Scraper;

use constant URL => 'http://g.e-hentai.org/s/5f895c76db/177964-1';

sub new {
    my ( $class,%args ) = @_;
    my $self = bless {%args};
    bless {
        url => $args{url}
    },$class;
}


    
