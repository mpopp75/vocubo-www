<?php
namespace Vocubo;
require_once 'Vocubo/User.php';

class Characters extends User
{
    private $language;

    public function __construct($language) {
        $this->language = $language;
        parent::__construct();
    }

    public function getCharacters() {
        $sql = sprintf("SELECT charx
                        FROM characters
                        WHERE iso639_1 = '%s'
                        ORDER BY idx",
                        $this->escape($this->language));

        return $this->getAll($sql);
    }
}
?>