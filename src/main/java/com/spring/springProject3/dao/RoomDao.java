package com.spring.springProject3.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.springProject3.vo.OptionVo;
import com.spring.springProject3.vo.RoomVo;

public interface RoomDao {

	int setRoomInput(@Param("vo") RoomVo vo);

	List<OptionVo> getOptionList();

	int getMaxIdx();

	int setRoomOptions(@Param("roomIdx") int roomIdx, @Param("optionIdx") int optionIdx);


}
