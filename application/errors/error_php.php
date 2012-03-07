<?php
$message = "Severity: " . $severity . "Message: " . $message . "Filename: " . $filepath . "Line: " . $line;
log_message('', str_replace(array("\n", "))", ")", "Array(", "  ", " => Array(", "[0]"), "", "PHP: " . $message));
/*
<div style="border:1px solid #990000;padding-left:20px;margin:0 0 10px 0;">

<h4>A PHP Error was encountered</h4>

<p>Severity: <?php echo $severity; ?></p>
<p>Message:  <?php echo $message; ?></p>
<p>Filename: <?php echo $filepath; ?></p>
<p>Line Number: <?php echo $line; ?></p>

</div>*/