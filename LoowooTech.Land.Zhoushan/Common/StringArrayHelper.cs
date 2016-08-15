using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LoowooTech.Land.Zhoushan.Common
{
    public static class StringArrayHelper
    {
        public static string[] GetStringArray(int[] array)
        {
            var result = new string[array.Length];
            for (var i = 0; i < array.Length; i++)
            {
                result[i] = array[i].ToString();
            }
            return result;
        }

        public static int[] GetIntArray(string str,char ch=',')
        {
            var temp = str.Split(ch);
            var a = 0;
            var result = new int[temp.Length];
            for (var i = 0; i < temp.Length; i++)
            {
                result[i] = int.TryParse(temp[i], out a) ? a : 0;
            }
            return result;
        }
    }
}
