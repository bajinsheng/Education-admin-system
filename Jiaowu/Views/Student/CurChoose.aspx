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
    <script src="../../Scripts/jquery-1.8.2.js"></script>
    <link href="../../Css/stu.css" rel="stylesheet" />
    <script type="text/javascript">
        $(function() {
            $("a:contains('删除')").click(function() {
                return confirm("请确认是否真的删除此数据？");
            });
        });
    </script>
</head>
<body>
    <div class="am-cf am-padding">
      <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">选定课程</strong> / <small>Choose</small></div>
    </div>
    <%if((int)ViewData["IsChooseCourse"] == 1)
    { %>
    <div class="am-g">
      <div class="am-u-sm-12">
          <blockquote>必修课</blockquote>
          <table class="am-table am-table-striped am-table-hover table-main" >
              <thead>
                  <tr>
                    <th>课程号</th><th>课程名</th>
                  </tr>
            </thead>
              <tbody>
                <%DataTable required = (DataTable)ViewData["required"];%>
                <% foreach (DataRow dataRow in required.Rows)
                    {%>
                        <tr>
                            <td><%: dataRow["Cno"] %></td>
                            <td><%: dataRow["Cname"] %></td>
                        </tr>
                <%} %>
              </tbody>
        </table>
          <blockquote>已选限选课</blockquote>
        <table class="am-table am-table-striped am-table-hover table-main">
              <thead>
                  <tr>
                    <th>课程号</th><th>课程名</th><th>操作</th>
                  </tr>
            </thead>
              <tbody>
                <%DataTable selective = (DataTable)ViewData["selective"];%>
                <% foreach (DataRow dataRow in selective.Rows)
                    {%>
                        <tr>
                            <td><%: dataRow["Cno"] %></td>
                            <td><%: dataRow["Cname"] %></td>
                            <td><%: Html.ActionLink("删除","Delete","Student",new {Id=dataRow["Cno"]},new {}) %></td>
                        </tr>
                <%} %>
              </tbody>
        </table>
          <p>可选择限选课：</p>
        <form name="gradein" action="/Student/Add" method="post" style="width:800px;">                               
            <%: Html.DropDownList("available") %>  
            <input type="submit" class="am-btn am-btn-primary am-btn-xs" value="提交" />
        </form>
      </div>
    </div>
    <%}
      else
      { %>
        当前非选课时间！
    <%} %>


</body>
</html>
