use inc::Module::Install;
name 'Net-E-Hentai';
all_from 'lib/Net/E/Hentai.pm';

requires 'WWW::Mechanize';
requires 'Web::Query';
requires 'Carp';
requires 'LWP::UserAgent';
requires 'File::Basename';
requires 'File::Spec';

tests 't/*.t';
author_tests 'xt';

test_requires 'Test::More';
auto_set_repository;
auto_include;
install_script('bin/ehentai');
WriteAll;
