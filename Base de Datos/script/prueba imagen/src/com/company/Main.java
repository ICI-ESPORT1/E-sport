package com.company;

import javax.swing.*;


public class Main {

    public static void main(String[] args) {
	// write your code here
    abrirVentana();
    }
    public static  void abrirVentana(){
        JFrame frame = new JFrame("ventana");
        frame.setContentPane(new ventana().getJboton());
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.pack();
        frame.setVisible(true);
    }

}
