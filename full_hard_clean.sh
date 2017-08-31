# Parameter check
if [ -z "$1" ]; then
  echo "Usage: ./(script) TARGET_NAMESPACE";
  echo 'WARNING. This script hard cleans ALL projects.";
  echo "Also - this script requires the hard_clean.sh script to be in the same directory."
  exit 0
fi

for project in $(oc get projects -n $1 -o jsonpath='{.items[*].metadata.name}');
do
  echo "Processing project "$project;

  ./hard_clean.sh $project;
done
