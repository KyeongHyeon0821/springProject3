package com.spring.springProject3.service;

import java.util.List;

import com.spring.springProject3.vo.ReservationListVo;
import com.spring.springProject3.vo.RoomVo;

public interface ReviewService {

	List<ReservationListVo> getRoomUsedList(String mid);

}
