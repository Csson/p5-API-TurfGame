use strict;
use warnings;

use Test::More;
use if $ENV{'AUTHOR_TESTING'}, 'Test::Warnings';

use API::TurfGame;
use API::TurfGame::Types -types;
use Data::Dump::Streamer;
use utf8;

my $turf = API::TurfGame->new;

subtest takeover_feed => sub {
    my $takeover_feed = $turf->feed_view;

    my $match = $takeover_feed->get_events(0)->longitude =~ m{^\d+\.\d+$};
    is $match, 1, 'That is a longitude';

};

done_testing;
