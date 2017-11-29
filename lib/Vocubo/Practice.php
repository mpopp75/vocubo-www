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
                               lang, lang_long, word_target, hints, RAND() AS rnd
                        FROM v_vocabulary_enabled
                        WHERE id_user = %d
                        ORDER BY count_log, correct_answers, percent_correct, rnd DESC
                        LIMIT 1",
                        (int)parent::$user_id);

        return $this->getRow($sql);
    }

    public function checkAnswer($id, $answer, $log = true) {
        $sql = sprintf("SELECT word_target
                        FROM vocabulary
                        WHERE id = %d",
                        (int)$id);

        $correctAnswer = $this->getOne($sql);

        if($correctAnswer === $answer) {
            $this->logResult($id, 1);
            return array(true, null);
        } else {
            $this->logResult($id, 0, $answer);
            return array(false, $correctAnswer);
        }
    }

    private function logResult($id, $result, $answer = "") {
        $sql = "";
        if ($answer === "") {
            $sql = sprintf("INSERT INTO practice_log
                            (id_user, id_vocabulary, result)
                            VALUES
                            (%d, %d, %d)",
                            (int)self::$user_id,
                            (int)$id,
                            (int)$result);
        } else {
            $sql = sprintf("INSERT INTO practice_log
                            (id_user, id_vocabulary, result, wrong_answer)
                            VALUES
                            (%d, %d, %d, '%s')",
                            (int)self::$user_id,
                            (int)$id,
                            (int)$result,
                            $this->escape($answer));
        }

        return $this->query($sql);
    }

    public function getLog($id, $limit = 10) {
        $sql = sprintf("SELECT ts, result, wrong_answer
                        FROM practice_log
                        WHERE id_user = %d
                          AND id_vocabulary = %d
                        ORDER BY ts DESC
                        LIMIT %d",
                        (int)self::$user_id,
                        (int)$id,
                        (int)$limit);

        return $this->getAll($sql);
    }
}
?>
