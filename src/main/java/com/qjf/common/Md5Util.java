package com.qjf.common;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * @Author:Tin
 * @Date: create in 2018/1/23 10:34
 * @Description: 实现一个简单md5加密功能，不依赖于第三方框架，解耦
 * 字符编码：utf-8
 */
public class Md5Util {

    private static Logger logger = LoggerFactory.getLogger(Md5Util.class);

    private static MessageDigest md = null;
    static{
        try {
            md = MessageDigest.getInstance("MD5");
        } catch (NoSuchAlgorithmException e) {
            logger.error(e.getMessage());
        }
    }

    private static final char[] HEX_DIGITS = "0123456789ABCDEF".toCharArray();

    public static String MD5(String s) {
        try {
            byte[] bytes = md.digest(s.getBytes("utf-8"));
            return toHex(bytes);
        }
        catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public static String MD5(String s,int iterations) {
        try {
            for(int i=0;i<iterations;i++){
                s = MD5( s);
            }
            return s;
        }
        catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public static String MD5LowerCase(String s,int iterations) {
        try {
            for(int i=0;i<iterations;i++){
                s = MD5LowerCase(s);
            }
            return s;
        }
        catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public static String MD5LowerCase(String s) {
        try {
            byte[] bytes = md.digest(s.getBytes("utf-8"));
            return toHex(bytes).toLowerCase();
        }
        catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    private static String toHex(byte[] bytes) {
        StringBuilder ret = new StringBuilder(bytes.length * 2);
        for (int i=0; i<bytes.length; i++) {
            ret.append(HEX_DIGITS[(bytes[i] >> 4) & 0x0f]);
            ret.append(HEX_DIGITS[bytes[i] & 0x0f]);
        }
        return ret.toString();
    }
}
