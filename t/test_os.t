use strict;
use FindBin qw($Bin);
use Yaml::Tiny;
use Test::More 'no_plan';

use HTTP::UA::Parser;

my $yaml = YAML::Tiny->read( $Bin.'/test_resources/test_user_agent_parser_os.yaml' )->[0]->{test_cases};

my $r = HTTP::UA::Parser->new();

foreach my $st (@{$yaml}){
    
    $r->parse($st->{user_agent_string});
    
    my $os = $r->os;
    
    ok ($os->family eq $st->{family}
        && $os->major == $st->{major}
        && $os->minor == $st->{minor}
        && $os->patch == $st->{patch}, 'OS '. $st->{family});
}

__END__
