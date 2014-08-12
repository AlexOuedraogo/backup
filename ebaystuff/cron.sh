#!/bin/bash
startDay=`date -d "-7 days" +%F`;
endDay=`date +%F`;
startTime=" 00:00:01";
endTime=" 23:59:00";

startDate="$startDay $startTime"
endDate="$endDay $endTime"

SUBJECT="super duper reminder about the weekly report, with platform totals already made :)"
# Email To ?
EMAIL="ecg-noc@ebay.com"
# Email text/message



echo "The INCIDENT TABLE will NOT have to be made today!"
echo "Instead wwe will ask the Wednesday night shift to do this one seperate"
echo "The reason is to give platforms a little time to edit incidents in the weekends"
echo "(We are working on a automatic solution for this)"
echo ""
echo "Top talking platforms between $startDate and $endDate" > cronresult.txt
echo >> cronresult.txt
echo >> cronresult.txt
echo >> cronresult.txt

echo "NAGIOS :: " >> cronresult.txt

mysql -h localhost -u nagios -pblergh666 -e "use noc; SELECT DISTINCT (p.name) AS platform, count(e.id ) AS count FROM event e, lu_platform p WHERE e.platform_id = p.id AND e.sourcetype_id = 1 AND e.event_datetime BETWEEN '$startDate' AND '$endDate' AND e.sender_id  NOT IN ( 759, 73 ) GROUP BY p.name ORDER BY count DESC\G"  >> cronresult.txt

echo >> cronresult.txt
echo >> cronresult.txt
echo >> cronresult.txt

echo "GOMEZ :: " >> cronresult.txt

mysql -h localhost -u nagios -pblergh666 -e "use noc; select DISTINCT (p.name) AS platform, count(e.id ) AS count from event e, lu_platform p WHERE e.platform_id = p.id AND e.sourcetype_id = 3 AND e.event_datetime BETWEEN '$startDate' AND '$endDate' AND e.eventtype_id IN ( 10, 11 ) GROUP BY p.name ORDER BY count DESC \G" >> cronresult.txt


EMAILMESSAGE=`cat cronresult.txt`
mail -s "$SUBJECT" "$EMAIL" < cronresult.txt
