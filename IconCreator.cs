using System;
using System.Drawing;
using System.IO;

namespace IconCreator
{
	static class Program
	{
		static int Main(string[] args)
        {
            Icon icon = Program.GenerateIcon("Hello");
            for (int i = 0; i < 10; i++)
            {
                Program.CreateIcon(" " + i.ToString(), i.ToString());
            }
            return 0;
        }

        static void CreateIcon(string text, string fileName)
        {
            Icon icon = Program.GenerateIcon(text);
            string CurrentDirectory = Directory.GetCurrentDirectory() + @"\icons\" + fileName + ".ico";
            using (FileStream fs = new FileStream(CurrentDirectory, FileMode.Create))
                icon.Save(fs);
        }

        static Icon GenerateIcon(string text)
        {
        
            string IconFontName = "Pixel FJVerdana";
            int IconFontSize = 9;
            FontStyle IconFontStyle = FontStyle.Regular;
            Color MainColor = Color.White;
            float OffsetX = 1;
            float OffsetY = 1;
            int MagicSize = 16;  // Constant tray icon size 
            Font fontToUse = new Font(IconFontName, IconFontSize, IconFontStyle, GraphicsUnit.Pixel);
            Brush brushToUse = new SolidBrush(MainColor);
            Bitmap bitmapText = new Bitmap(MagicSize, MagicSize);  // Const size for tray icon

            Graphics g = Graphics.FromImage(bitmapText);

            g.Clear(Color.Transparent);

            // Draw border
            g.DrawRectangle(
                new Pen(MainColor, 1),
                new Rectangle(0, 0, MagicSize - 1, MagicSize - 1));

            // Draw text
            g.TextRenderingHint = System.Drawing.Text.TextRenderingHint.SingleBitPerPixelGridFit;
            g.DrawString(text, fontToUse, brushToUse, OffsetX, OffsetY);

            // Create icon from bitmap and return it
            // bitmapText.GetHicon() can throw exception
            try
            {
                return Icon.FromHandle(bitmapText.GetHicon());
            }
            catch
            {
                return null;
            }
        }
    }
}