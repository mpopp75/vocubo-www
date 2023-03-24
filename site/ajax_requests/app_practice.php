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
            print json_encode($practice->checkAnswer($question_id, $answer));
            break;
        default :
            print "Unknown action";
    }

} else {
    print 0;
}
?>
