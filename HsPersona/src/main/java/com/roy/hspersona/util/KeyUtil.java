package com.roy.hspersona.util;

import java.math.BigInteger;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Random;

/**
 * @author roy
 * @date 2021/12/2
 * @desc
 */
public class KeyUtil {
    public static String getKey() {
        Date date = Calendar.getInstance().getTime();
        DateFormat df = new SimpleDateFormat("yyMMddHHmmssSSS");
        Random random = new Random();
        String s1 = Integer.toString(Math.abs(random.nextInt()) % 100000 + 100000);
        String s2 = Integer.toString(Math.abs(random.nextInt()) % 100000 + 100000);
        return "ID" + df.format(date) + s1.substring(1) + s2.substring(1);
    }

    public static String mergeId(String id1, String id2) {
        String code = MD5Util.getMD5Code(String.valueOf(id1) + id2).substring(8, 24);
        BigInteger value = new BigInteger(code, 16);
        String str = String.valueOf(value.toString()) + "0000000000000000000000000";
        str = str.substring(0, 25);
        return "ID" + str;
    }
}
