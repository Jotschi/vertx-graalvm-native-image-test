package de.jotschi.examples;

import io.netty.buffer.ByteBuf;
import io.netty.buffer.ByteBufUtil;
import io.netty.buffer.PooledByteBufAllocator;
import io.netty.util.internal.CleanerJava6;
import io.netty.util.internal.PlatformDependent;

public class DMATest {

	static {
		PlatformDependent.init();
		ByteBufUtil.init();
		PooledByteBufAllocator.init();
		CleanerJava6.init();
	}

	public static void main(String[] args) throws InterruptedException {
		Thread t = new Thread(() -> {
			ByteBuf buffer = PooledByteBufAllocator.DEFAULT.buffer(200);
			System.out.println(buffer.getClass().getName());
			buffer.setLong(0, 42L);
			long longValue = buffer.getLong(0);
			System.out.println("Long value: " + longValue);
			System.out.println(buffer.capacity());
			
			buffer.setByte(1, 43);
			byte b = buffer.getByte(1);
			System.out.println("From Byte:" + new Long(b).longValue());
		});
		t.start();
		t.join();
	}

}
