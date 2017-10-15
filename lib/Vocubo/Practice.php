<?php
namespace Vocubo;
require_once 'Vocubo/User.php';

class Practice extends User
{
    public function __construct() {
        parent::__construct();
    }

    public function getVocabulary() {
        $sql = sprintf("SELECT id, baselang, baselang_long, word_base,
                               lang, lang_long, word_target, hints, gender, RAND() AS rnd
                        FROM v_vocabulary_enabled
                        WHERE id_user = %d
                        ORDER BY rnd DESC
                        LIMIT 1",
                        (int)parent::$user_id);

        return $this->getRow($sql);
    }

    public function checkAnswer($id, $answer) {
        $sql = sprintf("SELECT word_target
                        FROM vocabulary
                        WHERE id = %d",
                        (int)$id);

        $correctAnswer = $this->getOne($sql);

        if($correctAnswer === $answer) {
            return array(true, null);
        } else {
            return array(false, $correctAnswer);
        }
    }
}
?>