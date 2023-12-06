const HOME=$("#HOME").val();

//유효성 체크변수 설정
const member_nameValidation = $('.member_nameValidation');
const member_nick_nameValidation=$(".member_nick_nameValidation");	
const member_idValidation = $('.member_idValidation');
const member_passwdValidation = $('.member_passwdValidation');	
const member_passwd2Validation = $('.member_passwd2Validation');	
const emailValidation = $('.emailValidation');	
const member_phone_numValidation=$(".member_phone_numValidation");


//회원 변수 설정
const member_name = $('#member_name');
const member_nick_name= $('#member_nick_name');	
const member_id = $('#member_id');
const  member_passwd = $('#member_passwd');
const  member_passwd2 = $('#member_passwd2');
const postcode=$("#postcode");
const member_address1=$("#member_address1");
const member_address2=$("#member_address2");
const member_email1 = $('#member_email1');
const member_email2 = $('#member_email2');
const member_phone_num = $('#member_phone_num');
const member_birth=$("#member_birth");


//
//색상
const checkedValueColor = "#4CAF50";
const usedValueColor = "#ff1744";
const defaultColor = "#aaa";
	
	
$(function(){	

    //1.이름 체크
	$('#member_name').on('keyup',   function() {		
		member_name.removeClass("checkedValue");
		member_name.removeClass("usedValue");
		member_name.attr("check", "1");
		
		if (member_name.val() == "") {
			member_nameValidation.text("이름을 입력해주세요.");
			member_nameValidation.css("color", defaultColor);
		} else {		
			
			 var getName= RegExp(/^[가-힣]+$/);
			 if(!getName.test($("#member_name").val())){
			        member_nameValidation.text("이름은 한글만 입력 가능합니다.");
				    member_nameValidation.css("color", usedValueColor);			
			        $("#member_name").focus();
			        return false;
			    }	
			 member_nameValidation.text("");
			 member_name.attr("check", "0");
		}
	});
	
	 //2.닉네임 체크
	$('#member_nick_name').on('keyup', function() {
			member_nick_name.removeClass("checkedValue");
			member_nick_name.removeClass("usedValue");
			member_nick_name.attr("check", "1");
			if (member_nick_name.val() == "") {
				member_nick_nameValidation.text("닉네임을 입력해주세요.");
				member_nick_nameValidation.css("color", defaultColor);
				return false;
			} 
		 	member_nick_nameValidation.text("");
		 	member_nick_name.attr("check", "0");
		 	
		 	$.ajax({
							type : "POST",
							data : {
								member_nick_name : member_nick_name.val()
							},
							url : `${HOME}/join/memberCheckDupNickname`,
							success : function(result) {
								
								if (result) {
									if (member_nick_name.val() == "") {
										member_nick_nameValidation.text("닉네임을 입력해주세요.");
										member_nick_nameValidation.css("color",defaultColor);
									} else {
										
												member_nick_name.addClass("checkedValue");
												member_nick_name.attr("check","0");
												member_nick_nameValidation.text("사용 가능한 닉네임입니다.");
												member_nick_nameValidation.css("color",checkedValueColor);											
									}
								} else if (!result) {
									// 중복 있음
									member_nick_name.addClass("usedValue");
									member_nick_nameValidation.text("이미 사용 중인 닉네임입니다.");
									member_nick_nameValidation.css("color",usedValueColor);
								}
							}
		     });
		 	
		 	
		 	
	});

 
    //3.아이디 체크
	$('#member_id').on('keyup',function() {
						member_id.removeClass("checkedValue");
						member_id.removeClass("usedValue");
						member_id.attr("check", "1");

						if (member_id.val() == "") {
							member_idValidation.text("아이디를 입력해주세요.");
							member_idValidation.css("color", defaultColor);
						}

						$.ajax({
							type : "POST",
							data : {
								member_id : member_id.val()
							},
							url : `${HOME}/join/memberCheckDupId`,
							success : function(result) {
								//console.log("아이디 중복 체크 : ", result);
								if (result) {
									if (member_id.val() == "") {
										member_idValidation.text("아이디를 입력해주세요.");
										member_idValidation.css("color",defaultColor);
									} else {
										
										if(isId(member_id.val())){
													// 중복 없음 && 정규식 통과
												member_id.addClass("checkedValue");
												member_id.attr("check","0");
												member_idValidation.text("사용 가능한 아이디입니다.");
												member_idValidation.css("color",checkedValueColor);
										}else{
												// 중복 없음 && 정규식체크  실패
												member_id.addClass("checkedValue");
												member_id.attr("check","1");
												member_idValidation.text("영문소문자/숫자, 4~16자로 입력해 주세요.");
												member_idValidation.css("color",usedValueColor);
										}									
									
									}
								} else if (!result) {
									// 중복 있음
									member_id.addClass("usedValue");
									member_idValidation.text("이미 사용 중인 아이디입니다.");
									member_idValidation.css("color",usedValueColor);
								}
							}
						});
	});
					
	
	//4.비밀번호 체크
	$('#member_passwd').on('keyup', function() {
		member_passwd.removeClass("checkedValue");
		 member_passwd.removeClass("usedValue");
		 member_passwd.attr("check", "1");

		if ( member_passwd.val() == "") {
			member_passwdValidation.text("비밀번호를 입력해주세요.");
			member_passwdValidation.css("color", defaultColor);
		} else {

           //영문 대소문자/숫자/특수문자 중 2가지 이상 조합, 8자~16자        
			if (isPassword(member_passwd.val())) {
				member_passwd.addClass("checkedValue");
				member_passwd.attr("check", "0");
				member_passwdValidation.text("사용 가능한 비밀번호입니다.");
				member_passwdValidation.css("color", checkedValueColor);
			} else {
 				member_passwd.addClass("usedValue");
				 member_passwd.attr("check", "1");
				 member_passwdValidation.text("영문 대소문자/숫자/특수문자 중 2가지 이상 조합, 8자~16자로 입력해 주세요.");
				 member_passwdValidation.css("color", usedValueColor);
			}
		}
	});
	
	
	
	//5.비밀번호 확인 체크
	$('#member_passwd2').on('keyup',function() {
				member_passwd2.removeClass("checkedValue");
				member_passwd2.removeClass("usedValue");
				member_passwd2.attr("check", "1");
				
				if (member_passwd2.val() == "") {
					member_passwd2Validation.text("비밀번호를 확인해주세요.");
					member_passwd2Validation.css("color", defaultColor);
				}

				if (member_passwd.val() != member_passwd2.val()) {
					member_passwd2.addClass("usedValue");
					member_passwd2.attr("check", "1");
					member_passwd2Validation.text("비밀번호 확인 입력값이 비밀번호와 다릅니다.");
					member_passwd2Validation.css("color", usedValueColor);
				} else {
					if (isPassword(member_passwd.val())  && (member_passwd.val() == member_passwd2.val() )) {
						member_passwd2.addClass("checkedValue");
						member_passwd2.attr("check", "0");
						member_passwd2Validation.text("비밀번호 확인 입력값이 비밀번호와 일치합니다.");
						member_passwd2Validation.css("color",checkedValueColor);
					}
				}
	
	});



				
  	//이메일 체크
	$('#member_email1').on('keyup',	function() {
			emailCheck();
	});
	
	//이메일 체크
	$('#member_email2').on('keyup',	function() {
			emailCheck();
	});
	
	
	
	
	//6.전화번호 확인 체크
	$('#member_phone_num').on('keyup',function() {
				member_phone_num.removeClass("checkedValue");
				member_phone_num.removeClass("usedValue");
				member_phone_num.attr("check", "1");
				
				if (member_phone_num.val() == "") {
					member_phone_numValidation.text("-을 포함해서 입력해 주세요.(예) 000-0000-0000 ");
					member_phone_numValidation.css("color", defaultColor);
					return;
				}	
				
/*				if(!isPhoneNumber(member_phone_num.val())){
					member_phone_numValidation.text("전화번호 형식이 맞지 않습니다.");
					member_phone_numValidation.css("color", usedValueColor);
					return;
				}*/
				
				
			$.ajax({
							type : "POST",
							data : {
								member_phone_num : member_phone_num.val()
							},
							url : `${HOME}/join/memberCheckDupPhone`,
							success : function(result) {
								//console.log("전화번호 중복 체크 :", result);
								
								if (result) {
									if (member_phone_num.val() == "") {
										member_phone_numValidation.text("전화번호를 입력해주세요.");
										member_phone_numValidation.css("color",defaultColor);
										return;
									} else {
								/*		
												member_phone_num.addClass("checkedValue");
												member_phone_num.attr("check","0");
												member_phone_numValidation.text("사용 가능한 전화번호번호입니다.");
												member_phone_numValidation.css("color",checkedValueColor);*/												
										
								
										if(member_phone_num.val().length>=12 && member_phone_num.val().length <14){
													// 중복 없음 && 정규식 통과
												member_phone_num.addClass("checkedValue");
												member_phone_num.attr("check","0");
												member_phone_numValidation.text("사용 가능한 전화번호번호입니다.");
												member_phone_numValidation.css("color",checkedValueColor);
												return;
										}else{
												// 중복 없음 && 정규식체크  실패
												member_phone_num.addClass("checkedValue");
												member_phone_num.attr("check","1");
												member_phone_numValidation.text("전화번호 형식이 맞지  않습니다.");
												member_phone_numValidation.css("color",usedValueColor);
												return;
										}						
									
									}
								} else{
									// 중복 있음
									member_phone_num.addClass("usedValue");
									member_phone_numValidation.text("이미 사용 중인 전화번호번호입니다.");
									member_phone_numValidation.css("color",usedValueColor);
								}
							}
						});		
	
	});


	
	$("input[type='reset']").on("click", function(){
		location.reload();
	})
	
	
});	

//이메일 체크
//function emailCheck(){
//				member_email1.removeClass("checkedValue");
//				member_email1.removeClass("usedValue");
//				member_email1.attr("check", "1");
//
//				if (member_email1.val() == "" || member_email2.val() =="") {
//					emailValidation.text("이메일을 입력해주세요.");
//					emailValidation.css("color", defaultColor);
//					return;
//				}
//				
//				const email=member_email1.val()+"@"+member_email2.val();
//				//console.log(" email  ", email);
//				
//				if(checkEmail(email)){
//					emailValidation.text("사용 가능한 이메일입니다.");
//					emailValidation.css("color", checkedValueColor);													
//				}else{
//					emailValidation.text("이메일 형식에 맞지 않습니다.");
//					emailValidation.css("color", usedValueColor);							
//					return;
//				}
//
//				$.ajax({
//					type : "POST",
//					data : {
//						member_e_mail : email
//					},
//					url :`${HOME}/join/memberCheckDupMail`,
//					success : function(result) {
//						console.log("이메일 중복 체크  : " ,result);
//
//						if (result) {
//							console.log("이메일 중복 아님  ");
//							
//							if (member_email1.val() == "" || member_email2.val() =="") {
//								emailValidation.text("인증번호를 이메일로 보내드리니 한번 더 확인 후 가입해주세요.");
//								emailValidation.css("color",defaultColor);
//								
//								return;
//							} else {
//								// 중복 없음
//								member_email1.addClass("checkedValue");
//								member_email1.attr("check", "0");
//								emailValidation.text("사용 가능한 이메일입니다.");
//								emailValidation.css("color",checkedValueColor);
//								return;
//							}
//
//						} else{
//							// 중복 있음
//							console.log("이메일 중복 ");
//							member_email1.addClass("usedValue");
//							emailValidation.text("이미 사용중인 이메일입니다.");
//							emailValidation.css("color", usedValueColor);
//						}
//					}
//				});
//
//			
//}

 

//빠르게 입력할때 0.35초의 딜레이를 줘서 여러번 ajax를 실행하는걸 방지	
 function delayQuery(input) {		
	  clearTimeout(input);	
	return new Promise((resoleve)=>{
		 input = setTimeout(function() {								
			console.log(" 대기")  		
  		 },2000);	  
	})	
}
	
//아이디 체크  : 영문자로 시작하는 영문자 또는 숫자 4~20자 	
function isId(asValue) {
	var regExp = /^[a-z]+[a-z0-9]{3,19}$/g; 
	return regExp.test(asValue);
}	
	
//비밀번호 체크 : 	영문, 숫자, 특수문자 중 2가지 이상 조합하 8자~16자
function isPassword(asValue) {
	var regExp = /^(?!((?:[A-Za-z]+)|(?:[~!@#$%^&*()_+=]+)|(?:[0-9]+))$)[A-Za-z\d~!@#$%^&*()_+=]{8,16}$/;
	return regExp.test(asValue); // 형식에 맞는 경우 true 리턴
}	
	

//주소 입력
function daumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                   //  document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                   // document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('postcode').value = data.zonecode;
                document.getElementById("member_address1").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("member_address2").focus();
            }
        }).open();
}
	
	
function emailDomainChange(event){
	const thisValue=$(event).val();
	$("#member_email2").val(thisValue);	
	//이메일 체크
	emailCheck();
}

//휴대폰 유효성 검사
function isPhoneNumber(asValue) {
	//var regExp = /^01(?:0|1|[6-9])-(?:\d{3}|\d{4})-\d{4}$/; 
	//var regExp = /(^02.{0}|^01.{1}|[0-9]{3,4})([0-9]{3,4})([0-9]{4})/g;
	var regExp = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?[0-9]{3,4}-?[0-9]{4}$/;
	return regExp.test(asValue);
	
	
}

//이메일 유효성검사
function checkEmail(str){                                                 
	     var reg_email = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;
	     if(!reg_email.test(str)) {                            
	          return false;         
	     }else {                       
	          return true;         
	     }                            
}  	
	
// 전화번호 입력 시 자동 하이픈 생성
/*
function oninputPhone(target) {
   target.value = target.value.replace(/[^0-9]/g, '').replace(/^(\d{2,3})(\d{3,4})(\d{4})$/, `$1-$2-$3`)
}
*/

//전화번호 입력 필드에 입력이 있을 때마다 실행되는 함수
function oninputPhone(target) {
	// 입력된 값을 숫자만 남기고 모두 제거한 후,
    // 특정 패턴에 맞게 하이픈(-)을 추가하여 전화번호 형식으로 만듦
    target.value = target.value
        .replace(/[^0-9]/g, '')		// 숫자가 아닌 문자를 제거
        .replace(/(^02.{0}|^01.{1}|[0-9]{3,4})([0-9]{3,4})([0-9]{4})/g, "$1-$2-$3");
}


//function  emailAuthPopupLayer(el){
//		
//		if (member_email1.val() == "" || member_email2.val() =="") {
//			alert("이메일을 입력해주세요.");
//			return;
//		}
//		const email=member_email1.val()+"@"+member_email2.val();			
//		if(!checkEmail(email)){
//				alert("이메일 형식에 맞지 않습니다.");
//				return;				
//		}
//		
//		if(member_email1.attr("check")!="0"){
//			   alert("이미 사용중인 이메일 입니다. 이메일을 확인해 주세요.");
//				return;
//		}
//		
//		$.ajax({
//			 type : "POST",
//			 data : {email:email},
//			url : `${HOME}/join/emailAuthSend`,
//			success : function(res) {		
//			  if(res=="success"){
//					poupLayerOepn(el);
//				}else{
//					alert("이메일 전송 오류");
//				} 											
//			},
//			error:function(res){	
//				 console.log(" 에러  :", res);
//			 }
//		});	
//}



//function poupLayerOepn(el){
//		$("#inputAuthEmailCode").val("");
//		
//	    var $el = $(el);		//레이어의 id를 $el 변수에 저장
//        var isDim = $el.prev().hasClass('dimBg');	//dimmed 레이어를 감지하기 위한 boolean 변수
//
//        isDim ? $('.dim-layer').fadeIn() : $el.fadeIn();
//
//        var $elWidth = ~~($el.outerWidth()),
//            $elHeight = ~~($el.outerHeight()),
//            docWidth = $(document).width(),
//            docHeight = $(document).height();
//
//        // 화면의 중앙에 레이어를 띄운다.
//        if ($elHeight < docHeight || $elWidth < docWidth) {
//            $el.css({
//                marginTop: -$elHeight /2,
//                marginLeft: -$elWidth/2
//            })
//        } else {
//            $el.css({top: 0, left: 0});
//        }
//
//        $el.find('a.btn-layerClose').click(function(){
//            isDim ? $('.dim-layer').fadeOut() : $el.fadeOut(); // 닫기 버튼을 클릭하면 레이어가 닫힌다.
//            return false;
//        });
//
//        $('.layer .dimBg').click(function(){
//            $('.dim-layer').fadeOut();
//            return false;
//        });
//}

//이메일 인증처리
//function emailAuthConfirm(){		
//	   const inputAuthEmailCode=$("#inputAuthEmailCode").val();
//	   const email=member_email1.val()+"@"+member_email2.val();		
//	   if(!inputAuthEmailCode){
//		   alert("이메일 인증코드 값을 입력해 주세요.");
//		   $("#inputAuthEmailCode").focus();
//		   return;
//	   }
//		$.ajax({
//			 type : "POST",
//			 data : {
//				 member_e_mail :email, 
//			 	 inputAuthEmailCode:inputAuthEmailCode
//			 },
//			url : `${HOME}/join/emailAuthConfirm`,
//			success : function(res) {		
//				
//			  if(res=="success"){
//					$("#member_email1").attr("disabled", true);
//					$("#member_email2").attr("disabled", true);
//					$("#member_emailDomain").attr("disabled", true);
//					$("#emailAuthPopupLayer-btn").attr("disabled", true);
//					$(".emailValidation").text("이메일 인증 처리 완료");					
//					alert("이메일 인증 처리 되었습니다.");
//					$(".btn-layerClose").click();
//				}else if(res=="authCodeError"){
//					alert("인증코드 값이 일치하지 않습니다. 다시 확인 부탁드립니다.");
//					$("#inputAuthEmailCode").val("");
//				}																
//			},
//			error:function(res){	
//				 console.log(" 에러  :", res.responseText);
//				alert("이메일 인증 오류 입니다.");
//			 }
//		});	
//		
//}


// '출생 연도' 셀렉트 박스 option 목록 동적 생성--년도
const birthYearEl = document.querySelector('#birth-year');
const now = new Date();	// 현재 날짜 및 시간
const nowYear = now.getFullYear();	// 연도
	// option 목록 생성 여부 확인
	isYearOptionExisted = false;
	
	birthYearEl.addEventListener('focus', function () {
	  // year 목록 생성되지 않았을 때 (최초 클릭 시)
	  if(!isYearOptionExisted) {
	    isYearOptionExisted = true;
	    for(let i = 1945; i <= nowYear; i++) {
	      // option element 생성
	      const YearOption = document.createElement('option')
	      YearOption.setAttribute('value', i)
	      YearOption.innerText = i
	      // birthYearEl의 자식 요소로 추가
	      this.appendChild(YearOption);
	    }
  }
});
// '출생 연도' 셀렉트 박스 option 목록 동적 생성--월
const monthEl = document.querySelector('#birth-month');
	isMonthOptionExisted = false;

	monthEl.addEventListener('focus', function () {
	  if(!isMonthOptionExisted) {
	    isMonthOptionExisted = true
	    for(let i = 1; i <= 12; i++) {
	      const monthOption = document.createElement('option')
		      monthOption.setAttribute('value', i)
		      monthOption.innerText = String(i).padStart(2,"0");
		      this.appendChild(monthOption);
	    }
  }
});

// '출생 연도' 셀렉트 박스 option 목록 동적 생성--날
const dayEl = document.querySelector('#birth-day');
	isDayOptionExisted = false;

	dayEl.addEventListener('focus', function () {

	  if(!isDayOptionExisted) {
	    isDayOptionExisted = true
	    for(let i = 1; i <= 31; i++) {
	      const dayOption = document.createElement('option')
		      dayOption.setAttribute('value', i)
		      dayOption.innerText = String(i).padStart(2,"0");
		      this.appendChild(dayOption);
	    }
	    
  }
  
});




function joinChecks() {
		
		//이름 체크
		if(member_name.val()==""){
			   alert("이름을 입력해 주세요.");
			   member_name.focus();
				return;
		}
		
		if(member_nick_name.val()==""){
			   alert("닉네임을 입력해 주세요.");
			   member_nick_name.focus();
				return;
		}	
	
		if(member_id.val()==""){
			   alert("아이디를 입력해 주세요.");
			   member_id.focus();
				return;
		}		
		
		if(member_passwd.val()==""){
			   alert("비밀번호를 입력해 주세요.");
			   member_passwd.focus();
				return;
		}			
		
		if(member_passwd2.val()==""){
			   alert("비밀번호확인을  입력해 주세요.");
			   member_passwd2.focus();
				return;
		}		
		
		if(postcode.val()==""){
			   alert("우편번호를  입력해 주세요.");
			   postcode.focus();
				return;
		}		
		
		if(member_address1.val()==""){
			   alert("주소를  입력해 주세요.");
			   member_address1.focus();
				return;
		}		
		
	
		if(member_email1.val()==""){
			 alert("이메일을  입력해 주세요.");
			 member_email1.focus();
			return;			
		}
		
		if(member_email2.val()==""){
			 alert("이메일을  입력해 주세요.");
			 member_email2.focus();
			return;			
		}
						
		
		if(member_phone_num.val()==""){
			   alert("전화번호를  입력해 주세요.");
			   member_phone_num.focus();
				return;
		}	
		
			
		if(member_phone_num.val()==""){
			   alert("전화번호를  입력해 주세요.");
			   member_phone_num.focus();
				return;
		}	
		
		const birthYear=$("#birth-year");
		const birthMonth=$("#birth-month");
		const birthDay=$("#birth-day");		
	     const birth=birthYear.val()+"-"+birthMonth.val()+"-"+birthDay.val();
	     console.log(" 생일 입력 :", birth);
	     $("#member_birth").val(birth);
	     	     
		if(birthYear.val()=="" || birthYear.val()==null){
			alert("생일을  입력해 주세요.");
			birthYear.focus();
			return;
		}  

		if(birthMonth.val()=="" || birthMonth.val()==null){
			alert("생일을  입력해 주세요.");
			birthMonth.focus();
			return;
		}  
		
		if(birthDay.val()=="" || birthDay.val()==null){
			alert("생일을  입력해 주세요.");
			birthDay.focus();
			return;
		}  
		
//		const emailAuthConfirm=$("#emailAuthPopupLayer-btn").attr("disabled");
//		console.log(" 이메일 인증 확인 :", emailAuthConfirm);
//		if(emailAuthConfirm!="disabled"){
//			alert("이메일 인증후 회원가입이 가능합니다.");
//			return;
//		}
		
		
	   console.log(" member_name.attr " , member_name.attr("check"));
		console.log(" member_nick_name.attr " , member_nick_name.attr("check"));
		console.log(" member_id.attr " , member_id.attr("check"));
		console.log(" member_passwd.attr " , member_passwd.attr("check"));
		console.log(" member_email1.attr " , member_email1.attr("check"));
		console.log(" member_phone_num.attr " , member_phone_num.attr("check"));
		
		
		if(member_name.attr("check") == "0" &&
			member_nick_name.attr("check")=="0" &&
			member_id.attr("check")=="0"&&
			member_passwd.attr("check")=="0" &&
			member_email1.attr("check")=="0" &&
			member_phone_num.attr("check")=="0"
		){
//			const  email=member_email1.val()+"@"+member_email2.val();
//			$("#member_e_mail").val(email);
//			
//				/*		
//						const paramData={
//								member_id : member_id.val(),
//								email : email.val(),
//								member_name : $('#member_name').val(),
//								gender:genderChoice,
//								member_phone_num:$('#member_phone_num').val(),
//								password : password.val(),
//								member_passwd2 : member_passwd2.val()
//						}*/
//						
//													
//						$.ajax({
//							type : "POST",									
//							url : `${HOME}/join/joinPro`,
//							data :$("#joinForm").serialize(),
//							success:function(res) {
//								console.log("회원가입  :", res);
//									
//								 if(res=="emailAuthError"){
//									 alert("이메일 인증후 회원가입이 가능합니다.");
//									 return;
//								 }
//								 
//								 				       
//								if (res.status== "success") {
//									alert(res.msg);
//									location.href = `${HOME}/login/Login`;
//								}else if (res.status== "failed") {
//									alert(res.msg);
//									return;
//								}else{;
//									alert("회원 가입 실패");
//								}	
//								
//																																
//							},
//							error:function(res){
//								console.log("에러   :", res);
//								alert("회원 가입 에러 입니다.");								
//							}
//						
//					     }).done(function (data) {
//					    		 console.log("done");
//								console.log(data);
//			            });
//			            			            
		}else{
					
			if(member_name.attr("check") == "1"){
				alert("이름을 확인해 주세요.");
				member_name.focus();
				return;
		
			} else if(member_nick_name.attr("check") == "1"){
				alert("닉네임을 확인해 주세요.");
				member_nick_name.focus();
				return;
			
			
			} else if(member_nick_name.attr("check") == "1"){
				alert("아이디를 확인해 주세요.");
				member_nick_name.focus();
				return;
			 
			
			}else if(member_passwd.attr("check") == "1"){
				alert("비밀번호를 확인해 주세요.");
				member_passwd.focus();
				return;
			 

			}else if(member_email1.attr("check") == "1"){
				alert("이메일을 확인해 주세요.");
				member_email1.focus();
				return;
				
				
			}else if(member_phone_num.attr("check") == "1"){
				alert("전화번호를  확인해 주세요.");
				member_phone_num.focus();
				return;
				
			}else{
					alert("회원가입 폼을 확인해 주세요.");	
			}										
		
		
		
		}
			
		return false;
}
	
	
///// 비밀번호 강약 //

function hasNumber(number) {
	  return /[0-9]/.test(number);
}

function hasMixed(number) {
	  return /[a-z]/.test(number) && /[A-Z]/.test(number);
}

function hasSpecial(number) {
	  return /[!#@$%^&*)(+=._-]/.test(number);
}


function strengthColor(count) {
	console.log(" strengthColor  ", count);
	
	  if (count < 2) {
	    return { label: '매우낮음', color: 'error'  };
	  } else if (count < 3) {
	    return { label: '약함', color: 'purple' };
	  } else if (count < 4) {
	    return { label: '보통', color: 'warning' };
	  } else if (count < 5) {
	    return { label: '좋음', color: 'success' };
	  } else if (count < 6) {
	    return { label: '높음', color: 'primary' };
	  } else {
	    return { label: '매우낮음', color: 'error' };
	  }
}

function strengthIndicator(number) {
	  let strengths = 0;
	  if (number.length > 5) {
	    strengths += 1;
	  }
	  if (number.length > 7) {
	    strengths += 1;
	  }
	  if (hasNumber(number)) {
	    strengths += 1;
	  }
	  if (hasSpecial(number)) {
	    strengths += 1;
	  }
	  if (hasMixed(number)) {
	    strengths += 1;
	  }
	  return strengths;
}

	
	
//HTML 요소 가져오기
const passwordInput = document.getElementById('member_passwd');
const meter = document.getElementById('meter');
const textbox = document.querySelector('.textbox');

// 암호 입력 이벤트 핸들러
passwordInput.addEventListener('input', handlePasswordInput);

function handlePasswordInput() {
	  const password = passwordInput.value;
	  
	  // 암호 강도 계산
	  const strength = strengthIndicator(password);
	  
	  // 암호 강도에 따라 progress 바 업데이트
	  meter.value = strength;
	  
	  // 암호 강도에 따라 메시지 표시
	  const color = strengthColor(strength);
	  textbox.innerHTML = `비밀번호안전도:<span class="${color.color}">${color.label}</span>`;
	  
	  console.log(" color.label  :", color.label);
	  
	  $(".textboxBottom").html("");
	  
	   if(color.color=="error"){
		  	  $(".textboxBottom").html(`<span class="${color.color}">사용할수 없는 비밀번호 입니다.</span>`);		  	  
	  }else if(color.color=="purple"){
		  	  $(".textboxBottom").html(`<span class="${color.color}">약함 사용할수 없는 비밀번호 입니다.</span>`);	
    	}else if(color.color=="warning"){						
		  	  $(".textboxBottom").html(`<span class="${color.color}">비밀번호안전도가 보통입니다.</span>`);
		  	  	  	  	  
	 }else if(color.color=="success"){			
		  	  $(".textboxBottom").html(`<span class="${color.color}">사용가능한  비밀번호 입니다.</span>`);	  	  	  	    	  	  
	  }else if(color.color=="primary"){
		  	  $(".textboxBottom").html(`<span class="${color.color}">예측하기 힘든 비밀번호로 더욱 안전합니다.</span>`);
	  }

	  
	  //textbox.style.color = color.color;
	  //meter.style.backgroundColor = color.color;
	   $("#meter").removeClass();
	  $("#meter").addClass(color.color);
}	

	
		