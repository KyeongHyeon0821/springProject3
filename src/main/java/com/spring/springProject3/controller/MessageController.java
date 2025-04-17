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
            @RequestParam(name="nickName", defaultValue="", required=false) String nickName
    	) {
  
		if(msgFlag.equals("memberJoinOk")) {
			model.addAttribute("message", "ȸ�� ������ �Ϸ�Ǿ����ϴ�.\\n�α��� �� ����ϼ���.");
			model.addAttribute("url", "member/memberLogin");
		}
		else if(msgFlag.equals("idCheckNo")) {
			model.addAttribute("message", "���̵� �ߺ��Ǿ����ϴ�.\\nȮ���Ͻð� �ٽ� �Է��ϼ���.");
			model.addAttribute("url", "member/memberJoin");
		}
		else if(msgFlag.equals("memberJoinNo")) {
			model.addAttribute("message", "ȸ�� ���Կ� �����Ͽ����ϴ�.\\n�ٽ� ȸ������ ���ּ���.");
			model.addAttribute("url", "member/memberJoin");
		}
		else if(msgFlag.equals("memberLoginOk")) {
		    if (nickName == null || nickName.equals("")) {
		        nickName = (String) session.getAttribute("sNickName"); // ���ǿ��� ��ü�� ������
		    }
		    model.addAttribute("message", nickName + " ȸ���� �α��� �Ǽ̽��ϴ�.");
		    model.addAttribute("url", "member/memberMyPage");
		}
		else if(msgFlag.equals("memberLoginNo")) {
			model.addAttribute("message", "���̵� �Ǵ� ��й�ȣ�� �߸� �Ǿ����ϴ�.\\n���̵�� ��й�ȣ�� ��Ȯ�� �Է��� �ּ���.");
			model.addAttribute("url", "member/memberLogin");
		}
		else if(msgFlag.equals("memberLogoutOk")) {
			model.addAttribute("message", "�α׾ƿ� �Ǿ����ϴ�.");
			model.addAttribute("url", "member/memberLogin");
		}
		else if(msgFlag.equals("pwdCheckNo")) {
			model.addAttribute("message", "��й�ȣ�� Ʋ���ϴ�. �ٽ� Ȯ���� �ּ���.");
			model.addAttribute("url", "member/pwdCheck/d");
		}
		else if(msgFlag.equals("pwdCheckNoP")) {
			model.addAttribute("message", "��й�ȣ�� Ʋ���ϴ�. �ٽ� Ȯ���� �ּ���.");
			model.addAttribute("url", "member/pwdCheck/p");
		}
		else if(msgFlag.equals("pwdCheckNoU")) {
			model.addAttribute("message", "��й�ȣ�� Ʋ���ϴ�. �ٽ� Ȯ���� �ּ���.");
			model.addAttribute("url", "member/pwdCheck/u");
		}
		else if(msgFlag.equals("memberDeleteCheck")) {
			model.addAttribute("message", "Ż��ó���� �Ϸ�Ǿ����ϴ�.");
			session.invalidate();
			model.addAttribute("url", "member/memberLogin");
		}
		else if(msgFlag.equals("pwdChangeOk")) {
			model.addAttribute("message", "��й�ȣ�� ������ �Ϸ�Ǿ����ϴ�.\\n�ٽ� �α����� �ּ���.");
			session.invalidate();
			model.addAttribute("url", "member/memberLogin");
		}
		else if(msgFlag.equals("pwdChangeNo")) {
			model.addAttribute("message", "��й�ȣ ���濡 �����Ͽ����ϴ�.");
			model.addAttribute("url", "member/pwdCheck/p");
		}
		else if(msgFlag.equals("memberUpdateOk")) {
			model.addAttribute("message", "ȸ�� ���� ������ �Ϸ�Ǿ����ϴ�.");
			model.addAttribute("url", "member/memberMyPage");
		}
		else if(msgFlag.equals("memberUpdateNo")) {
			model.addAttribute("message", "ȸ�� ���� ������ �����Ͽ����ϴ�.");
			model.addAttribute("url", "member/memberUpdate");
		}
		else if(msgFlag.equals("loginLockTimer")) {
		    Long remaining = (Long) session.getAttribute("remainingTime");
		    if (remaining == null) remaining = 60L; // �⺻�� 1��
		    model.addAttribute("message", "�α��� ���� 5ȸ�� ���� �α��� ���� ���Դϴ�.\\n" + remaining + "�� �� �ٽ� �õ����ּ���.");
		    model.addAttribute("url", "member/memberLogin");
		}
		else if(msgFlag.equals("memberFindPwdOk")) {
		    model.addAttribute("message", "�ӽ� ��й�ȣ�� �̸��Ϸ� ���۵Ǿ����ϴ�.");
		    model.addAttribute("url", "member/memberLogin");
		}
		else if(msgFlag.equals("memberFindPwdNo")) {
		    model.addAttribute("message", "��ġ�ϴ� ȸ�� ������ �����ϴ�.");
		    model.addAttribute("url", "member/memberFindPwd");
		}
		else if(msgFlag.equals("loginRequired")) {
		    model.addAttribute("message", "�α����� �ʿ��մϴ�.");
		    model.addAttribute("url", "member/memberLogin");
		}


		return "include/message";
    }
}
