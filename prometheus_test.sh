oc get pods --show-all=false --all-namespaces=true |  awk ' { printf $1"\t"$2"\t";system("oc get pod -o json -o jsonpath='{.spec.containers[*].resources}' -n"$1" "$2);printf "\tcpu ";system("curl -s -H \"Authorization: Bearer GTKHQ33c3eW6eVZViRtsBOzYW260N2FBTYKMtyrt7qU\" -X GET \"https://prometheus-openshift-metrics.apps.innershift.sodigital.io/api/v1/query?query=container_cpu_usage_seconds_total%7Bnamespace%3D~%22"$1"%22%2Cpod_name%3D%22"$2"%22%2Ccontainer_name%21%3D%22POD%22%7D\" | jq -r -j \".data.result[0].value[1]\"");printf "\tmemory ";system("curl -s -H \"Authorization: Bearer GTKHQ33c3eW6eVZViRtsBOzYW260N2FBTYKMtyrt7qU\" -X GET \"https://prometheus-openshift-metrics.apps.innershift.sodigital.io/api/v1/query?query=container_memory_working_set_bytes%7Bnamespace%3D%22"$1"%22%2Cpod_name%3D%22"$2"%22%2Ccontainer_name%21%3D%22POD%22%7D\" | jq -r -j \".data.result[0].value[1]\"");print " " }'
