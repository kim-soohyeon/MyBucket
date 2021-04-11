<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="user.UserDAO"%>
<%@ page import="bucket.BucketDTO"%>
<%@ page import="bucket.BucketDAO"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.net.URLEncoder"%>
<!DOCTYPE html>
<!-- 메인화면 입니다. -->
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="icon" href="https://d1ujqdpfgkvqfi.cloudfront.net/favicon-generator/htdocs/favicons/2018-10-09/b16c697d3c0070385bee9f772abe4cb0.ico.png" type="image/x-icon">
	<meta name="viewport" content="width=device-width, initial-scale=1,shrink-to-fit=no">
	<title>MY BUCKETLIST</title>
	<!-- 부트스트랩 CSS 추가하기 -->
	<link rel="stylesheet" href="./css/bootstrap.min.css">
	<!-- 커스텀 CSS 추가하기 -->
	<link rel="stylesheet" href="./css/custom.css">
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	String bucketDivide="전체";
	String searchType="최신순";
	String search="";
	int pageNumber=0;
	if(request.getParameter("bucketDivide")!=null){
		bucketDivide=request.getParameter("bucketDivide");
	}
	if(request.getParameter("searchType")!=null){
		searchType=request.getParameter("searchType");
	}
	if(request.getParameter("search")!=null){
		search=request.getParameter("search");
	}
	if(request.getParameter("pageNumber")!=null){
		try{
			pageNumber=Integer.parseInt(request.getParameter("pageNumber"));
		}catch(Exception e){
			System.out.println("검색 페이지 번호 오류");
		}
	}
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
	boolean emailChecked=new UserDAO().getUserEmailChecked(userID);
	if(emailChecked==false){
		PrintWriter script =response.getWriter();
		script.println("<script>");
		script.println("location.href='emailSendConfirm.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
%>
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
		<a class="navbar-brand" href="index.jsp"><img src="https://static.wixstatic.com/media/611892_cacc5e3df4dd4b09aedf730efd02b3f8%7Emv2.png_srz_80_80_85_22_0.50_1.20_0.00_png_srz" width="50" height="40"></a>
		<a class="navbar-brand" href="index.jsp">My BucketList</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div id="navbar" class="collapse navbar-collapse">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item active">
					<a class="nav-link" href="index.jsp">메인</a>
				</li>
				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" id="dropdown" data-toggle="dropdown">
						MyBucket
					</a>
					<div class="dropdown-menu" aria-labelledby="dropdown">
<%
	if(userID==null){
%>						
						
						<a class="dropdown-item" href="userLogin.jsp">로그인</a>
						<a class="dropdown-item" href="userJoin.jsp">회원가입</a>
<%
	}else{
%>
						<a class="dropdown-item" href="userLogout.jsp">로그아웃</a>
<%
	}
%>
					</div>
				</li>
			</ul>
			<form action="./index.jsp" method="get" class="form-inline my-2 my-lg-0">
				<input type="text" name="search" class="form-control mr-sm-2" type="search" placeholder="내용을 입력하세요." aria-label="Search">
				<button class="btn btn-outline-info my-2 my-sm-0" type="submit">검색</button>
			</form>
		</div>
	</nav>
	<section class="container">
		<form method="get" action="./index.jsp" class="form-inline mt-3">
			<select name="bucketDivide" class="form-control mx-1 mt-2">
				<option value="전체">전체</option>
				<option value="여행" <% if(bucketDivide.equals("여행")) out.println("selected"); %>>여행</option>
				<option value="운동" <% if(bucketDivide.equals("운동")) out.println("selected"); %>>운동</option>
				<option value="음식" <% if(bucketDivide.equals("음식")) out.println("selected"); %>>음식</option>
				<option value="기술" <% if(bucketDivide.equals("기술")) out.println("selected"); %>>기술</option>
				<option value="문화" <% if(bucketDivide.equals("문화")) out.println("selected"); %>>문화</option>
				<option value="생활" <% if(bucketDivide.equals("생활")) out.println("selected"); %>>생활</option>
				<option value="기타" <% if(bucketDivide.equals("기타")) out.println("selected"); %>>기타</option>
			</select>
			<select name="searchType" class="form-control mx-1 mt-2">
				//<option value="최신순">최신순</option>
				<!-- <option value="추천순"<% if(searchType.equals("추천순")) out.println("selected"); %>>추천순</option> -->
			</select>
			<input type="text" name="search" class="form-control mx-1 mt-2" placeholder="내용을 입력하세요.">
			<button type="submit" class="btn btn-outline-info mx-1 mt-2">검색</button>
			<a class="btn btn btn-outline-info mx-1 mt-2" data-toggle="modal" href="#addModal">추가하기</a>
		</form>
<%
	ArrayList<BucketDTO> bucketList=new ArrayList<BucketDTO>();
	bucketList=new BucketDAO().getList(bucketDivide, searchType, search, pageNumber);
	if(bucketList != null)
		for(int i=0; i<bucketList.size(); i++){
			if(i==5) break;
			BucketDTO bucket =bucketList.get(i);
%>	
		<div class="card bg-light mt-3">
			<div class="card-header bg-light">
				<div class="row">
					<div class="col-8 text-left"><%= bucket.getBucketName() %>&nbsp;<small>작성자: <%= bucket.getUserID() %></small></div>
					<div class="col-4 text-right">
						구분: <span style="color: blue;"><%= bucket.getBucketType() %></span>
					</div> 
				</div>
			</div>
			<div class="card-body">
				<p class="card-text"><%= bucket.getBucketContent() %></p>
				<div class="row">
					<div class="col-9 text-left">
						<!-- <span style="color: green;">(추천: <%= bucket.getLikeCount() %>)</span> -->
						<input type="button" value="진행중" onclick="change(this)" style="background-color:yellow;"><br>
						<script language="JavaScript">
						    function change(obj){
						        obj.style.background = 'green';
						        obj.value = "완료";
						    }
						</script>
					</div>
					<div class="col-3 text-right">
						
						<a style="color: green;" onclick="return confirm('이 버킷리스트를 삭제하시겠습니까?')" href="./deleteAction.jsp?bucketID=<%= bucket.getBucketID() %>">삭제</a>
					</div>
				</div>
			</div>
		</div>
<%
		}
%>	
	</section>	
	<ul class="pagination justify-content-center mt-3">
		<li class="page-item">
<%
	if(pageNumber <=0){
%>		
	<a class="page-link disabled">이전</a>
<%
	}else{
%>
	<a class="page-link" href="./index.jsp?bucketDivide=<%= URLEncoder.encode(bucketDivide,"UTF-8") %>&searchType=
	<%= URLEncoder.encode(searchType,"UTF-8") %>&search=<%= URLEncoder.encode(search,"UTF-8") %>&pageNumber=
	<%= pageNumber - 1 %>">이전</a>
<%
	}
%>
		</li>
		<li>
<%
	if(bucketList.size() <6){
%>		
	<a class="page-link disabled">다음</a>
<%
	}else{
%>
	<a class="page-link" href="./index.jsp?bucketDivide=<%= URLEncoder.encode(bucketDivide,"UTF-8") %>&searchType=
	<%= URLEncoder.encode(searchType,"UTF-8") %>&search=<%= URLEncoder.encode(search,"UTF-8") %>&pageNumber=
	<%= pageNumber + 1 %>">다음</a>
<%
	}
%>
		</li>
	</ul>
	<div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modal">버킷리스트 추가</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="./bucketRegisterAction.jsp" method="post">
						<div class="form-row">
							<div class="form-group col sm-8">
								<label>리스트명</label>
								<input type="text" name="bucketName" class="form-control" maxlength="20">
							</div>
						</div>
						<div class="form-row">
							<div class="form-group col sm-4">
								<label>구분</label>
								<select name="bucketType" class="form-control">
									<option value="전체">전체</option>
									<option value="여행">여행</option>
									<option value="운동">운동</option>
									<option value="음식">음식</option>
									<option value="기술">기술</option>
									<option value="문화">문화</option>
									<option value="생활">생활</option>
									<option value="기타">기타</option>
								</select>
							</div>
						</div>
						<div class="form-row">
							<div class="form-group">
								<label>목표연도</label>
								<select name="addYear" class="form-control">
									<option value="2011">2011</option>
									<option value="2012">2012</option>
									<option value="2013">2013</option>
									<option value="2014">2014</option>
									<option value="2015">2015</option>
									<option value="2016">2016</option>
									<option value="2017">2017</option>
									<option value="2018" selected>2018</option>
									<option value="2017">2019</option>
									<option value="2017">2020</option>
									<option value="2017">2021</option>
									<option value="2017">2022</option>
								</select>
							</div>
							<div class="form-group col-sm-2">
								<label>목표월</label>
								<select name="addMonth" class="form-control">
									<option value="1" selected>1</option>
									<option value="2">2</option>
									<option value="3">3</option>
									<option value="4">4</option>
									<option value="5">5</option>
									<option value="6">6</option>
									<option value="7">7</option>
									<option value="8">8</option>
									<option value="9">9</option>
									<option value="10">10</option>
									<option value="11">11</option>
									<option value="12">12</option>
								</select>
							</div>
							<div class="form-group col-sm-2">
								<label>목표일</label>
								<select name="addDay" class="form-control">
									<option value="1" selected>1</option>
									<option value="2">2</option>
									<option value="3">3</option>
									<option value="4">4</option>
									<option value="5">5</option>
									<option value="6">6</option>
									<option value="7">7</option>
									<option value="8">8</option>
									<option value="9">9</option>
									<option value="10">10</option>
									<option value="11">11</option>
									<option value="12">12</option>
									<option value="13">13</option>
									<option value="14">14</option>
									<option value="15">16</option>
									<option value="17">17</option>
									<option value="18">18</option>
									<option value="19">19</option>
									<option value="20">20</option>
									<option value="21">21</option>
									<option value="22">22</option>
									<option value="23">23</option>
									<option value="24">24</option>
									<option value="25">25</option>
									<option value="26">26</option>
									<option value="27">27</option>
									<option value="28">28</option>
									<option value="29">29</option>
									<option value="30">30</option>
									<option value="31">31</option>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label>세부내용</label>
							<textarea name="bucketContent" class="form-control" maxlength="2048" style="height: 180px;"></textarea>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-outline-secondary" data-dismiss="modal">취소</button>
							<button type="submit" class="btn btn-outline-info">추가하기</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<footer class="bg-dark mt-4 p-5 text-center" style="color: #FFFFFF;">
		201744012 김수현의 MyBucket
	</footer>
	<!-- 제이쿼리 자바스크립트 추가하기 -->
	<script src="./js/jquery.min.js"></script>
	<!-- 파퍼 자바스크립트 추가하기 -->
	<script src="./js/pooper.js"></script>
	<!-- 부트스트랩 자바스크립트 추가하기 -->
	<script src="./js/bootstrap.min.js"></script>
</body>
</html>