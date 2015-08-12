# requires installed:
# - tsung
# - perl
# - perl Template module
# - gnuplot

LOG_DIR=$(echo $HOME/.tsung/log/$(date +"%Y%m%d-%H%M"))
REPORT_DIR=../../priv/static/tsung_report
rm -rf $REPORT_DIR
echo "Log dir is: $LOG_DIR"
tsung -f tsung.xml start
mkdir $REPORT_DIR
cd $REPORT_DIR
/usr/lib/tsung/bin/tsung_stats.pl --stats $LOG_DIR/tsung.log
