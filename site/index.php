<?php
require_once '../lib/prepend.php';

$txt = "This is the index page.";

$twig_vars['txt'] = $txt;

require_once '../lib/append.php';
?>