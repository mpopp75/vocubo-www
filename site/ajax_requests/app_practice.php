<?php
require_once('../../lib/prepend-ajax.php');
require_once('../../lib/Vocubo/Practice.php');

$session_id = isset($_REQUEST['session_id']) ? $_REQUEST['session_id'] : "";
$question_id = isset($_REQUEST['question_id']) ? $_REQUEST['question_id'] : null;
$answer = isset($_REQUEST['answer']) ? $_REQUEST['answer'] : "";
$action = isset($_REQUEST['action']) ? $_REQUEST['action'] : "";

$practice = new \Vocubo\Practice($session_id);

if ($practice->checkLogin()) {
    switch ($action) {
        case "question" :
            print json_encode($practice->getVocabulary());
            break;
        case "answer" :
            $result = $practice->checkAnswer($question_id, $answer);

            $correct = "";
            $correct_answer = "";
            if ($result[0] == true) {
                $correct = "correct";
            } else {
                $correct = "incorrect";
                $correct_answer = $result[1];
            }

            print json_encode(array("correct" => $correct, "correct_answer" => $correct_answer));
            break;
        default :
            print "Unknown action";
    }

} else {
    print 0;
}
?>
