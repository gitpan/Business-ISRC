#!perl -T

use strict;
use warnings;

use Test::More tests => 2000;

use Locale::Country qw/all_country_codes/;
use Business::ISRC;

# only officially assigned code
my @country_code = map { uc($_) } all_country_codes();
my @registrant = qw/
a b c d e f g h i j k l m n o p q r s t u
A B C D E F G H I J K L M N O P Q R S T U
0 1 2 3 4 5 6 7 8 9
/;

for (1..1000) {
    # create dummy isrc
    my %dummy = (
        country    => $country_code[int(rand()*(scalar @country_code))],
        registrant => 
            $registrant[int(rand()*(scalar @registrant))] . 
            $registrant[int(rand()*(scalar @registrant))] . 
            $registrant[int(rand()*(scalar @registrant))],
        year        => sprintf("%02d", int(rand()*100)),
        designation => sprintf("%05d", int(rand()*10000)),
    );
    my $prefix = int(rand()*3) == 0 ? 'ISRC-' : '';
    my $delim  = int(rand()*3) == 0 ? '' : '-';
    
    my $dummy_isrc = $prefix . (join $delim
        , @dummy{qw/country registrant year designation/});

    my $isrc = Business::ISRC->new($dummy_isrc);
    isa_ok($isrc, 'Business::ISRC');
    is($dummy_isrc, $isrc->raw_string(), "$dummy_isrc");
}

