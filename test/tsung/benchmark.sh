# requires installed:
# - tsung
# - perl
# - perl Template module
# - gnuplot


# Linux kernel settings in: /etc/security/limits.conf
# *          soft    nofile   99999
# *          hard    nofile   999999 
# Linux kernel settings in: /etc/sysctl.conf
#
# net.ipv4.tcp_tw_reuse = 1
# net.ipv4.tcp_tw_recycle = 1
# net.ipv4.ip_local_port_range = 1024 65000
# fs.file-max = 65000
#

LOG_DIR=$(echo $HOME/.tsung/log/$(date +"%Y%m%d-%H%M"))
REPORT_DIR=../../priv/static/tsung_report
rm -rf $REPORT_DIR
echo "Log dir is: $LOG_DIR"
tsung -f tsung.xml start
mkdir $REPORT_DIR
cd $REPORT_DIR
/usr/lib/tsung/bin/tsung_stats.pl --stats $LOG_DIR/tsung.log
