  #!/bin/bash

if [ -z "$GRAALVM_HOME" ] ; then
  echo "Please set GRAALVM_HOME to point to your graalvm installation"
  exit
fi

PROJECT_DIR="`dirname \"$0\"`"


cd $PROJECT_DIR
./mvnw clean package

rm vertx-graal*
$GRAALVM_HOME/bin/native-image \
 --verbose \
 --no-server \
 --allow-incomplete-classpath \
 -Dio.netty.noUnsafe=true \
 -H:Name=hello-world \
 --initialize-at-build-time=ch.qos.logback \
 --initialize-at-build-time=org.slf4j \
 -H:+ReportUnsupportedElementsAtRuntime \
 -Dfile.encoding=UTF-8 \
 --no-fallback \
 -jar target/vertx-graalvm-native-image-test-0.0.1-SNAPSHOT.jar

echo $?
echo
rm docker/app
cp vertx-graalvm-native-image-test-0.0.1-SNAPSHOT docker/app



