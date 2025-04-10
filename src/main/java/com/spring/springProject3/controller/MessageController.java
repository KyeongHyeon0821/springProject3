package com.spring.springProject3.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/message")
public class MessageController {
  
  @RequestMapping("/memberJoinOk")
  public String memberJoinOk() {
    return "message/memberJoinOk";
  }
}
