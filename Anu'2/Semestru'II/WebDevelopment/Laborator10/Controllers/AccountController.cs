using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Laborator10.Data;
using Laborator10.Models;
using Microsoft.EntityFrameworkCore;
using System.Web;
using System.Text;

namespace Laborator10.Controllers
{
    public class AccountController : Controller
    {
        private readonly SqlDbContext context;

        public AccountController(SqlDbContext context)
        {
            this.context = context;
        }
        [HttpGet]
        public ActionResult Login()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Login(User model)
        {
            if (ModelState.IsValid)
            {
                using (var context = this.context)
                {
                    User user = context.Users
                                       .Where(u => u.UserId == model.UserId && u.Password == model.Password)
                                       .FirstOrDefault();

                    if (user != null)
                    {
                        HttpContext.Session.Set("UserName", Encoding.Unicode.GetBytes(user.UserName));
                        return RedirectToAction("Index", "Home");
                    }
                    else
                    {
                        ModelState.AddModelError("", "Invalid User Name or Password");
                        return View(model);
                    }
                }
            }
            else
            {
                return View(model);
            }
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult LogOff()
        {
            HttpContext.Session.Set("UserName", Encoding.Unicode.GetBytes(string.Empty));
            return RedirectToAction("Index", "Home");
        }
    }
}