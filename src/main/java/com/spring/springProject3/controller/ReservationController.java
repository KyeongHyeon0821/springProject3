package com.spring.springProject3.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.springProject3.service.HotelService;
import com.spring.springProject3.service.MemberService;
import com.spring.springProject3.service.ReservationService;
import com.spring.springProject3.service.RoomService;
import com.spring.springProject3.vo.HotelVo;
import com.spring.springProject3.vo.MemberVo;
import com.spring.springProject3.vo.ReservationVo;
import com.spring.springProject3.vo.RoomVo;

@Controller
@RequestMapping("/reservation")
public class ReservationController {

	@Autowired
	ReservationService reservationService;
	
	@Autowired
	RoomService roomService;
	
	@Autowired
	HotelService hotelService;
	
	@Autowired
	MemberService memberService;
	
	// 예약 폼 보기
	@RequestMapping(value = "/reservationForm", method = RequestMethod.GET)
	public String reservationFormGet(Model model,
			HttpSession session,
			@RequestParam("roomIdx") int roomIdx,
			@RequestParam("checkinDate") String checkinDate,
			@RequestParam("checkoutDate") String checkoutDate,
			@RequestParam("guestCount") int guestCount,
			@RequestParam("petCount") int petCount,
			@RequestParam("nights") int nights
		) {
		if(session.getAttribute("sMid")==null) return "redirect:/message/loginRequired";
		
		RoomVo roomVo = roomService.getRoom(roomIdx);
		HotelVo hotelVo = hotelService.getHotel(roomVo.getHotelIdx());
		MemberVo memberVo = memberService.getMemberIdCheck(session.getAttribute("sMid")+"");
				
		model.addAttribute("roomVo", roomVo);
		model.addAttribute("hotelVo", hotelVo);
		model.addAttribute("memberVo", memberVo);
		model.addAttribute("roomIdx", roomIdx);
		model.addAttribute("checkinDate", checkinDate);
		model.addAttribute("checkoutDate", checkoutDate);
		model.addAttribute("guestCount", guestCount);
		model.addAttribute("petCount", petCount);
		model.addAttribute("nights", nights);
		return "reservation/reservationForm";
	}
	
	// 예약 처리
	@RequestMapping(value = "/reservationForm", method = RequestMethod.POST)
	public String reservationFormPost(HttpSession session, ReservationVo vo) {
		String mid = session.getAttribute("sMid") + "";
		if(mid == null || mid.equals("")) return "redirect:/message/loginRequired";
		
		vo.setMid(mid);
		vo.setStatus("결제대기");
		
		int res = reservationService.setReservationInput(vo);
		
		if(res != 0) {
			session.setAttribute("reservationVo", vo);
			return "reservation/payment";
		}
		else return "redirect:/message/reservationNo";
	}
	
}
