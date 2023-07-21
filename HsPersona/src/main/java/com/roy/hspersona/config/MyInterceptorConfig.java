package com.roy.hspersona.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import sun.net.www.content.image.png;

import javax.annotation.Resource;

/**
 * @author roy
 * @date 2021/12/12
 * @desc
 */
@Configuration
public class MyInterceptorConfig  implements WebMvcConfigurer {

    @Resource
    private LoginInterceptor loginInterceptor;
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(loginInterceptor)
                .excludePathPatterns("/","/index","/error","/system/login/**",
                        "/web/**","/**/*.js","/**/*.css","/**.html",
                        "/**/*.png ","/**/*.jpg","/**/*.png","/**.ico");
    }
}
