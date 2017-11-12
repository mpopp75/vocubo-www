<?php
require_once '../lib/prepend.php';
require_once '../lib/Vocubo/Practice.php';
require_once '../lib/Vocubo/Characters.php';

$practice = new \Vocubo\Practice();

$vocabulary = $practice->getVocabulary();

$characters = new \Vocubo\Characters($vocabulary['lang']);
$chars = $characters->getCharacters();

$twig_vars['voc'] = $vocabulary;
$twig_vars['chars'] = $chars;

require_once '../lib/append.php';
?>