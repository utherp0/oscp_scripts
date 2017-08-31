for project in $(oc get projects -o jsonpath='{.items[*].metadata.name}');
do
  echo "Processing project "$project;

  ./hard_clean.sh $project;
done
