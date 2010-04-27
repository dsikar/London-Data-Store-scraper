#!/usr/bin/perl -w

use strict;

# my $filename = $ARGV[0];

my $filename  = "londondatastoredatasets";
# my $cmd = "rm $filename";
# system($cmd);

# my $cmd = "wget http://data.london.gov.uk/datasets -O $filename";
# system($cmd);

# load file
my $htmlfile = load_file($filename);

my @list = split("dividerdots", $htmlfile);

my $i;
for($i=0;$i<=$#list;$i++)
{
	my $sql = "";
	my $record = $list[$i];
	if(index($record, "<h3>")>-1)
	{
	# print "$i\n";
	my $start = index($record, "href=\"") + 6;
	$record = substr($record, $start);
	my $end = index($record, "\"");
	my $datafilepageurl = substr($record, 0, $end);
	print "http://london.data.gov.uk$datafilepageurl\t";

	# title
	$start = index($record, "title=\"") + 7;
	$record = substr($record, $start);
	$end = index($record, "\"");
	my $title = substr($record, 0, $end);
	print "$title\t";

	# taxonomy
	$start = index($record, "href=\"") + 6;
	$record = substr($record, $start);
	$start = index($record, "\">") + 2;
	$record = substr($record, $start);
	$end = index($record, "<");
	my $taxonomy = substr($record, 0, $end);
	print $taxonomy . "\n";
	# die;
	# $sql = "insert into tblDataFiles (DataFileURL, Title, Category) VALUES ('$datafilepageurl', '$title', '$taxonomy');";
	# print "$sql\n";
	}
}

my $end;

# get clickthrough url
# my $start = index($htmlfile, "href=\"") + 6;
#my $end = index($htmlfile, "\" target=");
#$url = substr($htmlfile, $start, $end - $start);




sub load_file
{       my ($path) = @_;
        my $file;
        open(FILE, "< $path" ) or die "Can't open $path : $!";
        while(<FILE>)
        {       $file .= $_;
        }
        return $file;
}

