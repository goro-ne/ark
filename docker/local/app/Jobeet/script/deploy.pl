use v5.20.3;
use strict;
use warnings;
use utf8;
use lib 'lib';

use Jobeet::Schema;
my $schema = Jobeet::Schema->connect(
    'dbi:mysql:host=172.17.0.1;port=3306;database=dev;mysql_write_timeout=1;mysql_read_timeout=1', 'root', 'root',
        {
            mysql_enable_utf8 => 1,
            on_connect_do => ['SET NAMES utf8'],
        }
    );
$schema->deploy;
