package com.spring.springProject3.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.springProject3.service.WebMessageService;

@Controller
@RequestMapping("webMessage")
public class WebMessageController {
	
	@Autowired
	WebMessageService webMessageService;

}
