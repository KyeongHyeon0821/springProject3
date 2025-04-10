package com.spring.springProject3.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MessageController {

	@RequestMapping(value = "/message/{msgFlag}", method = RequestMethod.GET)
	public String getMessage(Model model, @PathVariable String msgFlag, HttpSession session) {
		
		if(msgFlag.equals("hotelInputNo")) {
			model.addAttribute("message", "호텔 등록이 실패되었습니다.");
			model.addAttribute("url", "hotel/hotelInput");
		}
		else if(msgFlag.equals("hotelInputOk")) {
			model.addAttribute("message", "호텔이 등록되었습니다.");
			model.addAttribute("url", "hotel/hotelList");
		}
		
		
		return "include/message";
	}
}
