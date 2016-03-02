using MvcUserDemo;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Jiaowu.Controllers
{
    public class TeacherController : Controller
    {
        //
        // GET: /Teacher/

        public ActionResult Index(FormCollection collection)//用户名及密码验证
        {
            string userName = Request["UserName"];
            string passWord = Request["Password"];
            string validCode = Request["ValidCode"];
            string validateCode = Session["validateCode"] == null ? string.Empty : Session["validateCode"].ToString();
            string cmd = "select Tpswd from T_Teacher where Tno = @UserName";
            ViewData["Ip"] = GetIP();
            if ((string)SqlHelper.ExecuteScalar(cmd, new SqlParameter("@UserName", userName)) != passWord)
            {
                return RedirectToAction("Back", "Home");
            }
            else if (string.IsNullOrEmpty(validateCode) || validCode != validateCode)
            {
                return RedirectToAction("ValidBack", "Home");
            }
            else
            {
                Response.Cookies["teaName"].Value = userName;//cookie缓存
                Response.Cookies["teaName"].Expires = DateTime.Now.AddHours(1);
                return View();
            }
        }
        #region Welcome
        public ActionResult Welcome()//欢迎页面处理
        {
            string teaName = "";
            if (Request.Cookies["teaName"].Value != null)
                teaName = Request.Cookies["teaName"].Value;
            else
                return RedirectToAction("TimeOutBack", "Home");
            string cmd = "select Tname from T_Teacher where Tno = @UserName";
            ViewData["curTeacher"] = (string)SqlHelper.ExecuteScalar(cmd, new SqlParameter("@UserName", teaName));
            return View();
        }
        #endregion
        #region CurrentCurriculum
        public ActionResult CurrentCurriculum()//本学期的课程
        {
            string userName = "";
            string sem = "";//当前选课学期，预设
            //查询选课学期
            string cmd = "select CurSemester from T_Status";
            sem = (string)SqlHelper.ExecuteScalar(cmd);
            if (Request.Cookies["teaName"].Value != null)
                userName = Request.Cookies["teaName"].Value;
            else
                return RedirectToAction("TimeOutBack", "Home");
            cmd = "select Cno,Cname,T_Course.Classno,Pname,T_Pro.Pno from T_Course,T_Pclass,T_Pro where T_Course.Classno = T_Pclass.Classno and T_Pclass.Pno = T_Pro.Pno and Tno = @UserName and Sem = @Sem;";
            ViewData["CurriculumQuery"] = SqlHelper.ExecuteDataTable(cmd, new SqlParameter("@UserName", userName), new SqlParameter("@Sem", sem));
            return View();
        }
        public ActionResult DetailQuery(string Cno)//选课名单查询
        {
            string userName = "";
            if (Request.Cookies["teaName"].Value != null)
                userName = Request.Cookies["teaName"].Value;
            else
                return RedirectToAction("TimeOutBack", "Home");
            string cmd = "select T_Sc.Sno,Sname,Classno from T_Sc,T_Student where Cno = @Cno and T_Sc.Sno = T_Student.Sno ;";
            ViewData["DetailQuery"] = SqlHelper.ExecuteDataTable(cmd, new SqlParameter("@Cno", Cno));

            return View(); ;
        }
        #endregion
        #region GradeInput
        public ActionResult GradeInput()//成绩录入首界面，本学期课程显示
        {
            string userName = "";
            string sem = "";//当前选课学期，预设
            //查询选课学期
            string cmd = "select CurSemester from T_Status";
            sem = (string)SqlHelper.ExecuteScalar(cmd);
            if (Request.Cookies["teaName"].Value != null)
                userName = Request.Cookies["teaName"].Value;
            else
                return RedirectToAction("TimeOutBack", "Home");
            cmd = "select IsChooseCourse from T_Status";
            if ((bool)SqlHelper.ExecuteScalar(cmd) == false)
            {
                ViewData["IsChooseCourse"] = 0;
                return View();
            }
            else
            {
                ViewData["IsChooseCourse"] = 1;
            }
            cmd = "select Cno,Cname,T_Course.Classno,Pname,T_Pro.Pno from T_Course,T_Pclass,T_Pro where T_Course.Classno = T_Pclass.Classno and T_Pclass.Pno = T_Pro.Pno and Tno = @UserName and Sem = @Sem;";
            ViewData["GradeInputAvailable"] = SqlHelper.ExecuteDataTable(cmd, new SqlParameter("@UserName", userName), new SqlParameter("@Sem", sem));//传值当前教师所有课程
            return View();
        }
        public ActionResult GradeDetail(string Cno)//选课名单页面进行成绩录入
        {
            ViewData["valid"] = 0;
            string userName = "";
            Response.Cookies["gradeInputCurrentCno"].Value = Cno;//cookie缓存
            if (Request.Cookies["teaName"].Value != null)
                userName = Request.Cookies["teaName"].Value;
            else
                return RedirectToAction("TimeOutBack", "Home");
            string cmd = "select T_Sc.Sno,Cno,Sname,Classno,Grade from T_Sc,T_Student where Cno = @Cno and T_Sc.Sno = T_Student.Sno ;";
            ViewData["DetailQuery"] = SqlHelper.ExecuteDataTable(cmd, new SqlParameter("@Cno", Cno));
            return View();
        }
        public ActionResult InputOperate(FormCollection collection)//将输入的成绩录入到数据库中
        {
            ViewData["valid"] = 2;//0 不执行 1 失败 2 成功
            string cno = "";//当前选课名单选的课程号
            List<string> snoList = new List<string>();
            if (Request.Cookies["gradeInputCurrentCno"].Value != null)
                cno = Request.Cookies["gradeInputCurrentCno"].Value;
            else
                return RedirectToAction("TimeOutBack", "Home");
            string cmd = "select T_Sc.Sno from T_Sc,T_Student where Cno = @Cno and T_Sc.Sno = T_Student.Sno ;";
            DataTable snoListResult =  SqlHelper.ExecuteDataTable(cmd, new SqlParameter("@Cno", cno));
            DataRowCollection rows = snoListResult.Rows;
            for (int i = 0; i < rows.Count; i++)
            {
                DataRow row = rows[i];
                snoList.Add((string)row["Sno"]);
            }
            foreach(string item in snoList)
            {
                cmd = "update T_Sc set Grade=@Grade where Sno=@Sno and Cno = " + cno;
                if(SqlHelper.ExecuteNonQuery(cmd, new SqlParameter("@Grade", Request[item]), new SqlParameter("@Sno", item)) != 1)
                    ViewData["valid"] = 1;
            }
            cmd = "select T_Sc.Sno,Cno,Sname,Classno,Grade from T_Sc,T_Student where Cno = @Cno and T_Sc.Sno = T_Student.Sno ;";
            ViewData["DetailQuery"] = SqlHelper.ExecuteDataTable(cmd, new SqlParameter("@Cno", cno));
            return View("GradeDetail");
        }
        #endregion
        #region PasChange
        public ActionResult PasChange()//密码修改
        {
            ViewData["valid"] = 0;
            string userName;
            if (Request.Cookies["teaName"] != null)
                userName = Request.Cookies["teaName"].Value.ToString();
            else
                return RedirectToAction("TimeOutBack", "Home");
            return View();
        }
        public ActionResult Change(FormCollection collection)
        {
            string userName = "";
            if (Request.Cookies["teaName"] != null)
                userName = Request.Cookies["teaName"].Value.ToString();
            else
                return RedirectToAction("TimeOutBack", "Home");
            string oldPassWord = Request["change_old"];
            string newPassWord = Request["change_new"];
            string againPassWord = Request["change_makesure"];
            string cmd = "select Tpswd from T_Teacher where Tno =@UserName";
            if(newPassWord != againPassWord)
            {
                ViewData["valid"] = 3;
            }
            else if ((string)SqlHelper.ExecuteScalar(cmd, new SqlParameter("@UserName", userName)) == oldPassWord)
            {
                cmd = "update T_Teacher set Tpswd = @PassWord where Tno = @UserName";
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
