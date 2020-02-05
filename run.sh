#!/bin/bash


host="https://login.salesforce.com"


#java_path="target/emp-connector-0.0.1-SNAPSHOT-phat.jar"
java_path="emp-connector-0.0.1-SNAPSHOT-phat.jar"
class_name="com.salesforce.emp.connector.example.DevLoginExampleNewRelic"

pids=()
while read item ; 
do
	echo "$item"
	java -classpath $java_path $class_name $host $username $passwd  $item $nr_key &
	pids+=($!)
done <<EOF
/event/ApiEventStream 
/event/LightningUriEventStream
/event/ReportEventStream 
/event/UriEventStream
EOF

echo "Kill process? type yes to kill:"
while read resp ; 
do
  if [ "X$resp" == "Xyes" ] ; then
		kill ${pids[@]}
		exit
	else
		echo "Kill process? type yes to kill:"
	fi
done

