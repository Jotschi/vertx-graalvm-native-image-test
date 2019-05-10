package io.netty.bootstrap;

import java.util.Map.Entry;
import java.util.concurrent.TimeUnit;

import io.netty.channel.Channel;
import io.netty.channel.ChannelConfig;
import io.netty.channel.ChannelFuture;
import io.netty.channel.ChannelFutureListener;
import io.netty.channel.ChannelHandler;
import io.netty.channel.ChannelHandlerContext;
import io.netty.channel.ChannelInboundHandlerAdapter;
import io.netty.channel.ChannelInitializer;
import io.netty.channel.ChannelOption;
import io.netty.channel.ChannelPipeline;
import io.netty.channel.EventLoopGroup;
import io.netty.util.AttributeKey;
import io.netty.util.internal.logging.InternalLogger;
import io.netty.util.internal.logging.InternalLoggerFactory;

public class ServerChannelInitializer extends ChannelInitializer<Channel> {

	private static final InternalLogger logger = InternalLoggerFactory.getInstance(ServerBootstrap.class);

	private ServerBootstrapConfig config;
	private EventLoopGroup currentChildGroup;
	private ChannelHandler currentChildHandler;
	private Entry<ChannelOption<?>, Object>[] currentChildOptions;
	private Entry<AttributeKey<?>, Object>[] currentChildAttrs;


	public ServerChannelInitializer(ServerBootstrapConfig config, EventLoopGroup currentChildGroup, ChannelHandler currentChildHandler,
		Entry<ChannelOption<?>, Object>[] currentChildOptions, Entry<AttributeKey<?>, Object>[] currentChildAttrs) {
		this.config = config;
		this.currentChildGroup = currentChildGroup;
		this.currentChildHandler = currentChildHandler;
		this.currentChildOptions = currentChildOptions;
		this.currentChildAttrs = currentChildAttrs;
	}

	@Override
	public void channelRegistered(ChannelHandlerContext ctx) throws Exception {
		super.channelRegistered(ctx);
	}
	
	@Override
	public void initChannel(final Channel ch) throws Exception {
		final ChannelPipeline pipeline = ch.pipeline();
		ChannelHandler handler = config.handler();
		if (handler != null) {
			pipeline.addLast(handler);
		}

		ch.eventLoop().execute(new Runnable() {
			@Override
			public void run() {
				pipeline.addLast(new ServerBootstrapAcceptor(ch, currentChildGroup, currentChildHandler, currentChildOptions, currentChildAttrs));
			}
		});
	}

	private static class ServerBootstrapAcceptor extends ChannelInboundHandlerAdapter {

		private final EventLoopGroup childGroup;
		private final ChannelHandler childHandler;
		private final Entry<ChannelOption<?>, Object>[] childOptions;
		private final Entry<AttributeKey<?>, Object>[] childAttrs;
		private final Runnable enableAutoReadTask;

		ServerBootstrapAcceptor(final Channel channel, EventLoopGroup childGroup, ChannelHandler childHandler,
			Entry<ChannelOption<?>, Object>[] childOptions, Entry<AttributeKey<?>, Object>[] childAttrs) {
			this.childGroup = childGroup;
			this.childHandler = childHandler;
			this.childOptions = childOptions;
			this.childAttrs = childAttrs;

			// Task which is scheduled to re-enable auto-read.
			// It's important to create this Runnable before we try to submit it as otherwise the URLClassLoader may
			// not be able to load the class because of the file limit it already reached.
			//
			// See https://github.com/netty/netty/issues/1328
			enableAutoReadTask = new Runnable() {
				@Override
				public void run() {
					channel.config().setAutoRead(true);
				}
			};
		}

		@Override
		@SuppressWarnings("unchecked")
		public void channelRead(ChannelHandlerContext ctx, Object msg) {
			final Channel child = (Channel) msg;

			child.pipeline().addLast(childHandler);

			ServerBootstrap.setChannelOptions(child, childOptions, logger);

			for (Entry<AttributeKey<?>, Object> e : childAttrs) {
				child.attr((AttributeKey<Object>) e.getKey()).set(e.getValue());
			}

			try {
				childGroup.register(child).addListener(new ChannelFutureListener() {
					@Override
					public void operationComplete(ChannelFuture future) throws Exception {
						if (!future.isSuccess()) {
							forceClose(child, future.cause());
						}
					}
				});
			} catch (Throwable t) {
				forceClose(child, t);
			}
		}

		private static void forceClose(Channel child, Throwable t) {
			child.unsafe().closeForcibly();
			logger.warn("Failed to register an accepted channel: {}", child, t);
		}

		@Override
		public void exceptionCaught(ChannelHandlerContext ctx, Throwable cause) throws Exception {
			final ChannelConfig config = ctx.channel().config();
			if (config.isAutoRead()) {
				// stop accept new connections for 1 second to allow the channel to recover
				// See https://github.com/netty/netty/issues/1328
				config.setAutoRead(false);
				ctx.channel().eventLoop().schedule(enableAutoReadTask, 1, TimeUnit.SECONDS);
			}
			// still let the exceptionCaught event flow through the pipeline to give the user
			// a chance to do something with it
			ctx.fireExceptionCaught(cause);
		}
	}
}
