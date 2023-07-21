package com.roy.hspersona.util;

import java.math.BigDecimal;

/**
 * @author roy
 * @date 2021/12/2
 * @desc
 */
public class NumUtil {
    public static double add(double... x) {
        BigDecimal bd = new BigDecimal(0);
        byte b;
        int i;
        double[] arrayOfDouble;
        for (i = (arrayOfDouble = x).length, b = 0; b < i; ) {
            double d = arrayOfDouble[b];
            bd = bd.add(new BigDecimal(Double.toString(d)));
            b++;
        }
        return bd.doubleValue();
    }

    public static double mul(double... x) {
        BigDecimal bd = new BigDecimal(0);
        byte b;
        int i;
        double[] arrayOfDouble;
        for (i = (arrayOfDouble = x).length, b = 0; b < i; ) {
            double d = arrayOfDouble[b];
            bd = bd.multiply(new BigDecimal(Double.toString(d)));
            b++;
        }
        return bd.doubleValue();
    }

    public static double sub(double x, double y) {
        BigDecimal b1 = new BigDecimal(Double.toString(x));
        BigDecimal b2 = new BigDecimal(Double.toString(y));
        return b1.subtract(b2).doubleValue();
    }

    public static double div(double x, double y, int scale) {
        if (scale < 0) {
            System.err.println("除法精度必须大于0");
            return 0.0D;
        }
        BigDecimal b1 = new BigDecimal(Double.toString(x));
        BigDecimal b2 = new BigDecimal(Double.toString(y));
        return b1.divide(b2, scale, 6).doubleValue();
    }

    public static boolean isNum(String s) {
        try {
            Double.parseDouble(s);
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public static boolean isNum(String s, Double start, Double end) {
        try {
            Double d = Double.parseDouble(s);
            if (start != null && end != null)
                return d >= start && d <= end;
            if (start != null && end == null)
                return d >= start;
            if (start == null && end != null)
                return d <= end;
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public static boolean isInt(String s) {
        return isInt(s, null, null);
    }

    public static boolean isInt(String s, Integer start, Integer end) {
        Double a = (start == null) ? null : start.doubleValue();
        Double b = (end == null) ? null : end.doubleValue();
        if (isNum(s, a, b))
            return !s.contains(".");
        return false;
    }
}
