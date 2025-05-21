package com.spring.springProject3.controller;

import java.util.List;

import javax.mail.MessagingException;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.springProject3.common.ProjectProvide;
import com.spring.springProject3.service.CouponService;
import com.spring.springProject3.service.MemberService;
import com.spring.springProject3.vo.CouponVo;

@RequestMapping("/coupon")
@Controller
public class CouponController {
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	CouponService couponService;
	
	@Autowired
	ProjectProvide projectProvide;
	
	

	// 쿠폰관리 폼보기(사용자)
	@RequestMapping(value = "/couponForm", method = RequestMethod.GET)
	public String couponFormGet(Model model, HttpSession session) {
		String mid = (String) session.getAttribute("sMid");
		String email = memberService.getMemberIdCheck(mid).getEmail();
		List<CouponVo> couponVos = couponService.getUseCouponList();
		model.addAttribute("couponVos", couponVos);
		model.addAttribute("email", email);
		
		List<CouponVo> uVos = couponService.getCouponMidList(mid);
		model.addAttribute("uVos", uVos);
		return "coupon/couponForm";
	}
	
	@RequestMapping(value = "/couponContent/{idx}", method = RequestMethod.GET)
	public String couponContentGet(Model model, @PathVariable int idx) {
		CouponVo vo = couponService.getCouponContent(idx);
		model.addAttribute("vo", vo);
		return "coupon/couponContent";
	}
	
	// 쿠폰 중복 발급 체크
	@ResponseBody
	@RequestMapping(value = "/isCouponAlreadyIssued", method = RequestMethod.POST)
	public String couponCheckPost(String couponCode, HttpSession session) {
		String mid = session.getAttribute("sMid") + "";
		return couponService.getCouponIssuedCheck(mid, couponCode) + "";
	}
	
	
	
	// 사용자 쿠폰 발행을 위한 QR코드 생성및 쿠폰발송 메일보내기
	@ResponseBody
	@RequestMapping(value = "/couponIssue", method = RequestMethod.POST)
	public String couponFormPost(int idx, String mid, String email, String couponCode) throws MessagingException {
		CouponVo vo = couponService.getCouponContent(idx);
		vo.setMid(mid);
		vo.setEmail(email);
		vo.setUserCouponCode(couponCode);
		
		// Qr코드 생성
		String qrCodeName = projectProvide.newNameCreate(2) + vo.getMid();
		
		// QR코드안의 한글 인코딩
		String qrCodeImage = "";
		qrCodeImage = "쿠폰명 : " + vo.getCouponName() + "\n";
		qrCodeImage += "사용자 아이디 : " + vo.getMid() + "\n";
		qrCodeImage += "사용자 이메일 : " + vo.getEmail() + "\n";
		qrCodeImage += "쿠폰코드 : " + vo.getCouponCode() + "\n";
		qrCodeImage += "할인율(원) : ";
		if(vo.getDiscountType().equals("P")) qrCodeImage += vo.getDiscountValue() + "%\n";
		else qrCodeImage += vo.getDiscountValue() + "원\n";
		qrCodeImage += "쿠폰 발급날짜 : " + qrCodeName.substring(0,4) + "년, " + qrCodeName.substring(4,6) + "월, " + qrCodeName.substring(6,8) + "일\n";
		qrCodeImage += "쿠폰 사용만료일 : " + vo.getExpiryDate();
		projectProvide.qrCodeCreate(qrCodeName, qrCodeImage, "couponQrcode");	// Qr코드 만들기
		
		// 메일 전송처리
		String couponQrcode = qrCodeName+".png";	// couponQrcode 경로에 저장된 qrcode파일명
		projectProvide.qrMailSend(vo.getEmail(), vo.getCouponName(), vo.getPhoto(), couponQrcode);
		
		// 발급된 쿠폰과 사용자의 정보를 DB에 저장처리
		vo.setCouponQrcode(couponQrcode);
		System.out.println("vo(couponUser) : " + vo);
		return couponService.setCouponUserInformation(vo) + "";
	}
	
}
