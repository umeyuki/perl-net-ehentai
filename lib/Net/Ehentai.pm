package Net::Ehentai;
use strict;
use warnings;
use utf8;
use autodie;

use WWW::Mechanize;
use Web::Query;
use Carp;
use Data::Dumper::Concise;
use LWP::UserAgent;
use File::Basename;
use File::Spec;
our $VERSION = '0.01';

=head1 SYNOPSIS

use Net::Ehentai;

my $ne = Net::E::Hentai->new( url => 'http://g.e-hentai.org/g/177964/cc25675a95/');

$ne->download();


eh.download();


=cut

use constant {
    CURRENT_PAGE => 'div#i2 div.sn a#prev + div span:first-child',
    START_PAGE   => 'div#gdt .gdtm:first-child a',
    TOTAL_PAGE   => '.ip',
    NEXT         => 'div#i2 div.sn a#next',
    IMAGE        => 'div#i3 a img#img',
};

sub new {
    my ( $class, %args ) = @_;
    croak "url required!" unless $args{url};
    my $self = bless {
        url    => $args{url} || '',
        mech   => WWW::Mechanize->new(),
        ua     => LWP::UserAgent->new(),
        prefix => $args{prefix} || './',
    }, $class;
    $self->{total_page} = $self->_total_page;
    $self;
}

sub download {
    my $self = shift;

    eval {
        print "Now Downloading...\n";
        $self->_start_page();
        while ( $self->_next ) {
            $self->_process();
        }
    };
    if ( $@ ) {
        warn "Download error! Because of $@\n";
    }
}

sub _process {
    my $self = shift;
    wq( $self->mech->content )->find(IMAGE)
        ->each(
            sub {
                my $image_url = $_->attr('src');
                my $filename = File::Spec->catfile($self->{prefix} , basename($image_url));
                my $res = $self->ua->get($image_url, ':content_file' => $filename);
                die unless $res->is_success;
                sleep 5;
            }
        );
}

sub _start_page {
    my $self = shift;
    my $href = '';
    wq( $self->{url} )->find(START_PAGE)->each(
        sub {
            $href = $_->attr('href');
        }
    );
    $self->mech->follow_link( url => $href );
    $self->_process();
}

sub _next {
    my $self = shift;
    $self->{current_page} = $self->_current_page;
    if ( $self->{current_page} == $self->{total_page}  ) {
        return undef;
    }
    my $href = '';
    wq( $self->mech->content() )->find(NEXT)->
        each(
        sub {
            $href = $_->attr('href');
        }
    );
    $self->mech->follow_link( url => $href );
    return 1;
}


sub _total_page {
    my $self = shift;

    my $page = 0;
    $self->mech->get($self->{url});
    wq( $self->mech->content )->find(TOTAL_PAGE)
      ->each(
        sub {
            my $page_info = $_->text;
            my @args = split( ' ', $page_info );
            $page = $args[5];
        }
    );
    $page;
}

sub _current_page {
    my $self = shift;
    my $current_page;

    wq( $self->mech->content )->find(CURRENT_PAGE)
      ->each(
        sub {
            $current_page = $_->text;
        }
    );
    print "$current_page / $self->{total_page}\n";
    $current_page
}

sub mech {
    my $self = shift;
    $self->{mech};
}

sub ua {
    my $self = shift;
    $self->{ua};
}


1;
__END__

=head1 NAME

Net::Ehentai -

=head1 SYNOPSIS

  use Net::Ehentai;

=head1 DESCRIPTION

Net::E::Hentai is

=head1 AUTHOR

umeyuki E<lt>umeyuki1326{at}gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
