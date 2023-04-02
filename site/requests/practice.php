<?php
require_once('../../lib/prepend-ajax.php');
require_once('../../lib/Vocubo/Practice.php');
$practice = new \Vocubo\Practice();
$user = $practice->getUser();

$id = (int)$_POST['id'];
$what = htmlspecialchars($_POST['what'], ENT_QUOTES, "UTF-8");

switch ($what) {
    case "sendanswer" :
        $answer = htmlspecialchars($_POST['answer'], ENT_QUOTES, "UTF-8");

        $correct = $practice->checkAnswer($id, $answer);

        if($correct[0] === true) {
            print "<p style=\"color: green\">Answer is correct.</p>";
        } else {
            print "<p style=\"color: red\">Answer is false. Correct is <b><span class=\"langoutput\">" . $correct[1] . "</span></b></p>";
        }
        break;
    case "getlog" :
        $log = $practice->getLog($id);

        print json_encode($log);
        break;
}
?>