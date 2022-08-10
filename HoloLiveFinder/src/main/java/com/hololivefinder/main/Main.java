package com.hololivefinder.main;

public class Main {

	public static void main(String[] args) {
		DataManagement d = new DataManagement();
		d.InitialValue();//초기값 설정
		while(true)
		d.LiveConfirm();
	}

}
