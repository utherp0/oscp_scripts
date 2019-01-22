echo "[CREATING PIPELINE PROJECT]"
oc new-project complexpipeline --display-name="GroovyDSL Pipeline Example" --description="Example project showing GroovyDSL pipeline"
oc new-app registry.access.redhat.com/rhscl/nodejs-8-rhel7~https://github.com/utherp0/nodejs-ex --name="nodetest" -n complexpipeline
oc expose svc/nodetest -n complexpipeline

echo "[WAITING FOR NODETEST POD TO BE RUNNING IN COMPLEXPIPELINE...]"
until (oc get pods -n complexpipeline -l app=nodetest 2>/dev/null | grep Running); do echo -ne "."; sleep 1; done
echo ""

echo "[PATCHING THE DEPLOYMENT TO REMOVE TRIGGERS]"
oc patch dc/nodetest -p '{"spec":{"triggers":[]}}'

echo "[CREATING THE PIPELINE BUILDCONFIG]"
oc create -f pipeline_complex_bc.yaml -n complexpipeline

echo "[STARTING THE PIPELINE - WATCH THE OCP UI FOR DETAILS]"
oc start-build complexpipeline -n complexpipeline

echo "[PIPELINE DEMO SH COMPLETE]"
