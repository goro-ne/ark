#!/usr/bin/env perl -w

use strict;
use warnings;
use FindBin::libs;

use Jobeet::Models;

use Data::Dumper;
use Class::Inspector;
use Scalar::Util qw/blessed/;

# create default Categories
models('Schema::Category')->delete();

for my $category_name (qw/Design Programming Manager Administrator/) {
    models('Schema::Category')->create({ name => $category_name });
}

# create default Jobs


# my $debug = Class::Inspector->methods(blessed $programming_category, 'full');
# print Dumper $debug;


models('Schema::Job')->delete();

# Sample Data
# http://symfony.com/legacy/doc/jobeet/1_2/ja/03?orm=Propel
my $manager_category =
    models('Schema::Category')->find({ name => 'Manager' });
$manager_category->add_to_jobs({
    type         => 'full-time',
    company      => 'Sensio Labs manager',
    logo         => 'sensio-labs.gif',
    url          => 'http://www.sensiolabs.com/',
    position     => 'Manager',
    location     => 'Paris, France',
    description  => q[You've already developed websites with symfony and you want to
    work with Open-Source technologies. You have a minimum of 3
    years experience in web development with PHP or Java and you
    wish to participate to development of Web 2.0 sites using the
    best frameworks available.],
    how_to_apply => 'Send your resume to fabien.potencier [at] sensio.com',
    is_public    => 1,
    is_activated => 1,
    token        => 'job_sensio_labs',
    email        => 'job@example.com',
    expires_at   => '2010-10-10',
});

my $programming_category =
    models('Schema::Category')->find({ name => 'Programming' });

$programming_category->add_to_jobs({
    type         => 'full-time',
    company      => 'Sensio Labs',
    logo         => 'sensio-labs.gif',
    url          => 'http://www.sensiolabs.com/',
    position     => 'Web Developer',
    location     => 'Paris, France',
    description  => q[You've already developed websites with symfony and you want to
    work with Open-Source technologies. You have a minimum of 3
    years experience in web development with PHP or Java and you
    wish to participate to development of Web 2.0 sites using the
    best frameworks available.],
    how_to_apply => 'Send your resume to fabien.potencier [at] sensio.com',
    is_public    => 1,
    is_activated => 1,
    token        => 'job_sensio_labs',
    email        => 'job@example.com',
    expires_at   => '2017-10-10',
});

my $job_rs = models('Schema::Job');
my $cat_rs = models('Schema::Category');
my $cat_programming = $cat_rs->find({ name => 'Programming' });

for my $i (100 .. 130) {
    my $job = $job_rs->create({
        type         => 'full-time',
        category_id  => $cat_programming->id,
        company      => "Company $i",
        logo         => 'sensio-labs.gif',
        url          => 'http://www.sensiolabs.com/',
        position     => 'Web Developer',
        location     => 'Paris, France',
        description  => 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.',
        how_to_apply => "Send your resume to lorem.ipsum [at] company_${i}.sit",
        is_public    => 1,
        is_activated => 1,
        token        => "job_$i",
        email        => 'job@example.com',
        expires_at   => '2017-10-10',
    });
}

my $design_category = models('Schema::Category')->find({ name => 'Design' });
$design_category->add_to_jobs({
    type         => 'part-time',
    company      => 'Extreme Sensio',
    logo         => 'extreme-sensio.gif',
    url          => 'http://www.extreme-sensio.com/',
    position     => 'Web Designer',
    location     => 'Paris, France',
    description  => q[Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut
    enim ad minim veniam, quis nostrud exercitation ullamco laboris
    nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor
    in reprehenderit in.
 
    Voluptate velit esse cillum dolore eu fugiat nulla pariatur.
    Excepteur sint occaecat cupidatat non proident, sunt in culpa
    qui officia deserunt mollit anim id est laborum.],
    how_to_apply   => 'Send your resume to fabien.potencier [at] sensio.com',
    is_public    => 1,
    is_activated => 1,
    token        => 'job_extreme_sensio',
    email        => 'job@example.com',
    expires_at   => '2017-10-10',
});

$design_category->add_to_jobs({
    type         => 'part-time',
    company      => 'Extreme Sensio2',
    logo         => 'extreme-sensio.gif',
    url          => 'http://www.extreme-sensio.com/',
    position     => 'Web Designer',
    location     => 'Paris, France',
    description  => q[Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut
    enim ad minim veniam, quis nostrud exercitation ullamco laboris
    nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor
    in reprehenderit in.
 
    Voluptate velit esse cillum dolore eu fugiat nulla pariatur.
    Excepteur sint occaecat cupidatat non proident, sunt in culpa
    qui officia deserunt mollit anim id est laborum.],
    how_to_apply   => 'Send your resume to fabien.potencier [at] sensio.com',
    is_public    => 1,
    is_activated => 1,
    token        => 'job_extreme_sensio',
    email        => 'job@example.com',
    expires_at   => '2017-10-10',
});
