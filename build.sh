  #!/bin/bash

if [ -z "$GRAALVM_HOME" ] ; then
  echo "Please set GRAALVM_HOME to point to your graalvm installation"
  exit
fi

PROJECT_DIR="`dirname \"$0\"`"


cd $PROJECT_DIR
./mvnw clean package

# -H:+PrintClassInitialization \
# -H:ReflectionConfigurationFiles=./reflectconfigs/netty.json \
# --initialize-at-build-time=de.jotschi.examples.Runner \

# --delay-class-initialization-to-runtime=io.netty.handler.codec.http2.DefaultHttp2FrameWriter \
# --rerun-class-initialization-at-runtime=io.netty.handler.codec.http2.Http2CodecUtil \
# --rerun-class-initialization-at-runtime=io.netty.channel.DefaultChannelPipeline\$TailContext \
# --rerun-class-initialization-at-runtime=io.netty.channel.DefaultChannelPipeline \
# --initialize-at-run-time=io.vertx.core.net.impl.transport.EpollTransport \
rm vertx-graal*
$GRAALVM_HOME/bin/native-image \
 --verbose \
 --no-server \
 --allow-incomplete-classpath \
 -Dio.netty.noUnsafe=true \
 -H:Name=hello-world \
 --initialize-at-build-time=io.vertx \
 --initialize-at-build-time=ch.qos.logback \
 --initialize-at-build-time=org.slf4j \
 --initialize-at-build-time=com.fasterxml.jackson \
 -H:+ReportUnsupportedElementsAtRuntime \
 -Dfile.encoding=UTF-8 \
 --no-fallback \
 -jar target/vertx-graalvm-native-image-test-0.0.1-SNAPSHOT.jar

echo $?
echo
rm docker/app
cp vertx-graalvm-native-image-test-0.0.1-SNAPSHOT docker/app



