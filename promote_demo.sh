echo "[CREATING DEVELOPMENT PROJECT AND APPLICATION]"
oc new-project dev1 --display-name="Development Area" --description="Development Area"
oc new-app registry.access.redhat.com/rhscl/nodejs-8-rhel7~https://github.com/utherp0/nodejs-ex --name="nodetest" -n dev1
oc expose svc/nodetest -n dev1

echo "[WAITING FOR NODETEST POD TO BE RUNNING...]"
until (oc get pods -n dev1 -l app=nodetest 2>/dev/null | grep Running); do echo -ne "."; sleep 1; done
echo ""

echo "[TAGGING A PRODUCTION IMAGE FOR USE]"
oc tag dev1/nodetest:latest dev1/nodetest:production

echo "[CREATING PRODUCTION PROJECT]"
oc new-project prod1 --display-name="Production Area" --description="Production Area"
oc adm policy add-role-to-user system:image-puller system:serviceaccount:prod1:default -n dev1

echo "[CREATING AN APP DIRECTLY FROM THE TAGGED PRODUCTION IMAGE]"
oc new-app dev1/nodetest:production --name="prodtest" -n prod1
oc expose svc/prodtest -n prod1

echo "[WAITING FOR PRODUCTION POD TO BE AVAILABLE...]"
until (oc get pods -n prod1 -l app=prodtest 2>/dev/null | grep Running); do echo -ne "."; sleep 1; done
echo ""

echo "[CICD DEMO COMPLETE]"
