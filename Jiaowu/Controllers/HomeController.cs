using MvcUserDemo;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Jiaowu.Controllers
{
    public class HomeController : Controller
    {
        //
        // GET: /Home/

        public ActionResult Index()
        {
            ViewData["back"] = 0;
            return View();
        }
        public ActionResult Back()//用户名或密码验证错误返回
        {
            ViewData["back"] = 1;//0初次进入 1用户名或密码错误 2验证码错误
            return View("Index");
        }
        public ActionResult ValidBack()//用户名或密码验证错误返回
        {
            ViewData["back"] = 2;//1用户名或密码错误 2验证码错误
            return View("Index");
        }
        public ActionResult TimeOutBack()
        {
            ViewData["back"] = 3;//1用户名或密码错误 2验证码错误 3登陆超时
            return View("Index");
        }
        public ActionResult CheckCode()
        {
            //生成验证码
            ValidateCode validateCode = new ValidateCode();
            string code = validateCode.CreateValidateCode(4);
            Session["ValidateCode"] = code;
            byte[] bytes = validateCode.CreateValidateGraphic(code);
            return File(bytes, @"image/jpeg");
        }
    }
}
