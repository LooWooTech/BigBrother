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
                list = query.OrderByDescending(e => e.ID).SetPage(parameter.Page).ToList();

            }

            return list;
        }

        public User GetUser(string username, string password = null)
        {
            using (var db = GetDbContext())
            {
                var user = db.Users.FirstOrDefault(e => e.Username == username.ToLower());
                if (user == null)
                {
                    throw new ArgumentException("用户名不存在");
                }
                if (!string.IsNullOrEmpty(password) && user.Password != password.MD5())
                {
                    throw new ArgumentException("密码错误");
                }

                return user;
            }
        }

        public void UpdateLogin(User user)
        {
            using (var db = GetDbContext())
            {
                var entity = db.Users.FirstOrDefault(e => e.ID == user.ID);
                entity.LastLoginTime = DateTime.Now;
                db.SaveChanges();
            }
        }

        public User GetUser(int id)
        {
            if (id == 0) return null;
            using (var db = GetDbContext())
            {
                return db.Users.FirstOrDefault(e => e.ID == id);
            }
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
                model.AreaIds = new[] { area.ID };
            }
            else if (model.Role == UserRole.Branch)
            {
                if (string.IsNullOrEmpty(model.AreaIdsValue))
                {
                    throw new ArgumentException("没有选择用户所属区域");
                }
            }
            else
            {
                model.AreaIds = null;
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
                        entity.AreaIdsValue = model.AreaIdsValue;
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
