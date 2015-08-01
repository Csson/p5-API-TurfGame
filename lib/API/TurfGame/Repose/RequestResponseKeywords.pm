package API::TurfGame::Repose::RequestResponseKeywords;

use strict;
use warnings;

use Moo::Role;
use Module::Runtime qw/$module_name_rx/;

# VERSION
# ABSTRACT: ..

after parse => sub {
    my $self = shift;

    if($self->keyword eq 'request') {
        push @{ $self->relations->{'with'} ||= [] } => (
            'API::TurfGame::Repose::Request',
        );
    }
    elsif($self->keyword eq 'response') {
        push @{ $self->relations->{'with'} ||= [] } => (
            'API::TurfGame::Repose::Response',
        );
    }
};

1;
