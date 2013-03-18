
use strict;
use warnings;

use 5.010001;

use ExtUtils::MakeMaker 6.30;



my %WriteMakefileArgs = (
  "ABSTRACT" => "The ONLY meta pragma you'll ever need!",
  "AUTHOR" => "Brendan Byrd <BBYRD\@CPAN.org>",
  "BUILD_REQUIRES" => {
    "Test::CheckDeps" => "0.002",
    "Test::UseAllModules" => "0.10"
  },
  "CONFIGURE_REQUIRES" => {},
  "DISTNAME" => "sanity",
  "EXE_FILES" => [],
  "LICENSE" => "artistic_2",
  "NAME" => "sanity",
  "PREREQ_PM" => {
    "Import::Into" => "1.001000",
    "List::MoreUtils" => "0.23"
  },
  "VERSION" => "0.95",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM};
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod};
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



