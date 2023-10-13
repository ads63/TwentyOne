# Useful bash commands reference
## TAIL display or monitoring file(s) content
### monitoring last N lines from *.log files (default N=10)
tail -nN - f *.log

use ^C to terminate monitoring
### monitoring last N characters from server.log file
tail -cN - f server.log
### display last N characters from server.log file
tail -cN server.log
## HEAD display file(s) content
### display first N lines from *.log files (default N=10)
tail -nN  *.log
### display first N characters from server.log file
tail -cN server.log
## GREP to search in file or in other command output
### to searh in file(s)
 grep [options] [pattern] [file]
or
### to search in other_bash_command output
 other_bash_command | grep [options] [pattern]
 ### grep options
 -i - case insensitive
 -w - search whole word only
 -r - recursive search in subfolders
 -c - output matching count instead of data
 -v - invert matching criteria
 -n - add line numbers to output
 -m[num] - set lines limit to output
 -A[num] - output num lines after each line was found
 -B[num] - output num lines before each line was found
 -C[num] - output num lines before and after each line was found
 -l  - output only filenames where exist matching lines 
 -x - output lines which equal to pattern instead of include pattern
 ### grep patterns
 ^pattern - pattern at the beginning of line
 pattern$ - pattern at the end of line
 -f [pattern_file] - read patterns from pattern_file where single line corresponds to single pattern
 -e [pattern1] -e [pattern2] -e [pattern3] - multiple patterns in command line
 -E '[Extended RegEx]' - use extended regexp
## AWK text data processing (file / other command output)
awk {command} [file]
### command paameter
print $0 - print lines
print NR,$0 - add line numbers to printed lines 
print $n - print column n (n>0)
print $NF - print the last column
'/^ssss/' output lines starting with "ssss" 
'/ssss$/' output lines ending with "ssss" 
'! /ssss$/'  output lines not ending with "ssss" 
'/Xx/{print $0'} - print lines including Xx string
