package de.jotschi.examples;

import java.io.File;

import io.netty.buffer.AbstractByteBuf;
import io.netty.buffer.ByteBufUtil;
import io.netty.buffer.PooledByteBufAllocator;
import io.netty.channel.MultithreadEventLoopGroup;
import io.netty.channel.epoll.Epoll;
import io.netty.channel.epoll.Native;
import io.netty.channel.nio.NioEventLoop;
import io.netty.channel.socket.nio.NioServerSocketChannel;
import io.netty.handler.ssl.OpenSsl;
import io.netty.resolver.dns.DefaultDnsServerAddressStreamProvider;
import io.netty.util.NetUtil;
import io.netty.util.Recycler;
import io.netty.util.ResourceLeakDetectorFactory;
import io.netty.util.ThreadDeathWatcher;
import io.netty.util.internal.InternalThreadLocalMap;
import io.netty.util.internal.NativeLibraryLoader;
import io.netty.util.internal.PlatformDependent;
import io.vertx.core.Vertx;
import io.vertx.core.logging.Logger;
import io.vertx.core.logging.LoggerFactory;
import io.vertx.core.logging.SLF4JLogDelegateFactory;
import io.vertx.ext.web.Router;

public class Runner {

	private static Logger log;
	static {
		File logbackFile = new File("config", "logback.xml");
		System.setProperty("logback.configurationFile", logbackFile.getAbsolutePath());
		System.setProperty(LoggerFactory.LOGGER_DELEGATE_FACTORY_CLASS_NAME, SLF4JLogDelegateFactory.class.getName());
		log = LoggerFactory.getLogger(Runner.class);
		log.info("Setup Netty");
		setupNettyJNI();
		Recycler.init();
	}

	public static void main(String[] args) {
		// setupNetty();
		log.info("Starting server for: http://localhost:8080/hello");
		Vertx vertx = Vertx.vertx();
		Router router = Router.router(vertx);

		router.route("/hello").handler(rc -> {
			rc.response().end("World");
		});

		vertx.createHttpServer()
			.requestHandler(router::accept)
			.listen(8080);

	}

	private static void setupNettyJNI() {
		NativeLibraryLoader.init();

		log.info("Init platform");
		PlatformDependent.init();

		log.info("Init buffer utils");
		ByteBufUtil.init();
		{
			ResourceLeakDetectorFactory.init();
			log.info("PooledByteBufAllocator");
			PooledByteBufAllocator.init();
			log.info("AbstractByteBuf");
			AbstractByteBuf.init();
		}
		Native.init2();
		setupNetty();
	}

	private static void setupNetty() {
		log.info("Setup EPOLL");
		Epoll.ensureAvailability();
		Epoll.init();

		log.info("Setup Netty");
		Native.init();
		NetUtil.init();
		InternalThreadLocalMap.init();
		// Sets eventloop thread count
		MultithreadEventLoopGroup.init();
		NioServerSocketChannel.init();

		ThreadDeathWatcher.init();
		log.info("Setup SSL");
//		OpenSsl.init();
		NioEventLoop.init();
		DefaultDnsServerAddressStreamProvider.init();
		

	}

}
