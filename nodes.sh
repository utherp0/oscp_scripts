for node in $(oc get nodes -o jsonpath='{.items[*].metadata.name}'); do echo $node; oc describe node $node | grep Pods:; done
