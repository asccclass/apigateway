<!DOCTYPE html>
<html lang="zh_TW">
<head>
   <meta charset="UTF-8" />
   <meta name="viewport" content="width=device-width, initial-scale=1.0" />
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
   <script src="https://kit.fontawesome.com/64d58efce2.js" crossorigin="anonymous"></script>
   <link rel= "stylesheet" href= "https://maxst.icons8.com/vue-static/landings/line-awesome/line-awesome/1.3.0/css/line-awesome.min.css" >
   <link rel="stylesheet" href="/signupserver/css/checkin.css?v=007" />
{{- range $i, $val := .carousels -}}
   <title>{{- $val.fileName -}}報到</title>
</head>
<body>
 <div class="container">
   <div class="forms-container">
     <div class="signin-signup">
       <form class="sign-in-form">
         <h2 class="title">{{ $val.fileName }} - 報到</h2>
         <div class="input-field">
           <i class="las la-user-friends"></i>
           <input type="text" id="srchkey" name="srchkey" placeholder="您報名時的姓名、Email" />
         </div>
         <input type="button" value="送出" id="register" class="btn solid" />
         <h2 id="message"></h2>
       </form>
       <form class="sign-up-form">
         <div class="input-field">
            <i class="las la-map-marked"></i> 場次：{{- $val.fileName -}} 
         </div>
         <h2 class="title" id="result"></h2>
         <font color="green" size="72"><i class="las la-check-circle"></i></font>
         <div>
            <h3><i class="las la-calendar-check"></i>報到時間：<span id="registerDate"></span></h3>
            <h3><i class="las la-graduation-cap"></i>學校名稱：<span id="field1"></span></h3>
            <h3><i class="las la-signature"></i>姓名：<span id="field4"></span></h3>
            <h3><i class="las la-audio-description"></i><span id="field5"></span></h3>
         </div>
<!--
           <i class="fas fa-lock"></i>
           <input type="password" placeholder="Password" />
-->
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
const sign_up_btn = document.querySelector("#register");
const vals = document.querySelector("#srchkey");
const container = document.querySelector(".container");
const result = document.querySelector("#result");
const message = document.querySelector("#message");

sign_up_btn.addEventListener("click", () => {
   if(vals.value.lenght == 0) {
      alert("請輸入資訊");
      return;
   }
   var url = "/signupserver/usercheckin/scan/{{- $val.sheetID -}}";
   var data = "srchkey=" + vals.value.trim();
   $.ajax({
      type: 'POST',   
      url: url,
      data: data,
      success: function(data) {
         let res = JSON.parse(data);
         console.log(res);
         if(res.status == "failure")  {
            message.innerHTML = "<font color='red'>查無此人</font>"; return;
            window.setTimeout(( () => message.innerHTML="" ), 3000);
         } else if(res.status == "relogin") {
            result.innerHTML = "重複報到";
         } else {
            result.innerHTML = "報到成功";
         }
         document.querySelector("#registerDate").innerHTML = res.data.checkin;
         document.querySelector("#field1").innerHTML = res.data.field1;
         document.querySelector("#field4").innerHTML = res.data.field4;
         document.querySelector("#field5").innerHTML = res.data.field5;
         container.classList.add("sign-up-mode");
      }
   }); 
});
</script>
{{- end -}}
  </body>
</html>
