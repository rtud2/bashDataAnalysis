#!/bin/perl

# this perl script reads my ComEd bills (pdf) from `ComEd/`
# and converts them to txt using pdftotext, then parses for billing lines
#
# ./parseComEd.pl > allComEdCharge.tsv

use v5.10;
use autodie;
use File::Basename;     # for fileparse()

# run pdftotext for each file in the ComEd directory
foreach my $FILE (glob 'ComEd/*.pdf'){
    system "pdftotext -l 2 -f 2 -layout $FILE";# or
        #die "Failed to convert $FILE: $!\n";
}

# print a header
print "FILE	DESCRIPTION	NUMBER	UnitCost	Total\n";

# parse each text file for relevant electrical information
foreach my $FILE (glob 'ComEd/*.txt'){
    open $LN, '<', $FILE;                       # open up a File Handle
    my $FNAME = fileparse($FILE, '-ComEd.txt'); # strip '-ComEd.txt' off the back
    
    while(<$LN>){                               # for each line in the file handle
        chomp;
        s/^\s+//g;  #remove beginning spaces

        if (
            /\A(?<DESCRPT>\D+?)\s+                                  #charge description
            ((?<NUM>\$?[\d\.]+)(?:.+?)(?<UNIT>[\d\.]+?\%?)\s+?)?    #number and cost|unit
            (?<TOTAL>\$[\d\.]+)/x                                   #total amount
        ){                                
            #
            print "$FNAME	$+{DESCRPT}	$+{NUM}	$+{UNIT}	$+{TOTAL}\n";
        }

    }
    close $LN;

}
