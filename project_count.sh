# Parameter check
#if [ -z "$1" ]; then
#  echo "Usage: ./(script) TARGET_IMAGE_SUBSTRING";
#  exit 0
#fi

for project in $(oc get projects -o jsonpath='{.items[*].metadata.name}');
do
  requester=$(oc get project $project -o jsonpath='{..openshift\.io/requester}');
  admins=$(oc get rolebindings -n $project -o jsonpath='{.items[0].userNames}');

  echo $project":"$requester" (admins) "$admins;
done
