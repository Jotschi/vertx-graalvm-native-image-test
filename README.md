Basic test project which uses Vert.x Web to build a native image

I'm using this project to check when it will be possible to generate a native image for Vert.x using GraalVM / Substrate VM.

Related issue: https://github.com/oracle/graal/issues/353

----

In this test project I patched a few Vert.x and Netty classes to avoid imports related to native transports and SSL.
Otherwise the image could not be build.