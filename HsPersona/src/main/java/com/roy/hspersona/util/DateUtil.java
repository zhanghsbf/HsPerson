package com.roy.hspersona.util;

import org.apache.commons.lang3.StringUtils;

import java.text.SimpleDateFormat;
import java.text.ParseException;
import java.util.Date;

/**
 * @author roy
 * @date 2021/12/2
 * @desc
 */
public class DateUtil {
    public static String toString(Date date, String formatString) {
        if (date == null)
            return "";
        SimpleDateFormat dateFormat = new SimpleDateFormat(formatString);
        return dateFormat.format(date);
    }

    public static Date toDate(String s, String formatString) {
        if (StringUtils.isEmpty(s))
            return null;
        SimpleDateFormat dateFormat = new SimpleDateFormat(formatString);
        Date date = null;
        try {
            date = dateFormat.parse(s);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return date;
    }

    public static int calculateAge(Date birthDate) {
        if (birthDate == null)
            return 0;
        SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
        int birth = Integer.parseInt(format.format(birthDate));
        int now = Integer.parseInt(format.format(new Date()));
        return now / 10000 - birth / 10000 + ((birth % 10000 >= now % 10000) ? -1 : 0);
    }
}
