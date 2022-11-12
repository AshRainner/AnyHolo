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
		YoutubeDataApi.setKey();
		/*try {
			d.InitializationValue();
			//d.getKirinuki();
			d.getKirinukiInitialization("UCbYbIsGOwG9CCEbK5zUyx_A");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}*/
		Thread YoutubeThread = new Thread(new Runnable() {
			@Override
			public void run() {
				// TODO Auto-generated method stub
				while(true) {	
					try {
						System.out.println("라이브 컨펌 시작 : "+LocalDateTime.now());
						d.InitializationValue();
						d.LiveConfirm();
						System.out.println("라이브 컨펌 종료 : "+LocalDateTime.now());
						System.out.println("키리누키 시작 : "+LocalDateTime.now());
						d.getKirinuki();
						System.out.println("키리누키 종료 : "+LocalDateTime.now());
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}	
				}
			}
		});
		YoutubeThread.start();
		while(true) {
			System.out.println("트윗 시작 : "+LocalDateTime.now());
			try {
				d.getTweet();
				System.out.println("트윗 종료 : "+LocalDateTime.now());
				Thread.sleep((1000*40));	
			} catch (SQLException | IOException | InterruptedException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		}
		
	}
}
