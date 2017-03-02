use strict;
use warnings;
use Test::More tests => 1;

use Jobeet::Test;
use Jobeet::Models;
like models('conf')->{database}[0], qr{dbi:mysql:.+database=test.+}, 'connect mock database after "use Jobeet::Test"';
