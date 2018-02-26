#!/bin/bash
$MAIL_ADDRESS=somebody@somewhere.com
for status in $(oc get nodes -o jsonpath='{.items[*].status.conditions[?(@.reason=="KubeletReady")].status}');
do
  if [ "$status" != "True" ]; then
    echo "$(oc get nodes)" | mail -s "Openshift Cluster Unstable" $MAIL_ADDRESS
    break
  fi
done
