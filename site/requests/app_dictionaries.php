<?php
require_once('../../lib/prepend-ajax.php');
require_once('../../lib/Vocubo/Dictionaries.php');

$session_id = isset($_POST['session_id']) ? $_POST['session_id'] : "";
$action = isset($_POST['action']) ? $_POST['action'] : "";

$dictionaries = new \Vocubo\Dictionaries($session_id);

if ($dictionaries->checkLogin()) {
    switch ($action) {
        case "dictionary_list" :

            print json_encode($dictionaries->getDictionaries());

            break;
        default :
            print "Unknown action";
    }
} else {
    print 0;
}
?>
