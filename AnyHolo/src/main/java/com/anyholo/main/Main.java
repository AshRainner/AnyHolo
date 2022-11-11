package com.anyholo.main;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collections;

import com.anyholo.api.YoutubeDataApi;
import com.anyholo.db.DBController;

public class Main {
	public static void main(String[] args) {
		DataManagement d = new DataManagement();
		DBController.DBConnect();
		YoutubeDataApi.setKey();
		System.out.println("시작 : "+LocalDateTime.now());
		try {
			d.getKirinuki();
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//d.get7daysTweet();
		System.out.println("종료 : "+LocalDateTime.now());
		/*Thread tweetThread = new Thread(new Runnable() {
			@Override
			public void run() {
				// TODO Auto-generated method stub
				while(true) {
					System.out.println("트윗 시작 : "+LocalDateTime.now());
					d.getTweet();
					System.out.println("트윗 종료 : "+LocalDateTime.now());
					try {
						Thread.sleep((1000*40));
					} catch (InterruptedException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
			}
		});
		tweetThread.start();
		d.InitialValue();
		while(true) {
			System.out.println("라이브 컨펌 시작 : "+LocalDateTime.now());
			d.LiveConfirm();
			System.out.println("라이브 컨펌 종료 : "+LocalDateTime.now());
		}*/
		//내꺼 UCOPaYsI-TnBk0qxoAy_rjXA
		//홀로라이브 인도네시아님꺼 UC3_IjQ8uQXTBZ5ysRHOls7g
	}
}
