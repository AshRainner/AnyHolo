package com.anyholo.main;

import java.io.IOException;
import java.io.ObjectOutputStream;
import java.net.ServerSocket;
import java.net.Socket;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.anyholo.db.DBController;

public class tcpSocket extends Thread{
	ServerSocket server_socket;
	Socket socket;
	int num=0;

	@Override
	public void run() {
		// TODO Auto-generated method stub
		try {
			server_socket = new ServerSocket(9091);
			while(true) {
				System.out.println("시작");
				socket = server_socket.accept();
				SendThread sendThread = new SendThread(socket);
				sendThread.start();
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
}
class SendThread extends Thread{
	Socket socket;
	ObjectOutputStream os;
	public SendThread(Socket socket) {	
		try {
			this.socket=socket;	
			os = new ObjectOutputStream(socket.getOutputStream());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	@Override
	public void run() {
		try {
			System.out.println("데이터 취합중");
			JSONObject jObject = new JSONObject();
			JSONArray jArray = new JSONArray();
			DBController.DBSelect(jArray);
			jObject.put("Member", jArray);
			os.writeObject(jObject);
			os.flush();
			os.close();
			socket.close();
			System.out.println("데이터 보냈음");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}

