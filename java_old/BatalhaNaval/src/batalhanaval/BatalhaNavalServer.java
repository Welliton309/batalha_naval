/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package batalhanaval;

import java.rmi.Naming;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 *
 * @author Larissa
 */
public class BatalhaNavalServer {
    
    public static void main(String[] args) throws Exception {

        Pattern p;
        Matcher m;
        
        
        StringBuilder builder = new StringBuilder(";");
        for (String arg : args) {
            builder.append(arg).append(";");
        }
        String commandLine = builder.toString();
        
        BatalhaNavalImpl batalhaNaval = new BatalhaNavalImpl();
        
        // debug
        p = Pattern.compile(";-?(d|debug);");
        m = p.matcher(commandLine);
        if (m.find()) {
           batalhaNaval.setDebug(true);
           System.err.println("Debug");
        }
        
        // host
        String host = "localhost";
        p = Pattern.compile(";(\\d\\d\\d\\.\\d\\d\\d\\.\\d\\d\\d\\.\\d\\d\\d);$");
        m = p.matcher(commandLine);
        if (m.find()) {
            host = m.group(1);
        }
        
        String url = "//" + host + ":1099/batalhanaval";
        Naming.rebind(url, batalhaNaval);

        System.out.println(url);
    }
}
