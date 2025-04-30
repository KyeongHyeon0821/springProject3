package com.spring.springProject3.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class HomeController {
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model,
			@RequestParam(name="checkinDate", defaultValue = "", required = false) String checkinDate,
      @RequestParam(name="checkoutDate", defaultValue = "", required = false) String checkoutDate,
      @RequestParam(name="guestCount", defaultValue = "1", required = false) int guestCount,
      @RequestParam(name="petCount", defaultValue = "1", required = false) int petCount
		) {
		LocalDate today = LocalDate.now();
    LocalDate tomorrow = today.plusDays(1);

    checkinDate = today.toString();      // ex) "2025-04-24"
    checkoutDate = tomorrow.toString();  // ex) "2025-04-25"
    model.addAttribute("checkinDate", checkinDate);
    model.addAttribute("checkoutDate", checkoutDate);
    model.addAttribute("guestCount", guestCount);
    model.addAttribute("petCount", petCount);
		
		return "home";
	}
	
	//ckeditor에서의 그림파일 업로드시 수행처리되는 메소드
	@RequestMapping(value = "/imageUpload")
	public void imageUploadGet(MultipartFile upload, HttpServletRequest request, HttpServletResponse response) throws IOException {
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/");
		String oFileName = upload.getOriginalFilename();
		
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
		oFileName = sdf.format(date) + "_" + oFileName;
		
		byte[] bytes = upload.getBytes();
		FileOutputStream fos = new FileOutputStream(new File(realPath + oFileName));
		fos.write(bytes);
		
		PrintWriter out = response.getWriter();
		String fileUrl = request.getContextPath() + "/data/ckeditor/" + oFileName;
		out.println("{\"originalFilename\":\""+oFileName+"\",\"uploaded\":1,\"url\":\""+fileUrl+"\"}");
		out.flush();
		
		fos.close();
	}
	
}
