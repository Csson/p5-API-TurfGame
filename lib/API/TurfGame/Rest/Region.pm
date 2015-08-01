use 5.14.0;
use strict;
use warnings;
use API::TurfGame::Standard;

package API::TurfGame::Rest;

# VERSION
# PODCLASSNAME
# ABSTRACT: ..

resource Region {


    purpose List {

        request {

            get 'regions';

        }
        response {
            prop regions => (
                isa => TurfRegionItems,
                dpath => '/',
            );
        }
    }

    class Item {

        has id => (
            is => 'ro',
            isa => Int,
            required => 1,
        );
        has name => (
            is => 'ro',
            isa => Str,
            required => 1,
        );
        has country => (
            is => 'ro',
            isa => Str,
        );
        has region_lord => (
            is => 'ro',
            isa => TurfRegionLord,
            coerce => 1,
            predicate => 1,
            init_arg => 'regionLord',
        );
    }

    class RegionLord {
        has id => (
            is => 'ro',
            isa => Int,
            required => 1,
        );
        has name => (
            is => 'ro',
            isa => Str,
            required => 1,
        );
    }
}

1;
