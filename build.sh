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
 --allow-incomplete-classpath \
 --no-server \
 -Dio.netty.noUnsafe=true \
 -H:Name=hello-world \
 -H:ReflectionConfigurationFiles=./reflectconfigs/netty.json \
 --delay-class-initialization-to-runtime=io.netty.handler.codec.http.HttpObjectEncoder \
 --delay-class-initialization-to-runtime=io.netty.handler.codec.http2.Http2CodecUtil \
 --delay-class-initialization-to-runtime=io.netty.handler.codec.http2.DefaultHttp2FrameWriter \
 --delay-class-initialization-to-runtime=io.netty.handler.codec.http.websocketx.WebSocket00FrameEncoder \
 -H:+ReportUnsupportedElementsAtRuntime \
 -Dfile.encoding=UTF-8 \
 -jar target/vertx-graalvm-native-image-test-0.0.1-SNAPSHOT.jar
  
rm docker/app
cp vertx-graalvm-native-image-test-0.0.1-SNAPSHOT docker/app



