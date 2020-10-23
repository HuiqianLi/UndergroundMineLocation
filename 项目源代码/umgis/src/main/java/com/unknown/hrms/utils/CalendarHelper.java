package com.unknown.hrms.utils;



import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

/**
 * 日期处理辅助类
 *
 * @version 1.0
 * @date 2013-1-13
 * @author Administrator
 */
public class CalendarHelper {

    public CalendarHelper() {

    }

    public static final String DEFAULT_PATTERN = "yyyy-MM-dd HH:mm:ss";

    public static int YEAR = Calendar.YEAR;
    public static int MONTH = Calendar.MONDAY;
    public static int DAY = Calendar.DAY_OF_MONTH;
    public static int HOUR = Calendar.HOUR_OF_DAY;
    public static int MINUTE = Calendar.MINUTE;
    public static int SECOND = Calendar.SECOND;

    private static char DAY_DELIMITER = '-';

    /**
     * 取得当前日期
     *
     * @return YYYY-MM-DD
     */
    public static String getToday() {
        return getDateTime().substring(0, 10);
    }

    /**
     * Date型转换为字符串
     *
     * @return YYYY-MM-DD
     */

    public static String formatDate(Date date) {
        return getDateTime(date).substring(0, 10);
    }

    /**
     * 字符串型日期截取年月日
     *
     * @return YYYY-MM-DD
     */

    public static String formatDate(String date) {
        return date.substring(0, 10);
    }

    /**
     * Date型转换为字符串
     *
     * @return yyyy-MM-dd hh:mm:ss
     */

    public static String formatDatetime(Date date) {
        return getDateTime(date);
    }

    /**
     * Date型转换为字符串
     *
     * @return
     */
    public static String formatDate(Date date, String pattern) {
        DateFormat df = new SimpleDateFormat(pattern);
        return df.format(date);
    }

    /**
     * 转化日期对象
     *
     * @param datetime
     *
     * @throws ParseException
     * @return Date
     */
    public static Date parseDate(String datetime, String pattern) throws ParseException {
        DateFormat df = new SimpleDateFormat(pattern);
        return df.parse(datetime);
    }

    /**
     * 转化日期对象，格式：yyyy-MM-dd
     *
     * @param datetime
     * @return
     * @throws ParseException
     * @see
     * @since
     */
    public static Date parseDate(String datetime) throws ParseException {
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        return df.parse(datetime);
    }

    /**
     * 转化日期对象，格式：yyyy-MM-dd hh:mm:ss
     *
     * @param datetime
     * @return
     * @throws ParseException
     * @see
     * @since
     */
    public static Date parseDatetime(String datetime) throws ParseException {
        DateFormat df = new SimpleDateFormat(DEFAULT_PATTERN);
        return df.parse(datetime);
    }

    /**
     * 取得当前时间
     *
     * @return HH:MM:SS
     */
    public static String getTime() {
        return getDateTime().substring(11, 19);
    }

    /**
     * 得到当前的星期几，星期一为1～星期天为7
     *
     * @return int
     */
    public static int getCurWeekDay(Date date) {
        GregorianCalendar gc = new GregorianCalendar();
        gc.setTime(date);

        int ret = gc.get(GregorianCalendar.DAY_OF_WEEK);
        int wd = ret - 1;
        if (ret == 1) {
            wd = 7;
        } else {
            wd = ret - 1;
        }
        return wd;
    }

    /**
     * 取得当前的日期时间
     *
     * @return YYYY-MM-DD HH:MM:DD
     */
    public static String getDateTime() {
        return getDateTime(new GregorianCalendar());
    }

    /**
     * Date型转换为字符串
     *
     * @param date
     *            Date 输入时间
     * @return YYYY-MM-DD HH:MM:DD
     */
    public static String getDateTime(Date date) {
        Calendar calendar = new GregorianCalendar();
        calendar.setTime(date);
        return getDateTime(calendar);
    }

    /**
     * 根据日历返回日期时间
     *
     * @param calendar
     *            日历
     * @return YYYY-MM-DD HH:MM:DD
     */
    private static String getDateTime(Calendar calendar) {
        StringBuffer buf = new StringBuffer("");

        buf.append(calendar.get(Calendar.YEAR));
        buf.append(DAY_DELIMITER);
        //buf.append(calendar.get(Calendar.MONTH) + 1 > 9 ? calendar.get(Calendar.MONTH) + 1 + ""
        //     : "0" + (calendar.get(Calendar.MONTH) + 1));
        buf.append(appendZeroBefore(calendar.get(Calendar.MONTH)+ 1));
        buf.append(DAY_DELIMITER);
        //buf.append(calendar.get(Calendar.DAY_OF_MONTH) > 9 ? calendar.get(Calendar.DAY_OF_MONTH)
        //     + "" : "0" + calendar.get(Calendar.DAY_OF_MONTH));
        buf.append(appendZeroBefore(calendar.get(Calendar.DAY_OF_MONTH)));
        buf.append(" ");
        //buf.append(calendar.get(Calendar.HOUR_OF_DAY) > 9 ? calendar.get(Calendar.HOUR_OF_DAY) + ""
        //       : "0" + calendar.get(Calendar.HOUR_OF_DAY));
        buf.append(appendZeroBefore(calendar.get(Calendar.HOUR_OF_DAY)));
        buf.append(":");
        //buf.append(calendar.get(Calendar.MINUTE) > 9 ? calendar.get(Calendar.MINUTE) + "" : "0"
        //     + calendar.get(Calendar.MINUTE));
        buf.append(appendZeroBefore(calendar.get(Calendar.MINUTE)));
        buf.append(":");
        //buf.append(calendar.get(Calendar.SECOND) > 9 ? calendar.get(Calendar.SECOND) + "" : "0"
        //     + calendar.get(Calendar.SECOND));
        buf.append(appendZeroBefore(calendar.get(Calendar.SECOND)));
        return buf.toString();
    }

    /**
     * 根据年、月、日返回日期时间
     *
     * @param year
     *            年
     * @param month
     *            月
     * @param year
     *            日
     * @return YYYY-MM-DD
     */
    public static String getDateTime(int year, int month, int day) {
        StringBuffer buf = new StringBuffer("");

        buf.append(year);
        buf.append(DAY_DELIMITER);
        //buf.append(month > 9 ? month + "" : "0" + month);
        buf.append(appendZeroBefore(month));
        buf.append(DAY_DELIMITER);
        //buf.append(day > 9 ? day + "" : "0" + day);
        buf.append(appendZeroBefore(day));
        return buf.toString();
    }

    /**
     * 根据月、日返回日期时间
     *
     * @param month
     *            月
     * @param day
     *            日
     * @return MM-DD
     */
    public static String getDateTime(int month, int day) {
        StringBuffer buf = new StringBuffer("");
        //buf.append(month > 9 ? month + "" : "0" + month);
        buf.append(appendZeroBefore(month));
        buf.append(DAY_DELIMITER);
        //buf.append(day > 9 ? day + "" : "0" + day);
        buf.append(appendZeroBefore(day));
        return buf.toString();
    }

    /**
     * * 根据年、月、日、时、分、秒返回日期时间
     *
     * @param year
     *            年
     * @param month
     *            月
     * @param day
     *            日
     * @param hour
     *            时
     * @param minute
     *            分
     * @param second
     *            秒
     * @return String YYYY-MM-DD HH:MM:SS
     */

    public static String getDateTime(int year, int month, int day, int hour, int minute, int second) {
        StringBuffer buf = new StringBuffer("");
        buf.append(year);
        buf.append(DAY_DELIMITER);
        //buf.append(month > 9 ? month + "" : "0" + month);
        buf.append(appendZeroBefore(month));
        buf.append(DAY_DELIMITER);
        //buf.append(day > 9 ? day + "" : "0" + day);
        buf.append(appendZeroBefore(day));
        //buf.append(hour > 9 ? hour + "" : "0" + hour);
        buf.append(" "+appendZeroBefore(hour));
        buf.append(":");
        //buf.append(minute > 9 ? minute + "" : "0" + minute);
        buf.append(appendZeroBefore(minute));
        buf.append(":");
        //buf.append(second > 9 ? second + "" : "0" + second);
        buf.append(appendZeroBefore(second));
        return buf.toString();
    }

    /**
     * 在指定的日期中按某个时间类型添加指定步长
     *
     * @param datetime
     *            YYYY-MM-DD HH:MM:SS
     * @param type
     *            YEAR,MONTH,DAY,HOUR,MINUTE,SECOND
     * @param step
     *            步长 可以是整数或负数
     * @return 改变后的日期时间 YYYY-MM-DD HH:MM:SS
     */
    public static String getPreDateTime(String datetime, int type, int step) {

        Calendar calendar = new GregorianCalendar(Integer.parseInt(datetime.substring(0, 4)),
                Integer.parseInt(datetime.substring(5, 7)) - 1, Integer.parseInt(datetime
                .substring(8, 10)), Integer.parseInt(datetime.substring(11, 13)),
                Integer.parseInt(datetime.substring(14, 16)), Integer.parseInt(datetime.substring(
                17, 19)));
        calendar.add(type, step);
        return getDateTime(calendar);
    }

    /**
     * 根据字符串类型取得日期类型
     *
     * @param datetime
     *            String YYYY-MM-DD HH:MM:SS
     * @return Calendar
     */
    public static Calendar getCalendar(String datetime) {
        return new GregorianCalendar(Integer.parseInt(datetime.substring(0, 4)),
                Integer.parseInt(datetime.substring(5, 7)) - 1, Integer.parseInt(datetime
                .substring(8, 10)), Integer.parseInt(datetime.substring(11, 13)),
                Integer.parseInt(datetime.substring(14, 16)), Integer.parseInt(datetime.substring(
                17, 19)));
    }

    /**
     * 在指定的日期中按某个时间类型添加指定步长
     *
     * @param date
     *            YYYY-MM-DD HH:MM:SS
     * @param type
     *            YEAR,MONTH,DAY,HOUR,MINUTE,SECOND
     * @param step
     *            步长 可以是整数或负数
     * @return 改变后的日期时间 YYYY-MM-DD
     */
    public static String getPreDate(String date, int type, int step) {
        Calendar calendar = new GregorianCalendar(Integer.parseInt(date.substring(0, 4)),
                Integer.parseInt(date.substring(5, 7)) - 1,
                Integer.parseInt(date.substring(8, 10)), 0, 0, 0);
        calendar.add(type, step);
        return getDateTime(calendar).substring(0, 10);
    }

    /**
     * 取得当前日期的正数
     *
     * @return YYYYMMDD
     */

    public static int getDateInt() {
        String date = getToday();
        return Integer
                .parseInt(date.substring(0, 4) + date.substring(5, 7) + date.substring(8, 10));
    }

    public static String getDateTimeOfInt() {
        String date = getDateTime();
        return date.substring(0, 4) + date.substring(5, 7) + date.substring(8, 10)
                + date.substring(11, 13) + date.substring(14, 16) + date.substring(17, 19);
    }

    /**
     * 取得当前日期的正数
     *
     * @return YYYYMMDD
     */

    public static int getDateTimeInt() {
        String date = getToday();
        return Integer
                .parseInt(date.substring(0, 4) + date.substring(5, 7) + date.substring(8, 10));
    }

    /**
     * 取得指定时间的时间戳
     *
     * @return long 时间戳
     */
    public static long getTimeStamp(String datetime) {
        return getCalendar(datetime).getTime().getTime();
    }

    /**
     * 取得当前的时间戳
     *
     * @return long 时间戳
     */
    public static long getTimeStamp() {
        return System.currentTimeMillis();
    }

    /**
     * 取得当前时间的正数
     *
     * @return HHMMSS
     */

    public static int getTimeInt() {
        String date = getDateTime();
        return Integer.parseInt(date.substring(11, 13) + date.substring(14, 16)
                + date.substring(17, 19));
    }

    /**
     * 比较时间大小的例子 added from internet
     *
     * @throws ParseException
     */
    public static String compareTime(Date d1, Date d2) throws ParseException {
        // DateFormat df = new SimpleDateFormat("yyy-MM-dd");
        // Date d1 = df.parse("2000-01-01");
        // Date d2 = df.parse("1999-12-31");
        String relation = null;
        if (d1.equals(d2)) {
            relation = "same";
        } else if (d1.before(d2)) {
            relation = "before";
        } else {
            relation = "after";
        }
        return relation;
    }

    /**
     * 根据年、月算出每个月的天数
     *
     * @param year
     *            int
     * @param month
     *            int
     * @return int
     */
    public static int getRealDays(int year, int month) {
        int[] daysInMonth = new int[] { 31, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };
        if (2 == month) {
            if (((0 == year % 4) && (0 != (year % 100))) || (0 == year % 400) ){
                return 29;
            }else {
                return 28;
            }
        } else if (month > 12) {
            return 0;
        } else {
            return daysInMonth[month];
        }
    }

    /**
     * 计算输入日期间相差天数
     * @param date1
     * @param date2
     * @return
     */
    public static long calculateDayInteval(Date date1, Date date2) {
        long diff = date2.getTime() - date1.getTime();
        return diff / (1000 * 60 * 60 * 24);

    }

    /**
     * 当参数小于10的时候，在前面补0
     * @param param
     * @return
     * @see
     * @since
     */
    private static String appendZeroBefore(int param){
        String _ret = String.valueOf(param);
        if(param>=0 && param <10){
            _ret = "0"+param;
        }
        return _ret;
    }

    public static void main(String arg[])throws Exception{
        Date date = new Date();
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd H:m:s");
        date = dateFormat.parse("2017-6-9 9:8:8");
        System.out.println( date.toString()+"   "+getDateTime(date));
        String jjString = getDateTime(2012,1,4,5,6,8);
        System.err.println(jjString);
        System.out.println(getRealDays(2000, 2));
    }

}
