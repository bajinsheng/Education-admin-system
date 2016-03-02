<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>
<%@ Import Namespace="System.Data" %>
<!DOCTYPE html>

<html>
<head>
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
</head>
<body>
    <div class="am-cf am-padding">
        <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">详细选课名单</strong> / <small>Detail</small></div>
    </div>
    <div class="am-g">
      <div class="am-u-sm-12">
        <form class="am-form" action="/Teacher/InputOperate">
          <table class="am-table am-table-striped am-table-hover table-main">
            <thead>
              <tr>
                <th>学号</th><th>姓名</th><th>班级号</th>
              </tr>
              </thead>
              <tbody>
                    <%DataTable grade = (DataTable)ViewData["DetailQuery"];%>
                <% foreach (DataRow dataRow in grade.Rows)
                   {%>
                       <tr>
                           <td><%: dataRow["Sno"] %></td>
                           <td><%: dataRow["Sname"] %></td>
                           <td><%: dataRow["Classno"] %></td>
                       </tr>
                 <%} %>
              </tbody>
            </table>          
        </form>
      </div>
    </div>
    <a href="/Teacher/CurrentCurriculum"> <input type="button" class="am-btn am-btn-primary am-btn-xs" value="返回" /></a>
</body>
</html>
