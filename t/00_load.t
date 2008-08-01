#!perl -T

use strict;
use warnings;

use Test::More tests => 3;

BEGIN {
    use_ok('Locale::Country');
    use_ok('Class::Accessor::Fast');
    use_ok('Business::ISRC');
};
