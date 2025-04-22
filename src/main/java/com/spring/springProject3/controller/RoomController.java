package com.spring.springProject3.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
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
	@Transactional
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
	
	
	// 객실 상세 보기
	@RequestMapping(value = ("/roomDetail"), method = RequestMethod.GET)
	public String roomDetailGet(Model model, @RequestParam("roomIdx") int roomIdx) {
		
		RoomVo vo = roomService.getRoom(roomIdx);
		List<OptionVo> roomOptionList = roomService.getRoomOptionList(roomIdx);
				
		model.addAttribute("vo", vo);
		model.addAttribute("roomOptionList", roomOptionList);
		return "room/roomDetail";
	}
	
	// 객실 수정 폼 보기
	@RequestMapping(value = ("/roomUpdate"), method = RequestMethod.GET)
	public String roomUpdateGet(Model model, @RequestParam("roomIdx") int roomIdx) {
		
		RoomVo vo = roomService.getRoom(roomIdx);
		List<OptionVo> optionList = roomService.getOptionList(); // 전체 옵션 리스트
		List<OptionVo> roomOptionList = roomService.getRoomOptionList(roomIdx);  // 체크된 옵션 리스트
		HotelVo hotelVo = hotelService.getHotel(vo.getHotelIdx());
		
		
		model.addAttribute("vo", vo);
		model.addAttribute("hotelVo", hotelVo);
		model.addAttribute("optionList", optionList);
		model.addAttribute("roomOptionList", roomOptionList);
		
		return "room/roomUpdate";
	}
	
}
