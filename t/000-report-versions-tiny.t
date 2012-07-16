use strict;
use warnings;
use Test::More 0.88;
# This is a relatively nice way to avoid Test::NoWarnings breaking our
# expectations by adding extra tests, without using no_plan.  It also helps
# avoid any other test module that feels introducing random tests, or even
# test plans, is a nice idea.
our $success = 0;
END { $success && done_testing; }

my $v = "\n";

eval {                     # no excuses!
    # report our Perl details
    my $want = "any version";
    my $pv = ($^V || $]);
    $v .= "perl: $pv (wanted $want) on $^O from $^X\n\n";
};
defined($@) and diag("$@");

# Now, our module version dependencies:
sub pmver {
    my ($module, $wanted) = @_;
    $wanted = " (want $wanted)";
    my $pmver;
    eval "require $module;";
    if ($@) {
        if ($@ =~ m/Can't locate .* in \@INC/) {
            $pmver = 'module not found.';
        } else {
            diag("${module}: $@");
            $pmver = 'died during require.';
        }
    } else {
        my $version;
        eval { $version = $module->VERSION; };
        if ($@) {
            diag("${module}: $@");
            $pmver = 'died during VERSION check.';
        } elsif (defined $version) {
            $pmver = "$version";
        } else {
            $pmver = '<undef>';
        }
    }

    # So, we should be good, right?
    return sprintf('%-45s => %-10s%-15s%s', $module, $pmver, $wanted, "\n");
}

eval { $v .= pmver('Carp','any version') };
eval { $v .= pmver('Encode','any version') };
eval { $v .= pmver('ExtUtils::MakeMaker','6.30') };
eval { $v .= pmver('File::Find','any version') };
eval { $v .= pmver('File::Temp','any version') };
eval { $v .= pmver('IO::All','any version') };
eval { $v .= pmver('Import::Into','1.001000') };
eval { $v .= pmver('List::MoreUtils','any version') };
eval { $v .= pmver('Math::BigFloat','any version') };
eval { $v .= pmver('Math::BigInt','any version') };
eval { $v .= pmver('Test::More','0.88') };
eval { $v .= pmver('Toolkit','any version') };
eval { $v .= pmver('autolocale','any version') };
eval { $v .= pmver('autovivification','any version') };
eval { $v .= pmver('bareword::filehandles','any version') };
eval { $v .= pmver('bigint','any version') };
eval { $v .= pmver('criticism','any version') };
eval { $v .= pmver('indirect','any version') };
eval { $v .= pmver('multidimensional','any version') };
eval { $v .= pmver('namespace::autoclean','any version') };
eval { $v .= pmver('namespace::clean','any version') };
eval { $v .= pmver('namespace::functions','any version') };
eval { $v .= pmver('namespace::sweep','0.004') };
eval { $v .= pmver('perl5i','any version') };
eval { $v .= pmver('strict','any version') };
eval { $v .= pmver('subs::auto','any version') };
eval { $v .= pmver('true','any version') };
eval { $v .= pmver('utf8','any version') };
eval { $v .= pmver('utf8::all','any version') };
eval { $v .= pmver('vendorlib','any version') };
eval { $v .= pmver('warnings','any version') };



# All done.
$v .= <<'EOT';

Thanks for using my code.  I hope it works for you.
If not, please try and include this output in the bug report.
That will help me reproduce the issue and solve you problem.

EOT

diag($v);
ok(1, "we really didn't test anything, just reporting data");
$success = 1;

# Work around another nasty module on CPAN. :/
no warnings 'once';
$Template::Test::NO_FLUSH = 1;
exit 0;
