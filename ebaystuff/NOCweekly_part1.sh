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
# EMAIL="rvanbeers@ebay.com"
# Email text/message


echo > cronresult.txt
echo "The INCIDENT TABLE will NOT have to be made today!" >> cronresult.txt
echo "Instead we will ask the Tuesday night shift and super remind them seperate" >> cronresult.txt
echo "The reason is to give platforms time to edit incidents " >> cronresult.txt
echo "(We are working on a automatic solution for this)" >> cronresult.txt
echo >> cronresult.txt
echo >> cronresult.txt
echo >> cronresult.txt
echo "Top talking platforms between $startDate and $endDate" >> cronresult.txt
echo >> cronresult.txt

echo "NAGIOS :: " >> cronresult.txt

mysql -h localhost -u nagios -pblergh666 -e "use noc; SELECT DISTINCT (p.name) AS platform,
count(e.id ) AS count FROM event e, lu_platform p WHERE e.platform_id = p.id AND e.sourcetype_id = 1
AND e.event_datetime BETWEEN '$startDate' AND '$endDate' AND e.sender_id  NOT IN ( 759, 73 )  AND
e.status_id in (1,2,7,8) GROUP BY p.name ORDER BY count DESC\G"  >> cronresult.txt

echo >> cronresult.txt
echo >> cronresult.txt
echo >> cronresult.txt

echo "GOMEZ :: " >> cronresult.txt

mysql -h localhost -u nagios -pblergh666 -e "use noc; select DISTINCT (p.name) AS platform, count(e.id ) AS count from event e, lu_platform p WHERE e.platform_id = p.id AND e.sourcetype_id = 3 AND e.event_datetime BETWEEN '$startDate' AND '$endDate' AND e.eventtype_id IN ( 10, 11 ) GROUP BY p.name ORDER BY count DESC \G" >> cronresult.txt


EMAILMESSAGE=`cat cronresult.txt`
mail -s "$SUBJECT" "$EMAIL" < cronresult.txt
