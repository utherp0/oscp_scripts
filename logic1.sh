name=$(oc get bc jeegogs -o jsonpath='{$.spec.strategy..from.name}');

echo $name;

if grep -q jboss-eap <<<$name; then
  echo "Grep found EAP"
fi

if [[ $name == *"jboss-eap"* ]]; then
  echo "Found EAP"
fi
