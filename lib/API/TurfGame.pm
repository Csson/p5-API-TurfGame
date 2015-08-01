use 5.14.0;
use strict;
use warnings;
use API::TurfGame::Standard;

# VERSION
# PODCLASSNAME
# ABSTRACT: ..

class API::TurfGame {

    use LWP::UserAgent;
    use API::TurfGame::Rest::Region;
    use API::TurfGame::Rest::User;
    use API::TurfGame::Rest::Feed;

    has ua => (
        is => 'ro',
        isa => InstanceOf['LWP::UserAgent'],
        default => sub { LWP::UserAgent->new },
    );
    has base_url => (
        is => 'ro',
        isa => Any,
        lazy => 1,
        default => 'http://api.turfgame.com/v4',
    );
    
    
    method region_list(TurfRegionListRequest $request does coerce --> TurfRegionListResponse but assumed) {
        return $request->make_request;
    }

    method user_search(TurfUserSearchRequest $request does coerce --> TurfUserSearchResponse but assumed) {
        return $request->make_request;
    }

    method feed_view(TurfFeedViewRequest $request does coerce --> TurfFeedViewResponse but assumed) {
        return $request->make_request;
    }

    around region_list, user_search, feed_view
        ($next: $self, HashRef $data does slurpy)
    {
        $data->{'turfgame'} //= $self;
        $data->{'base_url'} = $self->base_url;
        $data->{'ua'} = $self->ua;

        return $self->$next($data);
    }

}

1;
