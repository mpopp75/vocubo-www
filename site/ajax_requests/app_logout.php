<?php
require_once('../../lib/prepend-ajax.php');
require_once('../../lib/Vocubo/User.php');

$session_id = isset($_REQUEST['session_id']) ? $_REQUEST['session_id'] : "";

$user = new \Vocubo\User();

if ($user->userLogout($session_id)) {
    print 1;
} else {
    print 0;
}
?>
