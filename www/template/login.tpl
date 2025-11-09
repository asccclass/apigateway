<!DOCTYPE html>
<html lang="zh_TW">
<head>
   <meta charset="UTF-8">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title>{{- .title -}} Login Page</title>
<style>
body {
   font-family: Arial, sans-serif;
   margin: 0;
   padding: 0;
   background-color: #000;
}

.container {
   max-width: 400px;
   margin: 80px auto;
   padding: 20px;
   background-color: #333;
   border-radius: 5px;
   box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

h2 {
   color: #fff;
   text-align: center;
}

form {
   display: flex;
   flex-direction: column;
}

input[type="text"],
input[type="password"] {
   padding: 10px;
   margin: 10px 0;
   border: 1px solid #666;
   border-radius: 5px;
   outline: none;
}

input[type="submit"] {
   padding: 10px;
   margin-top: 10px;
   background-color: #4CAF50;
   color: white;
   border: none;
   border-radius: 5px;
   cursor: pointer;
   outline: none;
}

input[type="submit"]:hover {
   background-color: #45a049;
}

@media screen and (max-width: 600px) {
   .container {
       margin: 20px auto;
       max-width: 300px;
   }
}
</style>
</head>
<body>

<div class="container">
   <h2>Login</h2>
   <form method="post" action="/apigateway/login">
      <input type="hidden" name="2url" value="/apigateway/index.html">
      <input type="text" name="username" placeholder="Username" required>
      <input type="password" name="password" placeholder="Password" required>
      <input type="submit" value="Login">
   </form>
</div>
</body>
</html>
