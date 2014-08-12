#!/bin/bash
startDay=`date -d "-7 days" +%F`;
endDay=`date +%F`;
startTime=" 00:00:01";
endTime=" 23:59:00";

startDate="$startDay $startTime"
endDate="$endDay $endTime"

SUBJECT="super duper reminder about the weekly report, part 2 the Incident Table "
# Email To ?
EMAIL="ecg-noc@ebay.com"
# EMAIL="rvanbeers@ebay.com"
# Email text/message
URL="https://ecgwiki.corp.ebay.com/confluence/display/NOC/HOWTO+do+the+Weekly+Dashboard%2C+and+stay+mentally+sane"
URL2="https://ecgwiki.corp.ebay.com/confluence/display/NOC/HOWTO+create+the+weekly+uptimes+table"

echo > cronresult.txt
echo "The INCIDENT TABLE will have to be made today!" >> cronresult.txt
echo "(We are working on a automatic solution for this)" >> cronresult.txt
echo "" >> cronresults.txt
echo "Please see this page for the procedure:" >> cronresult.txt
echo $URL >> cronresult.txt
echo "Select the Part 2 Adding Platform Incident information" >> cronresult.txt
echo "NEW NEW NEW" >> cronresult.txt
echo "Please create the UPTIME table as well" >> cronresult.txt
echo $URL2 >> cronresult.txt
echo >> cronresult.txt

EMAILMESSAGE=`cat cronresult.txt`
mail -s "$SUBJECT" "$EMAIL" < cronresult.txt
