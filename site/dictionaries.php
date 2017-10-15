<?php
require_once '../lib/prepend.php';
require_once '../lib/Vocubo/Dictionaries.php';

$dict = new \Vocubo\Dictionaries();
$dictionaries = $dict->getDictionaries();

// print "<pre>"; var_dump($dictionaries); print "</pre>";

$twig_vars['dictionaries'] = $dictionaries;

require_once '../lib/append.php';
?>