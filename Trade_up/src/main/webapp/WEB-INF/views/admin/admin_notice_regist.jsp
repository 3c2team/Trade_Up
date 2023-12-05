<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/admin_notice.js"></script>
<script type="text/javascript">

</script>
<title>공지사항 등록</title>
</head>
<body>
	<div class="jumbotron" style="padding: 2rem 2rem;">
		<div class="container">
			<h1 class="display-3" style="font-size: 30px;">
			<strong>공지사항 등록</strong>	
			</h1>
		</div>
	</div>
	
	<div class="container">
		<form name="newProduct" onsubmit="return confirm('등록하시겠습니까?')" action="AdminNoticeRegistPro" class="form-horizontal" method="post" 
		enctype="multipart/form-data">
<!-- 			<div class="form-group row"> -->
<!-- 				<label class="col-sm-2">등록 분류</label> -->
<!-- 				<div class="com-sm-3"> -->
<%-- 					<jsp:include page="../inc/admin_answer.jsp"></jsp:include> --%>
<!-- 				</div> -->
<!-- 			</div> -->
			<div class="form-group row">
				<label class="col-sm-2">제목</label>
				<div class="com-sm-3">
					<input type="text" name="notice_subject" required class="form-control">
				</div>
			</div>
			
			
			<div class="form-group row">
				<label class="col-sm-2">상세 내용</label>
				<div class="com-sm-5">
					<textarea name="notice_content" required cols="50" rows="2" class="form-control" style="width:400px; height: 180px;"></textarea>
				</div>
			</div>
			
			<div class="form-group row">
				<div class="col-sm-offset-2 col-sm-10">
					<input type="reset" class="btn btn-primary" onclick="window.close()" value="취소" >
					<input type="submit"class="btn btn-primary" value="등록" >
				</div>
			</div>
		</form>
	</div>
</body>
</html>