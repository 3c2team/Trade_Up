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
<style type="text/css">
.custom_btn{
   background-color: rgb(241 244 246);
   border: var(--bs-btn-border-width) solid var(--bs-btn-border-color);
   height: 5rem;
   width: 5rem;
   border-radius: 0.25rem;
    color: gray; 
    font-size: -webkit-xxx-large;
    margin-bottom: 1rem;
    margin-top: 1rem;
}
.custom_img{
   object-fit: cover;
   margin-left: 5px; 
   margin-right: 5px; 
    border: solid;
    border-color: chartreuse;
    border-width: thin;
}
#imgArea{
    overflow: auto;
    white-space: nowrap;
    width: 100%;
}
#reset{
    float: inline-end;
    cursor: pointer;
}
</style>
   <jsp:include page="inc/style.jsp"></jsp:include>
</head>
<body>
   <jsp:include page="inc/top.jsp"></jsp:include>
      <div class="custom_flex2" style="width: 40%;">
         <h2 class="fw-bold" style="text-align: center;">1:1문의</h2>
         <hr class="custom_border_grove">
         <form action="QuestionRegistPro" id="regis_pro" method="post" onsubmit="return question_submit()" enctype="multipart/form-data" >
            <select class="form-control" id="qna_category" style="margin: 20px 0; height: 3.2rem;">
               <option selected disabled value="fdfd fdfd">문의 유형을 선택하세요</option>
               <c:forEach var="selectQnaCategory" items="${selectQnaCategory}">
                  <option value="${selectQnaCategory.qna_category_num}">${selectQnaCategory.qna_category_name}</option>
               </c:forEach>
            </select>
               <select class="form-control" name="qna_category_datail" class="qna_category_datail" id="qna_category_datail" style="margin: 20px 0; height: 3.2rem;" disabled>
                  <option>상세 유형을 선택하세요</option>
               </select>
               <input type="hidden" value="${param.product_num }" name="product_num">
            <textarea class="form-control" name="content" style="resize: none; margin-bottom: 1.25rem; " rows="10" cols="10"></textarea>
            <div class="fs-6 fw-semibold">
               사진 동영상 첨부(
               <span id="count">0</span>/10) <span id="reset">초기화</span>
            </div>
            <div style="display: flex;">
               <button type="button" class="custom_btn" id="fileTrigger">
                  <i class="bi bi-camera"></i>
               </button>      
               <span id="imgArea" >
               </span>
            </div>
            <div class="d-grid gap-2">
               <input type="file"  multiple accept=" audio/*, video/*, image/*" name="file" id="file" style="display:none"/>
               <input type="submit"  style="height: 3.5rem;" id="dis_submit" disabled="disabled" class="btn btn-success" value="등록하기">
            </div>
         </form>
      </div>
   <jsp:include page="inc/bottom.jsp"></jsp:include>
   <script type="text/javascript">
      // 전송 데이터 관리할 DataTransfer 객체 생성
      const dataTransfer = new DataTransfer();
      let change_id = "";
      $(function() {
         $("#fileTrigger").on("click", function() {
            $("#file").trigger("click");
         });
         
         $("#file").on("change", uploadImageHandler);
      });
      let idx = 0;
      function uploadImageHandler(e) {   
         let files = e.target.files;
         console.log(files);
         let filesArr = Array.prototype.slice.call(files);
         console.log(filesArr);

         filesArr.forEach(function(file) {
             if(dataTransfer.files.length > 9) {
               alert("갯수를 초과하였습니다.");
                return;   
             }
            let reader = new FileReader();
            
            reader.onload = function(e) {
               let html = "<a href = \"javascript:void(0);\" id=\"img_" + idx + "\"><img src=\"" + e.target.result + "\" data-file='" + file.name + "' class='custom_img custom_btn' title='클릭 시 제거'></a>";
               $("#imgArea").append(html);
               console.log(idx);
               const deleteImg = $("#img_" + idx);
               idx++;
               $(deleteImg).on('click', (delete_img) => {
//                   debugger;
                  console.log(delete_img.currentTarget.id);
                  let delete_img_num = delete_img.currentTarget.id.split('_')[1]
                  $("#img_"+ delete_img_num)[0].remove();
                  dataTransfer.items.remove(delete_img_num);
                  $("#file")[0].files = dataTransfer.files;
                  $("#count").text($("#file")[0].files.length);
                  idx--;
                  for(let i = 0; i < $("#imgArea").children().length+1; i++){
                     if(i > delete_img_num){
                        change_id = $("#img_" + i);
                        change_id[0].id = "img_" + (i-1);
                     }
                  }
               });
            };
            reader.readAsDataURL(file);
            dataTransfer.items.add(file);
         });
         e.target.files = dataTransfer.files;
         $("#count").text($("#file")[0].files.length);
      }
      $("#reset").on("click",function(){
         $("#imgArea").html("");
         dataTransfer.items.clear();
         $("#file")[0].files = dataTransfer.files;
         idx = 0;
         $("#count").text($("#file")[0].files.length);
      });
      
      $("#qna_category").on("change",function(){
         $("#qna_category_datail").attr("disabled",false);
         console.log($(this).val());
         $("#dis_submit").attr("disabled",true);
         $.ajax({
            type: "POST",
            url: "SelectQnaCategorys",
            data: {
               qnaCategoryName : $(this).val()
            },
            dataType: 'json',
            success: function(data) {
               $("#qna_category_datail").html("<option selected disabled>상세 유형을 선택하세요</option>");
               data.forEach((params)=> {
                  $("#qna_category_datail").append(
                     "<option value="+params.qna_category_detail_num +">"+params.qna_category_detail_name +"</option>"
                  );
               });
               $("#qna_category_datail").on("change",function(){
            	   $("#dis_submit").attr("disabled",false);
               });
            },erorr: function() {
               alert("실패");
            }
         });
      });
      function question_submit() {
		if($("#qna_category").val()=='2'){
			$("#regis_pro")[0].action = 'ReportRegistPro';
		}
		if(confirm("등록하시겠습니까?")){
			alert("등록이 완료되었습니다.");   
			return true;
		}
			return false;
		}
      
   </script>
</body>
</html>