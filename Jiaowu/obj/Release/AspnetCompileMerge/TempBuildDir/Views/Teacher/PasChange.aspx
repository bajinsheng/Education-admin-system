﻿<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>教师自主管理系统</title>
    <meta name="keywords" content="index" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
    <meta name="renderer" content="webkit" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <link rel="icon" type="image/png" href="~/assets/i/favicon.png" />
    <link rel="apple-touch-icon-precomposed" href="~/assets/i/app-icon72x72@2x.png" />
    <meta name="apple-mobile-web-app-title" content="Amaze UI" />
    <link href="../../assets/css/admin.css" rel="stylesheet" />
    <link href="../../assets/css/amazeui.min.css" rel="stylesheet" />
    <script src="../../Scripts/jquery-1.8.2.js"></script>
    <% if ((int)ViewData["valid"] == 1)
    {%>
        <script type="text/javascript">
            $(function () {
                alert("密码错误！");
            });
        </script>
    <%}
    else if ((int)ViewData["valid"] == 2)
    {%>
        <script type="text/javascript">
            $(function () {
                alert("修改成功！");
            });
        </script>
    <%}
    else if ((int)ViewData["valid"] == 3)
    {%>
        <script type="text/javascript">
            $(function () {
                alert("两次输入不一致！");
            });
        </script>
    <%} %>
</head>
<body>
    <div class="am-cf am-padding">
        <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">密码修改</strong> / <small>Password Change</small></div>
    </div>
    <div class="am-u-sm-12 am-u-md-3">
            <form class="am-form am-form-horizontal" action="/Teacher/Change">
                <div class="am-form-group">
                    <div class="am-u-sm-9">
                        <input type="password" required="required" width="60px" name="change_old" placeholder="旧密码"/>
                    </div>
                </div>
                <div class="am-form-group">
                    <div class="am-u-sm-9">
                        <input type="password" required="required" name="change_new" placeholder="新密码"/>
                    </div>
                </div>
                <div class="am-form-group">
                    <div class="am-u-sm-9">
                        <input type="password" required="required" name="change_makesure" placeholder="确认密码"/>
                    </div>
                </div>
                <div class="am-form-group">
                    <input type="submit" value="保存修改" class="am-btn am-btn-primary am-btn-xs"/>
                </div>
            </form>
        </div>
</body>
</html>
