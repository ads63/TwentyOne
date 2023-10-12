# Useful bash commands reference
## TAIL
### monitoring last N lines from *.log files (default N=10)
tail -nN - f *.log
use ^C to terminate monitoring
### monitoring last N characters from server.log file
tail -cN - f server.log
### display last N characters from server.log file
tail -cN server.log
