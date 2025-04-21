package com.spring.springProject3.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.spring.springProject3.service.TouristSpotService;
import com.spring.springProject3.vo.TouristSpotVo;

@RestController
@RequestMapping("/tourist")
public class TouristSpotController {

    @Autowired
    TouristSpotService touristSpotService;

    // 카카오맵에서 위도/경도 기준으로 주변 관광지 조회
    @GetMapping("/nearby")
    public TouristSpotVo getNearbySpots(@RequestParam("lat") String lat, @RequestParam("lng") String lng) {
        return touristSpotService.getSpotsNearHotel(lat, lng);
    }
}
