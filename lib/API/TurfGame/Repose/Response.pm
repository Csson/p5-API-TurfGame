use 5.14.0;
use strict;
use warnings;
use API::TurfGame::Standard;

# PODCLASSNAME

role API::TurfGame::Repose::Response {

    # VERSION
    # ABSTRACT: .

    use List::UtilsBy 'extract_by';

    has turfgame => (
        is => 'rw',
        isa => InstanceOf['API::TurfGame'],
    );
    has ok => (
        is => 'ro',
        isa => Bool,
        lazy => 1,
        default => sub {
            my $self = shift;
            return $self->repose_response->status == 200 ? 1 : 0;
        },
    );

}

1;
