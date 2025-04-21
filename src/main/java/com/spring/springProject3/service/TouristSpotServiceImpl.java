package com.spring.springProject3.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.springProject3.dao.TouristSpotDao;
import com.spring.springProject3.vo.TouristSpotVo;

@Service
public class TouristSpotServiceImpl implements TouristSpotService {

    @Autowired
    TouristSpotDao touristSpotDao;

	@Override
	public TouristSpotVo getSpotsNearHotel(String lat, String lng) {
		return touristSpotDao.getSpotsNearHotel(lat, lng);
	}
}
