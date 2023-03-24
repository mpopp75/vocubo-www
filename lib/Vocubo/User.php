<?php
namespace Vocubo;
require_once 'Vocubo/Database.php';

class User extends Database
{
    protected static $user_id = null;
    protected static $user_name = null;
    protected static $user_session = null;

    public function __construct($session_id = null) {
        self::$user_session = isset($session_id) ? $session_id : session_id();
        parent::__construct();
    }

    public function userLogin($user, $password) {
        $config = $GLOBALS['config'];

        $sql = sprintf("SELECT id, email, `name`
                        FROM `user`
                        WHERE email = '%s'
                          AND pw = SHA1('%s')",
                        $this->escape($user),
                        $this->escape($config['salt_pre'] . $password . $config['salt_post']));

        if ($user = $this->getRow($sql)) {
            self::$user_id = (int)$user['id'];
            self::$user_name = $user['email'];
            self::$user_session = session_id();

            $sql = sprintf("INSERT IGNORE INTO logins
                            (id_user, session_id)
                            VALUES
                            (%d, '%s')",
                            (int)self::$user_id,
                            $this->escape(self::$user_session));

            if ($this->query($sql)) {
                return true;
            }
        }
        return false;
    }

    public function userLogout() {

        $sql = sprintf("DELETE FROM logins
                        WHERE session_id = '%s'
                           OR NOW() > ts + INTERVAL 14 DAY",
                        $this->escape(self::$user_session));

        if ($this->db->query($sql)) {
            self::$user_id = null;
            self::$user_name = null;
            self::$user_session = null;
            session_destroy();

            return true;
        } else {
            return false;
        }
    }

    public function checkLogin() {
        $sql = sprintf("SELECT u.id, u.email, u.`name`, l.session_id
                        FROM `user` u INNER JOIN logins l
                          ON u.id = l.id_user
                        WHERE l.session_id = '%s'",
                        $this->escape(self::$user_session));

        if ($user = $this->getRow($sql)) {
            self::$user_id = (int)$user['id'];
            self::$user_name = $user['email'];
            self::$user_session = $user['session_id'];

            return true;
        } else {
            return false;
        }
    }

    public function getUser() {
        if (isset(self::$user_id) && self::$user_id !== null) {
            return array('user_id' => self::$user_id,
                         'user_name' => self::$user_name,
                         'user_session' => self::$user_session);
        } else {
            return null;
        }
    }
}
?>
