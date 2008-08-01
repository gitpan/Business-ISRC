use 5.008008;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME              => 'Business::ISRC',
    VERSION_FROM      => 'lib/Business/ISRC.pm',
    PREREQ_PM         => {
        'Locale::Country'       => 2.07,
        'Class::Accessor::Fast' => 0.31,
    },
    ($] >= 5.005 ?
      (ABSTRACT_FROM  => 'lib/Business/ISRC.pm',
       AUTHOR         => 'nakano kyohei (bonar) <bonamonchy@gmail.com>') : ()),
);
