package com.spring.springProject3.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.springProject3.vo.HotelVo;

public interface HotelService {

	List<HotelVo> getHotelList();

	int setHotelInput(HotelVo vo, MultipartFile thumbnailFile);

	HotelVo getHotel(int idx);

}
