package com.spring.springProject3.service;

import java.util.List;

import com.spring.springProject3.vo.BoardReplyVo;
import com.spring.springProject3.vo.BoardVo;

public interface BoardService {

	int getBoardTotRecCnt();

	List<BoardVo> getBoardList(int startIndexNo, int pageSize, String search, String searchString);

	BoardVo getBoardContent(int idx);

	void setBoardReadNumPlus(int idx);

	int setBoardInputOk(BoardVo vo);

	int setBoardDelete(int idx);

	void imgCheck(String content);

	void imgDelete(String content);

	void imgBackup(String content);

	int setBoardUpdate(BoardVo vo);

	int setBoardGoodCheck1(int idx);

	int setBoardGoodCheck2(int idx, int goodCnt);

	BoardVo getPreNextSearch(int idx, String preNext);

	List<BoardReplyVo> getBoardReply(int idx);

	int setBoardReplyInput(BoardReplyVo vo);

	int setBoardReplyDelete(int idx);

	int setBoardReplyUpdateCheckOk(BoardReplyVo vo);

}
