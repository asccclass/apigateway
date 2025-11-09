<!DOCTYPE html>
<html lang="zh_TW">
<head>
   <meta charset="UTF-8">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
   <link rel="stylesheet" href="/signupserver/css/monitor.css">
   <title>Dashboard-Single Page</title>
   <script src="https://unpkg.com/htmx.org@1.9.10" integrity="sha384-D1Kt99CQMDuVetoL1lrYwg5t+9QdHe7NLX/SoJYkXDFfX37iInKRy5xLSi8nO7UC" crossorigin="anonymous"></script>
   <script src="https://unpkg.com/htmx.org/dist/ext/sse.js"></script>
</head>
<body>
{{- range $i, $val := .carousels -}}
   {{- $loginCnt := 0 -}}
   {{ range $row := $val.rows }}
      {{ if ne $row.checkin "" }}
         {{- $loginCnt = add1 $loginCnt -}}
      {{ end }}
   {{ end }}
    <!-- Sidebar -->
    <div class="sidebar">
	    <a href="#" class="logo">
            <i class='bx bx-code-alt'></i>
            <div class="logo-name"><span></span>Dashboard</div>
        </a>
        <ul class="side-menu">
            <li><a href="/signupserver/readacts" class="active"><i class='bx bxs-dashboard'></i>Dashboard</a></li>
            <li><a href="#"><i class='bx bx-store-alt'></i>System</a></li>
            <li><a href="/signupserver/page/qrcodegen"><i class='bx bx-qr-scan'></i>QR Code 產生器</a></li>
            <li><a href="#"><i class='bx bx-analyse'></i>Analytics</a></li>
            <li><a href="#"><i class='bx bx-message-square-dots'></i>Tickets</a></li>
            <li><a href="#"><i class='bx bx-group'></i>Users</a></li>
            <li><a href="#"><i class='bx bx-cog'></i>Settings</a></li>
        </ul>
        <ul class="side-menu">
            <li>
                <a href="#" class="logout">
                    <i class='bx bx-log-out-circle'></i>登出
                </a>
            </li>
        </ul>
    </div>
    <!-- End of Sidebar -->

    <!-- Main Content -->
    <div class="content">
        <!-- Navbar -->
        <nav>
            <i class='bx bx-menu'></i>
            <form action="#">
                <div class="form-input">
                    <input type="search" placeholder="Search...">
                    <a href="/signupserver/checkin/{{ $val.sheetID }}" class="search-btn" type="submit">
                       <i class='bx bx-search'></i>
                    </a>
                </div>
            </form>
            <input type="checkbox" id="theme-toggle" hidden>
            <label for="theme-toggle" class="theme-toggle"></label>
            <a href="#" class="notif">
                <i class='bx bx-bell'></i>
                <span class="count">12</span>
            </a>
            <a href="#" class="profile">
                <img src="images/logo.png">
            </a>
        </nav>
        <!-- End of Navbar -->
        <main>
            <div class="header">
                <div class="left">
                    <h1>儀錶板</h1>
                    <ul class="breadcrumb">
                        <li><a href="/signupserver/readacts">首頁</a></li>
                        /
                        <li>{{- $val.fileName -}}</li>
                    </ul>
                </div>
                <a href="/signupserver/checkinandshow/{{- $val.sheetID -}}" class="report" target=_blank>
                    <i class='bx bx-cloud-download'></i>
                    <span>參加者報到畫面</span>
                </a>
            </div>

            <!-- Insights -->
            <ul class="insights">
                <li>
                    <i class='bx bx-calendar-check'></i>
                    <span class="info">
                        <h3>{{- $loginCnt -}}</h3>
                        <p>已報到人數</p>
                    </span>
                </li>
<!-- 
                <li><i class='bx bx-show-alt'></i>
                    <span class="info">
                        <h3>3,944</h3>
                        <p>陪同人數</p>
                    </span>
                </li>
-->
                <li><i class='bx bx-line-chart'></i>
                    <span class="info">
                        <h3>{{- len $val.rows -}}</h3>
                        <p>報名人數</p>
                    </span>
                </li>
<!--
                <li><i class='bx bx-dollar-circle'></i>
                    <span class="info">
                        <h3>0</h3>
                        <p>報名陪同人數</p>
                    </span>
                </li>
-->
            </ul>
            <!-- End of Insights -->
            <div class="bottom-data">
                <div class="orders">
                    <div class="header">
                        <i class='bx bx-receipt'></i>
                        <h3>報名人員列表</h3>
                        <i class='bx bx-filter'></i>
                        <a href="" target=_blank><i class='bx bx-search'></i></a>
                    </div>
                    <table>
                        <thead>
                            <tr>
                               <th>Field1</th>
                               <th>Field2</th>
                               <th>Field3</th>
                               <th>Field4</th>
                            </tr>
                        </thead>
                        <tbody>
                     {{- range $row := $val.rows -}}
                            <tr>
                            {{ range $key, $txt := . }}
                               <td><p>{{ $txt }}</p></td>
                            {{ end }}
                               <td>
                                  <span class="status process">
                                     Not_check_in
                                  </span>
                               </td>
                            </tr>
                     {{- end -}}
                        </tbody>
                    </table>
                </div>

                <!-- Reminders -->
                <div class="reminders">
                    <div class="header">
                        <i class='bx bx-note'></i>
                        <h3>近期活動表</h3>
                        <i class='bx bx-filter'></i>
                        <i class='bx bx-plus'></i>
                    </div>
                    <ul class="task-list">
                        <li class="not-completed">
                            <div class="task-title">
                                <i class='bx bx-calendar'></i>
                                <p>
                                   <a href="/signupserver/readacts/{{- $val.sheetID -}}">{{- $val.fileName -}}</a>
                                </p>
                            </div>
                            <i class='bx bx-dots-vertical-rounded'></i>
                        </li>
                    </ul>
                </div>
                <!-- End of Reminders-->
            </div>
        </main>
    </div>
   <script>
      let loginNum = {{- $loginCnt -}};
      window.addEventListener("DOMContentLoaded", function () {
        var evsrc = new EventSource("/signupserver/sse");
        evsrc.onmessage = function(event) {
           console.log(event.data);
        };
        evsrc.onerror = function(event) {
          console.log("readyState = " + event.currentTarget.readyState);
        };
      })
   </script>
{{- end -}}
    <script src="/signupserver/js/monitor.js"></script>
</body>
</html>
