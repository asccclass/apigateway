<!DOCTYPE html>
<html lang="zh_TW">
   <head>
      <meta charset="utf-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>QR Code Generator</title>
      <link rel="stylesheet" href="/signupserver/css/params.css">
      <link rel="stylesheet" href="signupserver/css/header.css">
   </head>
<style>
body {
   background: #262a2f;
}
.QRCodeContainer {
   width: 400px;
   padding: 25px 35px;
   position: absolute;
   top: 50%;
   left: 50%;
   transform: translate(-50%, -50%);
   background: var(--white);
   border-radius: 10px;
}
.QRCodeContainer p {
   font-weight: 600;
   font-size: 15px;
   margin-bottom: 8px;
}
.QRCodeContainer input {
   width: 100%;
   height: 50px;
   border 1px solid #494eea;
   outline: 0;
   padding: 10px;
   margin: 10px 0 20px;
   border-radius: 5px;
}
.QRCodeContainer button {
   width: 100%;
   height: 50px;
   background: #494eea;
   color: var(--white);
   border: 0;
   outline: 0;
   border-radius: 5px;
   box-shadow: 0 10px 10px rgba(0, 0, 0, 0.1);
   cursor: pointer;
   margin: 20px 0;
   font-weight: 500;
}
.QRCodeContainer .imgBox {
   width: 200px;
   border-radius: 5px;
   max-height: 0;
   overflow: hidden;
   transition: max-height 1s;
}
.QRCodeContainer .imgBox img {
   width: 100%;
   padding: 10px;
}
.QRCodeContainer .imgBox.show-img {
   max-height: 300px;
   margin: 10px auto;
   border: 1px solid #d1d1d1;
}
.error {
   animation: shake 0.1s linear 10;
}
@keyframes shake {
   0% {
      transform: translateX(0);
   }
   25% {
      transform: translateX(-2px);
   }
   50% {
      transform: translateX(0);
   }
   75% {
      transform: translateX(2px);
   }
   100% {
      transform: translateX(0);
   }
}
</style>
<body bg-color="#262a2f">
   <div class="QRCodeContainer">
      <p>Enter your text or URL</p>
      <input type="text" placeholder="Text or URL" id="qrText">

      <div id="imgBox" class="imgBox">
         <img src="" id="qrImage">
      </div>
      <h2 id="message"></h2>
      <button onclick="generateQR()" bg-color="#494eea">Generate QR Code</button>
   </div>
<script>
   let imgBox = document.getElementById("imgBox");
   let qrImage = document.getElementById("qrImage");
   let qrText = document.getElementById("qrText");

   function generateQR() {
      if(!qrText.value || qrText.value == "") {  
         qrText.classList.add('error');
         setTimeout(()=> {
            qrText.classList.remove('error');
         }, 2000);
      } else {
         qrImage.src = "/signupserver/generateQRCodefromurl?width=256&url=" + qrText.value;
         imgBox.classList.add("show-img");
         document.querySelector("#message").innerHTML = qrText.value;
      }
   }
</script>
</body>
</html>
