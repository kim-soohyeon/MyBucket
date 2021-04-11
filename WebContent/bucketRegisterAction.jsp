<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="bucket.BucketDTO"%>
<%@ page import="bucket.BucketDAO"%>
<%@ page import="util.SHA256"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
	String userID=null;
	if(session.getAttribute("userID")!=null){
		userID=(String)session.getAttribute("userID");
	}
	if(userID==null){
		PrintWriter script =response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요.')");
		script.println("location.href='userLogin.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
	
	String bucketName=null;
	String bucketType=null;
	int addYear=0;
	int addMonth=0;
	int addDay=0;
	String bucketContent=null;
	
	if(request.getParameter("bucketName")!=null){
		bucketName=request.getParameter("bucketName");
	}
	if(request.getParameter("bucketType")!=null){
		bucketType=request.getParameter("bucketType");
	}
	if(request.getParameter("addYear")!=null){
		try{
			addYear=Integer.parseInt(request.getParameter("addYear"));
		}catch(Exception e){
			System.out.println("목표연도 데이터 오류");
		}
	}
	if(request.getParameter("addMonth")!=null){
		try{
			addMonth=Integer.parseInt(request.getParameter("addMonth"));
		}catch(Exception e){
			System.out.println("목표월 데이터 오류");
		}
	}
	if(request.getParameter("addDay")!=null){
		try{
			addDay=Integer.parseInt(request.getParameter("addDay"));
		}catch(Exception e){
			System.out.println("목표일 데이터 오류");
		}
	}
	if(request.getParameter("bucketContent")!=null){
		bucketContent=request.getParameter("bucketContent");
	}
	
	if(bucketName == null || bucketType == null || addYear==0 || addMonth==0 || addDay==0 || bucketContent==null || 
			bucketName.equals("") || bucketType.equals("") || bucketContent.equals("")){
		PrintWriter script=response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
	BucketDAO bucketDAO=new BucketDAO();
	int result = bucketDAO.write(new BucketDTO(0, userID, bucketName, bucketType, addYear, addMonth, addDay, bucketContent, 0));
	if(result==-1){
		PrintWriter script=response.getWriter();
		script.println("<script>");
		script.println("alert('버킷리스트 등록에 실패했습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}else{
		PrintWriter script=response.getWriter();
		script.println("<script>");
		script.println("location.href='index.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
%>