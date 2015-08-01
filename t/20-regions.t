use strict;
use warnings;

use Test::More;
use if $ENV{'AUTHOR_TESTING'}, 'Test::Warnings';

use API::TurfGame;
use Data::Dump::Streamer;

my $turf = API::TurfGame->new;

subtest region_list => sub {
    my $region_list = $turf->region_list;

    is $region_list->repose_response->status, 200, 'Correct http status';
    #is $domain_list->total_count, 2, 'Correct number of domains';
    #is $domain_list->get_items(0)->created_at->hour, 17, 'Correct created_at for first domain in list';
    #is $domain_list->get_items(0)->name, 'mgtest.code301.com', 'Correct name on checked domain';
    #is $domain_list->repose_raw_response->{'items'}[0]{'smtp_login'}, 'postmaster@mgtest.code301.com', 'Correct to_hash smtp_login';

    diag Dump $region_list->repose_raw_response;
    diag '=====================';
    diag $region_list->repose_request->url;
    diag '--------------';
    diag Dump $region_list->get_regions(0);

    diag Dump $region_list->map_regions(sub { return if !$_->has_region_lord; $_->region_lord->name });

};


done_testing;
