#!/usr/bin/perl
# warn if there are magic numbers in the code.
# usage:
#     scripts/magic-numbers.pl lib/checkstl.cpp

sub checkfile
{
    my $filename = $_[0];

    # parse file
    open(FILE, $filename);
    my @lines = <FILE>;
    close(FILE);

    # check comments..
    my $linenr = 0;
    my $comment = 0;
    foreach $line (@lines)
    {
        $linenr = $linenr + 1;

        # remove block comments..
        if ($line =~ /^\s*\/\*+\s*$/)
        {
            $comment = 1;
        }
        if ($line =~ /\*\//)
        {
            $comment = 0;
        }
        if ($comment == 1)
        {
            $line = "";
        }

        # is there a magic number?
        if (($line =~ /[^a-zA-Z0-9_][0-9]{3,}/) && 
            (!($line =~ /define|const|(\/\/)/)))
        {
                print "[$filename:$linenr] Magic number\n";
        }
    }
}


foreach $filename (@ARGV)
{
    checkfile($filename)
}


