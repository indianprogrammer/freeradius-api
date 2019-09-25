<?php

/*
  PDO Database connection class
 */
//echo 'db connected';
class DBConnection {

    static $hostname = 'localhost';
    static $port = '3306';
    static $database = 'radius';
    static $username = 'root';
    static $password = 'Master143@';

    static function dbConnect() {
        try {            
            return new PDO('mysql:host=' . self::$hostname . ';port=' . self::$port . ';dbname=' . self::$database, self::$username, self::$password);
        } catch (PDOException $e) {
            syslog ( LOG_ERR , json_encode($e) );
        }
    }
}
?>
