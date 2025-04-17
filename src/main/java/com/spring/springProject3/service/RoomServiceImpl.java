package com.spring.springProject3.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.springProject3.dao.RoomDao;
import com.spring.springProject3.vo.RoomVo;

@Service
public class RoomServiceImpl implements RoomService {

	@Autowired
	RoomDao roomDao;

	// 객실 등록 처리
	@Override
	public int setRoomInput(RoomVo vo, MultipartFile thumbnailFile, MultipartHttpServletRequest imageFiles) {
		
		
		return 0;
	}
}
