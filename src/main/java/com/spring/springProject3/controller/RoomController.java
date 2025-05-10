package com.spring.springProject3.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.springProject3.service.HotelService;
import com.spring.springProject3.service.RoomService;
import com.spring.springProject3.vo.HotelVo;
import com.spring.springProject3.vo.OptionVo;
import com.spring.springProject3.vo.RoomVo;

@Controller
@RequestMapping("/room")
public class RoomController {
	
	@Autowired
	RoomService roomService;
	
	@Autowired
	HotelService hotelService;
	
	// 객실 등록 폼 보기
	@RequestMapping(value = ("/roomInput"), method = RequestMethod.GET)
	public String roomInputGet(Model model, @RequestParam("hotelIdx") int hotelIdx) {
		HotelVo vo = hotelService.getHotel(hotelIdx);
		List<OptionVo> optionList = roomService.getOptionList();
				
		model.addAttribute("hotelIdx", hotelIdx);
		model.addAttribute("vo", vo);
		model.addAttribute("optionList", optionList);
		return "room/roomInput";
	}
	
	// 객실 등록 처리
	@RequestMapping(value = ("/roomInput"), method = RequestMethod.POST)
	public String roomInputPost(RoomVo vo, MultipartFile thumbnailFile, MultipartHttpServletRequest imageFiles,
			@RequestParam(name="options", required = false) String[] options
		) {
		// 썸네일, 그 외 이미지, 객실 데이터 저장(DB)
		int res = roomService.setRoomInput(vo, thumbnailFile, imageFiles);
		// 객실-옵션 데이터 저장(DB)
		int roomIdx = roomService.getMaxIdx();
		if(options != null) {
			for(String optionIdxStr : options) {
				res = roomService.setRoomOptions(roomIdx, Integer.parseInt(optionIdxStr));
			}
		}
		
		if(res !=0 ) return "redirect:/message/roomInputOk?hotelIdx="+vo.getHotelIdx();
		else return "redirect:/message/roomInputNo?hotelIdx="+vo.getHotelIdx();
	}
	
	
}
