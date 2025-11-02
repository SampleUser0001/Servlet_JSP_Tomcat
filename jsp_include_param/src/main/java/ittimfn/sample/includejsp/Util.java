package ittimfn.sample.tomcat.pulldown;

public class Util {
    
    public static final String nullToEmpty(String str) {
        return str == null || str.equals("null") ? "" : str;
    }

    private Util(){}
}
