<?php
require_once('../../lib/prepend-ajax.php');
require_once('../../lib/Vocubo/User.php');

$session_id = isset($_REQUEST['session_id']) ? $_REQUEST['session_id'] : "";

$user = new \Vocubo\User($session_id);

if ($user->userLogout()) {
    print 1;
} else {
    print 0;
}
?>
