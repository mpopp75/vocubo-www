<?php
namespace Vocubo;

class Database
{
    protected $db = null;

    public function __construct() {
        $config = $GLOBALS['config'];

        if (isset($config['dbcon']) && $this->db === null) {
            $dbcon = $config['dbcon'];
            $this->db = new \mysqli(
                $dbcon['host'],
                $dbcon['user'],
                $dbcon['pw'],
                $dbcon['db']
            );

            $this->query("SET NAMES utf8mb4");
        }
    }

    public function query($sql) {
        return $this->db->query($sql);
    }

    public function getOne($sql) {
        $query = $this->query($sql);

        $row = $query->fetch_row();

        return $row[0];
    }

    public function getRow($sql) {
        $query = $this->query($sql);

        return $query->fetch_assoc();
    }

    public function getAll($sql) {
        $query = $this->query($sql);

        $result = array();
        while ($row = $query->fetch_assoc()) {
            $result[] = $row;
        }

        return $result;
    }

    protected function escape($string) {
        return $this->db->real_escape_string($string);
    }
}
?>