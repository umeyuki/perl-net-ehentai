package Net::E::Hentai;
use strict;
use warnings;
use utf8;

use WWW::Mechanize;
use HTML::Entities qw/decode_entities/;
use Path::Class qw/dir/;
use HTML::Entities;
use Carp;
our $VERSION = '0.01';

=head1 SYNOPSIS

use Net::E::Hentai;

my $ne = Net::E::Hentai->new( url => 'http://g.e-hentai.org/g/177964/cc25675a95/');
ne.download();


=cut

sub new {
    my ( $class,%args ) = @_;
    my $self = bless {%args};
    bless {
        url    => decode_entities($args{url}),
        dir    => dir($args{dir}) || dir('./'),
        mech   => $args{mech} || WWW::Mechanize->new,
        prefix => $args{prefix} || ''
    },$class;
}

sub mech {
    my $self = shift;
    return $self->{mech};
}

sub get_content {
    my $self = shift;
    $self->mech->get($self->{url});
}

# $mech->get($url);
# my $tree = HTML::TreeBuilder::XPath->new();
# $tree->parse( $mech->content );                   
# my @items = $tree->findnodes(selector_to_xpath('div.gdtm div a'));
# my $item =  shift @items;
# $mech->follow_link( url => $item->{href} );

sub get_pages {
    my $self = shift;
    return 12;
};

sub download {
    my $self = shift;

    my $content = $self->get_content();
    # 総ページ数を取得
    my $pages = $self->get_pages();
    
    
    # トップページに移動
    $self->mech->get($self->{url});
    my $tree = HTML::TreeBuilder::XPath->new();
    $tree->parse( $self->mech->content );


    # 最初のページに移動
    $self->mech->follow_links('');
    
    for (1..$pages) {
        
    }
    
    # 総ページ数分以下の動作を繰り返す
    # id=imgのクラスのsrcを取得
    # ダウンロード
    # 次のページに移動
    
    my $dir;
    my $filepath = $dir->file('file_name');
    my $entry;
#    my $res = $ua->get( $entry->{MediaUrl}, ':content_file' => $filepath->stringify );
    $tree->delete;
}


sub _next {
    my ($self)
}

sub get_image_urls {
    my $self  = shift;
    my @images = ();
    
#    my $res = $ua->get( $url, ':content_file' => '/Users/umeyuki1326/work/test.jpg' );

    
    
    return \@images;
}


1;
__END__

=head1 NAME

Net::E::Hentai -

=head1 SYNOPSIS

  use Net::E::Hentai;

=head1 DESCRIPTION

Net::E::Hentai is

=head1 AUTHOR

umeyuki E<lt>umeyuki1326{at}gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
