package Jobeet::Schema::Result::Job;
use v5.20.3;
use strict;
use warnings;
use parent 'Jobeet::Schema::ResultBase';
use Jobeet::Schema::Types;

# ここにテーブル定義
__PACKAGE__->table('jobeet_job');

__PACKAGE__->add_columns(
    id =>           PK_INTEGER,
    category_id =>  INTEGER,
    type =>         VARCHAR,
    position =>     VARCHAR,
    location =>     VARCHAR,
    description =>  TEXT,
    how_to_apply => TEXT,
    token =>        VARCHAR,
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
    email =>        VARCHAR,
    expires_at =>   DATETIME,
    created_at =>   DATETIME,
    updated_at =>   DATETIME,
);

__PACKAGE__->set_primary_key('id');
__PACKAGE__->add_unique_constraint(['token']);

__PACKAGE__->belongs_to( category => 'Jobeet::Schema::Result::Category', 'category_id' );
1;