use 5.14.0;
use strict;
use warnings;
use API::TurfGame::Standard;

# PODCLASSNAME

role API::TurfGame::Repose::Request {

    # VERSION
    # ABSTRACT: .

    has turfgame => (
        is => 'ro',
        isa => InstanceOf['API::TurfGame'],
        required => 1,
    );

    around make_request {

        my $response = $self->$next;
        $response->turfgame($self->turfgame);
        return $response;
    }
}

1;
