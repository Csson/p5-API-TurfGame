use 5.14.0;
use strict;
use warnings;

package #
    API::TurfGame::Standard {

    # VERSION
    # ABSTRACT: ..

    use base 'Rest::Repose';
    use Types::Standard();
    use API::TurfGame::Types();
    use Time::Moment();
    use JSON::MaybeXS();

    sub import {
        my $class = shift;
        my %opts = @_;

        push @{ $opts{'imports'} ||= [] } => (
            'Types::Standard' => [{ replace => 1 }, '-types'],
            'API::TurfGame::Types' => [{ replace => 1 }, '-types'],
            'Time::Moment' => [],
            'JSON::MaybeXS' => [qw/encode_json/],
        );

        push @{ $opts{'traits'} } => (
            'API::TurfGame::Repose::RequestResponseKeywords',
        );

        $class->SUPER::import(%opts);
    }
}

1;
