package com.endava.tracing;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import zipkin.server.EnableZipkinServer;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;

@SpringBootApplication
@EnableZipkinServer
@EnableDiscoveryClient
public class TracingApplication {
	public static void main(String[] args) {
		SpringApplication.run(TracingApplication.class, args);
	}

}
