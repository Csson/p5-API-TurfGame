use 5.14.0;
use strict;
use warnings;
use API::TurfGame::Standard;

package API::TurfGame::Rest;

# VERSION
# PODCLASSNAME
# ABSTRACT: ..


resource User {

    purpose Search {

        request {

            post 'users', 'application/json';

            body sub {
                my $self = shift;

                my @data = map { { name => $_ } } $self->all_name;
                push @data => map { { id => $_ } } $self->all_id;
                push @data => map { { email => $_ } } $self->all_email;
                return encode_json(\@data);
            };

            param name => (
                isa => (ArrayRef[Str])->plus_coercions(Str, sub { [$_] }),
                coerce => 1,
                optional => 1,
            );
            param id => (
                isa => (ArrayRef[Int])->plus_coercions(Int, sub { [$_] }),
                coerce => 1,
                optional => 1,
                printable_method => sub {

                },
            );
            param email => (
                isa => (ArrayRef[Str])->plus_coercions(Str, sub { [$_] }),
                coerce => 1,
                optional => 1,
                printable_method => sub {

                },
            );

        }
        response {
            prop users => (
                isa => TurfUserSearchItems,
                dpath => '/',
            );
        }

        class Item {
            has blocktime => (
                is => 'ro',
                isa => Int,
            );
            has country => (
                is => 'ro',
                isa => Str,
            );
            has id => (
                is => 'ro',
                isa => Int,
            );
            has medals => (
                is => 'ro',
                isa => ArrayRef[Int],
                traits => ['Array'],
                default => sub { [ ] },
                handles => {
                    all_medals => 'elements',
                    map_medals => 'map',
                    filter_medals => 'grep',
                },
            );
            has name => (
                is => 'ro',
                isa => Str,
            );
            has place => (
                is => 'ro',
                isa => Int,
            );
            has points => (
                is => 'ro',
                isa => Int,
            );
            has points_per_hour => (
                is => 'ro',
                isa => Int,
                init_arg => 'pointsPerHour',
            );
            has rank => (
                is => 'ro',
                isa => Int,
            );
            has region => (
                is => 'ro',
                isa => TurfRegionItem,
                coerce => 1,
            );
            has taken => (
                is => 'ro',
                isa => Int,
            );
            has total_points => (
                is => 'ro',
                isa => Int,
                init_arg => 'totalPoints',
            );
            has unique_zones_taken => (
                is => 'ro',
                isa => Int,
                init_arg => 'uniqueZonesTaken',
            );
            has zones => (
                is => 'ro',
                isa => ArrayRef[Int],
                traits => ['Array'],
                default => sub { [ ] },
                handles => {
                    all_zones => 'elements',
                    map_zones => 'map',
                    filter_zones => 'grep',
                },
            );
        }
    }
}

1;
