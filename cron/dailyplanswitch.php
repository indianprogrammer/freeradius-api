<?php
#cron every day at 11:45PM
// UPDATE `users` SET currentprofile='EXPIRED' WHERE `expirydate` < now() AND currentprofile <> 'EXPIRED'
require_once('DBConnection.php');
$db = DBConnection::dbConnect();
#find all users with daily expiration
$sql = "UPDATE users SET currentprofile = profile WHERE users.username IN (SELECT username FROM `users` LEFT JOIN profiles ON users.profile = profiles.profile WHERE (profiles.value = 'DAILYLIMITED') )";
$st = $db->prepare($sql);
$st->execute();
$count=$st->rowCount();

syslog ( LOG_NOTICE , $count.' Users reset daily plan' );

?>
