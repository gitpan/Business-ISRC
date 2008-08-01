#!perl -T

use strict;
use warnings;

use Test::More tests => 16;
use Business::ISRC;

my @isrc_string = qw/
    ISRC-JP-I4Q-07-00001
    ISRC-JP-i4q-07-00001
    ISRC-jp-i4q-07-00001
    ISRCJPI4Q0700001
    JP-I4Q-07-00001
    JPI4Q0700001
    jpi4q0700001
    Jp-I4q0700001
/;
my $normalized = 'JP-I4Q-07-00001';

foreach my $test_isrc_str (@isrc_string) {
    my $isrc = Business::ISRC->new($test_isrc_str);
    isa_ok($isrc, 'Business::ISRC');
    is($isrc, $normalized, "$test_isrc_str to $isrc - normalize ok");
}


