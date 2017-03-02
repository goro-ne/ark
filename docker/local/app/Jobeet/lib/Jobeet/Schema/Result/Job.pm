package Jobeet::Schema::Result::Job;
use v5.20.3;
use strict;
use warnings;
use parent 'Jobeet::Schema::ResultBase';
use Jobeet::Schema::Types;
use Digest::SHA1 qw/sha1_hex/;
use Data::UUID;
use Jobeet::Models;

sub insert {
    my $self = shift;
    $self->token( sha1_hex(Data::UUID->new->create) );
    $self->expires_at( models('Schema')->now->add( days => models('conf')->{active_days} ) );
    $self->next::method(@_);
}

sub is_expired {
    my ($self) = @_;
    $self->days_before_expired < 0;
}

sub days_before_expired {
    my ($self) = @_;
    ($self->expires_at - models('Schema')->now)->days;
}

sub expires_soon {
    my ($self) = @_;
    $self->days_before_expired < 5;
}

sub publish {
    my ($self) = @_;
    $self->update({ is_activated => 1 });
}

# ここにテーブル定義
__PACKAGE__->table('jobeet_job');

__PACKAGE__->add_columns(
    id =>           PK_INTEGER,
    category_id =>  INTEGER,
    type =>         VARCHAR,
    company =>     VARCHAR,
    logo =>     VARCHAR(
        is_nullable => 1,
    ),
    url =>     VARCHAR,
    position =>     VARCHAR,
    location =>     VARCHAR,
    description =>  TEXT,
    how_to_apply => VARCHAR,
    is_public =>    TINYINT(
        default_value => 1,
        extra => {},
    ),
    is_public =>    TINYINT(
        default_value => 1,
        extra => {},
    ),
    is_activated => TINYINT(
        default_value => 0,
        extra => {},
    ),
    token =>        VARCHAR,
    email =>        VARCHAR,
    expires_at =>   DATETIME,
    created_at => DATETIME,
    updated_at => DATETIME,
);

__PACKAGE__->set_primary_key('id');
__PACKAGE__->add_unique_constraint(['token']);

__PACKAGE__->belongs_to( category => 'Jobeet::Schema::Result::Category', 'category_id' );

1;