package de.jotschi.vertx.example;

import io.vertx.core.Vertx;
import io.vertx.core.logging.Logger;
import io.vertx.core.logging.LoggerFactory;

public class Runner {

	public static final Logger log = LoggerFactory.getLogger(Runner.class);

	public static void main(String[] args) {
		// Setup the http server
		log.info("Starting server for: http://localhost:8080/hello");
		Vertx vertx = Vertx.vertx();
//		Router router = Router.router(vertx);

//		router.route("/hello").handler(rc -> {
//			log.info("Got hello request");
//			rc.response().end("World");	
//		});

//		vertx.createHttpServer()
//			.requestHandler(router::accept)
//			.listen(8080);

	}

}
