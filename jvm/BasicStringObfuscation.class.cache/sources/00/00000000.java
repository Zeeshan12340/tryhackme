package defpackage;

/* renamed from: BasicStringObfuscation  reason: default package */
/* loaded from: BasicStringObfuscation.class */
public class BasicStringObfuscation {
    private static final String correctPassword = "aRa2lPT6A6gIqm4RE";

    public static void main(String[] strArr) {
        if (strArr.length >= 1) {
            if (xor(correctPassword).equals(strArr[0])) {
                System.out.println("Correct!");
                return;
            } else {
                System.out.println("Incorrect");
                return;
            }
        }
        System.out.println("Please provide a password");
    }

    private static String xor(String str) {
        char[] charArray = str.toCharArray();
        char[] cArr = new char[charArray.length];
        for (int i = 0; i < cArr.length; i++) {
            cArr[i] = (char) (charArray[i] ^ (i % 3));
        }
        return new String(cArr);
    }
}