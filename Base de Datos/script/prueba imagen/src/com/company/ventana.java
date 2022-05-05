package com.company;

import javax.imageio.ImageIO;
import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.image.BufferedImage;
import java.io.File;

public class ventana {

    private JButton boton;
    private JPanel jboton;

    public static void main(String[] args) {
        JFrame frame = new JFrame("ventana");
        frame.setContentPane(new ventana().getJboton());
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.pack();
        frame.setVisible(true);

    }

    public ventana() {
        try{
            File file = new File("C:\\Users\\Celia\\Desktop\\escudo.png");
            BufferedImage bufferedImage = ImageIO.read(file);

            ImageIcon imageIcon = new ImageIcon(bufferedImage);

            boton.setIcon(imageIcon);

        }catch (Exception e){
            System.out.println(e.getClass());
        }

    }
    public JButton getBoton() {
        return boton;
    }

    public void setBoton(JButton boton) {
        this.boton = boton;
    }

    public JPanel getJboton() {
        return jboton;
    }

    public void setJboton(JPanel jboton) {
        this.jboton = jboton;
    }
    public ventana(JButton boton, JPanel jboton) {
        this.boton = boton;
        this.jboton = jboton;
    }


}
