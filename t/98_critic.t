#!perl -T

use strict;
use warnings;

use Test::More;

eval {
    require Test::Perl::Critic;
    Test::Perl::Critic->import();
};
if ($@) {
    plan skip_all => "Test::Perl::Critic not installed.";
}

all_critic_ok("lib");

