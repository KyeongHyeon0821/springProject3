package com.spring.springProject3.controller;

import javax.servlet.http.HttpServletRequest;
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
	public String getMessage(Model model, @PathVariable String msgFlag,
			HttpSession session, HttpServletRequest request,
			@RequestParam(name="mid", defaultValue = "", required = false) String mid,
			@RequestParam(name="idx", defaultValue = "0", required = false) int idx,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize,
			@RequestParam(name="search", defaultValue = "", required = false) String search,
			@RequestParam(name="searchString", defaultValue = "", required = false) String searchString,
			@RequestParam(name="part", defaultValue = "전체", required = false) String part,
			@RequestParam(name="mSw", defaultValue = "1", required = false) String mSw,
			@RequestParam(name="tempFlag", defaultValue = "", required = false) String tempFlag
		) {
		
		if(msgFlag.equals("inquiryInputOk")) {
			model.addAttribute("message", "작성하신 글이 등록되었습니다.");
			model.addAttribute("url", "inquiry/inquiryList");
		}
		else if(msgFlag.equals("inquiryInputNo")) {
			model.addAttribute("message", "작성하신 글 등록이 실패되었습니다.");
			model.addAttribute("url", "inquiry/inquiryInput");
		}
		else if(msgFlag.equals("inquiryDeleteCheckOk")) {
			model.addAttribute("message", "작성하신 문의글을 삭제하였습니다.");
			model.addAttribute("url", "inquiry/inquiryList");
		}
		else if(msgFlag.equals("inquiryDeleteCheckNo")) {
			model.addAttribute("message", "작성하신 문의글 삭제가 실패되었습니다.");
			model.addAttribute("url", "inquiry/inquiryDetail?idx="+idx);
		}
		else if(msgFlag.equals("inquiryUpdateOk")) {
			model.addAttribute("message", "작성하신 문의글이 수정되었습니다.");
			model.addAttribute("url", "inquiry/inquiryDetail?idx="+request.getParameter("idx"));
		}
		else if(msgFlag.equals("inquiryUpdateNo")) {
			model.addAttribute("message", "작성하신 문의글 수정이 실패되었습니다.");
			model.addAttribute("url", "inquiry/inquiryDetail?idx="+idx);
		}
		else if(msgFlag.equals("inquiryReplyOk")) {
			model.addAttribute("message", "작성하신 답변이 등록되었습니다.");
			model.addAttribute("url", "admin/adInquiryDetail?idx="+request.getParameter("idx"));
		}
		else if(msgFlag.equals("inquiryReplyNo")) {
			model.addAttribute("message", "작성하신 답변등록이 실패되었습니다.");
			model.addAttribute("url", "admin/adInquiryDetail?idx="+idx);
		}
		
		
		
		return "include/message";
	}
	
}
