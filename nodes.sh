oc get nodes
for node in $(oc get nodes -o jsonpath='{.items[*].metadata.name}');
do
  echo $node;
  NODEDESC=$(oc describe node $node);
  grep Pods: <<< "$NODEDESC";
  STATUS=$(grep -A6 Conditions <<< "$NODEDESC" | grep -A4 "\-\-\-\-" | awk 'NR> 1{ print $1;print $2 }' | tr "\n" " ");
  echo "$STATUS" | awk '{ printf($2 == "True" || $2 == "Unknown") ? "\033[1;31m OutOfDisk \033[0;39m" : "\033[1;32m OutOfDisk \033[0;39m"; printf($4 == "True" || $4 == "Unknown") ? "\033[1;31m MemoryPressure \033[0;39m" : "\033[1;32m MemoryPressure \033[0;39m"; printf($6 == "True" || $6 == "Unknown") ? "\033[1;31m DiskPressure \033[0;39m" : "\033[1;32m DiskPressure \033[0;39m"; printf($8 == "False" || $8 == "Unknown") ? "\033[1;31m Ready \033[0;39m" : "\033[1;32m Ready \033[0;39m"}'
  echo;
done
