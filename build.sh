  #!/bin/bash

GRAALVMDIR=/opt/jvm/graalvm-ee
PROJECT_DIR="`dirname \"$0\"`"

cd $PROJECT_DIR
mvn clean package

rm vertx-graal*
$GRAALVMDIR/bin/native-image \
 --verbose \
 --no-server \
 --pgo-instrument \
 -Dio.netty.noUnsafe=true  \
 -H:ReflectionConfigurationFiles=./reflectconfigs/netty.json \
 -H:+ReportUnsupportedElementsAtRuntime \
 -jar target/vertx-graalvm-native-image-test-0.0.1-SNAPSHOT.jar
 

