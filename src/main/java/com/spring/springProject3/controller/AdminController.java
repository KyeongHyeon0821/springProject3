package com.spring.springProject3.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.springProject3.service.AdminService;
import com.spring.springProject3.service.MemberService;
import com.spring.springProject3.vo.MemberVo;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	AdminService adminService; 
	
	@Autowired
	MemberService memberService;
	
	@GetMapping("/adminMain")
	public String admiMainGet() {
		return "/admin/adminMain";
	}
	@GetMapping("/adminLeft")
	public String admiLeftGet() {
		return "/admin/adminLeft";
	}
	@GetMapping("/adminContent")
	public String admiContentGet() {
		return "/admin/adminContent";
	}
	
	// 회원리스트 보기
	@GetMapping("/member/memberList")
	public String memberListGet(Model model) {
		List<MemberVo> vos = memberService.getMemberList();
		model.addAttribute("vos",vos);
		
		return "/admin/member/memberList";
	}
	// 개별 회원 정보 상세보기
	@GetMapping("/memberInfor/{idx}")
	public String memberInforGet(Model model, @PathVariable int idx) {
		MemberVo vo = memberService.getMemberIdxSearch(idx);
		model.addAttribute("vo",vo);
		return "/admin/member/memberInfor";
	}
}
