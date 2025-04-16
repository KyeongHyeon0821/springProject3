package com.spring.springProject3.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.springProject3.common.Pagination;
import com.spring.springProject3.service.QnaService;
import com.spring.springProject3.vo.PageVo;
import com.spring.springProject3.vo.QnaVo;

@Controller
@RequestMapping("/qna")
public class QnaController {
	
	@Autowired
	QnaService qnaService;
	
	@Autowired
	Pagination pagination;
	
	// qna 리스트 보기
	@RequestMapping(value = "/qnaList", method = RequestMethod.GET)
	public String qnaListGet(Model model, HttpSession session,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize,
			@RequestParam(name="mid", defaultValue = "", required = false) String mid
		) {
		PageVo pageVo = pagination.getTotRecCnt(pag,pageSize,"qna",mid,"");	// (페이지번호,한 페이지분량,section,part,검색어)
		List<QnaVo> vos = qnaService.getQnaList(pageVo.getStartIndexNo(), pageSize, mid);
		
		model.addAttribute("pageVo", pageVo);
		model.addAttribute("vos", vos);
		
		return "qna/qnaList";
	}
	
	// qna 입력 폼 보기
	@RequestMapping(value = "/qnaInput", method = RequestMethod.GET)
	public String qnaInputGet() {
		return "qna/qnaInput";
	}
	
	// qna 업로드 처리 
	@RequestMapping(value = "/qnaInput", method = RequestMethod.POST)
	public String qnaInputPost(QnaVo vo) {
		if(vo.getContent().indexOf("src=\"/") != -1) qnaService.imgCheck(vo.getContent());
		
		vo.setContent(vo.getContent().replace("/data/ckeditor/", "/data/qna/"));
		
		int res = qnaService.setQnaInputOk(vo);
		
		if(res != 0) return "redirect:/message/qnaInputOk";
		else return "redirect:/message/qnaInputNo";
	}

}
