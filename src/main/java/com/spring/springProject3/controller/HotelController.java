package com.spring.springProject3.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import com.spring.springProject3.service.HotelService;
import com.spring.springProject3.vo.HotelVo;

@RequestMapping("/hotel")
@Controller
public class HotelController {

	@Autowired
	HotelService hotelService;
	
	// 호텔 리스트
	@RequestMapping("/hotelList")
	public String hotelListGet(Model model) {
		List<HotelVo> vos = hotelService.getHotelList();
		model.addAttribute("vos", vos);
		return "hotel/hotelList";
	}
	
	// 호텔 등록폼 보기
	@RequestMapping(value =  "/hotelInput", method = RequestMethod.GET)
	public String hotelInputGet() {
		return "hotel/hotelInput";
	}
	
	// 호텔 등록 처리하기
	@RequestMapping(value =  "/hotelInput", method = RequestMethod.POST)
	public String hotelInputPost(HotelVo vo, MultipartFile thumbnailFile) {
		int res = hotelService.setHotelInput(vo, thumbnailFile);
		if(res !=0 ) return "redirect:/message/hotelInputOk";
		
		return "redirect:/message/hotelInputNo";
	}
	
	// ckeditor에서의 그림 파일 업로드시 수행처리되는 메소드 
	@RequestMapping(value =  "/hotelImageUpload")
	public void imageUploadGet(MultipartFile upload, HttpServletRequest request, HttpServletResponse response, String mid) throws IOException {
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/hotelImages/");
		String oFileName = upload.getOriginalFilename(); // 원본 파일 이름 가져오기
		UUID uid = UUID.randomUUID();
		
		String sFileName = mid + "_" + uid.toString().substring(0, 8) + "_" + oFileName; // 호텔 등록자 아이디 + uuid + 파일명 + "_" + oFileName;
		
		byte[] bytes = upload.getBytes();
		FileOutputStream fos = new FileOutputStream(new File(realPath + sFileName)); // 실제 경로에 파일 저장
		fos.write(bytes);
		
		PrintWriter out = response.getWriter();
		String fileUrl = request.getContextPath() + "/data/hotelImages/" + sFileName;  // 매핑 경로
		out.println("{\"originalFilename\":\""+oFileName+"\",\"uploaded\":1,\"url\":\""+fileUrl+"\"}");
		out.flush();
		
		fos.close();
	}
	
}
