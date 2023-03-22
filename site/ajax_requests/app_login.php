<?php
require_once('../../lib/prepend-ajax.php');
require_once('../../lib/Vocubo/User.php');

$uname = isset($_REQUEST['user']) ? $_REQUEST['user'] : "";
$pw   = isset($_REQUEST['pass']) ? $_REQUEST['pass'] : "";

$user = new \Vocubo\User();

if ($user->userLogin($uname, $pw)) {
    print json_encode($user->getUser());
} else {
    print "{\"user_id\":-1,\"user_name\":\"\",\"\":\"\"}";
}
?>
