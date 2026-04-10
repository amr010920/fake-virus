@echo off
:: Created by Amr0109200
set "ps1=%TEMP%\UltraVirus.ps1"

:: Build the advanced UI with Glitch + Red Flash + Esc Hook
echo Add-Type -AssemblyName System.Windows.Forms > "%ps1%"
echo $f = New-Object Windows.Forms.Form >> "%ps1%"
echo $f.FormBorderStyle = 0; $f.WindowState = 2; $f.TopMost = $true; $f.Opacity = 0.7; $f.BackColor = 'Black' >> "%ps1%"

:: Add Scarier "Glitch" Text
echo $l = New-Object Windows.Forms.Label; $l.Text = 'SYSTEM CORRUPTION DETECTED`nREPLICATING TROJAN...'; $l.Font = New-Object Drawing.Font('Courier New', 40, 1); $l.ForeColor = 'Red'; $l.Dock = 5; $l.TextAlign = 32 >> "%ps1%"
echo $f.Controls.Add($l) >> "%ps1%"

:: Flashing + Random Glitch Text Timer
echo $tF = New-Object Windows.Forms.Timer; $tF.Interval = 200; $tF.Add_Tick({ if ($f.BackColor.Name -eq 'Red') { $f.BackColor = 'Black'; $l.ForeColor = 'White' } else { $f.BackColor = 'Red'; $l.ForeColor = 'Black' } }); $tF.Start() >> "%ps1%"

:: The Window Spammer (Each window kills itself after 5s)
echo $tS = New-Object Windows.Forms.Timer; $tS.Interval = 500; $tS.Add_Tick({ Start-Process cmd.exe -ArgumentList '/c color 0c ^& title ALERT ^& echo REPLICATING... ^& echo ERROR_0x000F6 ^& ping 127.0.0.1 -n 6 ^>nul ^& exit' -WindowStyle Normal }); $tS.Start() >> "%ps1%"

:: 60-Second Auto-End
echo $tK = New-Object Windows.Forms.Timer; $tK.Interval = 60000; $tK.Add_Tick({ stop-process -name cmd -ErrorAction SilentlyContinue; $f.Close() }); $tK.Start() >> "%ps1%"

:: THE ESCAPE HATCH (Pressing Esc kills the form AND all spawned CMD windows)
echo $f.Add_KeyDown({ if ($_.KeyCode -eq 'Escape') { stop-process -name cmd -ErrorAction SilentlyContinue; $f.Close() } }) >> "%ps1%"
echo $f.ShowDialog() >> "%ps1%"

:: Launch the virus
powershell -ExecutionPolicy Bypass -WindowStyle Hidden -File "%ps1%"

:: Clean up
del "%ps1%"
exit