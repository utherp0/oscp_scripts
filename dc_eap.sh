for project in $(oc get projects -o jsonpath='{.items[*].metadata.name}');
  do echo $project;
  for dc in $(oc get dc -n $project -o jsonpath='{.items[*].metadata.name}');
    do oc describe dc $dc -n $project | grep jboss-eap-;
  done
done
