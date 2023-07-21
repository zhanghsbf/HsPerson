package com.roy.hspersona.util;

import java.security.MessageDigest;

/**
 * @author roy
 * @date 2021/12/2
 * @desc
 */
public class MD5Util {
    public static String getMD5Code(String res) {
        char[] hexDigits = {
                '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
                'a', 'b', 'c', 'd', 'e', 'f' };
        try {
            byte[] strTemp = res.getBytes();
            MessageDigest mdTemp = MessageDigest.getInstance("MD5");
            mdTemp.update(strTemp);
            byte[] md = mdTemp.digest();
            int j = md.length;
            char[] str = new char[j * 2];
            int k = 0;
            for (int i = 0; i < j; i++) {
                byte byte0 = md[i];
                str[k++] = hexDigits[byte0 >>> 4 & 0xF];
                str[k++] = hexDigits[byte0 & 0xF];
            }
            String dd = new String(str);
            return dd;
        } catch (Exception e) {
            return null;
        }
    }
}
