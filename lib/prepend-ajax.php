<?php
session_start();

// include configuration file
if (file_exists(dirname(__FILE__) . '/init/config.php')) {
    require_once dirname(__FILE__) . '/init/config.php';
}

if (file_exists(dirname(__FILE__) . '/init/config.local.php')) {
    require_once dirname(__FILE__) . '/init/config.local.php';
}

ini_set('include_path', $config['sitepath'] . 'lib' . PATH_SEPARATOR .ini_get('include_path'));

require_once 'Vocubo/Application.php';

$application = new \Vocubo\Application();
$application->checkLogin();
?>