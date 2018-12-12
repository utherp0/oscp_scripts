if [ -z "$1" ]; then
echo "Missing parameter 1, usage: quick-binary-build.sh (appName) imageName artifactFileLocation";
exit 0;
fi

if [ -z "$2" ]; then
echo "Missing parameter 2, usage: quick-binary-build.sh appName (imageName) artifactFileLocation";
exit 0;
fi

if [ -z "$3" ]; then
echo "Missing parameter 3, usage: quick-binary-build.sh appName imageName (artifactFileLocation)";
exit 0;
fi

# Create the build
oc new-build --name="$1" "$2" --binary=true;

if [ $("oc start-build $1 --from-file=$3 --wait=true")!=0 ]; then
echo "Build failed, check logs for $1";
exit 0;
fi

# Expose the route
#oc expose svc $1;
