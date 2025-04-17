package com.spring.springProject3.service;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.springProject3.vo.RoomVo;

public interface RoomService {

	int setRoomInput(RoomVo vo, MultipartFile thumbnailFile, MultipartHttpServletRequest imageFiles);

}
