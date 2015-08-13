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

# Make sure the browser does not cache the report pages
cd -
sed -i.bak 's/<head>/<head><meta http-equiv="cache-control" content="max-age=0" \/><meta http-equiv="cache-control" content="no-cache" \/><meta http-equiv="pragma" content="no-cache" \/><meta http-equiv="expires" content="0" \/><meta http-equiv="expires" content="Tue, 01 Jan 1980 1:00:00 GMT" \/>/' $REPORT_DIR/report.html

sed -i.bak 's/<head>/<head><meta http-equiv="cache-control" content="max-age=0" \/><meta http-equiv="cache-control" content="no-cache" \/><meta http-equiv="pragma" content="no-cache" \/><meta http-equiv="expires" content="0" \/><meta http-equiv="expires" content="Tue, 01 Jan 1980 1:00:00 GMT" \/>/' $REPORT_DIR/graph.html
