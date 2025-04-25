package com.spring.springProject3.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.springProject3.service.ReviewService;

@Controller
@RequestMapping("/review")
public class ReviewController {

	@Autowired
	ReviewService reviewService;
	
	
	//리뷰페이지 폼 보여주기
	@GetMapping("/memberReview")
	public String memberReviewFormGet() {
		int res=1;
		
		if(res !=0 ) return "/review/memberReviewInput";
		else return "redirect:/message/memberReviewNo";
	}
	
	
	
	
	@PostMapping(value="/reviewInputOk", produces="application/text; charset=utf-8" )
	public String reviewInputOkPost() {
		return "";
	}
	
}
