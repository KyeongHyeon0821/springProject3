package com.spring.springProject3.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.springProject3.service.HotelService;
import com.spring.springProject3.service.ReservationService;
import com.spring.springProject3.service.ReviewService;
import com.spring.springProject3.service.RoomService;
import com.spring.springProject3.vo.ReservationListVo;
import com.spring.springProject3.vo.ReviewVo;

@Controller
@RequestMapping("/review")
public class ReviewController {

	@Autowired
	ReviewService reviewService;
	
	@Autowired
	RoomService roomService;
	
	@Autowired
	HotelService hotelService;
	
	@Autowired
	ReservationService reservationService;
	
	
	
	//리뷰페이지 폼 보여주기
	@GetMapping("/memberReview")
	public String memberReviewFormGet(Model model, HttpSession session) {
		String mid = session.getAttribute("sMid") + "";
		//String nickName = session.getAttribute("sNickName") + "";
		 
		List<ReservationListVo> rsVos = reviewService.getRoomUsedList(mid);
		model.addAttribute("rsVos", rsVos);
		// sMid select * from reservation where mid = #{sMid} and status = '이용완료';
		return "review/memberReviewInput";
	}
	
	//리뷰 등록하기
	@PostMapping(value="/reviewInput", produces="application/text; charset=utf-8" )
	public String reviewInputOkPost(ReviewVo vo, HttpSession session) {
		String nickName = session.getAttribute("sNickName") + "";
		String mid = session.getAttribute("sMid") + "";
		int res = reviewService.setReviewInputOk(vo, mid, nickName);
		if(res != 0) return "redirect:/message/reviewInputOk"; 
		else return "redirect:/message/reviewInputNo"; 
	}
	
}
