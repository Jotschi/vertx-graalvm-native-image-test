package io.netty.channel.kqueue;

public class KQueue {
	public static boolean isAvailable() {
		return false;
	}

	public static void ensureAvailability() {
	}
}
