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
    <script src="../../Scripts/jquery-1.8.2.js"></script>
    <% if ((int)ViewData["valid"] == 1)
    {%>
        <script type="text/javascript">
            $(function () {
                alert("发生错误！");
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
    <%} %>
</head>
<body>
    <div class="am-cf am-padding">
        <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">成绩录入</strong> / <small>Grade Input</small></div>
    </div>
    <div class="am-g">
      <div class="am-u-sm-12">
        <form class="am-form" action="/Teacher/InputOperate" name="formInput">
          <table class="am-table am-table-striped am-table-hover table-main">
            <thead>
              <tr>
                <th>学号</th><th>姓名</th><th>班级号</th><th>成绩</th>
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
                               <td><input name="<%:dataRow["Sno"] %>" value="<%:dataRow["Grade"] %>" required="required" type="number" min="0" max="100"/></td>
                           </tr>
                     <%} %>
              </tbody>
            </table>
            <input type="submit" value="保存修改" class="am-btn am-btn-primary am-btn-xs"/>  
        </form>
      </div>
    </div>
</body>
</html>