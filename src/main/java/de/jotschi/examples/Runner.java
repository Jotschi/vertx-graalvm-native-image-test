package de.jotschi.examples;

import java.io.File;

import io.netty.buffer.AbstractByteBuf;
import io.netty.buffer.ByteBufUtil;
import io.netty.channel.epoll.Epoll;
import io.netty.channel.epoll.Native;
import io.netty.channel.nio.NioEventLoop;
import io.netty.handler.ssl.OpenSsl;
import io.netty.resolver.dns.DefaultDnsServerAddressStreamProvider;
import io.netty.util.ResourceLeakDetectorFactory;
import io.netty.util.ThreadDeathWatcher;
import io.vertx.core.Vertx;
import io.vertx.core.logging.Logger;
import io.vertx.core.logging.LoggerFactory;
import io.vertx.core.logging.SLF4JLogDelegateFactory;
import io.vertx.ext.web.Router;

public class Runner {

	public static void main(String[] args) {
		setupNetty();

		File logbackFile = new File("config", "logback.xml");
		System.setProperty("logback.configurationFile", logbackFile.getAbsolutePath());
		System.setProperty(LoggerFactory.LOGGER_DELEGATE_FACTORY_CLASS_NAME, SLF4JLogDelegateFactory.class.getName());
		Logger log = LoggerFactory.getLogger(Runner.class);

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

	private static void setupNetty() {
		Native.init2();
		Native.init();

		Epoll.ensureAvailability();
		Epoll.init();
		ResourceLeakDetectorFactory.init();
		AbstractByteBuf.init();
		ThreadDeathWatcher.init();
		OpenSsl.init();
		ByteBufUtil.init();
		NioEventLoop.init();
		DefaultDnsServerAddressStreamProvider.init();
	}

}
