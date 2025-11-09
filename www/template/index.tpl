<!DOCTYPE html>
<html lang="zh_TW">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link rel="stylesheet" href="css/monitor.css">
    <title>Sinica Dashboard Design</title>
</head>
<body>
{{- range $i, $val := .carousels -}}
    <!-- Sidebar -->
    <div class="sidebar">
	    <a href="#" class="logo">
            <i class='bx bx-code-alt'></i>
            <div class="logo-name"><span></span>Dashboard</div>
        </a>
        <ul class="side-menu">
            <li><a href="/signupserver/readacts" class="active"><i class='bx bxs-dashboard'></i>Dashboard</a></li>
            <li><a href="#"><i class='bx bx-store-alt'></i>System</a></li>
            <li><a href="/signupserver/page/qrcodegen"><box-icon name='qr-scan'></box-icon>QR Code 產生器</a></li>
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
                    <button class="search-btn" type="submit"><i class='bx bx-search'></i></button>
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
                        <li>報到資訊</li>
                    </ul>
                </div>
<!--
                <a href="#" class="report">
                    <i class='bx bx-cloud-download'></i>
                    <span>Download CSV</span>
                </a>
-->
            </div>

            <!-- Insights -->
<!--
            <ul class="insights">
                <li>
                    <i class='bx bx-calendar-check'></i>
                    <span class="info">
                        <h3> 1,074 </h3>
                        <p>已報到人數</p>
                    </span>
                </li>
                <li><i class='bx bx-show-alt'></i>
                    <span class="info">
                        <h3>3,944</h3>
                        <p>陪同人數</p>
                    </span>
                </li>
                <li><i class='bx bx-line-chart'></i>
                    <span class="info">
                        <h3>14,721</h3>
                        <p>報名總人數</p>
                    </span>
                </li>
                <li><i class='bx bx-dollar-circle'></i>
                    <span class="info">
                        <h3>0</h3>
                        <p>報名陪同人數</p>
                    </span>
                </li>
            </ul>
-->
            <!-- End of Insights -->
            <div class="bottom-data">
                <div class="orders">
                    <div class="header">
                        <i class='bx bx-receipt'></i>
                        <h3>最新訊息</h3>
                        <i class='bx bx-filter'></i>
                        <i class='bx bx-search'></i>
                    </div>
                    <table>
                        <thead>
                            <tr>
                                <th>System Name</th>
                                <th>Date Time</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>
                                    <img src="images/profile-1.jpg">
                                    <p>Email 服務</p>
                                </td>
                                <td>14-08-2023</td>
                                <td><span class="status process">Completed</span></td>
                            </tr>
                            <tr>
                                <td>
                                    <img src="images/profile-1.jpg">
                                    <p>VPN 服務</p>
                                </td>
                                <td>14-08-2023</td>
                                <td><span class="status completed">Pending</span></td>
                            </tr>
                            <tr>
                                <td>
                                    <img src="images/profile-1.jpg">
                                    <p>WiFi 服務</p>
                                </td>
                                <td>14-08-2023</td>
                                <td><span class="status pending">Processing</span></td>
                            </tr>
                            <tr>
                                <td>
                                    <img src="images/profile-1.jpg">
                                    <p>MySpace 服務</p>
                                </td>
                                <td>14-08-2023</td>
                                <td><span class="status pending">Processing</span></td>
                            </tr>
                            <tr>
                                <td>
                                    <img src="images/profile-1.jpg">
                                    <p>DNS 服務</p>
                                </td>
                                <td>14-08-2023</td>
                                <td><span class="status pending">Processing</span></td>
                            </tr>
                            <tr>
                                <td>
                                    <img src="images/profile-1.jpg">
                                    <p>SSO 服務</p>
                                </td>
                                <td>14-08-2023</td>
                                <td><span class="status pending">Processing</span></td>
                            </tr>
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
                        {{- range $key, $name := $val -}}
                        <li class="not-completed">
                            <div class="task-title">
                                <i class='bx bx-calendar'></i>
                                <p>
                                   <a href="/signupserver/readacts/{{- $key -}}">{{- $name -}}</a>
                                </p>
                            </div>
                            <i class='bx bx-dots-vertical-rounded'></i>
                        </li>
                        {{- end -}}
                    </ul>
                </div>
                <!-- End of Reminders-->
            </div>
        </main>
    </div>
{{- end -}}
    <script src="js/monitor.js"></script>
</body>
</html>
