package com.spring.springProject3.service;

import com.spring.springProject3.vo.TouristSpotVo;

public interface TouristSpotService {
	
	TouristSpotVo getSpotsNearHotel(String lat, String lng);
}
