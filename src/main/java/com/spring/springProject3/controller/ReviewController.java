package com.spring.springProject3.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.springProject3.service.HotelService;
import com.spring.springProject3.service.ReservationService;
import com.spring.springProject3.service.ReviewService;
import com.spring.springProject3.service.RoomService;
import com.spring.springProject3.vo.ReservationListVo;
import com.spring.springProject3.vo.ReservationVo;
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
		String sLevel = session.getAttribute("sLevel") + "";
		//String nickName = session.getAttribute("sNickName") + "";
		// 내가 쓴 리뷰 목록을 볼 수 있게 예약테이블에서 값을 가져온다.
		List<Integer> isReviewed = reviewService.getExistReviewedCheck(mid);
		
		// 리뷰를 달 준비가 된 객실의 정보도 함께 가져오도록 한다.3
		List<ReservationListVo> rsVos = reviewService.getRoomUsedList(mid);
		List<ReviewVo> rVos = reviewService.getRoomReviewAllList();
		model.addAttribute("sLevel", sLevel);
		model.addAttribute("rsVos", rsVos);
		model.addAttribute("rVos", rVos);
		model.addAttribute("isReviewed", isReviewed);
		System.out.println("rsVos : " + rsVos);
		// sMid select * from reservation where mid = #{sMid} and status = '이용완료';
		
		return "review/memberReviewInput";
	}
	
	//리뷰 등록하기
	@PostMapping(value="/reviewInput", produces="application/text; charset=utf-8" )
	public String reviewInputOkPost(ReviewVo vo, ReservationVo resVo, HttpSession session, HttpServletRequest request) {
		vo.setNickName(session.getAttribute("sNickName") + "");
		vo.setMid(session.getAttribute("sMid") + "");
		vo.setHostIp(request.getRemoteAddr());
		
		int res = reviewService.setReviewInputOk(vo);
		//룸 상태를 리뷰작성 상태로 교체
		reservationService.setReviewSave(vo);
		
		if(res != 0) return "redirect:/message/reviewInputOk?status=" + resVo.getStatus(); 
		else return "redirect:/message/reviewInputNo"; 
	}
	

	
}
