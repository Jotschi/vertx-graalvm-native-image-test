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
rm vertx-graal*
$GRAALVM_HOME/bin/native-image \
 --verbose \
 --no-server \
 --allow-incomplete-classpath \
 -Dio.netty.noUnsafe=true \
 -H:Name=hello-world \
 --delay-class-initialization-to-runtime=io.netty.handler.codec.http2.DefaultHttp2FrameWriter \
 --delay-class-initialization-to-runtime=io.netty.handler.codec.http.HttpObjectEncoder \
 --delay-class-initialization-to-runtime=io.netty.handler.codec.http.websocketx.WebSocket00FrameEncoder \
 --rerun-class-initialization-at-runtime=io.netty.handler.codec.http2.Http2CodecUtil \
 --rerun-class-initialization-at-runtime=io.netty.channel.DefaultChannelPipeline\$TailContext \
 --rerun-class-initialization-at-runtime=io.netty.channel.DefaultChannelPipeline \
 --initialize-at-build-time=io.netty.util.CharsetUtil \
 --initialize-at-build-time=io.netty.util.internal.UnpaddedInternalThreadLocalMap \
 --initialize-at-build-time=io.netty.util.concurrent.FastThreadLocal \
 --initialize-at-build-time=io.netty.buffer.UnpooledUnsafeNoCleanerDirectByteBuf \
 --initialize-at-build-time=io.netty.buffer.UnsafeByteBufUtil \
 --initialize-at-build-time=io.netty.buffer.UnpooledByteBufAllocator\$InstrumentedUnpooledUnsafeNoCleanerDirectByteBuf \
 --initialize-at-build-time=io.netty.util.internal.ReflectionUtil \
 --initialize-at-build-time=io.netty.util.AsciiString \
 --initialize-at-build-time=io.netty.util.AsciiString\$1 \
 --initialize-at-build-time=io.netty.util.AsciiString\$2 \
 --initialize-at-build-time=io.netty.util.internal.MathUtil \
 --initialize-at-build-time=io.netty.util.internal.ObjectUtil \
 --initialize-at-build-time=io.netty.util.internal.EmptyArrays \
 --initialize-at-build-time=io.netty.util.internal.StringUtil \
 --initialize-at-build-time=io.netty.util.internal.PlatformDependent \
 --initialize-at-build-time=io.netty.util.internal.PlatformDependent0 \
 --initialize-at-build-time=io.netty.util.internal.PlatformDependent\$1 \
 --initialize-at-build-time=io.netty.util.internal.PlatformDependent\$2 \
 --initialize-at-build-time=io.netty.util.internal.ReferenceCountUpdater \
 --initialize-at-build-time=io.netty.util.internal.logging.Log4JLoggerFactory \
 --initialize-at-build-time=io.netty.util.internal.logging.JdkLogger \
 --initialize-at-build-time=io.netty.util.ResourceLeakDetectorFactory \
 --initialize-at-build-time=io.netty.util.internal.logging.JdkLoggerFactory \
 --initialize-at-build-time=io.netty.util.internal.logging.Log4J2LoggerFactory \
 --initialize-at-build-time=io.netty.util.internal.SystemPropertyUtil \
 --initialize-at-build-time=io.netty.util.internal.LongAdderCounter \
 --initialize-at-build-time=io.netty.util.internal.CleanerJava6 \
 --initialize-at-build-time=io.netty.util.internal.logging.AbstractInternalLogger \
 --initialize-at-build-time=io.netty.util.internal.logging.Slf4JLoggerFactory \
 --initialize-at-build-time=io.netty.util.internal.logging.LocationAwareSlf4JLogger \
 --initialize-at-build-time=io.netty.util.ResourceLeakDetectorFactory\$DefaultResourceLeakDetectorFactory \
 --initialize-at-build-time=io.netty.util.ResourceLeakDetector \
 --initialize-at-build-time=io.netty.buffer.UnpooledByteBufAllocator \
 --initialize-at-build-time=io.netty.buffer.WrappedByteBuf \
 --initialize-at-build-time=io.netty.buffer.UnpooledDirectByteBuf \
 --initialize-at-build-time=io.netty.buffer.Unpooled \
 --initialize-at-build-time=io.netty.buffer.ReadOnlyByteBuf \
 --initialize-at-build-time=io.netty.buffer.UnpooledByteBufAllocator\$InstrumentedUnpooledDirectByteBuf \
 --initialize-at-build-time=io.netty.buffer.UnreleasableByteBuf \
 --initialize-at-build-time=io.netty.buffer.EmptyByteBuf \
 --initialize-at-build-time=io.netty.buffer.AbstractDerivedByteBuf \
 --initialize-at-build-time=io.netty.buffer.AbstractByteBufAllocator\$1 \
 --initialize-at-build-time=io.netty.buffer.AbstractReferenceCountedByteBuf\$1 \
 --initialize-at-build-time=io.netty.buffer.UnpooledByteBufAllocator\$UnpooledByteBufAllocatorMetric \
 --initialize-at-build-time=io.netty.buffer.ByteBuf \
 --initialize-at-run-time=io.netty.handler.ssl.JettyNpnSslEngine \
 --initialize-at-run-time=io.netty.handler.ssl.ConscryptAlpnSslEngine \
 --initialize-at-run-time=io.netty.util.internal.logging.Log4JLogger \
 --initialize-at-run-time=io.vertx.core.net.impl.transport.KQueueTransport \
 --initialize-at-run-time=io.vertx.core.net.impl.transport.EpollTransport \
 --initialize-at-build-time=ch.qos.logback.classic.encoder.PatternLayoutEncoder \
 --initialize-at-build-time=ch.qos.logback.classic.Logger \
 --initialize-at-build-time=ch.qos.logback.classic.Level \
 --initialize-at-build-time=ch.qos.logback.core.spi.FilterAttachableImpl \
 --initialize-at-build-time=ch.qos.logback.core.ConsoleAppender \
 --initialize-at-build-time=ch.qos.logback.core.status.InfoStatus \
 --initialize-at-build-time=ch.qos.logback.core.helpers.CyclicBuffer \
 --initialize-at-build-time=ch.qos.logback.core.spi.LogbackLock \
 --initialize-at-build-time=ch.qos.logback.classic.pattern.LevelConverter \
 --initialize-at-build-time=ch.qos.logback.core.BasicStatusManager \
 --initialize-at-build-time=ch.qos.logback.classic.pattern.LoggerConverter \
 --initialize-at-build-time=ch.qos.logback.core.pattern.FormatInfo  \
 --initialize-at-build-time=ch.qos.logback.core.CoreConstants \
 --initialize-at-build-time=ch.qos.logback.classic.spi.TurboFilterList \
 --initialize-at-build-time=ch.qos.logback.classic.spi.EventArgUtil \
 --initialize-at-build-time=ch.qos.logback.classic.spi.LoggingEvent \
 --initialize-at-build-time=ch.qos.logback.classic.pattern.MessageConverter \
 --initialize-at-build-time=ch.qos.logback.classic.util.LoggerNameUtil \
 --initialize-at-build-time=ch.qos.logback.classic.pattern.ExtendedThrowableProxyConverter \
 --initialize-at-build-time=ch.qos.logback.classic.pattern.TargetLengthBasedClassNameAbbreviator \
 --initialize-at-build-time=ch.qos.logback.classic.pattern.LineSeparatorConverter \
 --initialize-at-build-time=ch.qos.logback.classic.spi.LoggerContextVO \
 --initialize-at-build-time=ch.qos.logback.classic.util.LogbackMDCAdapter \
 --initialize-at-build-time=ch.qos.logback.classic.PatternLayout \
 --initialize-at-build-time=ch.qos.logback.core.pattern.LiteralConverter \
 --initialize-at-build-time=ch.qos.logback.core.util.CachingDateFormatter \
 --initialize-at-build-time=ch.qos.logback.classic.pattern.DateConverter \
 --initialize-at-build-time=ch.qos.logback.core.joran.spi.ConsoleTarget\$1 \
 --initialize-at-build-time=ch.qos.logback.classic.pattern.ThreadConverter \
 --initialize-at-build-time=ch.qos.logback.core.spi.AppenderAttachableImpl \
 --initialize-at-build-time=ch.qos.logback.classic.util.ContextSelectorStaticBinder \
 --initialize-at-build-time=ch.qos.logback.classic.LoggerContext \
 --initialize-at-build-time=ch.qos.logback.classic.selector.DefaultContextSelector \
 --initialize-at-build-time=org.slf4j.impl.StaticLoggerBinder \
 --initialize-at-build-time=org.slf4j.helpers.FormattingTuple \
 --initialize-at-build-time=org.slf4j.MDC \
 --initialize-at-build-time=org.slf4j.helpers.MessageFormatter \
 --initialize-at-build-time=org.slf4j.helpers.NOPLoggerFactory \
 --initialize-at-build-time=org.slf4j.LoggerFactory \
 --initialize-at-build-time=org.slf4j.helpers.SubstituteLoggerFactory \
 -H:+ReportUnsupportedElementsAtRuntime \
 -Dfile.encoding=UTF-8 \
 --no-fallback \
 -jar target/vertx-graalvm-native-image-test-0.0.1-SNAPSHOT.jar

echo $?
echo
rm docker/app
cp vertx-graalvm-native-image-test-0.0.1-SNAPSHOT docker/app



