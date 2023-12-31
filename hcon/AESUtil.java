import java.util.Base64;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

public class AESUtil {

  public static void main(String args[]) throws Exception {
    byte[] cipherText = encrypt("Testing AES/CBC/PKCS5PADDING stuff from Java and with JavaScript - some random text".getBytes(), "SEARCHTHESECRETKEY".getBytes()); // 32 length Key
    System.out.println(new String(cipherText));
    byte[] origText = decrypt(new String("RwO9+7tuGJ3nc1cIhN4E31WV/qeYGLURrcS7K+Af85w=").getBytes(), "SEARCHTHESECRETKEY".getBytes());
    System.out.println(new String(origText));
  }

  public static byte[] encrypt(byte[] plainTextData, byte[] secretKey) throws Exception {
    try {
      String iv = new String(secretKey).substring(0, 16);

      Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5PADDING");

      byte[] dataBytes = plainTextData;
      int plaintextLength = dataBytes.length;
      byte[] plaintext = new byte[plaintextLength];
      System.arraycopy(dataBytes, 0, plaintext, 0, dataBytes.length);

      SecretKeySpec keyspec = new SecretKeySpec(secretKey, "AES");
      IvParameterSpec ivspec = new IvParameterSpec(iv.getBytes());

      cipher.init(Cipher.ENCRYPT_MODE, keyspec, ivspec);
      byte[] encrypted = cipher.doFinal(plaintext);

      return new String(Base64.getEncoder().encode(encrypted)).getBytes();

    } catch (Exception e) {
      e.printStackTrace();
      return null;
    }
  }

  public static byte[] decrypt(byte[] cipherTextData, byte[] secretKey) throws Exception {
    try {
      String iv = new String(secretKey).substring(0, 16);

      byte[] encrypted = Base64.getDecoder().decode(cipherTextData);

      Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5PADDING");
      SecretKeySpec keyspec = new SecretKeySpec(secretKey, "AES");
      IvParameterSpec ivspec = new IvParameterSpec(iv.getBytes());

      cipher.init(Cipher.DECRYPT_MODE, keyspec, ivspec);

      byte[] original = cipher.doFinal(encrypted);
      String originalString = new String(original);
      return originalString.getBytes();
    } catch (Exception e) {
      e.printStackTrace();
      return null;
    }
  }
}