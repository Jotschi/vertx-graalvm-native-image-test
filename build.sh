  #!/bin/bash

GRAALVMDIR=/opt/jvm/graalvm
M2=$(realpath $HOME/.m2)
PROJECT_DIR="`dirname \"$0\"`"

$GRAALVMDIR/bin/native-image \
 --verbose \
 --no-server \
 -H:ReflectionConfigurationFiles=./reflectconfigs/netty \
 -Dio.netty.noUnsafe=true  \
 -H:+ReportUnsupportedElementsAtRuntime \
 -Dfile.encoding=UTF-8 \
 -jar target/vertx-graalvm-native-image-test-0.0.1-SNAPSHOT.jar
 

