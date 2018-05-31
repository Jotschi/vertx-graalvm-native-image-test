Basic test project which uses Vert.x Web to build a native image

I'm using this project to check when it will be possible to generate a native image for Vert.x using GraalVM / Substrate VM.

NOTE: May 2018 - Building is currently failing due to missing support for netty.

Related issue: https://github.com/oracle/graal/issues/353

```
Build on Server(pid: 6963, port: 26682)
   classlist:     329.96 ms
       (cap):     407.71 ms
       setup:     567.36 ms
RecomputeFieldValue.ArrayIndexScale automatic substitution failed. The automatic substitution registration was attempted because a call to sun.misc.Unsafe.arrayIndexScale(Class) was detected in the static initializer of io.netty.util.internal.PlatformDependent0. Add a RecomputeFieldValue.ArrayIndexScale manual substitution for io.netty.util.internal.PlatformDependent0. 
RecomputeFieldValue.FieldOffset automatic substitution failed. The automatic substitution registration was attempted because a call to sun.misc.Unsafe.objectFieldOffset(Field) was detected in the static initializer of io.netty.util.internal.PlatformDependent0. Add a RecomputeFieldValue.FieldOffset manual substitution for io.netty.util.internal.PlatformDependent0. 
    analysis:   1,627.34 ms
fatal error: java.lang.NoClassDefFoundError
        at sun.reflect.NativeConstructorAccessorImpl.newInstance0(Native Method)
        at sun.reflect.NativeConstructorAccessorImpl.newInstance(NativeConstructorAccessorImpl.java:62)
        at sun.reflect.DelegatingConstructorAccessorImpl.newInstance(DelegatingConstructorAccessorImpl.java:45)
        at java.lang.reflect.Constructor.newInstance(Constructor.java:423)
        at java.util.concurrent.ForkJoinTask.getThrowableException(ForkJoinTask.java:598)
        at java.util.concurrent.ForkJoinTask.get(ForkJoinTask.java:1005)
        at com.oracle.svm.hosted.NativeImageGenerator.run(NativeImageGenerator.java:398)
        at com.oracle.svm.hosted.NativeImageGeneratorRunner.buildImage(NativeImageGeneratorRunner.java:240)
        at com.oracle.svm.hosted.NativeImageGeneratorRunner.build(NativeImageGeneratorRunner.java:337)
        at com.oracle.svm.hosted.server.NativeImageBuildServer.executeCompilation(NativeImageBuildServer.java:378)
        at com.oracle.svm.hosted.server.NativeImageBuildServer.lambda$processCommand$8(NativeImageBuildServer.java:315)
        at com.oracle.svm.hosted.server.NativeImageBuildServer.withJVMContext(NativeImageBuildServer.java:396)
        at com.oracle.svm.hosted.server.NativeImageBuildServer.processCommand(NativeImageBuildServer.java:312)
        at com.oracle.svm.hosted.server.NativeImageBuildServer.processRequest(NativeImageBuildServer.java:256)
        at com.oracle.svm.hosted.server.NativeImageBuildServer.lambda$serve$7(NativeImageBuildServer.java:216)
        at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1149)
        at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:624)
        at java.lang.Thread.run(Thread.java:748)
Caused by: java.lang.NoClassDefFoundError: io/netty/handler/ssl/ReferenceCountedOpenSslServerContext$OpenSslSniHostnameMatcher
        at java.lang.Class.getDeclaringClass0(Native Method)
        at java.lang.Class.getDeclaringClass(Class.java:1235)
        at java.lang.Class.getEnclosingClass(Class.java:1277)
        at jdk.vm.ci.hotspot.HotSpotResolvedObjectTypeImpl.getEnclosingType(HotSpotResolvedObjectTypeImpl.java:894)
        at jdk.vm.ci.hotspot.HotSpotResolvedObjectTypeImpl.getEnclosingType(HotSpotResolvedObjectTypeImpl.java:58)
        at com.oracle.graal.pointsto.meta.AnalysisType.getEnclosingType(AnalysisType.java:917)
        at com.oracle.svm.hosted.analysis.Inflation.checkType(Inflation.java:138)
        at java.lang.Iterable.forEach(Iterable.java:75)
        at java.util.Collections$UnmodifiableCollection.forEach(Collections.java:1080)
        at com.oracle.svm.hosted.analysis.Inflation.checkObjectGraph(Inflation.java:123)
        at com.oracle.graal.pointsto.BigBang.checkObjectGraph(BigBang.java:580)
        at com.oracle.graal.pointsto.BigBang.finish(BigBang.java:552)
        at com.oracle.svm.hosted.NativeImageGenerator.doRun(NativeImageGenerator.java:653)
        at com.oracle.svm.hosted.NativeImageGenerator.lambda$run$0(NativeImageGenerator.java:381)
        at java.util.concurrent.ForkJoinTask$AdaptedRunnableAction.exec(ForkJoinTask.java:1386)
        at java.util.concurrent.ForkJoinTask.doExec(ForkJoinTask.java:289)
        at java.util.concurrent.ForkJoinPool$WorkQueue.runTask(ForkJoinPool.java:1056)
        at java.util.concurrent.ForkJoinPool.runWorker(ForkJoinPool.java:1692)
        at java.util.concurrent.ForkJoinWorkerThread.run(ForkJoinWorkerThread.java:157)
Error: Processing image build request failed
```