  #!/bin/bash

GRAALVMDIR=/opt/jvm/graalvm
PROJECT_DIR="`dirname \"$0\"`"

cd $PROJECT_DIR
mvn clean package

rm vertx-graal*
$GRAALVMDIR/bin/native-image \
 --verbose \
 --no-server \
 -Dio.netty.noUnsafe=true  \
 -H:Name=hello-world \
 -H:ReflectionConfigurationFiles=./reflectconfigs/netty.json \
 -H:+ReportUnsupportedElementsAtRuntime \
 -Dfile.encoding=UTF-8 \
 -jar target/vertx-graalvm-native-image-test-0.0.1-SNAPSHOT.jar
 

