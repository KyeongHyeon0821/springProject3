package com.spring.springProject3.controller;

import java.util.List;

import org.apache.hc.core5.annotation.Contract;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.springProject3.common.Pagination;
import com.spring.springProject3.common.ProjectProvide;
import com.spring.springProject3.service.FaqService;
import com.spring.springProject3.vo.FaqVo;
import com.spring.springProject3.vo.PageVo;

@Controller
@RequestMapping("/faq")
public class FaqController {
	
	@Autowired
	FaqService faqService;
	
	
	@Autowired
	Pagination pagination;
	
	@Autowired
	ProjectProvide projectProvide;
	
	
	// FAQ 관리자 폼 보기
	@RequestMapping(value = "/adFaqList", method = RequestMethod.GET)
	public String adFaqListGet(Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize,
			@RequestParam(name="choice", defaultValue = "전체", required = false) String choice	
		) {
		PageVo pageVo = pagination.getTotRecCnt(pag,pageSize,"adFaqList","",choice);
		
		List<FaqVo> vos = faqService.getFaqList(pageVo.getStartIndexNo(), pageSize, choice);
		
		model.addAttribute("pageVo", pageVo);
		model.addAttribute("vos", vos);
		
		return "admin/faq/adFaqList";
	}
	
	// FAQ 입력 폼 보기
	@RequestMapping(value = "/adFaqInput", method = RequestMethod.GET)
	public String adFaqInputGet() {
		return "admin/faq/adFaqInput";
	}
	
	// FAQ 입력 처리
	@RequestMapping(value = "/adFaqInput", method = RequestMethod.POST)
	public String adFaqInputPost(FaqVo vo) {
		if(vo.getContent().indexOf("src=\"/") != -1) {
			projectProvide.imgCheck(vo.getContent(), "ckeditor", "faq");
			
			vo.setContent(vo.getContent().replace("/data/ckeditor/", "/data/faq/"));
		}
		int res = faqService.setAdFaqInputOk(vo);
		
		if(res != 0) return "redirect:/message/adFaqInputOk";
		else return "redirect:/message/adFaqInputNo";
	}
	
	// FAQ 내용보기
	@RequestMapping(value = "/adFaqDetail", method = RequestMethod.GET)
	public String adFaqDetailGet() {
		return "admin/adFaqDetail";
	}

}
