use strict;
use warnings;

use Test::More;
use if $ENV{'AUTHOR_TESTING'}, 'Test::Warnings';

use API::TurfGame;
use Data::Dump::Streamer;
use utf8;

my $turf = API::TurfGame->new;

subtest user_search => sub {
    my $user_search = $turf->user_search(name => [qw/ventoux Femöringen staren/]);

    is $user_search->repose_response->status, 200, 'Correct http status';
    is $user_search->get_users(0)->name, 'ventoux', 'Correct first user';
    is $user_search->find_users(sub { $_->name eq 'ventoux'})->id, 113809, 'Correct id for ventoux';

};


done_testing;
