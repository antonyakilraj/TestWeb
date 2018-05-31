//This program is an example for doGet method.
//you can use the doPost method using the doPost html.
package com.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/GetMethodUrl")
public class GetMethodUrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 // Set response content type
	      response.setContentType("text/html");

	      PrintWriter out = response.getWriter();
	      String title = "Using GET Method to Read Form Data";
	      String docType =
	         "<!doctype html public \"-//w3c//dtd html 4.0 " + "transitional//en\">\n";
	         
	      out.println(docType +
	         "<html>\n" +
	            "<head><title>" + title + "</title></head>\n" +
	            "<body bgcolor = \"#f0f0f0\">\n" +
	               "<h1 align = \"center\">" + title + "</h1>\n" +
	               "<ul>\n" +
	                  "  <li><b>The data from url is</b>: "
	                  + request.getParameter("your_data") + "\n" +
	                  	               "</ul>\n" +
	            "</body></html>"
	      
	      );
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}


//use the below URL to check the output
//http://localhost:8080/TestWeb/GetMethodUrl?your_data=hi
//you can enter your own value for your_data.
