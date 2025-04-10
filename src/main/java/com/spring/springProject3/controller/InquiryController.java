package com.spring.springProject3.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.springProject3.common.Pagination;
import com.spring.springProject3.service.InquiryService;
import com.spring.springProject3.vo.InquiryVo;
import com.spring.springProject3.vo.PageVo;

@Controller
@RequestMapping("/inquiry")
public class InquiryController {
	
	@Autowired
	InquiryService inquiryService;
	
	@Autowired
	Pagination pagination;

	@RequestMapping(value = "inquiryList", method = RequestMethod.GET)
	public String inquiryListGet(Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize
		) {
		PageVo pageVo = pagination.getTotRecCnt(pag,pageSize,"inquiry","","");	// (페이지번호,한 페이지분량,section,part,검색어)
		List<InquiryVo> vos = inquiryService.getInquiryList(pageVo.getStartIndexNo(), pageSize);
		
		model.addAttribute("pageVo", pageVo);
		model.addAttribute("vos", vos);
		
		return "inquiry/inquiryList";
	}
}
