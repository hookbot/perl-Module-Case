
use strict;
use warnings;

BEGIN {
    if (eval { require tEsT::mOrE }) {
        # Yey! This is very likely to be a case-insensitive file system
        import Test::More;
    }
    else {
         print "1..0 # SKIP Smells like case-sensitive file system so not a valid test.\n";
         exit;
    }
}

BEGIN {
    plan tests => 4;
    my $f = $INC{"Test/More.pm"} = delete $INC{"tEsT/mOrE.pm"};
    ok($f, "Case-ignorant file system detected");
    ok($INC{"Test/More.pm"}, "Test::More loaded with munged case: $f");
}

# This is what happened WITHOUT using Module::Case.
# Exploit the problem on case insensitive file system:
ok(eval {require cWd}, "cWd: Case-ignorant file system gleefully loads the module");
ok(!$@, "No errors even though mismatching package $@");
