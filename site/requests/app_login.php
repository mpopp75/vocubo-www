<?php
require_once('../../lib/prepend-ajax.php');
require_once('../../lib/Vocubo/User.php');

$uname = isset($_POST['user']) ? $_POST['user'] : "";
$pw   = isset($_POST['pass']) ? $_POST['pass'] : "";

$user = new \Vocubo\User();

if ($user->userLogin($uname, $pw)) {
    print json_encode($user->getUser());
} else {
    print "{\"user_id\":-1,\"user_name\":\"\",\"\":\"\"}";
}
?>
