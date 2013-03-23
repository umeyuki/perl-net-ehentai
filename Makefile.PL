use inc::Module::Install;
name 'Net-E-Hentai';
all_from 'lib/Net/E/Hentai.pm';

# requires '';

tests 't/*.t';
author_tests 'xt';

test_requires 'Test::More';
auto_set_repository;
auto_include;
WriteAll;
