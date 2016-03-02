<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>
<%@ Import Namespace="System.Data" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
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
        <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">本学期课程</strong> / <small>Curriculum</small></div>
    </div>
<%if((int)ViewData["IsChooseCourse"] == 1)
{ %>
    <div class="am-g">
      <div class="am-u-sm-12">
        <form class="am-form" action="/Teacher/InputOperate">
          <table class="am-table am-table-striped am-table-hover table-main">
            <thead>
              <tr>
                <th>课程号</th><th>课程名</th><th>班级号</th><th>专业</th><th>专业号</th><th>选课名单</th>
              </tr>
              </thead>
              <tbody>
                <%DataTable grade = (DataTable)ViewData["GradeInputAvailable"];%>
                    <% foreach (DataRow dataRow in grade.Rows)
                    {%>
                        <tr>
                            <td><%: dataRow["Cno"] %></td>
                            <td><%: dataRow["Cname"] %></td>
                            <td><%: dataRow["Classno"] %></td>
                            <td><%: dataRow["Pname"] %></td>
                            <td><%: dataRow["Pno"] %></td>
                            <td><%: Html.ActionLink("名单","Gradedetail","Teacher",new {Cno=dataRow["Cno"]},new {}) %></td>
                        </tr>
                <%} %>
              </tbody>
            </table>          
        </form>
      </div>
    </div>   
<%}
    else
    { %>
    当前非录入成绩时间！
<%} %> 
</body>
</html>
