#!/bin/bash

# We remove PID files, because if the services get restarted without the container being restarted, it can cause conflicts the next time the container is restarted.

echo REMOVING OLD RSYSLOG PID FILE
rm -f /var/run/rsyslogd.pid

echo STARTING RSYSLOG
rsyslogd

#echo STARTING CRONTAB
# set crontab to foreground with loglevel 8
#/usr/sbin/crond -f -l 8
## for a custom crontab create a file called crontab inside your code and mount it to /etc/crontab 

echo REMOVING OLD POSTFIX PID FILE
rm -f /var/spool/postfix/pid/master.pid

# for a custom crontab create a file called crontab inside your code and mount it to /etc/crontab 

echo "SETTING POSTFIX myhostname TO postfix."`hostname` 
# postfix hosts that start with numbers are illegal. Sometimes docker generates a hostname that starts with a number
# https://productforums.google.com/forum/?p=RfcMessageNonCompliant&visit_id=1-636484614145615211-840996552&rd=1#!topic/gmail/e15zAgzGbc4;context-place=forum/gmail
# even if the hostname is randomly generated, this will solve the issue.
sed -i -e 's/^myhostname = .*/'"myhostname = postfix.`hostname`"'/g' /etc/postfix/main.cf

echo STARTING POSTFIX SERVER
service postfix start

echo REMOVING OLD APACHE PID FILE
rm -f /var/run/apache2/apache2.pid

echo STARTING APACHE SERVER
/usr/sbin/apache2ctl -D FOREGROUND

