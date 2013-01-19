use strict;
use FindBin qw($Bin);
use Yaml::Tiny ();
use Test::More 'no_plan';

BEGIN { use_ok('HTTP::UA::Parser') };

my $yaml = YAML::Tiny->read( $Bin.'/test_resources/test_user_agent_parser.yaml' )->[0]->{test_cases};
my $r = HTTP::UA::Parser->new();

foreach my $st (@{$yaml}){
    $r->parse($st->{user_agent_string});
    my $ua = $r->ua;
    #print $ua->family . "\n";
    ok ($ua->family eq $st->{family}
        && $ua->major eq $st->{major}
        && $ua->minor eq $st->{minor}
        && $ua->patch eq $st->{patch}, 'UA '. $st->{family});
}


__END__
