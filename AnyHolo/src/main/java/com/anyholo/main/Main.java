package com.anyholo.main;

import java.util.ArrayList;
import java.util.Collections;

public class Main {

	public static void main(String[] args) {
		/*ArrayList<TestV> list = new ArrayList<TestV>();
		list.add(new TestV("1",null));
		list.add(new TestV("3",null));
		list.add(new TestV("5",null));
		list.add(new TestV("7",null));
		System.out.println(list);
		Collections.reverse(list);
		ArrayList<TestV> list2 = new ArrayList<TestV>();
		list2.add(new TestV("2","1"));
		list2.add(new TestV("4","3"));
		list2.add(new TestV("6","5"));
		System.out.println(list2);
		for(int i=0;i<list.size();i++) {
			for(int j=0;j<list2.size();j++) {
				if(list.get(i).getId().equals(list2.get(j).getNid())) {
					System.out.println("!");
					list.add(i+1,list2.get(j));
					list2.remove(j);
					break;
				}
			}
		}
		for(TestV v : list)
			System.out.println(v.id);*/
		DataManagement d = new DataManagement();
		//d.getKirinuki("UCOPaYsI-TnBk0qxoAy_rjXA");
		d.getTweet();
		
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
