#!perl -T

use strict;
use warnings;

use Test::More tests => 4;
use Business::ISRC;

my $isrc_string = 'JP-I4Q-07-00001';
my $isrc = Business::ISRC->new($isrc_string);

# overload test
is($isrc, $isrc_string, 'overload 1');
is("[" . $isrc . "]", "[$isrc_string]", 'overload 2');
my $a = $isrc;
is($a, $isrc_string, 'overload 3');
is($isrc . $isrc, "$isrc_string$isrc_string", 'overload 4');


