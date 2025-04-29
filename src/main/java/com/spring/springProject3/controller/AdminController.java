package com.spring.springProject3.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.springProject3.common.Pagination;
import com.spring.springProject3.service.AdminService;
import com.spring.springProject3.service.HotelService;
import com.spring.springProject3.service.MemberService;
import com.spring.springProject3.vo.HotelVo;
import com.spring.springProject3.vo.InquiryVo;
import com.spring.springProject3.vo.MemberVo;
import com.spring.springProject3.vo.PageVo;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	AdminService adminService; 
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	HotelService hotelService;
	
	@Autowired
	Pagination pagination;
	
	@GetMapping("/adminMain")
	public String admiMainGet() {
		return "admin/adminMain";
	}
	@GetMapping("/adminLeft")
	public String admiLeftGet() {
		return "admin/adminLeft";
	}
	@GetMapping("/adminContent")
	public String admiContentGet() {
		return "admin/adminContent";
	}
	
	//관리자 메인화면(대시보드)폼 보기
	@GetMapping("/dashBoard/dashBoard")
	public String adminMainFormGet() {
		return "/admin/dashBoard/dashBoard";
	}
	
	// 회원리스트 보기
	@GetMapping("/member/memberList")
	public String memberListGet(Model model) {
		List<MemberVo> vos = memberService.getMemberList();
		model.addAttribute("vos",vos);
		
		return "admin/member/memberList";
	}
	
	// 개별 회원 정보 상세보기
	@GetMapping("/memberInfor/{idx}")
	public String memberInforGet(Model model, @PathVariable int idx) {
		MemberVo vo = memberService.getMemberIdxSearch(idx);
		model.addAttribute("vo",vo);
		return "admin/member/memberInfor";
	}
	
	// 1:1문의 리스트 보기
	@GetMapping("/inquiry/adInquiryList")
	public String adInquiryListGet(Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize,
			@RequestParam(name="choice", defaultValue = "전체", required = false) String choice
		) {
		PageVo pageVo = pagination.getTotRecCnt(pag,pageSize,"adminInquiry","",choice);	// (페이지번호,한 페이지분량,section,part,검색어)
		List<InquiryVo> vos = adminService.getInquiryList(pageVo.getStartIndexNo(), pageSize, choice);
		
		model.addAttribute("pageVo", pageVo);
		model.addAttribute("vos", vos);
		model.addAttribute("choice", choice);
		return "admin/inquiry/adInquiryList";
	}
	
	// 1:1문의 상세보기 폼 보기
	@RequestMapping(value = "/inquiry/adInquiryDetail", method = RequestMethod.GET)
	public String adInquiryDetailGet(Model model, int idx) {
		InquiryVo vo = adminService.getInquiryDetail(idx);
		model.addAttribute("vo", vo);
		
		return "admin/inquiry/adInquiryDetail";
	}
	
	// 1:1문의 답변등록하기
	@ResponseBody
	@RequestMapping(value = "/inquiry/adInquiryDetail", method = RequestMethod.POST)
	public String inquiryReplyPost(int idx, String reContent) {
		adminService.setInquiryReplyStatusOk(idx);
		return adminService.setInquiryReplyOk(idx, reContent) + "";
	}
	
	// 1:1문의 답변 수정
	@ResponseBody
	@RequestMapping(value = "/inquiry/adInquiryDetailUpdate", method = RequestMethod.POST)
	public String inquiryReplyUpdatePost(int reIdx, String reContent) {
		return adminService.setAdInquiryDetailUpdate(reIdx, reContent) + "";
	}
	
	// 1:1문의 보류
	@ResponseBody
	@RequestMapping(value = "/inquiry/adInquiryDetailHold", method = RequestMethod.POST)
	public String adInquiryDetailHoldPost(int idx) {
		return adminService.setAdInquiryDetailHold(idx) + "";
	}
	
	//호텔리스트 부르기
	@RequestMapping("/hotelList")
	public String hotelListGet(Model model, HttpSession session,
			 @RequestParam(name="startIndexNo", defaultValue = "0", required = false) int startIndexNo,
			 @RequestParam(name="pageSize", defaultValue = "6", required = false) int pageSize
		) {
		String mid = session.getAttribute("sMid") + "";
		List<HotelVo> vos = hotelService.getHotelList(startIndexNo, pageSize);
		
		if(!mid.equals("")) {
			List<Integer> likedHotelListIdx = hotelService.getLikedHotelListIdx(mid);
			model.addAttribute("likedHotelListIdx", likedHotelListIdx);
		}
		model.addAttribute("vos", vos);
		return "hotel/hotelList";
	}
	
}

