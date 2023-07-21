package com.roy.hspersona.template.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @author roy
 * @date 2021/11/30
 * @desc
 */
@Controller
@RequestMapping("temp")
public class TemplateController {

    @RequestMapping("toTest")
    public String toTestHtml(){
        return "test";
    }
}
