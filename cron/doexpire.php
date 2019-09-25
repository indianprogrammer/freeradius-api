<?php
#cron every 5 min
require_once('DBConnection.php');
$db = DBConnection::dbConnect();
$sql= "UPDATE `users` SET currentprofile='EXPIRED' WHERE `expirydate` < now() AND currentprofile <> 'EXPIRED'";
$st = $db->prepare($sql);
$st->execute();
$count=$st->rowCount();

syslog ( LOG_NOTICE , $count.' Users expired' );

?>
