package com.spring.springProject3.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MessageController {

	@RequestMapping(value = "/message/{msgFlag}", method = RequestMethod.GET)
	public String getMessage(Model model, @PathVariable String msgFlag, HttpSession session,
			@RequestParam(name="idx", defaultValue = "0", required = false) int idx
		) {
		
		if(msgFlag.equals("hotelInputNo")) {
			model.addAttribute("message", "호텔 등록이 실패되었습니다.");
			model.addAttribute("url", "hotel/hotelInput");
		}
		else if(msgFlag.equals("hotelInputOk")) {
			model.addAttribute("message", "호텔이 등록되었습니다.");
			model.addAttribute("url", "hotel/hotelList");
		}
		else if(msgFlag.equals("hotelInputError")) {
			model.addAttribute("message", "호텔 등록 중 오류가 발생했습니다. \\n다시 시도해주세요.");
			model.addAttribute("url", "hotel/hotelInput");
		}
		else if(msgFlag.equals("hotelDeleteCheckOk")) {
			model.addAttribute("message", "호텔 등록 취소 신청이 접수되었습니다.");
			model.addAttribute("url", "hotel/hotelList");
		}
		else if(msgFlag.equals("hotelDeleteCheckNo")) {
			model.addAttribute("message", "호텔 등록 취소 신청 처리 중 문제가 발생했습니다. 다시 시도해주세요.");
			model.addAttribute("url", "hotel/hotelDetail?idx="+idx);
		}
		else if(msgFlag.equals("hotelUpdateOk")) {
			model.addAttribute("message", "호텔 정보가 수정되었습니다.");
			model.addAttribute("url", "hotel/hotelDetail?idx="+idx);
		}
		else if(msgFlag.equals("hotelUpdateNo")) {
			model.addAttribute("message", "호텔 정보 수정 중 오류가 발생했습니다. \\n다시 시도해주세요.");
			model.addAttribute("url", "hotel/hotelUpdate?idx="+idx);
		}
		
		
		return "include/message";
	}
}
