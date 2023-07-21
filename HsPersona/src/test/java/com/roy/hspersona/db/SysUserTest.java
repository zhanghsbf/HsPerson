package com.roy.hspersona.db;

import com.roy.hspersona.system.entity.SysUser;
import com.roy.hspersona.system.mapper.SysUserMapper;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import javax.annotation.Resource;

/**
 * @author roy
 * @date 2021/11/30
 * @desc
 */

@SpringBootTest
public class SysUserTest {

    @Resource
    private SysUserMapper sysUserMapper;

    @Test
    public void dbTest(){
        for (SysUser sysUser : sysUserMapper.selectList(null)) {
            System.out.println(sysUser);
        }
    }
}
