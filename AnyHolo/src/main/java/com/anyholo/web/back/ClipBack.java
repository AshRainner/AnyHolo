package com.anyholo.web.back;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.anyholo.db.DBController;
import com.anyholo.model.data.KirinukiUser;
import com.anyholo.model.data.KirinukiVideo;
import com.anyholo.model.data.KirinukiView;

@WebServlet("/Clip")
public class ClipBack extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");;
		response.setCharacterEncoding("UTF-8");
		DBController dbc = new DBController();
		int page = 1;
		String country="";
		if(request.getParameter("Page")!=null)
			page=Integer.parseInt(request.getParameter("Page"));
		if(request.getParameter("Country")!=null)	
			country=request.getParameter("Country");
		String keyword="";
		if(request.getParameter("Keyword")!=null)
			keyword = request.getParameter("Keyword");
		PrintWriter out = response.getWriter();	
		JSONArray jArray = new JSONArray();
		dbc.DBSelect(jArray,DBController.KIRINUKI_SELECT,country,keyword,page,1);
		List<KirinukiView> kirinuki = new ArrayList<KirinukiView>();
		for(int i=0;i<jArray.size();i++) {
			JSONObject obj = (JSONObject) jArray.get(i);
			kirinuki.add(new KirinukiView(
					new KirinukiUser(obj.get("userUrl").toString(),obj.get("channelName").toString()),
					new KirinukiVideo(obj.get("youtubeUrl").toString(),obj.get("videoTitle").toString(),
							obj.get("thumnailUrl").toString(),"",getTime(obj.get("uploadTime").toString()),"","")));
		}
		request.setAttribute("kirinukiList", kirinuki);
		request.setAttribute("Keyword", keyword);
		request.getRequestDispatcher("/WEB-INF/Clip.jsp").forward(request, response);
	}
	public String getTime(String time){
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        try {
            Calendar uptime = Calendar.getInstance();
            uptime.setTime(sdf.parse(time));
            Calendar onedayafter = Calendar.getInstance();
            onedayafter.setTime(sdf.parse(time));
            onedayafter.add(Calendar.DAY_OF_MONTH,+1);
            Calendar now = Calendar.getInstance();
            //한국이라 9시간 더해줘야함
            //now.add(Calendar.HOUR,9);
            if(now.before(onedayafter)) { // 현재시간은 언제나 업로드 타임보다 앞이라 하루 뒤 시간을 넘었는지만 체크하면됨
                long diffSec = (now.getTimeInMillis()-uptime.getTimeInMillis())/1000;
                long diffHour = diffSec/(60*60);
                //Log.d("시간 차 : ",String.valueOf(diffHour));
                if(diffHour!=0){
                    return diffHour+"시간 전";
                }
                long diffMinute = diffSec/(60);
                //Log.d("분 차 : ",String.valueOf(diffMinute));
                return diffMinute+"분 전";
            }
            sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date d = sdf.parse(time);
            return sdf.format(d);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return "";
    }
}