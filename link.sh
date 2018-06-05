#!/bin/bash

jlink --module-path $JAVA_HOME/jmods:\
/media/nvm/mesh/vertx-graalvm-native-image-test/app/target/classes:\
/home/jotschi/.m2/repository/io/vertx/vertx-web/3.5.1/vertx-web-3.5.1.jar:\
/home/jotschi/.m2/repository/io/vertx/vertx-core/3.5.1/vertx-core-3.5.1.jar:\
/home/jotschi/.m2/repository/io/netty/netty-common/4.1.19.Final/netty-common-4.1.19.Final.jar:\
/home/jotschi/.m2/repository/io/netty/netty-buffer/4.1.19.Final/netty-buffer-4.1.19.Final.jar:\
/home/jotschi/.m2/repository/io/netty/netty-transport/4.1.19.Final/netty-transport-4.1.19.Final.jar:\
/home/jotschi/.m2/repository/io/netty/netty-handler/4.1.19.Final/netty-handler-4.1.19.Final.jar:\
/home/jotschi/.m2/repository/io/netty/netty-codec/4.1.19.Final/netty-codec-4.1.19.Final.jar:\
/home/jotschi/.m2/repository/io/netty/netty-codec-http/4.1.19.Final/netty-codec-http-4.1.19.Final.jar:\
/home/jotschi/.m2/repository/com/fasterxml/jackson/core/jackson-core/2.9.3/jackson-core-2.9.3.jar:\
/home/jotschi/.m2/repository/com/fasterxml/jackson/core/jackson-databind/2.9.3/jackson-databind-2.9.3.jar:\
/home/jotschi/.m2/repository/com/fasterxml/jackson/core/jackson-annotations/2.9.0/jackson-annotations-2.9.0.jar:\
/home/jotschi/.m2/repository/io/netty/netty-tcnative/2.0.8.Final/netty-tcnative-2.0.8.Final.jar:\
/home/jotschi/.m2/repository/com/jcraft/jzlib/1.1.3/jzlib-1.1.3.jar \
--verbose \
--add-modules de.jotschi.vertx.example \
--launcher run=de.jotschi.vertx.example/de.jotschi.vertx.example.Runner \
--output dist \
--compress 2 \
--strip-debug \
--no-header-files \
--no-man-pages

#/home/jotschi/.m2/repository/io/vertx/vertx-auth-common/3.5.1/vertx-auth-common-3.5.1.jar:\
#/home/jotschi/.m2/repository/io/netty/netty-handler-proxy/4.1.19.Final/netty-handler-proxy-4.1.19.Final.jar:\
#/home/jotschi/.m2/repository/io/vertx/vertx-bridge-common/3.5.1/vertx-bridge-common-3.5.1.jar:\
#/home/jotschi/.m2/repository/io/netty/netty-codec-socks/4.1.19.Final/netty-codec-socks-4.1.19.Final.jar:\
#/home/jotschi/.m2/repository/io/netty/netty-resolver/4.1.19.Final/netty-resolver-4.1.19.Final.jar:\
#/home/jotschi/.m2/repository/io/netty/netty-resolver-dns/4.1.19.Final/netty-resolver-dns-4.1.19.Final.jar:\
#/home/jotschi/.m2/repository/io/netty/netty-codec-dns/4.1.19.Final/netty-codec-dns-4.1.19.Final.jar:\
