#!perl -T

use strict;
use warnings;

use Test::More tests => 8;
use Business::ISRC;

my @invalid_isrc = qw/
    XX-I4Q-07-00001
    JPN-I4Q-07-00001
    JP-***-07-00001
    JP-I4QA-07-00001
    JP-I4Q-aa-00001
    JP-I4Q-2007-00001
    JP-I4Q-aa-0000x
    JP-I4Q-aa-000011
/;

$Business::ISRC::VERBOSE = 0;

foreach my $invalid_isrc (@invalid_isrc) {
    my $isrc = Business::ISRC->new($invalid_isrc);
    ok(!$isrc, "invalid [$invalid_isrc]");
}



