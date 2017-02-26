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

