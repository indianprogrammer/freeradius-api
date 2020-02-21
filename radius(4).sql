-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Feb 21, 2020 at 12:20 PM
-- Server version: 10.3.17-MariaDB-1
-- PHP Version: 7.3.9-1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `radius`
--

-- --------------------------------------------------------

--
-- Table structure for table `auditlog`
--

CREATE TABLE `auditlog` (
  `id` int(11) NOT NULL,
  `username` varchar(64) NOT NULL DEFAULT '',
  `password` varchar(64) NOT NULL,
  `reply` varchar(32) NOT NULL DEFAULT '',
  `authdate` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `auditlog`
--

INSERT INTO `auditlog` (`id`, `username`, `password`, `reply`, `authdate`) VALUES
(1, 'test1', '0x3fd345a0235410826d878dec78332aa807', 'Access-Reject', '2019-09-23 04:46:06'),
(2, 'test1', '0x1268c367fc9b0058ef6037e7eba53e1b3a', 'Access-Accept', '2019-09-23 04:53:55'),
(3, 'test1', '0x4718652c9cef09fce9cbbc25dfcccad8fa', 'Access-Accept', '2019-09-23 04:54:14'),
(4, 'test1', '0x1f4d656db9fbc61a20956f8f3de4f74b17', 'Access-Accept', '2019-09-23 04:54:15'),
(5, 'test1', '0x84a073b28d92d9ef1a5074c2523f4e1ee4', 'Access-Accept', '2019-09-23 04:58:27'),
(6, 'test1', '0xc2b2c0897c6b9d6caa349fc595d7ac5833', 'Access-Accept', '2019-09-23 05:06:12');

-- --------------------------------------------------------

--
-- Table structure for table `nas`
--

CREATE TABLE `nas` (
  `id` int(10) NOT NULL,
  `nasname` varchar(128) NOT NULL,
  `coaport` int(6) NOT NULL DEFAULT 3799,
  `shortname` varchar(32) DEFAULT NULL,
  `type` varchar(30) DEFAULT 'other',
  `ports` int(5) DEFAULT NULL,
  `secret` varchar(60) NOT NULL DEFAULT 'secret',
  `server` varchar(64) DEFAULT NULL,
  `community` varchar(50) DEFAULT NULL,
  `description` varchar(200) DEFAULT 'RADIUS Client'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `nas`
--

INSERT INTO `nas` (`id`, `nasname`, `coaport`, `shortname`, `type`, `ports`, `secret`, `server`, `community`, `description`) VALUES
(1, '103.69.44.77', 3799, NULL, 'other', NULL, '123456', NULL, NULL, 'RADIUS Client'),
(2, '106.51.73.204', 3799, NULL, 'other', NULL, '123456', NULL, NULL, 'RADIUS Client'),
(3, '103.39.139.147', 3799, NULL, 'other', NULL, '123456', NULL, NULL, 'RADIUS Client');

-- --------------------------------------------------------

--
-- Table structure for table `profiles`
--

CREATE TABLE `profiles` (
  `id` int(11) UNSIGNED NOT NULL,
  `profile` varchar(64) NOT NULL,
  `attribute` varchar(64) NOT NULL DEFAULT '',
  `op` varchar(10) DEFAULT NULL,
  `value` varchar(253) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `profiles`
--

INSERT INTO `profiles` (`id`, `profile`, `attribute`, `op`, `value`) VALUES
(1, 'EXPIRED', 'Mikrotik-Rate-Limit', ':=', '1k/1k'),
(2, '2M', 'Mikrotik-Rate-Limit', ':=', '2M/2M 3M/3M 1M/1M 18/18 8 1M/1M'),
(3, '2M', 'Max-Daily-Data', ':=', '30'),
(4, '2M', 'PROFILETYPE', ':=', 'DAILYLIMITED'),
(5, '2M', 'DURATION', 'MONTH', '1'),
(9, 'skynetportal5m', 'Mikrotik-Rate-Limit', ':=', '5M/5M 6M/6M 1M/1M 18/18 8 1M/1M'),
(11, 'skynetportal5m', 'PROFILETYPE', ':=', 'DAILYLIMITED'),
(12, 'skynetportal5m', 'DURATION', 'DAY', '1');

-- --------------------------------------------------------

--
-- Table structure for table `radacct`
--

CREATE TABLE `radacct` (
  `radacctid` bigint(21) NOT NULL,
  `acctsessionid` varchar(64) NOT NULL DEFAULT '',
  `acctuniqueid` varchar(32) NOT NULL DEFAULT '',
  `username` varchar(64) NOT NULL DEFAULT '',
  `groupname` varchar(64) NOT NULL DEFAULT '',
  `realm` varchar(64) DEFAULT '',
  `nasipaddress` varchar(15) NOT NULL DEFAULT '',
  `nasportid` varchar(15) DEFAULT NULL,
  `nasporttype` varchar(32) DEFAULT NULL,
  `acctstarttime` datetime DEFAULT NULL,
  `acctupdatetime` datetime DEFAULT NULL,
  `acctinterval` varchar(10) DEFAULT NULL,
  `acctstoptime` datetime DEFAULT NULL,
  `acctsessiontime` int(12) UNSIGNED DEFAULT NULL,
  `acctauthentic` varchar(32) DEFAULT NULL,
  `connectinfo_start` varchar(50) DEFAULT NULL,
  `connectinfo_stop` varchar(50) DEFAULT NULL,
  `acctinputoctets` bigint(20) DEFAULT NULL,
  `acctoutputoctets` bigint(20) DEFAULT NULL,
  `calledstationid` varchar(50) NOT NULL DEFAULT '',
  `callingstationid` varchar(50) NOT NULL DEFAULT '',
  `acctterminatecause` varchar(32) NOT NULL DEFAULT '',
  `servicetype` varchar(32) DEFAULT NULL,
  `framedinterfaceid` varchar(64) DEFAULT NULL,
  `framedprotocol` varchar(32) DEFAULT NULL,
  `framedipaddress` varchar(15) NOT NULL DEFAULT '',
  `framedipv6address` varchar(60) DEFAULT NULL,
  `framedipv6prefix` varchar(64) DEFAULT NULL,
  `delegatedipv6prefix` varchar(64) DEFAULT NULL,
  `acctstartdelay` int(12) UNSIGNED DEFAULT NULL,
  `acctstopdelay` int(12) UNSIGNED DEFAULT NULL,
  `xascendsessionsvrkey` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `radacct`
--

INSERT INTO `radacct` (`radacctid`, `acctsessionid`, `acctuniqueid`, `username`, `groupname`, `realm`, `nasipaddress`, `nasportid`, `nasporttype`, `acctstarttime`, `acctupdatetime`, `acctinterval`, `acctstoptime`, `acctsessiontime`, `acctauthentic`, `connectinfo_start`, `connectinfo_stop`, `acctinputoctets`, `acctoutputoctets`, `calledstationid`, `callingstationid`, `acctterminatecause`, `servicetype`, `framedinterfaceid`, `framedprotocol`, `framedipaddress`, `framedipv6address`, `framedipv6prefix`, `delegatedipv6prefix`, `acctstartdelay`, `acctstopdelay`, `xascendsessionsvrkey`) VALUES
(3, '8040000f', 'd392437ccdfb23320b2ff3d8da6e998d', 'test1', '', '', '192.168.1.244', 'lan_bridge', 'Wireless-802.11', '2019-09-23 10:36:12', '2019-09-23 10:58:42', '30', '2019-09-23 10:59:05', 1374, '', '', '', 2787678, 1296594, 'hotspot1', '78:44:76:9A:22:F1', 'User-Request', '', '', '', '10.10.9.238', '', '', '', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `radgroupcheck`
--

CREATE TABLE `radgroupcheck` (
  `id` int(11) UNSIGNED NOT NULL,
  `groupname` varchar(64) NOT NULL DEFAULT '',
  `attribute` varchar(64) NOT NULL DEFAULT '',
  `op` char(2) NOT NULL DEFAULT '==',
  `value` varchar(253) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `radreply`
--

CREATE TABLE `radreply` (
  `id` int(11) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL DEFAULT '',
  `attribute` varchar(64) NOT NULL DEFAULT '',
  `op` char(2) NOT NULL DEFAULT '=',
  `value` varchar(253) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `radreply`
--

INSERT INTO `radreply` (`id`, `username`, `attribute`, `op`, `value`) VALUES
(1, 'test11', 'Framed-IP-Address', ':=', '10.0.10.1');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(20) NOT NULL,
  `password` varchar(20) NOT NULL,
  `profile` varchar(64) DEFAULT 'EXPIRED',
  `currentprofile` varchar(64) NOT NULL DEFAULT 'EXPIRED',
  `expirydate` datetime DEFAULT NULL,
  `ipaddress` varchar(15) DEFAULT NULL,
  `macaddress` varchar(17) DEFAULT NULL,
  `macbind` enum('ENABLE','DISABLE','ONREQUEST') NOT NULL DEFAULT 'DISABLE',
  `status` enum('ENABLE','DISABLE') NOT NULL DEFAULT 'DISABLE',
  `created` datetime DEFAULT current_timestamp(),
  `updated` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `profile`, `currentprofile`, `expirydate`, `ipaddress`, `macaddress`, `macbind`, `status`, `created`, `updated`) VALUES
(1, 'test1', 'test1', 'skynetportal5m', 'skynetportal5m', '2020-02-06 01:17:13', NULL, NULL, 'DISABLE', 'ENABLE', '2019-09-15 00:00:00', '2020-02-05 01:17:13'),
(2, 'sktest', 'sktest', '2M', 'EXPIRED', '2019-09-24 00:00:00', NULL, NULL, 'DISABLE', 'ENABLE', '2019-09-15 00:00:00', '2019-09-25 12:29:01'),
(38, 'userval', 'passval', 'skynetportal5m', 'skynetportal5m', '2020-02-06 14:32:47', NULL, NULL, 'DISABLE', 'ENABLE', '2019-09-26 12:59:13', '2020-02-05 14:32:47');

-- --------------------------------------------------------

--
-- Table structure for table `user_nas`
--

CREATE TABLE `user_nas` (
  `userid` int(11) NOT NULL,
  `nasid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `auditlog`
--
ALTER TABLE `auditlog`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`username`(32));

--
-- Indexes for table `nas`
--
ALTER TABLE `nas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `nasname` (`nasname`);

--
-- Indexes for table `profiles`
--
ALTER TABLE `profiles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `radacct`
--
ALTER TABLE `radacct`
  ADD PRIMARY KEY (`radacctid`),
  ADD UNIQUE KEY `acctuniqueid` (`acctuniqueid`),
  ADD KEY `username` (`username`),
  ADD KEY `framedipaddress` (`framedipaddress`),
  ADD KEY `acctsessionid` (`acctsessionid`),
  ADD KEY `acctsessiontime` (`acctsessiontime`),
  ADD KEY `acctstarttime` (`acctstarttime`),
  ADD KEY `acctstoptime` (`acctstoptime`),
  ADD KEY `nasipaddress` (`nasipaddress`);

--
-- Indexes for table `radgroupcheck`
--
ALTER TABLE `radgroupcheck`
  ADD PRIMARY KEY (`id`),
  ADD KEY `groupname` (`groupname`(32));

--
-- Indexes for table `radreply`
--
ALTER TABLE `radreply`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`username`(32));

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `user_nas`
--
ALTER TABLE `user_nas`
  ADD KEY `nasid` (`nasid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `auditlog`
--
ALTER TABLE `auditlog`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `nas`
--
ALTER TABLE `nas`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `profiles`
--
ALTER TABLE `profiles`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `radacct`
--
ALTER TABLE `radacct`
  MODIFY `radacctid` bigint(21) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `radgroupcheck`
--
ALTER TABLE `radgroupcheck`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `radreply`
--
ALTER TABLE `radreply`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
