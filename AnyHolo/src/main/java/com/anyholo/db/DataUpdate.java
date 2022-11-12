package com.anyholo.db;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.time.LocalDateTime;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.anyholo.api.YoutubeDataApi;
import com.anyholo.main.DataManagement;

@WebServlet("/dataUpdate")
public class DataUpdate extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		DataManagement d = new DataManagement();
		YoutubeDataApi.setKey();
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