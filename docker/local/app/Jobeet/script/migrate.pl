use strict;
use warnings;
use utf8;
use lib 'lib';
use feature qw(say);

use Jobeet::Models;
use Getopt::Long;
use GitDDL;
use Data::Dumper;

GetOptions(
    \my %options,
    qw/dry-run/
);



my $dsn = models('conf')->{database}->[0];


print Dumper($dsn);



my $gd = GitDDL->new(
#    work_tree => './',
    work_tree => './',
    #    ddl_file  => './sql/schema.sql',
    ddl_file  => './sql/schema.sql',
    dsn       => models('conf')->{database},
);

# checking whether the database version matchs ddl_file version or not.
$gd->check_version;
 
# getting database version
my $db_version = $gd->database_version;
 
# getting ddl version
my $ddl_version = $gd->ddl_version;
 
# upgrade database
$gd->upgrade_database;
 
# deploy ddl
$gd->deploy;



# my $db_version = '';
# eval {
#     open my $fh, '>', \my $stderr;
#     local *STDERR = $fh;
#     $db_version    = $gd->database_version;
# };

# print Dumper($db_version);


# if (!$db_version) {
#     $gd->deploy;
#     say 'done migrate';
#     exit;
# }

# if ($gd->check_version) {
#     say 'Database is already latest';
# } else {
#     print $gd->diff . "\n";
#     if (!$options{'dry-run'}) {
#         $gd->upgrade_database;
#         say 'done migrate';
#     }
# }
