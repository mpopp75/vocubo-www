<?php
namespace Vocubo;
require_once 'Vocubo/User.php';

class Dictionaries extends User
{
    public function __construct() {
        parent::__construct();
    }

    public function getDictionaries() {
        $sql = sprintf("SELECT id, dictname, baselang, baselang_long, lang, lang_long, enabled, tags
                        FROM v_dictionaries
                        WHERE id_user = %d
                        ORDER BY id",
                        (int)parent::$user_id);

        return $this->getAll($sql);
    }
}
?>