package com.spring.springProject3.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MessageController {

    @RequestMapping(value = "/message/{msgFlag}", method = RequestMethod.GET)
    public String getMessage(Model model, @PathVariable String msgFlag,
            HttpSession session,
            // @RequestParam(name="mid", defaultValue="", required=false) String mid
            @RequestParam(name="nickName", defaultValue="", required=false) String nickName
    	) {
  
		if(msgFlag.equals("memberJoinOk")) {
			model.addAttribute("message", "회원 가입이 완료되었습니다.\\n로그인후 사용하세요.");
			model.addAttribute("url", "member/memberLogin");
		}
		else if(msgFlag.equals("memberJoinNo")) {
			model.addAttribute("message", "회원 가입에 실패하였습니다.\\n다시 회원가입 해주세요.");
			model.addAttribute("url", "member/memberJoin");
		}
		else if(msgFlag.equals("memberLoginOk")) {
		    if (nickName == null || nickName.equals("")) {
		        nickName = (String) session.getAttribute("sNickName"); // 세션에서 대체로 꺼내기
		    }
		    model.addAttribute("message", nickName + " 회원님 로그인 되셨습니다.");
		    model.addAttribute("url", "member/memberMain");
		}
		else if(msgFlag.equals("memberLoginNo")) {
			model.addAttribute("message", "로그인에 실패하였습니다. 다시 로그인해 주세요.");
			model.addAttribute("url", "member/memberLogin");
		}
		else if(msgFlag.equals("memberLogoutOk")) {
			model.addAttribute("message", "로그아웃 되었습니다.");
			model.addAttribute("url", "member/memberLogin");
		}
		else if(msgFlag.equals("pwdCheckNo")) {
			model.addAttribute("message", "비밀번호가 틀립니다. 다시 확인해 주세요.");
			model.addAttribute("url", "member/pwdCheck/d");
		}
		else if(msgFlag.equals("pwdCheckNoP")) {
			model.addAttribute("message", "비밀번호가 틀립니다. 다시 확인해 주세요.");
			model.addAttribute("url", "member/pwdCheck/p");
		}
		else if(msgFlag.equals("pwdCheckNoU")) {
			model.addAttribute("message", "비밀번호가 틀립니다. 다시 확인해 주세요.");
			model.addAttribute("url", "member/pwdCheck/u");
		}
		else if(msgFlag.equals("memberDeleteCheck")) {
			model.addAttribute("message", "탈퇴처리가 완료되었습니다.");
			session.invalidate();
			model.addAttribute("url", "member/memberLogin");
		}
		else if(msgFlag.equals("pwdChangeOk")) {
			model.addAttribute("message", "비밀번호를 변경이 완료되었습니다.\\n다시 로그인해 주세요.");
			session.invalidate();
			model.addAttribute("url", "member/memberLogin");
		}
		else if(msgFlag.equals("pwdChangeNo")) {
			model.addAttribute("message", "비밀번호 변경에 실패하였습니다.");
			model.addAttribute("url", "member/pwdCheck/p");
		}
		else if(msgFlag.equals("memberUpdateOk")) {
			model.addAttribute("message", "회원 정보 수정이 완료되었습니다.");
			model.addAttribute("url", "member/memberMain");
		}
		else if(msgFlag.equals("memberUpdateNo")) {
			model.addAttribute("message", "회원 정보 수정에 실패하였습니다.");
			model.addAttribute("url", "member/memberUpdate");
		}
		return "include/message";
    }
}
