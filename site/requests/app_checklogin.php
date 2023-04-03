<?php
require_once('../../lib/prepend-ajax.php');
require_once('../../lib/Vocubo/User.php');

$session_id = isset($_POST['session_id']) ? $_POST['session_id'] : "";

$user = new \Vocubo\User($session_id);

if ($user->checkLogin(true)) {
    print json_encode($user->getUser());
} else {
    print "{\"user_id\":-1,\"user_name\":\"\",\"\":\"\"}";
}
?>
