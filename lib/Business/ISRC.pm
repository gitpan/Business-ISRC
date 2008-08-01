package Business::ISRC;

use strict;
use warnings;

use Locale::Country qw/code2country/;
use base 'Class::Accessor::Fast';

use overload '""' => 'as_default_string';

$Business::ISRC::VERSION = '0.01';
$Business::ISRC::VERBOSE = 1;

__PACKAGE__->mk_ro_accessors(qw/
    raw_string
    country_code
    country_name
    registrant_code
    year
    designation_code
/);

sub _parse {
    my ($isrc_string) = @_;
    return if !defined $isrc_string;

    my $str = uc($isrc_string);
    $str =~ s/\s//g;

    # it should be like "US-L4Q-07-02458"
    if ($str !~ /^
        (?:ISRC)?\-?        # prefix
        ([a-zA-Z]{2})\-?    # country code
        ([a-zA-Z0-9]{3})\-? # registrant code
        (\d{2})\-?          # year
        (\d{5})             # designation code
    $/x) {
        return;
    }
    return {
        raw_string       => $isrc_string,
        country_code     => uc($1),
        registrant_code  => uc($2),
        year             => $3,
        designation_code => $4,
    };
}

sub new {
    my ($class, $isrc_string) = @_;

    my $self = _parse($isrc_string);
    if (!defined $self) {
        warn "invalid ISRC string [$isrc_string]."
            . "see perldoc Business::ISRC and check format." 
            if $Business::ISRC::VERBOSE;
        return;
    }
    bless $self, $class;

    my $country_name = code2country(lc($self->country_code));
    if (!defined $country_name) {
        warn "unknown country code: " . $self->country_code 
            if $Business::ISRC::VERBOSE;
        return;
    }
    $self->{country_name} = $country_name;

    return $self;
}

sub as_default_string {
    my $self = shift;
    return $self->as_string();
}

sub as_string {
    my ($self, %opt) = @_;

    my $delim = exists $opt{no_dash} ? '' : '-';
    my (@ret);
    push @ret, 'ISRC' if exists $opt{add_prefix};
    push @ret
        , $self->country_code
        , $self->registrant_code
        , $self->year
        , $self->designation_code
        ;
    return join $delim, @ret;
}

1;

__END__

=head1 NAME

Business::ISRC - Perl extension for manipulating International Standard Recording Code (ISRC)

=head1 SYNOPSIS

  use Business::ISRC;

  # create object (validate string)
  my $isrc = Business::ISRC->new("usl4q0702458")
      or die "invalid isrc format";

  $isrc->country_code;    # US
  $isrc->country_name;    # Unites States
  $isrc->registrant_code; # L4Q
  $isrc->year; # 07
  $isrc->designation_code; # 02458

  # get normalized string
  print $isrc; # US-L4Q-07-02458

  # or this is the same as above
  print $isrc->as_string();

=head1 DESCRIPTION

This module provides data container for ISRC. ISRC is an unique code 
for identifying sound recordings and music videos internationally. 
You can use this to validate or normalize ISRC strings.

visit ifpi site for details of ISRC definition:

ISRC Handbook(HTML)
http://www.ifpi.org/content/section_resources/isrc_handbook.html

=head2 ISRC FORMAT

ISRC string is made up for these five parts:

  sample: US-L4Q-07-02458

  name  letters desc
  -------------------------------------
  ISRC  (4)   - prefix (omittable)
  US    (2)   - country code (ISO 3166-1-Alpha-2)
  L4Q   (3)   - registrant code. case insensitive.
  07    (2)   - year (1980=>80, 2012=>12)
  02458 (5)   - designation code, track serial number.

=head1 ACCESSOR

all accessors are created by mk_ro_accessors of Class::Accessor::Fast.
so all fields are read-only.

  raw_string       # first argument of new()
  country_code
  country_name
  registrant_code
  year
  designation_code

you can get value like this:

  my $rc = $isrc->registrant_code;

=head1 METHOD

=head2 new()

Construct Business::ISRC object. return if failed to parse given 
ISRC string. if the name for the given country code in ISRC was
not found in Locale::Country module, new() also return (nothing).

=head2 as_string()

return normalized string. you can specify these options:

  my $str = $isrc->as_string(
      add_prefix => 1, # add "ISRC-" prefix
      no_dash    => 1, # delete dash from string
  );

=head2 as_default_string()

  same as as_string() with no option.

=head1 SEE ALSO

L<Business::UPC>

=head1 AUTHOR

Nakano Kyohei (bonar) E<lt>bonamonchy@gmail.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2008 by nakano kyohei (bonar)

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.8 or,
at your option, any later version of Perl 5 you may have available.

=cut
