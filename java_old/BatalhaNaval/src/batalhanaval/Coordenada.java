/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package batalhanaval;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 *
 * @author Larissa
 */
public class Coordenada {

    private static String ALPHA = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    
    public static String num2char(int i) {
        return String.valueOf(ALPHA.toCharArray()[i]);
    }

    public static Coordenada parse(String coordenada) throws Exception {
        int x, y;
        OrientacaoEnum o = OrientacaoEnum.HORIZONTAL;
        
        Pattern p = Pattern.compile("([0-9]+)");
        Matcher m = p.matcher(coordenada);
        if (m.find()) {
            x = Integer.valueOf(m.group(1)) - 1;
        } else {
            throw new Exception("Coordenada X não encontrada.");
        }
        
        p = Pattern.compile("([A-Za-z]+)");
        m = p.matcher(coordenada);
        if (m.find()) {
            y = char2num(m.group(1));
        } else {
            throw new Exception("Coordenada Y não encontrada.");
        }
        
        if (coordenada.contains("|")) {
            o = OrientacaoEnum.VERTICAL;
        }
        
        return new Coordenada(x, y, o);
    }

    private static int char2num(String letra) {
        return ALPHA.indexOf(letra.toUpperCase());
    }

    private int x;
    private int y;
    private Enum orientacaoEnum;

    public Coordenada(int x, int y, Enum orientacaoEnum){
        this.x = x;
        this.y = y;
        this.orientacaoEnum = orientacaoEnum;
    }

    
    public int getX() {
        return x;
    }

    public int getY() {
        return y;
    }

    public Enum getOrientacaoEnum() {
        return orientacaoEnum;
    }

}
