# Vert.x GraalVM - Native Image Test

This is a basic test project which uses [GraalVM](https://www.graalvm.org/) / [Substrate VM](https://github.com/oracle/graal/tree/master/substratevm) VM to build a native image of a Vert.x Web application.

## How to build

I prepared and tested the build only on Linux but it should also work on other platforms.

1. Build a shaded jar of your application
2. Run the `native-image` tool from GraalVM to generate the executable

The `build.sh` file contains more details about needed arguments.


## Patches

In this test project I patched a few Vert.x and Netty classes to avoid imports related to native transports and SSL. Otherwise the image could not be build.

### Vert.x Transport

First I needed to patch the `io.vertx.core.net.impl.transport.Transport` class in order to prevent the loading of EPoll and KQueue native support. Otherwise Substrate VM will try to load these classes and fail.

```java
public class Transport {
…
  /**
   * The native transport, it may be {@code null} or failed.
   */
  public static Transport nativeTransport() {
    // Patched: I remove the native transport discovery. 
    // The imports would be picked up by substrate 
    // and cause further issues. 
    return null;
  }
…
}
```

### Netty SSL

Native SSL support is another problematic area. I created a patched dummy `io.netty.handler.ssl.ReferenceCountedOpenSslEngine` class in order to prevent Substrate VM from digging deeper into the SSL code of Netty.

### Netty Reflections

Next we need to set up the reflection configuration within `reflectconfigs/netty.json`.

Netty uses reflection to instantiate the socket channels. This is done in the ReflectiveChannelFactory. We need to tell Substrate VM how classes of type `NioServerSocketChannel` and `NioSocketChannel` can be instantiated. 

```
[
  {
    "name" : "io.netty.channel.socket.nio.NioSocketChannel",
    "methods" : [
      { "name" : "<init>", "parameterTypes" : [] }
    ]
  },
  {
    "name" : "io.netty.channel.socket.nio.NioServerSocketChannel",
    "methods" : [
      { "name" : "<init>", "parameterTypes" : [] }
    ]
  }
]
```



## Limitations

Native EPoll, KQueue support, SSL is not yet working.

Related issue: https://github.com/oracle/graal/issues/353

## Blog post

More information can also be found in [my post on the Vert.x blog](https://vertx.io/blog/eclipse-vert-x-goes-native/).