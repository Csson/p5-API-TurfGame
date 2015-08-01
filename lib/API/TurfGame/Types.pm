use Moops;
use strict;
use warnings;

# VERSION
# PODCLASSNAME
# ABSTRACT: ..

library API::TurfGame::Types

declares

    TimeMoment,
    TimestampRFC3339,

    TurfRegionItem,
    TurfRegionItems,
    TurfRegionLord,
    TurfRegionListRequest,
    TurfRegionListResponse,

    TurfUserSearchItems,
    TurfUserSearchItem,
    TurfUserSearchRequest,
    TurfUserSearchResponse,

    TurfFeedViewItems,
    TurfFeedViewRequest,
    TurfFeedViewResponse,
    TurfFeedViewOwner,
    TurfFeedViewTakeoverZone,
    TurfFeedViewTakeover

{

    class_type TimeMoment => { class => 'Time::Moment' };

    my $class_types = [
        'Rest::Region::Item' => {
            type => TurfRegionItem,
            coerce_from => ['HashRef'],
        },
        'Rest::Region::RegionLord' => {
            type => TurfRegionLord,
            coerce_from => ['HashRef'],
        },
        'Rest::Region::List::Request' => {
            type => TurfRegionListRequest,
            coerce_from => ['HashRef'],
        },
        'Rest::Region::List::Response' => {
            type => TurfRegionListResponse,
            coerce_from => ['HashRef'],
        },

        'Rest::User::Search::Request' => {
            type => TurfUserSearchRequest,
            coerce_from => ['HashRef'],
        },
        'Rest::User::Search::Response' => {
            type => TurfUserSearchResponse,
            coerce_from => ['HashRef'],
        },
        'Rest::User::Search::Item' => {
            type => TurfUserSearchItem,
            coerce_from => ['HashRef'],
        },

        'Rest::Feed::View::Request' => {
            type => TurfFeedViewRequest,
            coerce_from => ['HashRef'],
        },
        'Rest::Feed::View::Response' => {
            type => TurfFeedViewResponse,
            coerce_from => ['HashRef'],
        },
        'Rest::Feed::View::Owner' => {
            type => TurfFeedViewOwner,
            coerce_from => ['HashRef'],
        },
        'Rest::Feed::View::Takeover' => {
            type => TurfFeedViewTakeover,
            coerce_from => ['HashRef'],
        },
        'Rest::Feed::View::TakeoverZone' => {
            type => TurfFeedViewTakeoverZone,
            coerce_from => ['HashRef'],
        },
    ];

    for (my $i = 0; $i < scalar @$class_types; $i += 2) {

        my $partclass = $class_types->[$i];
        my $def = $class_types->[$i + 1];
        my $fullclass = 'API::TurfGame::' . $partclass;
        my $type = $def->{'type'};
        my $coercions = $def->{'coerce_from'} // [];
        my $coerce_from_method = $def->{'coerce_from_method'} // 'new';

        class_type $type => { class => $fullclass };

        foreach my $coercion (@$coercions) {
            coerce_from_hashref($type, $fullclass, $coerce_from_method) if $coercion eq 'HashRef';
        }
    }


    my $item_declarations = [
        'Region::Item' => {
            as => ArrayRef[TurfRegionItem],
            one => TurfRegionItem,
            many => TurfRegionItems,
        },
        'User::Search::Item' => {
            as => ArrayRef[TurfUserSearchItem],
            one => TurfUserSearchItem,
            many => TurfUserSearchItems,
        },
        # Change this when expanding Feeditem to all types
        'Feed::View::Takeover' => {
            as => ArrayRef[TurfFeedViewTakeover],
            one => TurfFeedViewTakeover,
            many => TurfFeedViewItems,
        },
    ];

    for (my $i = 0; $i < scalar @$item_declarations; $i += 2) {
        my $partclass = $item_declarations->[$i];
        my $def = $item_declarations->[$i + 1];
        my $fullclass = 'API::TurfGame::Rest::' . $partclass;

        my $as = $def->{'as'};
        my $one = $def->{'one'};
        my $many = $def->{'many'};

        declare $many,
        as $as,
        message { sprintf "Those are not $one objects" };

        coerce $many,
        from ArrayRef[HashRef],
        via { [ map { $fullclass->new($_) } @$_ ] };

        coerce $one,
        from ArrayRef,
        via { [ $fullclass->new(@$_) ] };
    }

    declare TimestampRFC3339,
    as Str,
    where {
        $_ =~ m{^
                \d{4}    # year
                \-
                \d{2}    # month
                \-
                \d{2}    # day of month
                T
                \d{2}    # hour
                :
                \d{2}    # minute
                :
                \d{2}    # second
                \+
                \d{4}    # timezone
            }x;
    },
    message { sprintf q{That (%s) doesn't look like an RFC3339 time stamp}, $_ };

    coerce TimestampRFC3339,
    from TimeMoment,
    via { $_->strftime('%Y-%m-%dT%H:%M:%S+%Z') };

    coerce TimeMoment,
    from TimestampRFC3339,
    via { 
        $_ =~ m{^
                 (?<year>\d{4})      # year
                 \-
                 (?<mon>\w{2})       # month
                 \-
                 (?<day>\d{2})     # day of month
                 T
                 (?<hour>\d{2})    # hour
                 :
                 (?<min>\d{2})     # minute
                 :
                 (?<sec>\d{2})     # second
                 \+
                 (?<tz>.+)           # time zone
            }x;

        'Time::Moment'->new(year => $+{'year'},
                            month => $+{'mon'},
                            day => $+{'day'},
                            hour => $+{'hour'},
                            minute => $+{'minute'},
                            second => $+{'second'}
                        );
    };


    sub coerce_from_hashref {
        my $type = shift;
        my $class = shift;
        my $method = shift;

        coerce $type,
        from HashRef,
        via {
            # transform all keys with '-' to '_'
            my $inref = $_;
            my $hashref = { map { my $key = $_; $key =~ s{-}{_}g; { $key => $inref->{ $_ } } } keys %$inref };

            $class->$method(%$hashref);
        };
    }
}

1;
