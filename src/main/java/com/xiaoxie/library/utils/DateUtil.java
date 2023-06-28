package com.xiaoxie.library.utils;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;


public class DateUtil {
    /**
     * 返回yyyy-MM-dd HH:mm:ss
     * @return
     */
    public static String getDateTime() {
        Date date = new Date();
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        return format.format(date);
    }

    /**
     * 返回yyyy-MM-dd
     * @return
     */
    public static String getDate() {
        Date date = new Date();
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        return format.format(date);
    }

    /**
     * 返回时间戳
     * @return
     */
    public static Date getTimestamp() {
        Date date = new Date();
        Timestamp timestamp = new Timestamp(date.getTime());
        return timestamp;
    }

    /**
     * 计算两个日期相差多少
     * @param a
     * @param b
     * @return
     */
    public static int getDay(Date a, Date b) {
        int days = (int) ((a.getTime() - b.getTime()) / (1000 * 3600 * 24));
        return days;
    }
}
