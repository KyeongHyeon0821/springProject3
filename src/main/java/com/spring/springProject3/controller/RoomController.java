package com.spring.springProject3.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.springProject3.service.RoomService;
import com.spring.springProject3.vo.RoomVo;

@Controller
@RequestMapping("/room")
public class RoomController {
	
	@Autowired
	RoomService roomService;
	
	// 객실 등록 폼 보기
	@RequestMapping(value = ("/roomInput"), method = RequestMethod.GET)
	public String roomInputGet(Model model, @RequestParam("hotelIdx") int hotelIdx) {
		model.addAttribute("hotelIdx", hotelIdx);
		return "room/roomInput";
	}
	
	// 객실 등록 처리
	@RequestMapping(value = ("/roomInput"), method = RequestMethod.POST)
	public String roomInputPost(RoomVo vo, MultipartFile thumbnailFile, MultipartHttpServletRequest imageFiles) {
		int res = roomService.setRoomInput(vo, thumbnailFile, imageFiles);
		
		if(res !=0 ) return "redirect:/message/roomInputOk?hotelIdx="+vo.getHotelIdx();
		else return "redirect:/message/roomInputNo?hotelIdx="+vo.getHotelIdx();
	}
	
	
}
