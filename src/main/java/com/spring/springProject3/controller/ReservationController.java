package com.spring.springProject3.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
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
      @RequestParam(value = "roomIdx", required = true) Integer roomIdx,
      @RequestParam(value = "checkinDate", required = true) String checkinDate,
      @RequestParam(value = "checkoutDate", required = true) String checkoutDate,
      @RequestParam(value = "guestCount", required = true) Integer guestCount,
      @RequestParam(value = "petCount", required = true) Integer petCount,
      @RequestParam(value = "nights", required = true) Integer nights,
      @RequestParam(value = "searchString", defaultValue = "", required = false) String searchString
		) {
		if(session.getAttribute("sMid")==null) return "redirect:/message/loginRequired";
		
		// 유효성 체크
    if (roomIdx == null || roomIdx <= 0) {
        return "redirect:/message/invalidValue"; 
    }
    if (checkinDate == null || checkinDate.trim().isEmpty()) {
        return "redirect:/message/invalidValue";  
    }
    if (checkoutDate == null || checkoutDate.trim().isEmpty()) {
        return "redirect:/message/invalidValue"; 
    }
    if (guestCount == null || guestCount <= 0) {
        return "redirect:/message/invalidValue";  
    }
    if (petCount == null || petCount < 0) {
        return "redirect:/message/invalidValue"; 
    }
    if (nights == null || nights <= 0) {
        return "redirect:/message/invalidValue";
    }
		
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
		model.addAttribute("searchString", searchString);
		return "reservation/reservationForm";
	}
	
	// 예약 처리
	@RequestMapping(value = "/reservationForm", method = RequestMethod.POST)
	public String reservationFormPost(HttpSession session, Model model, ReservationVo vo) {
		String mid = session.getAttribute("sMid") + "";
		if(mid == null || mid.equals("")) return "redirect:/message/loginRequired"; // 로그인 체크
		
		Date today = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHss");
		
		
		vo.setMid(mid);
		vo.setStatus("결제대기");
		vo.setReservationNo(sdf.format(today) + UUID.randomUUID().toString().substring(0,2) + vo.getRoomIdx()); // 예약번호만들기
		
		int res = reservationService.setReservationInput(vo); // 예약 테이블 입력 처리
		
		if(res != 0) { // 결제대기 처리 되었으면 실행
			RoomVo roomVo = roomService.getRoom(vo.getRoomIdx());
			HotelVo hotelVo = hotelService.getHotel(roomVo.getHotelIdx());
			
			model.addAttribute("hotelVo", hotelVo);
			model.addAttribute("vo", vo);
			session.setAttribute("reservationVo", vo);
			return "reservation/payment";
		}
		else return "redirect:/message/reservationNo";
	}
	
	
	// 결제 완료 후 결제 정보/예약정보 보기
	@RequestMapping(value = ("/paymentOk"), method = RequestMethod.GET)
	public String paymentOkGet(HttpSession session, Model model) {
		ReservationVo reservationVo = (ReservationVo) session.getAttribute("reservationVo");
		
		// 예약완료 처리
		reservationService.setReservationPaymentOk(reservationVo.getReservationNo());
		// 예약 정보, 사용자 정보 넘기기
		RoomVo roomVo = roomService.getRoom(reservationVo.getRoomIdx()); 
		HotelVo hotelVo = hotelService.getHotel(roomVo.getHotelIdx()); 
		reservationVo = reservationService.getReservation(reservationVo.getReservationNo());
		model.addAttribute("reservationVo", reservationVo);
		model.addAttribute("roomVo", roomVo);
		model.addAttribute("hotelVo", hotelVo);
		session.removeAttribute("reservationVo");
		return "reservation/paymentOk";
	}
	
	
	// 마이페이지 예약상태 상세보기
	@RequestMapping(value = "/reservationDetail/{reservationNo}", method = RequestMethod.GET)
	public String reservationStatusGet(HttpSession session, Model model, @PathVariable("reservationNo") String reservationNo) {
		ReservationVo reservationVo = reservationService.getReservation(reservationNo);
		RoomVo roomVo = roomService.getRoom(reservationVo.getRoomIdx());
		HotelVo hotelVo = hotelService.getHotel(roomVo.getHotelIdx());
		
		session.setAttribute("reservationVo", reservationVo);
		model.addAttribute("reservationVo", reservationVo);
		model.addAttribute("roomVo", roomVo);
		model.addAttribute("hotelVo", hotelVo);
		return "reservation/reservationDetail";
	}
	
	
	// 마이페이지 결제 처리
	@RequestMapping(value = "/payment/{reservationNo}", method = RequestMethod.GET)
	public String paymentGet(HttpSession session, Model model, @PathVariable("reservationNo") String reservationNo) {
		String mid = session.getAttribute("sMid") + "";
		if(mid == null || mid.equals("")) return "redirect:/message/loginRequired"; // 로그인 체크
		
		ReservationVo vo = reservationService.getReservation(reservationNo);
		RoomVo roomVo = roomService.getRoom(vo.getRoomIdx());
		HotelVo hotelVo = hotelService.getHotel(roomVo.getHotelIdx());
		
		model.addAttribute("hotelVo", hotelVo);
		model.addAttribute("vo", vo);
		
		System.out.println("hotelVo" + hotelVo);
		System.out.println("vo" + vo);
		return "reservation/payment";
	}
	
	
}
