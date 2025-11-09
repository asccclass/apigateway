<!DOCTYPE html>
<html lang="zh_TW">
<head>
   <meta charset="UTF-8" />
   <meta name="viewport" content="width=device-width, initial-scale=1.0" />
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
   <link rel= "stylesheet" href= "https://maxst.icons8.com/vue-static/landings/line-awesome/line-awesome/1.3.0/css/line-awesome.min.css" >
   <script src="https://unpkg.com/html5-qrcode" type="text/javascript"></script>
{{- range $i, $val := .carousels -}}
   <title>報到頁面</title>
   <style>
      .result {
         text-align: center;
         justify-content: center;
         align-items: center;
      }
   </style>
</head>
<body>
 <div class="container">
    <h1>{{- $val.fileName -}}
    <div id="result" class="result"></div>
    <div id="reader" width="600px"></div>
 </div>
<script>
$(document).ready(function() {
   var message = document.querySelector("#result");
   var url = "/signupserver/usercheckin/scan/{{- $val.sheetID -}}";
   var srchkey = "";
   const html5QrCode = new Html5Qrcode("reader");
   const config = { fps: 10, qrbox: { width: 250, height: 250 } };
   const qrCodeSuccessCallback = (decodedText, decodedResult) => {
      if(srchkey == decodedText)  return;
      srchkey = decodedText;
      let data = "srchkey=" + srchkey.trim();
      $.ajax({
         type: 'POST',   
         url: url,
         data: data,
         success: function(data) {
            let res = JSON.parse(data);
            if(res.status == "failure")  {
               message.innerHTML = "<font color='red'>查無此人</font>"; return;
            } else if(res.status == "relogin") {
               message.innerHTML = "<font color='red'>" + res.data.field4 + "  " + res.data.field1 + " 已報到</font>";
            } else {
               message.innerHTML = "<font color='blue'>報到成功</font>";
            }
            window.setTimeout(( () => message.innerHTML="" ), 2000);
            srchkey = "";
/*
            document.querySelector("#registerDate").innerHTML = res.data.checkin;
            document.querySelector("#field1").innerHTML = res.data.field1;
            document.querySelector("#field4").innerHTML = res.data.field4;
            document.querySelector("#field5").innerHTML = res.data.field5;
*/
         }
      }); 
   };
   html5QrCode.start({ facingMode: "environment" }, config, qrCodeSuccessCallback);
});
</script>
{{ end }}
  </body>
</html>
