for project in $(oc get projects -o jsonpath='{.items[*].metadata.name}');
  do echo $project;
  for bc in $(oc get bc -n $project -o jsonpath='{.items[*].metadata.name}');
    do echo "  "$bc;
    oc describe bc $bc -n $project | grep From
  done
done
