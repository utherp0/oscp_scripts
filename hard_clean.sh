# Parameter check
if [ -z "$1" ]; then
  echo "Usage: ./(script) TARGET_NAMESPACE";
  exit 0
fi

# Hard reset all Pods in Pending or Terminating
for pod in $(oc get pods -n $1 -o jsonpath='{.items[*].metadata.name}');
do
  output=$(oc get pod $pod -n $1);

  if [[ $output == *"Terminating"* ]]; then
    echo "Pod "$pod" stuck in Terminating";

    oc delete pod $pod --force --grace-period=0 -n $1;
    echo "  [Forced Delete]";
  fi

  if [[ $output == *"Pending"* ]]; then
    echo "Pod "$pod" stuck in Pending";
  
    oc delete pod $pod --force --grace-period=0 -n $1;
    echo "  [Forced Delete]";
  fi
done
