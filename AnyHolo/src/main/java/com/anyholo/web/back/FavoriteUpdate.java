package com.anyholo.web.back;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.anyholo.db.DBController;

@WebServlet("/FavoriteUpdate")
public class FavoriteUpdate extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");;
		response.setCharacterEncoding("UTF-8");
		DBController dbc = new DBController();
		String name="";
		String updel = request.getParameter("updel");
		if(request.getParameter("Name")!=null)
			name=request.getParameter("Name");
		String id="";
		HttpSession session= request.getSession();
		id=(String) session.getAttribute("id");
		System.out.println(id+":"+name+":"+updel);
		try {
			if(updel.equals("up")) {
				dbc.FavoriteUpdate(id, name);
				session.setAttribute("favorite", name+";"+session.getAttribute("favorite"));
			}
			else {
				dbc.FavoriteUpdate_Del(id, name);
				session.setAttribute("favorite", ((String)session.getAttribute("favorite")).replace(name+";", ""));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}