<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
 <meta charset="UTF-8">
    <meta name="description" content="Male_Fashion Template">
    <meta name="keywords" content="Male_Fashion, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Male-Fashion | Template</title>
    <link href="${pageContext.request.contextPath }/resources/css/notice_store.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath }/resources/css/admin_style.css" rel="stylesheet" />
    <script async defer src="https://buttons.github.io/buttons.js"></script>
        <script
		src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js"
		crossorigin="anonymous"></script>
    <script src="${pageContext.request.contextPath }/resources/js/admin_datatable.js"></script>
	<script src="${pageContext.request.contextPath }/resources/js/admin_calender.js"></script>
	<script src="${pageContext.request.contextPath }/resources/js/admin_search_list.js"></script>
	<script src="${pageContext.request.contextPath }/resources/js/admin_authorization.js"></script>
<style type="text/css">
	.custom_price_inquiry{
		width: 70%;
	    margin: auto;
	    margin-top: 2%;
	    margin-bottom: 2%;
	    display: flex;
	    flex-direction: column;
	    align-items: center;
	}
	.custom_box2{
		width: 100%;
		height: 7em;
		margin-bottom: 5%; 
		display: flex;
		background: #a6ebb6!important;
	}
	.custom_price{
	    width: 33%;
    	height: 100%;
	}
	.custom_font{
		margin: 10px;
	}
	.custom_color{
		color: #62f784;
	}
</style>
	<jsp:include page="inc/style.jsp"></jsp:include>
</head>
<body>
	<jsp:include page="inc/top.jsp"></jsp:include>
		<div class="categoryMenuArea">
			<div class="categoryName"><h3>공지사항</h3></div>
			<div class="categoryMenu">
<!-- 	            <a href="/Products?category=All" class="categoryLink">All</a> -->
	            <a href="?category=Notice" class="categoryLink" style="color:black;">공지사항</a>
	            <a href="?category=Event" class="categoryLink" style="color:black;">이벤트</a>
        	</div>
		</div>
		
		<!-- -------------------------------------------------------------------------------------- -->
		<div class="custom_div">
			<div class="table-responsive text-nowrap">
					<form action="MemberListPeriod" method="post" style="margin:30px">
						<table id="datatablesSimple" >
							<thead>
								<tr>
									<th>공지사항</th>
	<!-- 													<th>관리자 권한 부여</th> -->
								</tr>
							</thead>
							<tbody>
	<%-- 											<c:forEach var="" items="${}"> --%>
								<tr>
									<td><a href="" style="color:black;">본문 제목</a></td>
								</tr>
	<%-- 											</c:forEach> --%>
							</tbody>
						</table>	
				</form>
			</div>
		</div>
		
		
	
	
	<jsp:include page="inc/bottom.jsp"></jsp:include>
</body>
</html>