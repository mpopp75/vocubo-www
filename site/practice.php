<?php
require_once '../lib/prepend.php';
require_once '../lib/Vocubo/Practice.php';

$practice = new \Vocubo\Practice();

$vocabulary = $practice->getVocabulary();

$twig_vars['voc'] = $vocabulary;

require_once '../lib/append.php';
?>