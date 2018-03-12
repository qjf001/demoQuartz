package com.qjf.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * @Author:Tin
 * @Date: create in 2018/3/12 17:55
 * @Description:
 */
@Controller
@RequestMapping
public class TopController {

    @RequestMapping(value="/",method = RequestMethod.GET)
    public String login(){
        return "/admin/layuiAdmin/main";
    }

    @RequestMapping(value="admin/main",method = RequestMethod.GET)
    public String main(){
        return "/admin/layuiAdmin/main";
    }

}
