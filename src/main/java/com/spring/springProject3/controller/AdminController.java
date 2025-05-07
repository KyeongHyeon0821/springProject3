package com.spring.springProject3.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.springProject3.common.Pagination;
import com.spring.springProject3.service.AdminService;
import com.spring.springProject3.service.HotelService;
import com.spring.springProject3.service.MemberService;
import com.spring.springProject3.service.ReservationService;
import com.spring.springProject3.service.ReviewService;
import com.spring.springProject3.vo.HotelVo;
import com.spring.springProject3.vo.InquiryVo;
import com.spring.springProject3.vo.MemberVo;
import com.spring.springProject3.vo.PageVo;
import com.spring.springProject3.vo.ReservationListVo;
import com.spring.springProject3.vo.ReviewVo;
import com.spring.springProject3.vo.RoomVo;

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
	ReviewService reviewService;
	
	@Autowired
	Pagination pagination;
	
	@Autowired
	ReservationService reservationService;
	
	
	@GetMapping("/adminMain")
	public String admiMainGet() {
		// 결제 안 한 예약 자동 취소 ('대기중' -> '예약취소' 예약 당일 안 했을 경우)
		reservationService.setReservationAutoCancel();
		// 예약상태 업데이트(체크아웃 날짜가 오늘 날짜랑 같거나 이전이면 이용완료 처리(오늘 날짜부터 새 예약을 받을 수 있도록)
		reservationService.setReservationUpdateToDone();
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
	@GetMapping("/member/memberList/{section}")
	public String memberListGet(Model model,@PathVariable int section) {
		List<MemberVo> vos = memberService.getMemberList(section);
		model.addAttribute("vos",vos);
		model.addAttribute("section", section);
		
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
	@RequestMapping("/hotel/hotelList")
	public String hotelListGet(Model model, HttpSession session,
			 @RequestParam(name="startIndexNo", defaultValue = "0", required = false) int startIndexNo,
			 @RequestParam(name="pageSize", defaultValue = "6", required = false) int pageSize
		) {
		String mid = session.getAttribute("sMid") + "";
		List<HotelVo> vos = adminService.getAdHotelList(startIndexNo, pageSize);
		
		if(!mid.equals("")) {
			List<Integer> likedHotelListIdx = hotelService.getLikedHotelListIdx(mid);
			model.addAttribute("likedHotelListIdx", likedHotelListIdx);
		}
		model.addAttribute("vos", vos);
		return "admin/hotel/hotelList";
	}
	
	
	// 선택한 호텔 전체적으로 상태 변경하기
	@ResponseBody
	@RequestMapping(value = "/hotel/hotelStatusSelectCheck", method = RequestMethod.POST)
	public String hotelStatusSelectCheckPost(String idxSelectArray, String statusSelect) {
		System.out.println("idxSelectArray:" + idxSelectArray + ", statusSelect: " + statusSelect);
		return adminService.setHotelStatusSelectCheck(idxSelectArray, statusSelect);
	}
	
	// 객실(room) 리스트 보기
	@RequestMapping(value = "/room/roomList", method = RequestMethod.GET)
	public String adminRoomListGet(Model model, HttpSession session, @RequestParam int hotelIdx) {
		String mid = session.getAttribute("sMid") + "";
		List<RoomVo> vos = adminService.getAdminRoomList(hotelIdx);
		
		model.addAttribute("vos", vos);
		return "/admin/room/roomList";
	}
	
	// 객실(room) 상세화면 보기
	@ResponseBody
	@RequestMapping(value = "/room/roomDetail/{idx}", method = RequestMethod.GET)
	public RoomVo roomDetailGet(@PathVariable int idx) {
		RoomVo vo = adminService.getRoomDetailSearch(idx);
		
		return vo;
	}

	
	
	
	// 선택한 객실 전체적으로 상태 변경하기
	@ResponseBody
	@RequestMapping(value = "/room/roomStatusSelectCheck", method = RequestMethod.POST)
	public String roomStatusSelectCheckPost(String idxSelectArray, String statusSelect) {
		System.out.println("idxSelectArray:" + idxSelectArray + ", statusSelect: " + statusSelect);
		return adminService.setRoomStatusSelectCheck(idxSelectArray, statusSelect);
	}
	
	
	//관리자 실시간 1:1 채팅창 폼 보여주기
	@GetMapping("/liveChat/adminChat")
	public String adminChatGet() {
		return "admin/liveChat/adminChat";
	}
	
	//리뷰 리스트 불러오기
	@GetMapping("/review/adReviewList")
	public String memberReviewFormGet(Model model, HttpSession session,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "8", required = false) int pageSize,
			@RequestParam(name="choice", defaultValue = "전체", required = false) String choice
			) {
		String mid = session.getAttribute("sMid") + "";
		
		//페이징 처리
		
		// 리뷰가 달린 객실과 리뷰들의 정보를 가져올 수 있도록 한다.
		PageVo pageVo = pagination.getTotRecCnt(pag,pageSize,"adminReview","",choice);	// (페이지번호,한 페이지분량,section,part,검색어)
		List<ReservationListVo> rsVos = reviewService.getRoomUsedAllList(pageVo.getStartIndexNo(),pageSize, choice, mid);
		List<ReviewVo> rVos = reviewService.getRoomReviewAllList();
		model.addAttribute("rsVos", rsVos);
		model.addAttribute("rVos", rVos);
		model.addAttribute("pageVo", pageVo);
		model.addAttribute("choice", choice);
		// sMid select * from reservation where mid = #{sMid} and status = '이용완료';
		System.out.println("rsVos : " + rsVos);
		System.out.println("rVos : " + rVos);
		
		return "admin/review/adReviewList";
	}
	
	// 리뷰 삭제하기
	@ResponseBody
	@PostMapping("/reviewDelete")
	public String reviewDeletePost(String reviewStr) {
		
		return adminService.setReviewDelete(reviewStr);
	}
	
}

