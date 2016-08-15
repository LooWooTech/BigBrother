using LoowooTech.Land.Zhoushan.Common;
using LoowooTech.Land.Zhoushan.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LoowooTech.Land.Zhoushan.Managers
{
    public class UserManager : ManagerBase
    {
        public List<User> GetUsers(UserParameter parameter)
        {
            List<User> list = null;
            using (var db = GetDbContext())
            {
                var query = db.Users.AsQueryable();
                if (!string.IsNullOrEmpty(parameter.SearchKey))
                {
                    query = query.Where(e => e.Name.Contains(parameter.SearchKey));
                }
                list= query.OrderByDescending(e => e.ID).SetPage(parameter.Page).ToList();
               
            }
            if (list != null)
            {
                foreach (var user in list)
                {
                    if (!string.IsNullOrEmpty(user.AreaIDS))
                    {
                        if (user.Role == UserRole.City || user.Role == UserRole.Branch)
                        {
                            user.Areas = Core.AreaManager.GetAreas(StringArrayHelper.GetIntArray(user.AreaIDS));
                        }
                    }
                }
            }
       
            return list;
        }

        public User GetUser(string username, string password = null)
        {
            User user = null;
            using (var db = GetDbContext())
            {
                user =db.Users.FirstOrDefault(e => e.Username == username.ToLower());
               
            }
            if (user != null)
            {
                if (!string.IsNullOrEmpty(password) && user.Password != password.MD5())
                {
                    throw new ArgumentException("密码错误");
                }
                if (!string.IsNullOrEmpty(user.AreaIDS))
                {
                    user.Areas = Core.AreaManager.GetAreas(StringArrayHelper.GetIntArray(user.AreaIDS));
                }
            }
            return user;
        }

        public User GetUser(int id)
        {
            if (id == 0) return null;
            User user = null;
            using (var db = GetDbContext())
            {
                user= db.Users.FirstOrDefault(e => e.ID == id);
               
            }
            if (user != null && user.Role==UserRole.Branch&&!string.IsNullOrEmpty(user.AreaIDS))
            {
                user.Areas = Core.AreaManager.GetAreas(StringArrayHelper.GetIntArray(user.AreaIDS));
            }
            return user;
        }

        public void Save(User model)
        {
            if (model.Role == UserRole.City)
            {
                var area = Core.AreaManager.GetArea(System.Configuration.ConfigurationManager.AppSettings["CITY"]);
                if (area == null)
                {
                    throw new ArgumentException("未找到市本级相关区域记录");
                }
                model.AreaIDS = area.ID.ToString();
            }else if (model.Role == UserRole.Branch)
            {

            }
            else
            {
                model.AreaIDS = null;
            }
            using (var db = GetDbContext())
            {
                if (model.ID > 0)
                {
                    var entity = db.Users.FirstOrDefault(e => e.ID == model.ID);
                    if (entity != null)
                    {
                        if (db.Users.Any(e => e.Username == model.Username.ToLower() && e.ID != model.ID))
                        {
                            throw new ArgumentException("用户名已被使用");
                        }
                        entity.Username = model.Username.ToLower();
                        if (!string.IsNullOrEmpty(model.Password))
                        {
                            entity.Password = model.Password.MD5();
                        }
                        entity.Name = model.Name;
                        entity.Role = model.Role;
                        entity.AreaIDS = model.AreaIDS;
                    }
                }
                else
                {
                    if (string.IsNullOrEmpty(model.Password))
                    {
                        throw new ArgumentException("密码不能为空");
                    }

                    model.Username = model.Username.ToLower();
                    model.Password = model.Password.MD5();
                    db.Users.Add(model);
                }
                db.SaveChanges();
            }
        }

        public void Delete(int id)
        {
            using (var db = GetDbContext())
            {
                var entity = db.Users.FirstOrDefault(e => e.ID == id);
                if (entity != null)
                {
                    db.Users.Remove(entity);
                    db.SaveChanges();
                }
            }
        }
    }
}
