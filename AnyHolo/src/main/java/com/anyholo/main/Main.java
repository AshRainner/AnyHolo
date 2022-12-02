package com.anyholo.main;

import java.io.IOException;
import java.sql.SQLException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.anyholo.api.YoutubeDataApi;

public class Main {
	public static void main(String[] args){
		/*tcpSocket ts= new tcpSocket();
		ts.start();*/
		DataManagement yt = new DataManagement(); //youtube/twitter
		DataManagement k = new DataManagement();//kirinuki
		YoutubeDataApi.setKey();
		/*try {
			k.InitializationKirinukiValue();
			k.ResetKirinukiVideo(); // 최초로 넣을 때
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
					yt.InitializationValue();
					//System.out.println("라이브 컨펌 시작 : "+LocalDateTime.now());
					yt.LiveConfirm();
					//System.out.println("라이브 컨펌 종료 : "+LocalDateTime.now());				
				}
			}
		});
		Thread KirinukiThread = new Thread(new Runnable() {

			@Override
			public void run() {		
				while(true) {
					k.InitializationKirinukiValue();
					//System.out.println("키리누키 시작 : "+LocalDateTime.now());
					k.getKirinuki();
					//System.out.println("키리누키 종료 : "+LocalDateTime.now());
					try {
						Thread.sleep((1000*40));
					} catch (InterruptedException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
			}
		});
		YoutubeThread.start();
		KirinukiThread.start();
		/*try {
			yt.InitializationValue();
			yt.get7daysTweet();
		} catch (SQLException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}*/
		try {
			Thread.sleep(5000);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		while(true) {
			//System.out.println("트윗 시작 : "+LocalDateTime.now());
			try {
				yt.getTweet();
				//System.out.println("트윗 종료 : "+LocalDateTime.now());
				Thread.sleep((1000*40));	
			} catch (SQLException | IOException | InterruptedException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		}
	}
}
