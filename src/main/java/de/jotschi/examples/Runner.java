package de.jotschi.examples;

import io.netty.buffer.ByteBufUtil;
import io.netty.buffer.PooledByteBufAllocator;
import io.netty.channel.epoll.Epoll;
import io.netty.channel.epoll.Native;
import io.netty.channel.socket.nio.NioServerSocketChannel;
import io.netty.util.internal.CleanerJava6;
import io.netty.util.internal.NativeLibraryLoader;
import io.netty.util.internal.PlatformDependent;
import io.vertx.core.Vertx;
import io.vertx.core.VertxOptions;
import io.vertx.core.logging.Logger;
import io.vertx.core.logging.LoggerFactory;
import io.vertx.ext.web.Router;

public class Runner {

	private static Logger log;
	static {
		setupLogger();
		log.info("Setup Netty");
		setupNettyJNI();
	}

	public static void main(String[] args) {
		setupLogger();
		// Load the statically linked lib
		// String staticLibName = "netty_transport_native_epoll";
		// System.loadLibrary(staticLibName);

		// setupNetty();
		log.info("Starting server for: http://localhost:8080/hello");
		VertxOptions options = new VertxOptions();
		options.setPreferNativeTransport(true);
		Vertx vertx = Vertx.vertx(options);
		Router router = Router.router(vertx);

		router.route("/hello").handler(rc -> {
			rc.response().end("World");
		});

		vertx.createHttpServer()
			.requestHandler(router::handle)
			.listen(8080);

	}

	private static void setupLogger() {
		// File logbackFile = new File("config", "logback.xml");
		// System.setProperty("logback.configurationFile", logbackFile.getAbsolutePath());
		// System.setProperty(LoggerFactory.LOGGER_DELEGATE_FACTORY_CLASS_NAME, SLF4JLogDelegateFactory.class.getName());
		log = LoggerFactory.getLogger(Runner.class);
	}

	private static void setupNettyJNI() {
		NativeLibraryLoader.init();

		log.info("Init platform");
		PlatformDependent.init();

		log.info("Init buffer utils");
		ByteBufUtil.init();
		PooledByteBufAllocator.init();
		Native.init2();
		setupNetty();
	}

	private static void setupNetty() {
		log.info("Setup EPOLL");
		Epoll.ensureAvailability();
		Epoll.init();

		log.info("Setup Netty");
		Native.init();
		// Sets eventloop thread count
		NioServerSocketChannel.init();
		CleanerJava6.init();
	}

}
