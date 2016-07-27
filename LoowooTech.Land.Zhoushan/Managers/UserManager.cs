﻿using LoowooTech.Land.Zhoushan.Common;
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
                    if (user.Role==UserRole.Branch&&user.AreaID.HasValue)
                    {
                        user.Area = Core.AreaManager.GetArea(user.AreaID.Value);
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
                if (user.Role == UserRole.Branch && user.AreaID.HasValue)
                {
                    user.Area = Core.AreaManager.GetArea(user.AreaID.Value);
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
            if (user != null && user.Role==UserRole.Branch&&user.AreaID.HasValue)
            {
                user.Area = Core.AreaManager.GetArea(user.AreaID.Value);
            }
            return user;
        }

        public void Save(User model)
        {
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
                        entity.AreaID = model.Role == UserRole.Branch ? model.AreaID : null;
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
