using MvcUserDemo;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;

namespace Jiaowu.Controllers
{
    public class StudentController : Controller
    {
        //
        // GET: /Student/

        public ActionResult Index(FormCollection collection)//用户名密码验证
        {
            string userName = Request["UserName"];
            string passWord = Request["Password"];
            string validCode = Request["ValidCode"];
            string validateCode = Session["validateCode"] == null ? string.Empty : Session["validateCode"].ToString();
            string cmd = "select Spswd from T_Student where Sno = @UserName";
            ViewData["Ip"] = GetIP();
            if ((string)SqlHelper.ExecuteScalar(cmd, new SqlParameter("@UserName", userName)) != passWord)
            {
                Session["validateCode"] = null;
                return RedirectToAction("Back","Home");
            }
            else if (string.IsNullOrEmpty(validateCode) || validCode != validateCode)
            {
                return RedirectToAction("ValidBack", "Home");
            }
            else
            {
                Response.Cookies["stuName"].Value = userName;//cookie缓存
                Response.Cookies["stuName"].Expires = DateTime.Now.AddHours(1);
                return View();
            }
            
        }
        #region Welcome
        public ActionResult Welcome()//欢迎页面处理
        {
            string stuName = "";
            if (Request.Cookies["stuName"].Value != null)
                stuName = Request.Cookies["stuName"].Value;
            else
                return RedirectToAction("TimeOutBack", "Home");
            string cmd = "select Sname from T_Student where Sno = @UserName";
            ViewData["curStudent"] = (string)SqlHelper.ExecuteScalar(cmd, new SqlParameter("@UserName", stuName));
            return View();
        }
        #endregion
        #region Info
        public ActionResult Info()//基本信息页面处理
        {
            string userName = "";
            DateTime time;
            
            if (Request.Cookies["stuName"].Value != null)
                userName = Request.Cookies["stuName"].Value;
            else
                return RedirectToAction("TimeOutBack", "Home");
            string cmd = "select * from T_Student,T_Pclass,T_Pro where T_Student.Classno = T_Pclass.Classno and T_Pclass.Pno = T_Pro.Pno and T_Student.sno = @UserName;";
            DataTable studentInfomation = SqlHelper.ExecuteDataTable(cmd, new SqlParameter("@UserName", userName));
            DataRowCollection rows = studentInfomation.Rows;
            for (int i = 0; i < rows.Count;i++ )
            {
                DataRow row = rows[i];
                ViewData["Sno"] = (string)row["Sno"];
                ViewData["Name"] = (string)row["Sname"];
                ViewData["Sex"] = (string)row["Ssex"];
                ViewData["Pname"] = (string)row["Pname"];
                ViewData["Classname"] = (string)row["Classname"];
                ViewData["Bir"] = row["Bir"];
            }
            return View();  
        }
        #endregion
        #region Grade
        public ActionResult Grade()//已选课程及成绩查询
        {
            string userName = "";
            if (Request.Cookies["stuName"].Value != null)
                userName = Request.Cookies["stuName"].Value;
            else
                return RedirectToAction("TimeOutBack", "Home");
            string cmd = "select T_Sc.Cno,Cname,Sem,Grade from T_Sc,T_Course where T_Sc.Cno = T_Course.Cno and T_Sc.sno =  @UserName and Grade is not null order by Sem;";
            ViewData["grade"] = SqlHelper.ExecuteDataTable(cmd, new SqlParameter("@UserName", userName));
            return View();
        }
        public ActionResult GradeQuery(FormCollection collection)//已修课程查询
        {
            string id = Request["id"];
            string name = Request["name"];
            string userName = "";
            if (Request.Cookies["stuName"].Value != null)
                userName = Request.Cookies["stuName"].Value;
            else
                return RedirectToAction("TimeOutBack", "Home");
            string cmd;
            if(id != "")
            {
                cmd = "select T_Sc.Cno,Cname,Sem,Grade from T_Sc,T_Course where T_Sc.Cno = T_Course.Cno and T_Sc.sno =  @UserName and Grade is not null and T_Sc.Cno = @Id;";
                ViewData["grade"] = SqlHelper.ExecuteDataTable(cmd, new SqlParameter("@UserName", userName), new SqlParameter("@Id", id));
                return View("grade");
            }
            else
            {
                cmd = "select T_Sc.Cno,Cname,Sem,Grade from T_Sc,T_Course where T_Sc.Cno = T_Course.Cno and T_Sc.sno = @UserName and Cname like '%"+name+"%' and Grade is not null;";
                ViewData["grade"] = SqlHelper.ExecuteDataTable(cmd, new SqlParameter("@UserName", userName));
                return View("grade");
            }
        }
        #endregion
        #region CurChoose
        public ActionResult CurChoose()//查询已选课程
        {
            string userName="";
            List<SelectListItem> availableList = new List<SelectListItem>();
            string sem = "";//当前选课学期，预设
            if (Request.Cookies["stuName"] != null)
                userName = Request.Cookies["stuName"].Value.ToString();
            else
                return RedirectToAction("TimeOutBack", "Home");
            string cmd;
            //确定当前是否选课时间
            cmd = "select IsChooseCourse from T_Status";
            if((bool)SqlHelper.ExecuteScalar(cmd) == false)
            {
                ViewData["IsChooseCourse"] = 0;
                return View();
            }
            else
            {
                ViewData["IsChooseCourse"] = 1;
            }
            //查询选课学期
            cmd = "select NextSemester from T_Status";
            sem = (string)SqlHelper.ExecuteScalar(cmd);
            //查询必修课
            cmd = "select Cno,Cname from T_Course where T_Course.Classno = (select Classno from T_Student where Sno=@UserName) and Sem = @Sem and Take = 1;";
            ViewData["required"] = SqlHelper.ExecuteDataTable(cmd, new SqlParameter("@UserName", userName), new SqlParameter("@Sem", sem));
            //查询已选限选课
            cmd = "select T_Course.Cno,Cname from T_Course,T_Sc where T_Course.Cno = T_Sc.Cno and Sno=@UserName and Take = 2 and Sem = @Sem;";
            ViewData["selective"] = SqlHelper.ExecuteDataTable(cmd, new SqlParameter("@UserName", userName), new SqlParameter("@Sem", sem));
            //查询可选限选课
            cmd = "select Cno,Cname from T_Course where T_Course.Classno = (select Classno from T_Student where Sno=@UserName) and Sem =@Sem and Take = 2 and Cno not in (select T_Course.Cno from T_Course,T_Sc where T_Course.Cno = T_Sc.Cno and Sno=@UserName and Take = 2 and Sem =@Sem);";
            DataTable available = SqlHelper.ExecuteDataTable(cmd, new SqlParameter("@UserName", userName), new SqlParameter("@Sem", sem));
            DataRowCollection rows = available.Rows;
            for (int i = 0; i < rows.Count; i++)
            {
                DataRow row = rows[i];
                availableList.Add(new SelectListItem() { Selected = false, Text = (string)row["Cname"], Value = (string)row["Cno"] });
            }
            ViewData["available"] = availableList;
            return View();
        }
        public ActionResult Add(FormCollection collection)
        {
            string userName="";
            if (Request.Cookies["stuName"] != null)
                userName = Request.Cookies["stuName"].Value.ToString();
            else
                return RedirectToAction("TimeOutBack", "Home");
            string cno = Request["available"];
            if(cno != null)
            {
                string cmd = "insert into T_Sc (Cno,Sno) values(@Cno,@UserName);";
                SqlHelper.ExecuteNonQuery(cmd, new SqlParameter("@UserName", userName), new SqlParameter("@Cno", cno));
            }
            return RedirectToAction("CurChoose");
        }
        public ActionResult Delete(string Id)
        {
            string userName = "";
            string sem = "";//当前选课学期，预设
            //查询选课学期
            string cmd = "select NextSemester from T_Status";
            sem = (string)SqlHelper.ExecuteScalar(cmd);
            if (Request.Cookies["stuName"] != null)
                userName = Request.Cookies["stuName"].Value.ToString();
            else
                return RedirectToAction("TimeOutBack", "Home");
            cmd = "delete from T_Sc where Cno=@Id and Sno = @Sno";

            SqlHelper.ExecuteNonQuery(cmd, new SqlParameter("@Id", Id), new SqlParameter("@Sno", userName));
            //页面跳转到删除后的首页

            return RedirectToAction("CurChoose");
        }
        #endregion
        #region PasChange
        public ActionResult PasChange()//密码修改
        {
            ViewData["valid"] = 0;
            string userName;
            if (Request.Cookies["stuName"] != null)
                userName = Request.Cookies["stuName"].Value.ToString();
            else
                return RedirectToAction("TimeOutBack", "Home");
            return View();
        }
        public ActionResult Change(FormCollection collection)
        {
            string userName = "";
            if (Request.Cookies["stuName"] != null)
                userName = Request.Cookies["stuName"].Value.ToString();
            else
                return RedirectToAction("TimeOutBack", "Home");
            string oldPassWord = Request["change_old"];
            string newPassWord = Request["change_new"];
            string againPassWord = Request["change_makesure"];
            string cmd = "select Spswd from T_Student where Sno =@UserName";
            if (newPassWord != againPassWord)
            {
                ViewData["valid"] = 3;
            }
            else if ((string)SqlHelper.ExecuteScalar(cmd, new SqlParameter("@UserName", userName)) == oldPassWord)
            {
                cmd = "update T_Student set Spswd = @PassWord where Sno = @UserName";
                SqlHelper.ExecuteNonQuery(cmd, new SqlParameter("@PassWord", newPassWord), new SqlParameter("@UserName", userName));
                ViewData["valid"] = 2;
            }
            else
            {
                ViewData["valid"] = 1;
            }
            return View("PasChange");
        }
        #endregion
       private string GetIP()// 获取IP
       {
           string ip = string.Empty;
           if (!string.IsNullOrEmpty(System.Web.HttpContext.Current.Request.ServerVariables["HTTP_VIA"]))
               ip = Convert.ToString(System.Web.HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"]);
           if (string.IsNullOrEmpty(ip))
               ip = Convert.ToString(System.Web.HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"]);
           return ip;
       }
 
    }
}
