# Localize templates in French
use strict; 
use warnings;
use File::Find;
use JSON::Path 'jpath_map';
use JSON::PP;

my $i18ndir = 'D:/projets/jhipster-projects/issues/monolingual/src/main/webapp/i18n/fr';

my $basedir = 'D:/projets/jhipster-projects/generator-jhipster/generators';
find(\&wanted, $basedir);

sub wanted {
    return unless /.*\.html\.ejs$/;
    my $inputfile = $File::Find::name;
    my $outputfile = "$inputfile.new";
    $outputfile =~ s/\//\\/g;

	print "Processing $inputfile\n";
 
     # Try to open the input file.
    unless(open INPUT, $inputfile) {
        die "\nUnable to open '$inputfile'\n";
    }
    
    # Try to create the output file
    # (open it for writing)
    unless(open OUTPUT, '>'.$outputfile) {
        die "\nUnable to create '$outputfile'\n";
    }

    while (my $line = <INPUT>) {
        if ($line =~ /(.*) jhiTranslate="([a-z.]+)">(.*)(<\/.*>)/) { 
            print OUTPUT "$1 jhiTranslate=\"$2\"><%- t('$2') %>$4\n";
        } elsif ($line =~ /(.*) jhiTranslate="([a-z.]+)">$/) { 
            print OUTPUT "$1 jhiTranslate=\"$2\">\n<%- t('$2') %>\n";
        } else {
            print OUTPUT $line;
        }
    }

    # Close the files.
    close INPUT;
    close OUTPUT;

    rename $outputfile, $inputfile;
}
