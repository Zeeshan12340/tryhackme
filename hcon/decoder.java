import java.util.Base64;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

class decoder {

  public static void main(String args[]) throws Exception {
    //byte[] origText = decrypt(new String("RwO9+7tuGJ3nc1cIhN4E31WV/qeYGLURrcS7K+Af85w=").getBytes(), "SEARCHTHESECRETKEY".getBytes());
    //System.out.println(new String(origText));
    System.out.println(dec("RwO9+7tuGJ3nc1cIhN4E31WV/qeYGLURrcS7K+Af85w="));
  }


public static String dec(String data) {

    try {

        byte[] decoded_data = Base64.getDecoder().decode(data.getBytes());
        
        Cipher my_cipher = Cipher.getInstance("AES/CBC/PKCS5PADDING");
        my_cipher.init(2, new SecretKeySpec("hconkwithyhackme".getBytes("UTF-8"), "AES"), new IvParameterSpec("THEIVFORINGEOAEY".getBytes("UTF-8")));
        return new String(my_cipher.doFinal(decoded_data));
        
        } catch (Exception e) {
      e.printStackTrace();
      return null;
    }
    }
}
