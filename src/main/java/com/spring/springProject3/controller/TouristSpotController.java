package com.spring.springProject3.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.springProject3.service.TouristSpotService;
import com.spring.springProject3.vo.TouristSpotVo;

@Controller
public class TouristSpotController {

    @Autowired
    TouristSpotService touristSpotService;

    // 특정 호텔 주변 관광지 목록 가져오기
    @GetMapping("/hotelDetail")
    public String hotelDetail(@RequestParam("idx") int hotelIdx, Model model) {
        List<TouristSpotVo> touristList = touristSpotService.getSpotsByHotelIdx(hotelIdx);
        model.addAttribute("touristList", touristList);
        return "hotel/hotelDetail";
    }
    
    // 관광지 등록 폼 이동
    @GetMapping("/touristInput")
    public String touristInputForm(@RequestParam("hotelIdx") int hotelIdx, Model model) {
        model.addAttribute("hotelIdx", hotelIdx); // 호텔 정보 연동
        return "tourist/touristSpotInput"; // JSP 위치: /WEB-INF/views/tourist/touristSpotInput.jsp
    }

    // 관광지 등록 처리
    @PostMapping("/touristInput")
    public String touristInputSubmit(TouristSpotVo vo) {
        touristSpotService.insertTouristSpot(vo);
        return "redirect:/hotel/hotelDetail?idx=" + vo.getHotelIdx(); // 등록 후 해당 호텔 상세로 이동
    }
}
