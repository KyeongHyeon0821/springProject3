package com.spring.springProject3.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.springProject3.service.InquiryService;
import com.spring.springProject3.vo.InquiryVo;

@Controller
@RequestMapping("/inquiry")
public class InquiryController {
	
	@Autowired
	InquiryService inquiryService;
	

	@RequestMapping(value = "inquiryList", method = RequestMethod.GET)
	public String inquiryListGet(Model model) {
		//List<InquiryVo> vos = inquiryService.getInquiryList();
		
		return "inquiry/inquiryList";
	}
}
