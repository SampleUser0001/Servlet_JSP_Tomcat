package ittimfn.sample.tomcat.radio;

public final class Util {

    private Util() {
    }

    public static String nullToEmpty(String str) {
        return str == null || str.equals("null") ? "" : str;
    }
}
