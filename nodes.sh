oc get nodes
for node in $(oc get nodes -o jsonpath='{.items[*].metadata.name}');
do
  echo -e "\033[1;34m$node\033[0;39m";
  NODEDESC=$(oc describe node $node);
  grep Pods: <<< "$NODEDESC";
  grep Roles: <<< "$NODEDESC";
  STATUS=$(grep -A7 Conditions <<< "$NODEDESC" | grep -A5 "\-\-\-\-" | awk 'NR> 1{ print $1;print $2 }' | tr "\n" " ");

  echo "$STATUS" | awk '{
for(i=1;i<=NF;i++){if ($i ~ /OutOfDisk/) { printf($i+1 == "True" || $i+1 == "Unknown") ? "\033[1;31m OutOfDisk \033[0;39m" : "\033[1;32m OutOfDisk \033[0;39m"}};
for(i=1;i<=NF;i++){if ($i ~ /MemoryPressure/) {printf($i+1 == "True" || $i+1 == "Unknown") ? "\033[1;31m MemoryPressure \033[0;39m" : "\033[1;32m MemoryPressure \033[0;39m"}};
for(i=1;i<=NF;i++){if ($i ~ /DiskPressure/) {printf($i+1 == "True" || $i+1 == "Unknown") ? "\033[1;31m DiskPressure \033[0;39m" : "\033[1;32m DiskPressure \033[0;39m"}};
for(i=1;i<=NF;i++){if ($i ~ /Ready/) {printf($i+1 == "False" || $i+1 == "Unknown") ? "\033[1;31m Ready \033[0;39m" : "\033[1;32m Ready \033[0;39m"}};
for(i=1;i<=NF;i++){if ($i ~ /PIDPressure/) {printf($i+1 == "True" || $i+1 == "Unknown") ? "\033[1;31m PIDPressure \033[0;39m" : "\033[1;32m PIDPressure \033[0;39m";}}
}'

  echo;
done
