package de.jotschi.examples;

import io.vertx.core.Vertx;
import io.vertx.ext.web.Router;

public class Runner {
/*
	static {
		System.setProperty(LoggerFactory.LOGGER_DELEGATE_FACTORY_CLASS_NAME, SLF4JLogDelegateFactory.class.getName());
	}
	*/

	public static void main(String[] args) {
		// Use logback for logging
//		File logbackFile = new File("config", "logback.xml");
//		System.setProperty("logback.configurationFile", logbackFile.getAbsolutePath());
//		Logger log = LoggerFactory.getLogger(Runner.class);

		// Setup the http server
//		log.info("Starting server for: http://localhost:8080/hello");
		Vertx vertx = Vertx.vertx();
		Router router = Router.router(vertx);

		router.route("/hello").handler(rc -> {
			// log.info("Got hello request");
			rc.response().end("World");
		});

		vertx.createHttpServer()
			.requestHandler(router::handle)
			.listen(8080);

	}

}
