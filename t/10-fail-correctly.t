
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
    plan tests => 9;
    my $f = $INC{"Test/More.pm"} = delete $INC{"tEsT/mOrE.pm"};
    ok($f, "Case-ignorant file system detected");
    ok($INC{"Test/More.pm"}, "Test::More loaded with munged case");
}

use Module::Case qw(cwD Cwd);

ok(1, "Module::Case used and imported with flagged modules");
ok(!$INC{"Cwd.pm"}, "Cwd not loaded yet");
ok(eval { require Cwd }, "Cwd require'd");
ok($INC{"Cwd.pm"}, "Cwd loaded correctly");

ok(!eval { require cwD }, "Correctly fails even on case-ignorant file system");
chomp (my $why = $@);
ok($why, "Reason: $why");
ok(!$INC{"cwD.pm"}, "Cwd never loaded");
