package ittimfn.sample.includejsp;

public class Util {

    public static String nullToEmpty(String str) {
        return str == null || str.equals("null") ? "" : str;
    }

    private Util(){}
}
