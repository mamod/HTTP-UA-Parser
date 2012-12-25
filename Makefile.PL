use 5.010001;
use ExtUtils::MakeMaker;
use FindBin qw($Bin);
use File::Copy;

# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
My_WriteMakefile(
    NAME              => 'HTTP::UA::Parser',
    VERSION_FROM      => 'lib/HTTP/UA/Parser.pm', # finds $VERSION
    EXE_FILES    => ['script/ua_parser'],
    PREREQ_PM         => {
	'YAML::Tiny' => 0
    },
    ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM  => 'lib/HTTP/UA/Parser.pm', # retrieve abstract from module
       AUTHOR         => 'Mamod A. Mehyar <mamod.mehyar@gmail.com>') : ())
);

sub My_WriteMakefile {
    my %params=@_;
    my $regexes = '../regexes.yaml';
    my $regexes2 = $Bin.'/regexes.yaml';
    my $dest = $Bin.'/lib/HTTP/UA/Parser';
    if (-e $regexes) {
	copy($regexes, $dest) or die "File cannot be copied.";
    } elsif (-e $regexes2) {
	copy($regexes2, $dest) or die "File cannot be copied.";
    } else {
	print "Can't locate regexes.yaml file\n";
	print "We will try to fetch it from a remote server\n";
	my $regexContent = getRegexes();
	open my $file,'>',$regexes2 or die "can't open file $!";
	print $file $regexContent;
	close $file;
	print "regexes.yaml downloaded successfully\n";
    }
    WriteMakefile(%params);
}

sub getRegexes {
    require './script/ua_parser';
    my $con = getFile();
    return $con;
}
