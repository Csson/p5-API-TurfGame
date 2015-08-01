use 5.14.0;
use strict;
use warnings;
use API::TurfGame::Standard;

package API::TurfGame::Rest;

# VERSION
# PODCLASSNAME
# ABSTRACT: ..


resource Feed {

    purpose View {

        request {

            get 'feeds/takeover';

        }
        response {
            prop events => (
                isa => TurfFeedViewItems,
                dpath => '/',
            );
        }

        class Owner {
            has id => (
                is => 'ro',
                isa => Int,
            );
            has name => (
                is => 'ro',
                isa => Str,
            );
        }
        class TakeoverZone {
            has current_owner => (
                is => 'ro',
                isa => TurfFeedViewOwner,
                coerce => 1,
                init_arg => 'currentOwner',
            );
            has date_created => (
                is => 'ro',
                isa => TimeMoment,
                coerce => 1,
                init_arg => 'dateCreated',
            );
            has date_last_taken => (
                is => 'ro',
                isa => TimeMoment,
                coerce => 1,
                init_arg => 'dateLastTaken',
            );
            has id => (
                is => 'ro',
                isa => Int,
            );
            has latitude => (
                is => 'ro',
                isa => StrictNum,
            );
            has longitude => (
                is => 'ro',
                isa => StrictNum,
            );
            has name => (
                is => 'ro',
                isa => Str,
            );
            has points_per_hour => (
                is => 'ro',
                isa => Int,
                init_arg => 'pointsPerHour',
            );
            has previous_owner => (
                is => 'ro',
                isa => TurfFeedViewOwner,
                coerce => 1,
                init_arg => 'previousOwner',
            );
            has region => (
                is => 'ro',
                isa => TurfRegionItem,
                coerce => 1,
            );
            has takeover_points => (
                is => 'ro',
                isa => Int,
                init_arg => 'takeoverPoints',
            );
            has total_takeovers => (
                is => 'ro',
                isa => Int,
                init_arg => 'totalTakeovers',
            );
        }

        class Takeover {
            has current_owner => (
                is => 'ro',
                isa => TurfFeedViewOwner,
                coerce => 1,
                init_arg => 'currentOwner',
            );
            has latitude => (
                is => 'ro',
                isa => StrictNum,
            );
            has longitude => (
                is => 'ro',
                isa => StrictNum,
            );
            has time => (
                is => 'ro',
                isa => TimeMoment,
                coerce => 1,
            );
            has type => (
                is => 'ro',
                isa => Str,
            );
            has zone => (
                is => 'ro',
                isa => TurfFeedViewTakeoverZone,
                coerce => 1,
            );
        }
    }
}

1;
