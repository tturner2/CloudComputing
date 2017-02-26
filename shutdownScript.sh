#!/bin/bash
HOUR=12
#Test Comment
CSVFILE = "instances.csv
aws ec2 describe-instances | jq -r '.Reservations[].Instances[] | .InstanceId + "," + .LaunchTime' > $CSVFILE

for x in $(cat $CSVFILE)
do
  lt = $(echo $x | cut -f2 -d',')
  id = $(echo $x | cut -f1 -d',')

  ltu = $(date -d $lt "+%s")-$ltu ))
  if [ $(($runtime/3600)) -gt $HOUR ]; then
    echo "$id was running since $lt ...needs to be terminated"
    aws ec2 terminate-instances --instance-ids $id
  else
    echo "$id is safe"
  fi
done

DBCSV = "dbInstances.csv"

aws rds describe-db-instances | jq -r '.DBInstances[] | .DBInstanceIdentifier + ", " + .InstanceCreateTime' > $DBCSV

for x in $(cat $DBCSV)
do
  dblt = $(echo $x | cut -f2 -d',')
  dbid = $(echo $x | cut -f1 -d',')

  dbltu = $(date -d $dblt "+%s")-$dbltu ))
  if [ $(($runtime/3600)) -gt $HOUR ]; then
    echo "$dbid was running since $dblt ...needs to be terminated"
    aws rds delete-db-instance --db-instance-identifier $dbid
  else
    echo "$dbid is safe"
  fi
done


