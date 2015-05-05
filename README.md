# Elasticsearch-Maintenance
This script Help you to prevent space disk over load deleting older logs.
-Instal Elasticsearch curator
-Créate a task on crontab that it's execute daily and allow to delete older logs
-You can set the number of days you want to retain your logs

Work great with https://github.com/mrlesmithjr/Logstash_Kibana3

Maybe you are using a Fortigate with Logstash and could be of your interest the statistic values of received bytes and other numeric values, this configuration file would be for you: https://github.com/lbonfante/Elasticsearch-Fortigate
