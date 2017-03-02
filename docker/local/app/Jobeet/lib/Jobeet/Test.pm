package Jobeet::Test;
use Ark 'Test';

use File::Temp qw/tempdir/;
use Jobeet::Models;
use DBI;
use Data::Dumper;

sub import {
    my ($class, $app, %options) = @_;
    $app ||= 'Jobeet';
    {
        my $dsn = 'dbi:mysql:host=172.17.0.1;port=3306;database=test;mysql_write_timeout=1;mysql_read_timeout=1';
        my $db_user = 'root';
        my $db_passwd = 'root';

        # delete all foreign keys
        my $dbh = DBI->connect($dsn, $db_user, $db_passwd);
        my $sth = $dbh->prepare(q{SELECT 
            F1.TABLE_NAME AS TABLE_NAME
            ,F2.CONSTRAINT_NAME AS CONSTRAINT_NAME
            FROM
            information_schema.KEY_COLUMN_USAGE F1
            LEFT JOIN information_schema.TABLE_CONSTRAINTS F2 ON F1.TABLE_SCHEMA = F2.TABLE_SCHEMA
            AND F1.CONSTRAINT_NAME = F2.CONSTRAINT_NAME
            WHERE
            F2.CONSTRAINT_TYPE = 'FOREIGN KEY'
            AND F2.TABLE_SCHEMA = 'test'});
        $sth->execute();
        $sth->bind_columns(\my $table_name, \my $key_name);
        while($sth->fetch) {
            $dbh->do(q{ALTER TABLE } . $table_name . q{ DROP FOREIGN KEY } . $key_name)
        }
        # drop all tables
        my $sth = $dbh->prepare(q{SELECT table_name FROM information_schema.tables WHERE table_schema = 'test' AND table_name NOT IN ('table1', 'table2')});
        $sth->execute();
        $sth->bind_columns(\my $table_name2);
        while($sth->fetch) {
            $dbh->do(q{DROP TABLE } . $table_name2)
        }
        # create tables
        models('conf')->{database} = [$dsn, $db_user, $db_passwd,
            {
                on_connect_do => ['SET NAMES utf8'],
                mysql_enable_utf8 => 1,
            }
        ];
        models('Schema')->deploy;
    }

    @_ = ($class, $app, %options);
    goto $class->can('SUPER::import');
}

1;