RED=$(tput setaf 1) GREEN=$(tput setaf 2) YELLOW=$(tput setaf 3)
NC=$(tput sgr0)
okgood="${GREEN}OK$NC" okbad="${RED}OK$NC"
printf 'Node %-45s Non-Terminating Pods %-3s OutOfDisk  MemoryPressure  DiskPressure  Ready  PIDPressure  Roles\n'
for node in $(oc get nodes -o jsonpath='{.items[*].metadata.name}');
do
  NODEDESC=$(oc describe node $node);
  numpods=$(grep Pods: <<< "$NODEDESC" | awk '{ print $3 }' | awk -F "(" '{ print $2 }')
  roles=$(grep Roles: <<< "$NODEDESC" | awk '{ print $2 }')
  STATUS=$(grep -A7 Conditions <<< "$NODEDESC" | grep -A5 "\-\-\-\-" | awk 'NR> 1{ print $1;print $2 }' | tr "\n" " ");

  outofdisk=$(awk -v okgood="$okgood" -v okbad="$okbad" '{ for(i=1;i<=NF;i++){if ($i ~ /OutOfDisk/){ printf "%s",($i+1 == "True" || $i+1 == "Unknown") ? okbad : okgood}}};' <<< "$STATUS")
  memorypressure=$(awk -v okgood="$okgood" -v okbad="$okbad" '{ for(i=1;i<=NF;i++){if ($i ~ /MemoryPressure/) { printf "%s",($i+1 == "True" || $i+1 == "Unknown") ? okbad : okgood}}};' <<< "$STATUS")
  diskpressure=$(awk -v okgood="$okgood" -v okbad="$okbad" '{ for(i=1;i<=NF;i++){if ($i ~ /DiskPressure/) { printf "%s",($i+1 == "True" || $i+1 == "Unknown") ? okbad : okgood}}};' <<< "$STATUS")
  ready=$(awk -v okgood="$okgood" -v okbad="$okbad" '{ for(i=1;i<=NF;i++){if ($i ~ /Ready/) { printf "%s",($i+1 == "False" || $i+1 == "Unknown") ? okbad : okgood}}};' <<< "$STATUS")
  pidpressure=$(awk -v okgood="$okgood" -v okbad="$okbad" '{ for(i=1;i<=NF;i++){if ($i ~ /PIDPressure/) { printf "%s",($i+1 == "True" || $i+1 == "Unknown") ? okbad : okgood}}};' <<< "$STATUS")

  printf '%-50s %-20s     %-20s  %-25s  %-23s  %-16s  %-23s %s\n' "$node" "$numpods" "$outofdisk" "$memorypressure" "$diskpressure" "$ready" "$pidpressure" "$roles"
done
