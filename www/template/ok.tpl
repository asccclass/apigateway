<!DOCTYPE html>
<html lang="zh_TW">
<head>
   <meta charset="UTF-8" />
   <meta name="viewport" content="width=device-width, initial-scale=1.0" />
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
   <script src="https://kit.fontawesome.com/64d58efce2.js" crossorigin="anonymous"></script>
   <link rel="stylesheet" href="/signupserver/css/ok.css?v=007" />
{{- range $i, $val := .carousels -}}
   <title>{{- $val.fileName -}}報到OK</title>
</head>
<body>
 <div class="container">
   <div class="card">
     <div class="signin-signup">
       <form method="post" action="/signupserver/usercheckin/scan/{{- $val.sheetID -}}" class="sign-in-form">
         <h2 class="title">{{ $val.fileName }} - 報到</h2>
         <div class="input-field">
           <i class="fas fa-user"></i>
           <input type="text" name="srchkey" placeholder="您報名時的姓名、Email" />
         </div>
         <input type="Submit" value="送出" id="register" class="btn solid" />
       </form>
       <form action="#" class="sign-up-form">
         <h2 class="title">掃描QR Code</h2>
         <div class="input-field">
           <i class="fas fa-lock"></i>
           <input type="password" placeholder="Password" />
         </div>
         <input type="submit" class="btn" value="關閉掃描" />
       </form>
     </div>
   </div>

   <div class="panels-container">
     <div class="panel left-panel">
       <div class="content">
         <h3>{{- $val.fileName -}}</h3>
         <p>
            請輸入您註冊時的資訊，點選送出後，即可顯示入場通行證。
         </p>
<!--
         <button class="btn transparent" id="sign-up-btn">活動地點</button>
-->
       </div>
       <img src="/signupserver/images/log.svg" class="image" alt="" />
     </div>
     <div class="panel right-panel">
       <div class="content">
         <h3>One of us ?</h3>
         <p>
           Lorem ipsum dolor sit amet consectetur adipisicing elit. Nostrum
           laboriosam ad deleniti.
         </p>
         <button class="btn transparent" id="sign-in-btn">
           Sign in
         </button>
       </div>
       <img src="/signupserver/images/register.svg" class="image" alt="" />
     </div>
   </div>
 </div>
<script>
/*
const sign_up_btn = document.querySelector("#register");

sign_up_btn.addEventListener("click", () => {
   var url = "/signupserver/usercheckin/" + value;
   $.ajax({
      contentType: 'application/json',
      type: 'GET',   
      url: url,   
      success: function(data) {
console.log(data);
      }
   }); 
});
*/
</script>
{{- end -}}
  </body>
</html>
