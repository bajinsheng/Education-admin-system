<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>
<%@ Import Namespace="System.Data" %>
<!DOCTYPE >
<html>
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>学生自主管理系统</title>
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
      <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">已修课程及成绩查询</strong> / <small>Grade</small></div>
    </div>
    <div class="am-u-sm-12 am-u-md-3">
        <div class="am-input-group am-input-group-sm">
            <form method="post" action="/Student/GradeQuery">
                课程号：<input type="number" class="am-form-field" name ="id"><br>
                课程名<input type="text" class="am-form-field" name ="name">
                <span class="am-input-group-btn">
                <input class="am-btn am-btn-primary am-btn-xs" type="submit" formaction="/Student/GradeQuery" value="查询"></input>
                </span>
            </form>
        </div>
    </div>
    <div class="am-g">
      <div class="am-u-sm-12">
        <form class="am-form">
          <table class="am-table am-table-striped am-table-hover table-main">
            <thead>
              <tr>
                <th class="table-author am-hide-sm-only">课程号</th><th class="table-author am-hide-sm-only">课程名</th><th class="table-date am-hide-sm-only">成绩</th><th class="table-date am-hide-sm-only">开课学期</th>
              </tr>
          </thead>
          <tbody>
                <%DataTable grade =(DataTable)ViewData["grade"];%>
                <% foreach (DataRow dataRow in grade.Rows)
                   {%>
                       <tr>
                           <td class="am-hide-sm-only"><%: dataRow["Cno"] %></td>
                           <td class="am-hide-sm-only"><%: dataRow["Cname"] %></td>
                           <td class="am-hide-sm-only"><%: dataRow["Grade"] %></td>
                           <td class="am-hide-sm-only"><%: dataRow["Sem"] %></td>
                       </tr>
                 <%} %>  
          </tbody>
        </table>
         </form>
      </div>
    </div>
</body>
</html>