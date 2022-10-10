package com.anyholo.main;

import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;

public class Main {

	public static void main(String[] args) {
		//"yyyy-dd-MM'T'HH:mm:ss'Z'"
		/*String now = ZonedDateTime.now().format(DateTimeFormatter.ISO_INSTANT);
		System.out.println(ZonedDateTime.now().plusDays(2).format(DateTimeFormatter.ISO_INSTANT));*/
		DataManagement d = new DataManagement();
		d.twitTest();
		/*d.InitialValue();//초기값 설정
		Thread refresh = new tcpSocket();
		refresh.start();
		System.out.println("0");
		while(true) {
		d.LiveConfirm();
		System.out.println("1");
		}*/
	}
}
  