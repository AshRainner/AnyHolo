package com.anyholo.main;

import java.text.ParseException;
import java.time.LocalDateTime;

public class Main {

	public static void main(String[] args) {
		//"yyyy-dd-MM'T'HH:mm:ss'Z'"
		/*String now = ZonedDateTime.now().format(DateTimeFormatter.ISO_INSTANT);
		System.out.println(ZonedDateTime.now().plusDays(2).format(DateTimeFormatter.ISO_INSTANT));*/
		DataManagement d = new DataManagement();
		//d.test("UC3_IjQ8uQXTBZ5ysRHOls7g");
		d.getTwit();
		//내꺼 UCOPaYsI-TnBk0qxoAy_rjXA
		//홀로라이브 인도네시아님꺼 UC3_IjQ8uQXTBZ5ysRHOls7g
		/*while(true) {
			System.out.println("시작"+LocalDateTime.now());
			d.getTwit();
			System.out.println("끝"+LocalDateTime.now());
			try {
				Thread.sleep(1000*50);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}*/
		
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
