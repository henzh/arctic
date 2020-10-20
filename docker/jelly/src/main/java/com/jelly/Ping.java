package com.jelly;

import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestMapping;

@RestController
public class Ping {

	@RequestMapping("/ping")
	public String index() {
		return "Pinged!";
	}
}
