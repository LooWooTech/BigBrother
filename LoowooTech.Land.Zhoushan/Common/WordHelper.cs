using NPOI.XWPF.UserModel;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LoowooTech.Land.Zhoushan.Common
{
    public static class WordHelper
    {
        public static XWPFDocument CreateDoc()
        {
            return new XWPFDocument();
        }

        public static void WriteTitle(this XWPFDocument doc, string title, int fontSize = 24)
        {
            var p = doc.CreateParagraph();
            p.Alignment = ParagraphAlignment.CENTER;
            var r = p.CreateRun();
            r.FontSize = fontSize;
            r.SetText(title);
        }

        public static void WriteContent(this XWPFDocument doc, string content)
        {
            var p = doc.CreateParagraph();
            var r = p.CreateRun();
            r.FontSize = 16;
            r.SetText(content);
        }

        public static Stream GetStream(this XWPFDocument doc)
        {
            var ms = new MemoryStream();
            doc.Write(ms);
            return ms;
        }
    }
}
