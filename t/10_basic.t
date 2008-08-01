#!perl -T

use strict;
use warnings;

use Test::More tests => 11;
use Business::ISRC;

my $isrc_string = 'JP-I4Q-07-00001';

my $isrc = Business::ISRC->new($isrc_string);
ok($isrc, 'response');
isa_ok($isrc, 'Business::ISRC');

is($isrc->raw_string      , $isrc_string, 'raw string');
is($isrc->country_code    , 'JP'        , 'country code');
is($isrc->country_name    , 'Japan'     , 'country name');
is($isrc->registrant_code , 'I4Q'       , 'registrant code');
is($isrc->year            , '07'        , 'year');
is($isrc->designation_code, '00001'     , 'designation_code');

is($isrc->as_string(), 'JP-I4Q-07-00001'
    , 'as_string : no option');
is($isrc->as_string(add_prefix => 1), 'ISRC-' . $isrc_string
    , 'as_string : add_prefix');
is($isrc->as_string(no_dash => 1), 'JPI4Q0700001'
    , 'as_string : no_dash');



