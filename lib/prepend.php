<?php
session_start();
// turn on output buffering
ob_start();

// include configuration file
if (file_exists(dirname(__FILE__) . '/init/config.php')) {
    require_once dirname(__FILE__) . '/init/config.php';
}

if (file_exists(dirname(__FILE__) . '/init/config.local.php')) {
    require_once dirname(__FILE__) . '/init/config.local.php';
}

ini_set('include_path', $config['sitepath'] . 'lib' . PATH_SEPARATOR .ini_get('include_path'));

/* ===== LOAD TWIG ===== */
require_once $config['sitepath'] . 'vendor/autoload.php';

$loader = new Twig_Loader_Filesystem ('templates');
$twig = new Twig_Environment ($loader , array('cache' => 'compilation_cache',
                                              'auto_reload' => true));

$file = preg_replace("/\/(.*)\.php/", "\\1", $_SERVER['SCRIPT_NAME']);
$template = $twig->loadTemplate($file . ".twig");
/* ===== END LOAD TWIG ===== */

/* ===== USER LOGIN ===== */
require_once 'Vocubo/Application.php';

$application = new \Vocubo\Application();

$user = null;
if (isset($_GET['logout']) && $_GET['logout'] === "1") {
  $application->userLogout();
} elseif ($application->checkLogin() === true) {
  $user = $application->getUser();
} elseif (isset($_POST['username']) && isset($_POST['pw'])) {
  if ($application->userLogin($_POST['username'], $_POST['pw'])) {
    $user = $application->getUser();
  }
}

$twig_vars['user'] = $user;
$twig_vars['file'] = $file;
/* ===== END USER LOGIN ===== */
?>