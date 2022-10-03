package com.anyholo.main;

public class Main {

	public static void main(String[] args) {
		DataManagement d = new DataManagement();
		d.InitialValue();//초기값 설정
		Thread refresh = new tcpSocket();
		refresh.start();
		System.out.println("0");
		while(true) {
		d.LiveConfirm();
		System.out.println("1");
		}
	}
}
  