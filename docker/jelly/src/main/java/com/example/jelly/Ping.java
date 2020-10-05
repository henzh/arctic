package com.example.jelly;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class Ping {
    
    @RequestMapping("/")
	public String ping() {
		return "Jelly is healthy!";
	}
}
