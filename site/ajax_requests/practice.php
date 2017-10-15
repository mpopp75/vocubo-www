<?php
require_once('../../lib/prepend-ajax.php');
require_once('../../lib/Vocubo/Practice.php');
$practice = new \Vocubo\Practice();
$user = $practice->getUser();

$id = (int)$_POST['id'];
$answer = htmlspecialchars($_POST['answer'], ENT_QUOTES, "UTF-8");

$correct = $practice->checkAnswer($id, $answer);

if($correct[0] === true) {
    print "<p style=\"color: green\">Answer is correct.</p>";
} else {
    print "<p style=\"color: red\">Answer is false. Correct is <b>" . $correct[1] . "</b></p>";
}
?>