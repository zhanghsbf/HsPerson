package com.roy.hspersona;

import com.roy.hspersona.taglib.SysTagDialect;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

/**
 * @author roy
 * @date 2021/11/29
 * @desc
 */
@SpringBootApplication
@MapperScan({"com.roy.hspersona"})
public class Application {
    public static void main(String[] args) {
        SpringApplication.run(Application.class);
    }

    @Bean
    public SysTagDialect getSysTagDailect(){
        return new SysTagDialect();
    }
}
