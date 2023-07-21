package com.roy.hspersona.config;

import com.roy.hspersona.common.Constant;
import org.springframework.stereotype.Repository;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;

/**
 * @author roy
 * @date 2021/12/6
 * @desc
 */
@Repository
public class ParamConfig {

    private final String configFile = "/conf/params.properties";

    public void init(){
        FileInputStream istream = null;
        try {
            Properties props = new Properties();
            String path = ParamConfig.class.getResource("/").getPath() + configFile;
            istream = new FileInputStream(path);
            props.load(istream);
            if (props.get("params.projectname") == null || props.get("params.projectname").equals("")) {
                Constant.setProjectName("");
            } else {
                Constant.setProjectName("/" + props.get("params.projectname"));
            }
            Constant.setVersion((String) props.get("params.version"));
            Constant.FTP_USERNAME = (String) props.get("ftp.username");
            Constant.FTP_PASSWORD = (String) props.get("ftp.password");
            Constant.FTP_PORT = Integer.parseInt((String) props.get("ftp.port"));
            Constant.FTP_IP = (String) props.get("ftp.ip");
            Constant.FTP_HTTP_PORT = Integer.parseInt((String) props.get("ftp.http.port"));
            Constant.FTP_HTTP_ALIAS = (String) props.get("ftp.http.alias");
            System.out.println("..........系统项目名称：" + Constant.projectName);
            System.out.println("..........系统版本号：" + Constant.version);
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            try {
                istream.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
}
