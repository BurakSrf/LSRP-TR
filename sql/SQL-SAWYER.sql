-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Anamakine: 127.0.0.1
-- Üretim Zamanı: 23 Oca 2022, 01:28:54
-- Sunucu sürümü: 10.4.22-MariaDB
-- PHP Sürümü: 8.1.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Veritabanı: `lsrp`
--

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `accounts`
--

CREATE TABLE `accounts` (
  `id` int(11) NOT NULL,
  `name` varchar(21) NOT NULL,
  `password` varchar(129) NOT NULL,
  `secret` varchar(129) NOT NULL,
  `email` varchar(255) NOT NULL,
  `reg_time` int(12) NOT NULL,
  `reg_ip` varchar(16) NOT NULL,
  `last_ucp_time` int(12) NOT NULL,
  `last_ucp_ip` varchar(16) NOT NULL,
  `last_game_time` int(12) NOT NULL,
  `last_game_ip` varchar(16) NOT NULL,
  `name_changes` int(11) NOT NULL DEFAULT 0,
  `number_changes` int(11) NOT NULL DEFAULT 0,
  `donate` int(11) NOT NULL DEFAULT 0,
  `forumlink` varchar(256) NOT NULL,
  `google_auth` varchar(17) NOT NULL DEFAULT '!',
  `is_approved` int(1) NOT NULL DEFAULT 0,
  `active_id` int(11) NOT NULL,
  `security_question` text NOT NULL,
  `security_word` text NOT NULL,
  `memorable_word` text NOT NULL,
  `memorable_hint` text NOT NULL,
  `is_logged` int(11) NOT NULL DEFAULT 0,
  `adminlevel` int(11) NOT NULL DEFAULT 0,
  `adminname` varchar(128) NOT NULL DEFAULT 'Yok',
  `testerlevel` int(11) NOT NULL DEFAULT 0,
  `testername` varchar(128) NOT NULL DEFAULT 'Yok',
  `acceptcount` int(11) NOT NULL,
  `deniedcount` int(11) NOT NULL,
  `hash` text NOT NULL,
  `reg_hwid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin5;

--
-- Tablo döküm verisi `accounts`
--

INSERT INTO `accounts` (`id`, `name`, `password`, `secret`, `email`, `reg_time`, `reg_ip`, `last_ucp_time`, `last_ucp_ip`, `last_game_time`, `last_game_ip`, `name_changes`, `number_changes`, `donate`, `forumlink`, `google_auth`, `is_approved`, `active_id`, `security_question`, `security_word`, `memorable_word`, `memorable_hint`, `is_logged`, `adminlevel`, `adminname`, `testerlevel`, `testername`, `acceptcount`, `deniedcount`, `hash`, `reg_hwid`) VALUES
(1, 'Sawyer', 'f7a58e0ba326b34db18d2b288010eb5bcc046b09199ce9deb3fa4319119108b5ecdff4d8e84a1cf48915276eafe1df7ec35abe3d6e2df6d3cb6afc6927cee7bb', '', '', 0, '', 0, '', 1642636669, '127.0.0.1', 0, 0, 0, '', '!', 0, 1, '', '', '', '', 0, 6, 'Yok', 0, 'Yok', 0, 0, '', 0);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `actors`
--

CREATE TABLE `actors` (
  `id` int(11) NOT NULL,
  `ActorName` varchar(45) NOT NULL DEFAULT 'Yok',
  `ActorSkin` smallint(5) NOT NULL DEFAULT 1,
  `ActorX` float NOT NULL,
  `ActorY` float NOT NULL,
  `ActorZ` float NOT NULL,
  `ActorA` float NOT NULL,
  `ActorInterior` int(11) NOT NULL DEFAULT 0,
  `ActorWorld` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin5;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `admin_logs`
--

CREATE TABLE `admin_logs` (
  `log_id` int(11) NOT NULL,
  `admin_dbid` int(11) NOT NULL,
  `log_detail` varchar(256) NOT NULL,
  `time` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin5;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `adverts`
--

CREATE TABLE `adverts` (
  `id` int(11) NOT NULL,
  `advertby` int(11) NOT NULL DEFAULT 0,
  `advertnumber` int(11) NOT NULL DEFAULT 0,
  `adverttype` tinyint(1) NOT NULL DEFAULT 1,
  `adverttext` varchar(128) NOT NULL,
  `adverttime` int(12) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin5;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `answers`
--

CREATE TABLE `answers` (
  `id` int(11) NOT NULL,
  `correct_answer` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin5;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `antenna`
--

CREATE TABLE `antenna` (
  `id` int(11) NOT NULL,
  `pos_x` float NOT NULL,
  `pos_y` float NOT NULL,
  `pos_z` float NOT NULL,
  `pos_rx` float NOT NULL,
  `pos_ry` float NOT NULL,
  `pos_rz` float NOT NULL,
  `created_by` int(11) NOT NULL,
  `created_at` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin5;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `atms`
--

CREATE TABLE `atms` (
  `id` int(11) NOT NULL,
  `AtmLocation` varchar(40) NOT NULL DEFAULT 'Yok',
  `AtmX` float NOT NULL,
  `AtmY` float NOT NULL,
  `AtmZ` float NOT NULL,
  `AtmRX` float NOT NULL,
  `AtmRY` float NOT NULL,
  `AtmRZ` float NOT NULL,
  `AtmInterior` int(11) NOT NULL DEFAULT 0,
  `AtmWorld` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin5;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `bans`
--

CREATE TABLE `bans` (
  `id` mediumint(8) NOT NULL,
  `active` tinyint(2) NOT NULL,
  `ban_ip` varchar(16) NOT NULL,
  `ban_name` varchar(25) NOT NULL,
  `ban_regid` smallint(7) NOT NULL,
  `ban_accountid` smallint(7) NOT NULL,
  `admin` varchar(25) NOT NULL,
  `admin_regid` smallint(7) NOT NULL,
  `reason` varchar(35) NOT NULL,
  `time` int(11) NOT NULL,
  `unban_time` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin5;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `billboards`
--

CREATE TABLE `billboards` (
  `id` int(11) NOT NULL,
  `BillboardModel` int(11) NOT NULL,
  `BillboardText` varchar(128) NOT NULL DEFAULT 'Yok',
  `BillboardX` float NOT NULL,
  `BillboardY` float NOT NULL,
  `BillboardZ` float NOT NULL,
  `BillboardRX` float NOT NULL,
  `BillboardRY` float NOT NULL,
  `BillboardRZ` float NOT NULL,
  `BillboardInterior` int(11) NOT NULL DEFAULT 0,
  `BillboardWorld` int(11) NOT NULL DEFAULT 0,
  `BillboardRentedBy` int(11) NOT NULL DEFAULT 0,
  `BillboardRentExpiresAt` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin5;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `bulletins`
--

CREATE TABLE `bulletins` (
  `id` int(11) NOT NULL,
  `BullettinDetails` varchar(128) NOT NULL DEFAULT 'Yok',
  `BulletinBy` int(11) NOT NULL DEFAULT 0,
  `BulletinDate` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin5;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `businesses`
--

CREATE TABLE `businesses` (
  `id` int(11) NOT NULL,
  `BusinessOwner` int(11) NOT NULL DEFAULT 0,
  `BusinessName` varchar(128) NOT NULL DEFAULT 'Yok',
  `BusinessMOTD` varchar(128) NOT NULL DEFAULT 'Yok',
  `BusinessPrice` int(11) NOT NULL DEFAULT 50000,
  `BusinessLevel` smallint(5) NOT NULL DEFAULT 1,
  `BusinessType` tinyint(2) NOT NULL,
  `BusinessRType` tinyint(1) NOT NULL DEFAULT 0,
  `EnterX` float NOT NULL,
  `EnterY` float NOT NULL,
  `EnterZ` float NOT NULL,
  `EnterA` float NOT NULL,
  `EnterInterior` int(11) NOT NULL DEFAULT 0,
  `EnterWorld` int(11) NOT NULL DEFAULT 0,
  `ExitX` float NOT NULL,
  `ExitY` float NOT NULL,
  `ExitZ` float NOT NULL,
  `ExitA` float NOT NULL,
  `ExitInterior` int(11) NOT NULL DEFAULT 0,
  `ExitWorld` int(11) NOT NULL DEFAULT 0,
  `BankX` float NOT NULL,
  `BankY` float NOT NULL,
  `BankZ` float NOT NULL,
  `BankInterior` int(11) NOT NULL DEFAULT 0,
  `BankWorld` int(11) NOT NULL DEFAULT 0,
  `BusinessLocked` tinyint(1) NOT NULL DEFAULT 0,
  `BusinessHasXMR` tinyint(1) NOT NULL DEFAULT 0,
  `BusinessCashbox` int(11) NOT NULL DEFAULT 0,
  `BusinessFee` int(11) NOT NULL DEFAULT 0,
  `Time` tinyint(2) NOT NULL DEFAULT 12,
  `Lights` tinyint(1) NOT NULL DEFAULT 1,
  `BusinessProduct` int(11) NOT NULL DEFAULT 100,
  `BusinessWantedProduct` int(1) NOT NULL DEFAULT 0,
  `BusinessProductPrice` int(11) NOT NULL DEFAULT 50,
  `Food1` tinyint(1) NOT NULL DEFAULT 0,
  `Food2` tinyint(1) NOT NULL DEFAULT 1,
  `Food3` tinyint(1) NOT NULL DEFAULT 2,
  `Price1` smallint(4) NOT NULL DEFAULT 50,
  `Price2` smallint(4) NOT NULL DEFAULT 50,
  `Price3` smallint(4) NOT NULL DEFAULT 50
) ENGINE=InnoDB DEFAULT CHARSET=latin5;

--
-- Tablo döküm verisi `businesses`
--

INSERT INTO `businesses` (`id`, `BusinessOwner`, `BusinessName`, `BusinessMOTD`, `BusinessPrice`, `BusinessLevel`, `BusinessType`, `BusinessRType`, `EnterX`, `EnterY`, `EnterZ`, `EnterA`, `EnterInterior`, `EnterWorld`, `ExitX`, `ExitY`, `ExitZ`, `ExitA`, `ExitInterior`, `ExitWorld`, `BankX`, `BankY`, `BankZ`, `BankInterior`, `BankWorld`, `BusinessLocked`, `BusinessHasXMR`, `BusinessCashbox`, `BusinessFee`, `Time`, `Lights`, `BusinessProduct`, `BusinessWantedProduct`, `BusinessProductPrice`, `Food1`, `Food2`, `Food3`, `Price1`, `Price2`, `Price3`) VALUES
(1, 0, 'Market', '', 50000, 1, 1, 0, 1342.92, -1431.02, 13.3828, 327.388, 0, 0, 1342.92, -1431.02, 10000, 327.388, 99, 99, 0, 0, 0, 0, 0, 1, 0, 0, 1, 12, 1, 100, 0, 75, 0, 1, 2, 50, 50, 50);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `cameras`
--

CREATE TABLE `cameras` (
  `id` smallint(5) NOT NULL,
  `CameraName` varchar(30) NOT NULL,
  `CameraX` float NOT NULL,
  `CameraY` float NOT NULL,
  `CameraZ` float NOT NULL,
  `CameraRX` float NOT NULL,
  `CameraRY` float NOT NULL,
  `CameraRZ` float NOT NULL,
  `CameraInterior` int(11) NOT NULL DEFAULT 0,
  `CameraWorld` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin5;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `chopshop`
--

CREATE TABLE `chopshop` (
  `id` int(11) NOT NULL,
  `money` int(11) DEFAULT NULL,
  `offsetX` float DEFAULT NULL,
  `offsetY` float DEFAULT NULL,
  `offsetZ` float DEFAULT NULL,
  `rotX` float DEFAULT NULL,
  `rotY` float DEFAULT NULL,
  `rotZ` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `clothings`
--

CREATE TABLE `clothings` (
  `id` int(11) NOT NULL,
  `clothing_model` smallint(5) NOT NULL,
  `clothing_name` varchar(32) NOT NULL,
  `clothing_price` smallint(5) NOT NULL,
  `clothing_type` tinyint(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin5;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `connections`
--

CREATE TABLE `connections` (
  `conn_id` int(8) NOT NULL,
  `name` varchar(24) NOT NULL,
  `reg_id` smallint(7) NOT NULL,
  `IP` varchar(16) NOT NULL,
  `time` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin5;

--
-- Tablo döküm verisi `connections`
--

INSERT INTO `connections` (`conn_id`, `name`, `reg_id`, `IP`, `time`) VALUES
(1, 'Sawyer', 1, '127.0.0.1', 0);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `criminal_record`
--

CREATE TABLE `criminal_record` (
  `id` int(11) NOT NULL,
  `player_name` varchar(32) COLLATE utf8_turkish_ci NOT NULL,
  `entry_reason` varchar(128) COLLATE utf8_turkish_ci NOT NULL,
  `entry_date` int(11) NOT NULL,
  `entry_by` varchar(32) COLLATE utf8_turkish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `dealerships`
--

CREATE TABLE `dealerships` (
  `id` int(11) NOT NULL,
  `VehicleCategory` tinyint(3) NOT NULL,
  `VehicleName` varchar(45) NOT NULL,
  `VehicleModel` smallint(5) NOT NULL,
  `VehiclePrice` int(11) NOT NULL,
  `VehicleEnabled` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=latin5;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `dealership_categories`
--

CREATE TABLE `dealership_categories` (
  `id` int(11) NOT NULL,
  `CategoryName` varchar(25) NOT NULL,
  `CategoryModel` smallint(5) NOT NULL DEFAULT 0,
  `CategorySecret` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin5;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `doors`
--

CREATE TABLE `doors` (
  `id` int(11) NOT NULL,
  `PosX` float NOT NULL,
  `PosY` float NOT NULL,
  `PosZ` float NOT NULL,
  `PosA` float NOT NULL,
  `PosInterior` int(11) NOT NULL DEFAULT 0,
  `PosWorld` int(11) NOT NULL DEFAULT 0,
  `IntX` float NOT NULL,
  `IntY` float NOT NULL,
  `IntZ` float NOT NULL,
  `IntA` float NOT NULL,
  `IntInterior` int(11) NOT NULL DEFAULT 0,
  `IntWorld` int(11) NOT NULL DEFAULT 0,
  `DoorFaction` int(11) NOT NULL DEFAULT 0,
  `DoorName` varchar(35) NOT NULL DEFAULT 'Yok',
  `DoorLocked` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=latin5;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `entrances`
--

CREATE TABLE `entrances` (
  `id` int(11) NOT NULL,
  `EntranceName` varchar(32) NOT NULL DEFAULT 'Yok',
  `EnterX` float NOT NULL,
  `EnterY` float NOT NULL,
  `EnterZ` float NOT NULL,
  `EnterA` float NOT NULL,
  `EnterInterior` int(11) NOT NULL DEFAULT 0,
  `EnterWorld` int(11) NOT NULL DEFAULT 0,
  `ExitX` float NOT NULL,
  `ExitY` float NOT NULL,
  `ExitZ` float NOT NULL,
  `ExitA` float NOT NULL,
  `ExitInterior` int(11) NOT NULL,
  `ExitWorld` int(11) NOT NULL,
  `EntranceIcon` int(11) NOT NULL DEFAULT 1318,
  `EntranceFaction` int(11) NOT NULL DEFAULT 0,
  `EntranceLocked` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=latin5;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `events`
--

CREATE TABLE `events` (
  `id` int(11) NOT NULL,
  `name` varchar(256) CHARACTER SET latin5 NOT NULL DEFAULT 'Yok',
  `content` varchar(20000) CHARACTER SET latin5 NOT NULL DEFAULT 'Yok',
  `type` int(11) NOT NULL DEFAULT 0,
  `date` varchar(128) CHARACTER SET latin5 NOT NULL DEFAULT '',
  `status` int(11) NOT NULL DEFAULT 1,
  `joinable` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `event_participants`
--

CREATE TABLE `event_participants` (
  `id` int(11) NOT NULL,
  `eventid` int(11) NOT NULL DEFAULT 0,
  `accountid` int(11) NOT NULL DEFAULT 0,
  `date` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `factions`
--

CREATE TABLE `factions` (
  `id` int(11) NOT NULL,
  `Name` varchar(128) NOT NULL,
  `Abbreviation` varchar(128) NOT NULL,
  `MaxRanks` int(11) NOT NULL DEFAULT 20,
  `EditRank` int(11) NOT NULL DEFAULT 1,
  `ChatRank` int(11) NOT NULL DEFAULT 20,
  `TowRank` int(11) NOT NULL DEFAULT 1,
  `ChatColor` int(11) NOT NULL DEFAULT -1920073814,
  `ChatStatus` int(11) NOT NULL DEFAULT 0,
  `CopPerms` int(11) NOT NULL DEFAULT 0,
  `MedPerms` int(11) NOT NULL DEFAULT 0,
  `SanPerms` int(11) NOT NULL DEFAULT 0,
  `SpawnX` float NOT NULL,
  `SpawnY` float NOT NULL,
  `SpawnZ` float NOT NULL,
  `SpawnA` float NOT NULL,
  `SpawnInt` int(11) NOT NULL,
  `SpawnWorld` int(11) NOT NULL,
  `ExSpawn1X` float NOT NULL,
  `ExSpawn1Y` float NOT NULL,
  `ExSpawn1Z` float NOT NULL,
  `ExSpawn1Int` int(11) NOT NULL,
  `ExSpawn1World` int(11) NOT NULL,
  `ExSpawn2X` float NOT NULL,
  `ExSpawn2Y` float NOT NULL,
  `ExSpawn2Z` float NOT NULL,
  `ExSpawn2Int` int(11) NOT NULL,
  `ExSpawn2World` int(11) NOT NULL,
  `ExSpawn3X` float NOT NULL,
  `ExSpawn3Y` float NOT NULL,
  `ExSpawn3Z` float NOT NULL,
  `ExSpawn3Int` int(11) NOT NULL,
  `ExSpawn3World` int(11) NOT NULL,
  `Bank` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin5;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `faction_attachments`
--

CREATE TABLE `faction_attachments` (
  `id` int(11) NOT NULL,
  `faction_id` smallint(5) NOT NULL,
  `att_id` smallint(5) NOT NULL,
  `att_name` varchar(20) NOT NULL,
  `att_price` smallint(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin5;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `faction_ranks`
--

CREATE TABLE `faction_ranks` (
  `faction_id` int(11) NOT NULL,
  `factionrank1` varchar(60) NOT NULL DEFAULT 'Ayarlanmamış',
  `factionranksalary1` smallint(5) NOT NULL DEFAULT 0,
  `factionrank2` varchar(60) NOT NULL DEFAULT 'Ayarlanmamış',
  `factionranksalary2` smallint(5) NOT NULL DEFAULT 0,
  `factionrank3` varchar(60) NOT NULL DEFAULT 'Ayarlanmamış',
  `factionranksalary3` smallint(5) NOT NULL DEFAULT 0,
  `factionrank4` varchar(60) NOT NULL DEFAULT 'Ayarlanmamış',
  `factionranksalary4` smallint(5) NOT NULL DEFAULT 0,
  `factionrank5` varchar(60) NOT NULL DEFAULT 'Ayarlanmamış',
  `factionranksalary5` smallint(5) NOT NULL DEFAULT 0,
  `factionrank6` varchar(60) NOT NULL DEFAULT 'Ayarlanmamış',
  `factionranksalary6` smallint(5) NOT NULL DEFAULT 0,
  `factionrank7` varchar(60) NOT NULL DEFAULT 'Ayarlanmamış',
  `factionranksalary7` smallint(5) NOT NULL DEFAULT 0,
  `factionrank8` varchar(60) NOT NULL DEFAULT 'Ayarlanmamış',
  `factionranksalary8` smallint(5) NOT NULL DEFAULT 0,
  `factionrank9` varchar(60) NOT NULL DEFAULT 'Ayarlanmamış',
  `factionranksalary9` smallint(5) NOT NULL DEFAULT 0,
  `factionrank10` varchar(60) NOT NULL DEFAULT 'Ayarlanmamış',
  `factionranksalary10` smallint(5) NOT NULL DEFAULT 0,
  `factionrank11` varchar(60) NOT NULL DEFAULT 'Ayarlanmamış',
  `factionranksalary11` smallint(5) NOT NULL DEFAULT 0,
  `factionrank12` varchar(60) NOT NULL DEFAULT 'Ayarlanmamış',
  `factionranksalary12` smallint(5) NOT NULL DEFAULT 0,
  `factionrank13` varchar(60) NOT NULL DEFAULT 'Ayarlanmamış',
  `factionranksalary13` smallint(5) NOT NULL DEFAULT 0,
  `factionrank14` varchar(60) NOT NULL DEFAULT 'Ayarlanmamış',
  `factionranksalary14` smallint(5) NOT NULL DEFAULT 0,
  `factionrank15` varchar(60) NOT NULL DEFAULT 'Ayarlanmamış',
  `factionranksalary15` smallint(5) NOT NULL DEFAULT 0,
  `factionrank16` varchar(60) NOT NULL DEFAULT 'Ayarlanmamış',
  `factionranksalary16` smallint(5) NOT NULL DEFAULT 0,
  `factionrank17` varchar(60) NOT NULL DEFAULT 'Ayarlanmamış',
  `factionranksalary17` smallint(5) NOT NULL DEFAULT 0,
  `factionrank18` varchar(60) NOT NULL DEFAULT 'Ayarlanmamış',
  `factionranksalary18` smallint(5) NOT NULL DEFAULT 0,
  `factionrank19` varchar(60) NOT NULL DEFAULT 'Ayarlanmamış',
  `factionranksalary19` smallint(5) NOT NULL DEFAULT 0,
  `factionrank20` varchar(60) NOT NULL DEFAULT 'Ayarlanmamış',
  `factionranksalary20` smallint(5) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin5;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `faction_roadblocks`
--

CREATE TABLE `faction_roadblocks` (
  `id` int(11) NOT NULL,
  `RoadblockObjID` int(11) NOT NULL,
  `RoadblockName` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin5;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `faction_uniforms`
--

CREATE TABLE `faction_uniforms` (
  `id` int(11) NOT NULL,
  `faction_id` smallint(5) NOT NULL DEFAULT -1,
  `skin_id` smallint(5) NOT NULL,
  `skin_name` varchar(20) NOT NULL,
  `skin_race` tinyint(1) NOT NULL DEFAULT 1,
  `skin_sex` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=latin5;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `furnitures`
--

CREATE TABLE `furnitures` (
  `id` int(11) NOT NULL,
  `PropertyID` int(11) NOT NULL DEFAULT -1,
  `BusinessID` int(11) NOT NULL DEFAULT -1,
  `CategoryID` int(11) NOT NULL,
  `SubCategoryID` int(11) NOT NULL,
  `FurnitureID` int(11) NOT NULL,
  `FurniturePrice` int(11) NOT NULL,
  `FurnitureName` varchar(64) NOT NULL,
  `FurnitureX` float NOT NULL,
  `FurnitureY` float NOT NULL,
  `FurnitureZ` float NOT NULL,
  `FurnitureRX` float NOT NULL,
  `FurnitureRY` float NOT NULL,
  `FurnitureRZ` float NOT NULL,
  `FurnitureVW` int(11) NOT NULL,
  `FurnitureInt` int(11) NOT NULL,
  `Texture_1` int(11) NOT NULL DEFAULT -1,
  `Texture_2` int(11) NOT NULL DEFAULT -1,
  `Texture_3` int(11) NOT NULL DEFAULT -1,
  `Texture_4` int(11) NOT NULL DEFAULT -1,
  `Texture_5` int(11) NOT NULL DEFAULT -1
) ENGINE=InnoDB DEFAULT CHARSET=latin5;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `furniture_categories`
--

CREATE TABLE `furniture_categories` (
  `id` int(11) NOT NULL,
  `CategoryName` varchar(26) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin5;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `furniture_lists`
--

CREATE TABLE `furniture_lists` (
  `id` int(11) NOT NULL,
  `SubCategoryID` int(11) NOT NULL,
  `ObjID` int(11) NOT NULL,
  `ObjName` varchar(64) NOT NULL,
  `ObjPrice` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin5;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `furniture_subcategories`
--

CREATE TABLE `furniture_subcategories` (
  `id` int(11) NOT NULL,
  `CategoryID` int(11) NOT NULL,
  `SubCategoryName` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin5;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `garages`
--

CREATE TABLE `garages` (
  `id` int(11) NOT NULL,
  `GaragePropertyID` int(11) NOT NULL DEFAULT 0,
  `EnterX` float NOT NULL,
  `EnterY` float NOT NULL,
  `EnterZ` float NOT NULL,
  `EnterA` float NOT NULL,
  `EnterInterior` int(11) NOT NULL DEFAULT 0,
  `EnterWorld` int(11) NOT NULL DEFAULT 0,
  `ExitX` float NOT NULL,
  `ExitY` float NOT NULL,
  `ExitZ` float NOT NULL,
  `ExitA` float NOT NULL,
  `ExitInterior` int(11) NOT NULL DEFAULT 0,
  `ExitWorld` int(11) NOT NULL DEFAULT 0,
  `GarageFaction` int(11) NOT NULL DEFAULT 0,
  `GarageLocked` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=latin5;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `garbages`
--

CREATE TABLE `garbages` (
  `id` int(11) NOT NULL,
  `GarbageType` tinyint(1) NOT NULL,
  `GarbageTakenCapacity` smallint(5) NOT NULL DEFAULT 0,
  `GarbageCapacity` smallint(5) NOT NULL DEFAULT 20,
  `GarbageX` float NOT NULL,
  `GarbageY` float NOT NULL,
  `GarbageZ` float NOT NULL,
  `GarbageInterior` int(11) NOT NULL DEFAULT 0,
  `GarbageWorld` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin5;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `gates`
--

CREATE TABLE `gates` (
  `id` int(11) NOT NULL,
  `GateModel` int(11) NOT NULL,
  `GateSpeed` float NOT NULL,
  `GateRadius` float NOT NULL,
  `GateTime` int(11) NOT NULL,
  `PosX` float NOT NULL,
  `PosY` float NOT NULL,
  `PosZ` float NOT NULL,
  `RotX` float NOT NULL,
  `RotY` float NOT NULL,
  `RotZ` float NOT NULL,
  `GateInterior` int(11) NOT NULL,
  `GateWorld` int(11) NOT NULL,
  `OpenX` float NOT NULL,
  `OpenY` float NOT NULL,
  `OpenZ` float NOT NULL,
  `OpenRotX` float NOT NULL,
  `OpenRotY` float NOT NULL,
  `OpenRotZ` float NOT NULL,
  `GateFaction` int(11) NOT NULL,
  `GateLinkID` int(11) NOT NULL,
  `TIndex` int(11) NOT NULL DEFAULT 0,
  `TModel` int(11) NOT NULL DEFAULT 0,
  `TXDName` varchar(33) NOT NULL,
  `TextureName` varchar(33) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin5;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `impoundlots`
--

CREATE TABLE `impoundlots` (
  `impoundID` int(12) NOT NULL,
  `impoundLotX` float DEFAULT 0,
  `impoundLotY` float DEFAULT 0,
  `impoundLotZ` float DEFAULT 0,
  `impoundReleaseX` float DEFAULT 0,
  `impoundReleaseY` float DEFAULT 0,
  `impoundReleaseZ` float DEFAULT 0,
  `impoundReleaseInt` int(12) DEFAULT 0,
  `impoundReleaseWorld` int(12) DEFAULT 0,
  `impoundReleaseA` float DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `log_ajail`
--

CREATE TABLE `log_ajail` (
  `id` int(11) NOT NULL,
  `Name` varchar(40) NOT NULL,
  `Reason` varchar(128) NOT NULL,
  `JailedBy` varchar(40) NOT NULL,
  `Date` varchar(128) NOT NULL,
  `Time` int(11) NOT NULL,
  `IP` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `log_anotes`
--

CREATE TABLE `log_anotes` (
  `id` int(11) NOT NULL,
  `Name` varchar(40) NOT NULL,
  `Reason` varchar(256) NOT NULL,
  `Date` varchar(128) NOT NULL,
  `IP` varchar(40) NOT NULL,
  `AddedBy` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `log_kicks`
--

CREATE TABLE `log_kicks` (
  `id` int(11) NOT NULL,
  `Name` varchar(40) NOT NULL,
  `KickedBy` varchar(40) NOT NULL,
  `Reason` varchar(128) NOT NULL,
  `Date` int(11) NOT NULL,
  `IP` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `models`
--

CREATE TABLE `models` (
  `id` int(11) NOT NULL,
  `base_id` int(11) NOT NULL,
  `model_id` int(11) NOT NULL,
  `model_name` varchar(32) NOT NULL,
  `model_gender` tinyint(1) NOT NULL DEFAULT 1,
  `model_race` tinyint(3) NOT NULL,
  `model_category` tinyint(3) NOT NULL,
  `owner_dbid` int(11) NOT NULL DEFAULT 0,
  `credits` varchar(24) NOT NULL,
  `is_enabled` tinyint(1) NOT NULL DEFAULT 1,
  `created_by` int(11) NOT NULL,
  `created_at` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin5;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `objects`
--

CREATE TABLE `objects` (
  `id` int(11) NOT NULL,
  `ObjectModel` int(11) NOT NULL,
  `ObjectX` float NOT NULL,
  `ObjectY` float NOT NULL,
  `ObjectZ` float NOT NULL,
  `ObjectRX` float NOT NULL,
  `ObjectRY` float NOT NULL,
  `ObjectRZ` float NOT NULL,
  `ObjectInterior` int(11) NOT NULL DEFAULT 0,
  `ObjectWorld` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin5;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `paynsprays`
--

CREATE TABLE `paynsprays` (
  `id` int(11) NOT NULL,
  `PnsName` varchar(45) NOT NULL,
  `PnsPrice` smallint(5) NOT NULL DEFAULT 0,
  `PnsEarnings` int(11) NOT NULL DEFAULT 0,
  `EnterX` float NOT NULL,
  `EnterY` float NOT NULL,
  `EnterZ` float NOT NULL,
  `EnterA` float NOT NULL,
  `EnterInterior` int(11) NOT NULL DEFAULT 0,
  `EnterWorld` int(11) NOT NULL DEFAULT 0,
  `RepairX` float NOT NULL,
  `RepairY` float NOT NULL,
  `RepairZ` float NOT NULL,
  `RepairA` float NOT NULL,
  `RepairInterior` int(11) NOT NULL DEFAULT 0,
  `RepairWorld` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin5;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `players`
--

CREATE TABLE `players` (
  `id` int(11) NOT NULL,
  `accountid` int(11) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `Name` varchar(24) NOT NULL,
  `AdminLevel` smallint(4) NOT NULL DEFAULT 0,
  `AdminHide` tinyint(1) NOT NULL DEFAULT 0,
  `AdminName` varchar(24) NOT NULL DEFAULT 'Ayarlanmamış',
  `TesterLevel` tinyint(1) NOT NULL DEFAULT 0,
  `TesterName` varchar(24) NOT NULL DEFAULT 'Ayarlanmamış',
  `Exp` int(11) NOT NULL DEFAULT 0,
  `Level` int(11) NOT NULL DEFAULT 1,
  `Money` int(11) NOT NULL DEFAULT 5000,
  `Bank` int(11) NOT NULL DEFAULT 0,
  `Paycheck` int(11) NOT NULL DEFAULT 500,
  `Savings` int(11) NOT NULL DEFAULT 0,
  `UpgradePoints` int(11) NOT NULL DEFAULT 0,
  `Gender` tinyint(1) NOT NULL DEFAULT 1,
  `Birthdate` smallint(4) NOT NULL DEFAULT 1998,
  `Birthplace` varchar(35) NOT NULL DEFAULT 'Ayarlanmamış',
  `Attributes` varchar(128) NOT NULL DEFAULT 'Ayarlanmamış',
  `SecurityNumber` int(11) NOT NULL DEFAULT 0,
  `LastX` float NOT NULL DEFAULT 1642.37,
  `LastY` float NOT NULL DEFAULT -2334.47,
  `LastZ` float NOT NULL DEFAULT -2.6797,
  `LastRot` float NOT NULL DEFAULT 358.076,
  `Interior` int(11) NOT NULL DEFAULT 0,
  `World` int(11) NOT NULL DEFAULT 0,
  `MaxHealth` tinyint(3) NOT NULL DEFAULT 100,
  `LastHealth` float NOT NULL DEFAULT 100,
  `LastArmor` float NOT NULL DEFAULT 0,
  `Skin` int(11) NOT NULL DEFAULT 264,
  `DutySkin` int(11) NOT NULL DEFAULT 0,
  `DonatorLevel` tinyint(1) NOT NULL DEFAULT 0,
  `DonateTime` int(12) NOT NULL,
  `Rep` smallint(5) NOT NULL DEFAULT 0,
  `FirstLogin` tinyint(1) NOT NULL DEFAULT 1,
  `OnlineTime` int(12) NOT NULL DEFAULT 0,
  `RegTime` int(12) NOT NULL,
  `LastTime` int(12) NOT NULL,
  `LastTimeLength` int(12) NOT NULL,
  `RegisterIP` varchar(16) NOT NULL,
  `LastIP` varchar(16) NOT NULL,
  `PlayTime` int(12) NOT NULL DEFAULT 0,
  `CrashTime` int(12) NOT NULL DEFAULT 0,
  `Crashed` tinyint(1) NOT NULL DEFAULT 0,
  `HWID` varchar(60) NOT NULL,
  `CarKey` int(11) NOT NULL DEFAULT 0,
  `HasCarSpawned` int(11) NOT NULL DEFAULT 0,
  `HasCarSpawnedID` int(11) NOT NULL DEFAULT 0,
  `DriversLicense` tinyint(1) NOT NULL DEFAULT 0,
  `WeaponsLicense` tinyint(1) NOT NULL DEFAULT 0,
  `MedicalLicense` tinyint(1) NOT NULL DEFAULT 0,
  `Faction` int(11) NOT NULL DEFAULT -1,
  `FactionRank` int(11) NOT NULL DEFAULT 0,
  `Badge` int(11) NOT NULL DEFAULT 0,
  `Job` tinyint(1) NOT NULL DEFAULT 0,
  `JobTime` int(12) NOT NULL DEFAULT 0,
  `JobLevel` tinyint(3) NOT NULL DEFAULT 0,
  `SideJob` tinyint(1) NOT NULL DEFAULT 0,
  `SideJobTime` int(12) NOT NULL DEFAULT 0,
  `SideJobLevel` tinyint(3) NOT NULL DEFAULT 0,
  `ICJailed` int(11) NOT NULL DEFAULT 0,
  `ICJailTime` int(11) NOT NULL DEFAULT 0,
  `PrisonTimes` int(11) NOT NULL DEFAULT 0,
  `ActiveListing` int(11) NOT NULL DEFAULT 0,
  `OfflineAjail` int(12) NOT NULL DEFAULT 0,
  `OfflineAjailReason` varchar(128) NOT NULL DEFAULT 'Ayarlanmamış',
  `AdminJailed` int(11) NOT NULL DEFAULT 0,
  `AdminJailTime` int(11) NOT NULL DEFAULT 0,
  `JailTimes` int(11) NOT NULL DEFAULT 0,
  `AdminMessage` varchar(128) NOT NULL,
  `AdminMessageBy` int(11) NOT NULL DEFAULT 0,
  `AdmMessageConfirm` int(11) NOT NULL DEFAULT 0,
  `BrutallyWounded` int(11) NOT NULL DEFAULT 0,
  `Chatstyle` tinyint(3) NOT NULL DEFAULT 0,
  `Walkstyle` tinyint(3) NOT NULL DEFAULT 0,
  `Fightstyle` tinyint(3) NOT NULL DEFAULT 0,
  `Hudstyle` tinyint(3) NOT NULL DEFAULT 0,
  `Streetstyle` tinyint(1) NOT NULL DEFAULT 0,
  `ChatStatus` tinyint(1) NOT NULL DEFAULT 1,
  `HudStatus` tinyint(1) NOT NULL DEFAULT 1,
  `StreetStatus` tinyint(1) NOT NULL DEFAULT 1,
  `PMStatus` tinyint(1) NOT NULL DEFAULT 1,
  `OOCStatus` tinyint(1) NOT NULL DEFAULT 1,
  `FactionStatus` tinyint(1) NOT NULL DEFAULT 1,
  `NewsStatus` tinyint(1) NOT NULL DEFAULT 1,
  `InsideComplex` int(11) NOT NULL DEFAULT -1,
  `InsideHouse` int(11) NOT NULL DEFAULT -1,
  `InsideApartment` int(11) NOT NULL DEFAULT -1,
  `InsideBusiness` int(11) NOT NULL DEFAULT -1,
  `InsideGarage` int(11) NOT NULL DEFAULT -1,
  `InsideEntrance` int(11) NOT NULL DEFAULT -1,
  `HasMask` tinyint(1) NOT NULL DEFAULT 0,
  `HasRadio` tinyint(1) NOT NULL DEFAULT 0,
  `HasBurnerPhone` tinyint(1) NOT NULL DEFAULT 0,
  `MaskID` int(11) NOT NULL,
  `MaskIDEx` int(11) NOT NULL,
  `OwnedCar1` int(11) NOT NULL DEFAULT 0,
  `OwnedCar2` int(11) NOT NULL DEFAULT 0,
  `OwnedCar3` int(11) NOT NULL DEFAULT 0,
  `OwnedCar4` int(11) NOT NULL DEFAULT 0,
  `OwnedCar5` int(11) NOT NULL DEFAULT 0,
  `OwnedCar6` int(11) NOT NULL DEFAULT 0,
  `OwnedCar7` int(11) NOT NULL DEFAULT 0,
  `OwnedCar8` int(11) NOT NULL DEFAULT 0,
  `OwnedCar9` int(11) NOT NULL DEFAULT 0,
  `OwnedCar10` int(11) NOT NULL DEFAULT 0,
  `MainSlot` tinyint(2) NOT NULL DEFAULT 1,
  `Radio1` int(11) NOT NULL DEFAULT 0,
  `Radio2` int(11) NOT NULL DEFAULT 0,
  `Radio3` int(11) NOT NULL DEFAULT 0,
  `Radio4` int(11) NOT NULL DEFAULT 0,
  `Radio5` int(11) NOT NULL DEFAULT 0,
  `Radio6` int(11) NOT NULL DEFAULT 0,
  `Radio7` int(11) NOT NULL DEFAULT 0,
  `Radio8` int(11) NOT NULL DEFAULT 0,
  `Slot1` int(11) NOT NULL DEFAULT 0,
  `Slot2` int(11) NOT NULL DEFAULT 0,
  `Slot3` int(11) NOT NULL DEFAULT 0,
  `Slot4` int(11) NOT NULL DEFAULT 0,
  `Slot5` int(11) NOT NULL DEFAULT 0,
  `Slot6` int(11) NOT NULL DEFAULT 0,
  `Slot7` int(11) NOT NULL DEFAULT 0,
  `Slot8` int(11) NOT NULL DEFAULT 0,
  `Weapons0` smallint(3) NOT NULL DEFAULT 0,
  `WeaponsAmmo0` smallint(3) NOT NULL DEFAULT 0,
  `Weapons1` smallint(3) NOT NULL DEFAULT 0,
  `WeaponsAmmo1` smallint(3) NOT NULL DEFAULT 0,
  `Weapons2` smallint(3) NOT NULL DEFAULT 0,
  `WeaponsAmmo2` smallint(3) NOT NULL DEFAULT 0,
  `Weapons3` smallint(3) NOT NULL DEFAULT 0,
  `WeaponsAmmo3` smallint(3) NOT NULL DEFAULT 0,
  `PhoneNumber` int(11) NOT NULL DEFAULT 0,
  `BurnerPhoneNumber` int(11) NOT NULL DEFAULT 0,
  `PhoneOff` tinyint(1) NOT NULL DEFAULT 0,
  `PhoneType` tinyint(11) NOT NULL DEFAULT 0,
  `PhoneSilent` tinyint(1) NOT NULL DEFAULT 0,
  `PhoneRingtone` smallint(5) NOT NULL DEFAULT 20600,
  `Renting` int(11) NOT NULL DEFAULT -1,
  `WorkOn` smallint(5) NOT NULL DEFAULT -1,
  `SpawnSelect` int(11) NOT NULL DEFAULT 0,
  `SpawnHouse` int(11) NOT NULL DEFAULT 0,
  `SpawnPrecinct` int(11) NOT NULL DEFAULT 0,
  `pCopDuty` tinyint(1) NOT NULL DEFAULT 0,
  `pSWATDuty` tinyint(1) NOT NULL DEFAULT 0,
  `Components` int(11) NOT NULL DEFAULT 0,
  `Cigarettes` int(11) NOT NULL DEFAULT 0,
  `Drinks` int(11) NOT NULL DEFAULT 0,
  `Fishes` smallint(5) NOT NULL DEFAULT 0,
  `AccountStatus` int(11) NOT NULL,
  `Donator` int(11) NOT NULL DEFAULT 0,
  `IsLogged` int(11) NOT NULL,
  `Boombox` int(11) NOT NULL,
  `banreason` varchar(255) NOT NULL,
  `banAdmin` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin5 ROW_FORMAT=COMPRESSED;

--
-- Tablo döküm verisi `players`
--

INSERT INTO `players` (`id`, `accountid`, `status`, `Name`, `AdminLevel`, `AdminHide`, `AdminName`, `TesterLevel`, `TesterName`, `Exp`, `Level`, `Money`, `Bank`, `Paycheck`, `Savings`, `UpgradePoints`, `Gender`, `Birthdate`, `Birthplace`, `Attributes`, `SecurityNumber`, `LastX`, `LastY`, `LastZ`, `LastRot`, `Interior`, `World`, `MaxHealth`, `LastHealth`, `LastArmor`, `Skin`, `DutySkin`, `DonatorLevel`, `DonateTime`, `Rep`, `FirstLogin`, `OnlineTime`, `RegTime`, `LastTime`, `LastTimeLength`, `RegisterIP`, `LastIP`, `PlayTime`, `CrashTime`, `Crashed`, `HWID`, `CarKey`, `HasCarSpawned`, `HasCarSpawnedID`, `DriversLicense`, `WeaponsLicense`, `MedicalLicense`, `Faction`, `FactionRank`, `Badge`, `Job`, `JobTime`, `JobLevel`, `SideJob`, `SideJobTime`, `SideJobLevel`, `ICJailed`, `ICJailTime`, `PrisonTimes`, `ActiveListing`, `OfflineAjail`, `OfflineAjailReason`, `AdminJailed`, `AdminJailTime`, `JailTimes`, `AdminMessage`, `AdminMessageBy`, `AdmMessageConfirm`, `BrutallyWounded`, `Chatstyle`, `Walkstyle`, `Fightstyle`, `Hudstyle`, `Streetstyle`, `ChatStatus`, `HudStatus`, `StreetStatus`, `PMStatus`, `OOCStatus`, `FactionStatus`, `NewsStatus`, `InsideComplex`, `InsideHouse`, `InsideApartment`, `InsideBusiness`, `InsideGarage`, `InsideEntrance`, `HasMask`, `HasRadio`, `HasBurnerPhone`, `MaskID`, `MaskIDEx`, `OwnedCar1`, `OwnedCar2`, `OwnedCar3`, `OwnedCar4`, `OwnedCar5`, `OwnedCar6`, `OwnedCar7`, `OwnedCar8`, `OwnedCar9`, `OwnedCar10`, `MainSlot`, `Radio1`, `Radio2`, `Radio3`, `Radio4`, `Radio5`, `Radio6`, `Radio7`, `Radio8`, `Slot1`, `Slot2`, `Slot3`, `Slot4`, `Slot5`, `Slot6`, `Slot7`, `Slot8`, `Weapons0`, `WeaponsAmmo0`, `Weapons1`, `WeaponsAmmo1`, `Weapons2`, `WeaponsAmmo2`, `Weapons3`, `WeaponsAmmo3`, `PhoneNumber`, `BurnerPhoneNumber`, `PhoneOff`, `PhoneType`, `PhoneSilent`, `PhoneRingtone`, `Renting`, `WorkOn`, `SpawnSelect`, `SpawnHouse`, `SpawnPrecinct`, `pCopDuty`, `pSWATDuty`, `Components`, `Cigarettes`, `Drinks`, `Fishes`, `AccountStatus`, `Donator`, `IsLogged`, `Boombox`, `banreason`, `banAdmin`) VALUES
(1, 1, 0, 'Sawyer_Ford', 6, 0, 'Ayarlanmamış', 0, 'Ayarlanmamış', 0, 1, 500000, 0, 500, 0, 0, 0, 1998, 'Ayarlanmamış', 'Ayarlanmamış', 323283, 1188.7, -1350.58, 13.5687, 265.301, 0, 0, 127, 100, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1642638639, 57, '127.0.0.1', '127.0.0.1', 1918, 0, 0, '9DCEF4F8450C8E59C04EE888D8CC00ACE9989880', 0, 0, 0, 0, 0, 0, -1, 0, 38771, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Ayarlanmamış', 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, -1, -1, -1, -1, -1, -1, 0, 0, 0, 367766, 64, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8615968, 40961, 0, 0, 0, 20600, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, '', '');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `player_anotes`
--

CREATE TABLE `player_anotes` (
  `id` int(11) NOT NULL,
  `player_dbid` int(11) NOT NULL,
  `anote_reason` varchar(128) NOT NULL,
  `anote_issuer` varchar(60) NOT NULL,
  `anote_date` int(11) NOT NULL,
  `anote_active` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `player_clothing`
--

CREATE TABLE `player_clothing` (
  `id` int(11) NOT NULL,
  `player_dbid` int(11) NOT NULL,
  `clothing_name` varchar(20) NOT NULL,
  `slot_id` tinyint(1) NOT NULL DEFAULT 0,
  `model_id` int(11) NOT NULL,
  `bone_id` tinyint(2) NOT NULL,
  `pos_x` float NOT NULL,
  `pos_y` float NOT NULL,
  `pos_z` float NOT NULL,
  `rot_x` float NOT NULL,
  `rot_y` float NOT NULL,
  `rot_z` float NOT NULL,
  `scale_x` float NOT NULL,
  `scale_y` float NOT NULL,
  `scale_z` float NOT NULL,
  `auto_wear` tinyint(1) NOT NULL DEFAULT 0,
  `color1` int(11) NOT NULL,
  `color2` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin5;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `player_contacts`
--

CREATE TABLE `player_contacts` (
  `id` int(11) NOT NULL,
  `playersqlid` int(11) NOT NULL,
  `contactid` int(11) NOT NULL,
  `contact_name` varchar(128) NOT NULL,
  `contact_num` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `player_drugs`
--

CREATE TABLE `player_drugs` (
  `id` int(11) NOT NULL,
  `player_dbid` int(11) NOT NULL,
  `drug_name` varchar(64) NOT NULL,
  `drug_type` tinyint(2) NOT NULL,
  `drug_amount` float NOT NULL DEFAULT 0,
  `drug_quality` tinyint(3) NOT NULL DEFAULT 100,
  `drug_size` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=latin5;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `player_fines`
--

CREATE TABLE `player_fines` (
  `id` int(11) NOT NULL,
  `player_dbid` int(11) NOT NULL,
  `issuer_name` varchar(24) NOT NULL,
  `fine_amount` int(11) NOT NULL,
  `fine_faction` smallint(5) NOT NULL DEFAULT 0,
  `fine_reason` varchar(128) NOT NULL,
  `fine_date` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin5;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `player_logs`
--

CREATE TABLE `player_logs` (
  `log_id` int(11) NOT NULL,
  `player_dbid` int(11) NOT NULL,
  `log_detail` varchar(256) NOT NULL,
  `time` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin5;

--
-- Tablo döküm verisi `player_logs`
--

INSERT INTO `player_logs` (`log_id`, `player_dbid`, `log_detail`, `time`) VALUES
(1, 1, 'Oyundan çıkış yaptı. (/q)', 1642635982),
(2, 1, 'Oyundan çıkış yaptı. (/q)', 1642636120),
(3, 1, 'Oyundan çıkış yaptı. (/q)', 1642636243),
(4, 1, 'Oyundan çıkış yaptı. (/q)', 1642636379),
(5, 1, 'Sawyer_Ford yazdı: abilgi', 1642637121),
(6, 1, 'Oyundan çıkış yaptı. (/q)', 1642638639);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `player_notes`
--

CREATE TABLE `player_notes` (
  `id` int(11) NOT NULL,
  `playersqlid` int(11) NOT NULL,
  `details` varchar(128) NOT NULL,
  `time` int(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin5;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `player_packages`
--

CREATE TABLE `player_packages` (
  `id` int(11) NOT NULL,
  `player_dbid` int(11) NOT NULL DEFAULT 0,
  `weaponid` tinyint(2) NOT NULL DEFAULT 24,
  `ammo` smallint(5) NOT NULL DEFAULT 500
) ENGINE=InnoDB DEFAULT CHARSET=latin5;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `properties`
--

CREATE TABLE `properties` (
  `id` int(11) NOT NULL,
  `OwnerSQL` int(11) NOT NULL DEFAULT 0,
  `Type` int(11) NOT NULL,
  `ComplexID` int(11) NOT NULL,
  `Faction` int(11) NOT NULL DEFAULT -1,
  `Level` int(11) NOT NULL DEFAULT 1,
  `Money` int(11) NOT NULL DEFAULT 0,
  `ExteriorX` float NOT NULL,
  `ExteriorY` float NOT NULL,
  `ExteriorZ` float NOT NULL,
  `ExteriorA` float NOT NULL,
  `ExteriorID` int(11) NOT NULL,
  `ExteriorWorld` int(11) NOT NULL,
  `InteriorX` float NOT NULL,
  `InteriorY` float NOT NULL,
  `InteriorZ` float NOT NULL,
  `InteriorA` float NOT NULL,
  `InteriorID` int(11) NOT NULL,
  `InteriorWorld` int(11) NOT NULL,
  `CheckPosX` float NOT NULL,
  `CheckPosY` float NOT NULL,
  `CheckPosZ` float NOT NULL,
  `CheckID` int(11) NOT NULL,
  `CheckWorld` int(11) NOT NULL,
  `MarketPrice` int(11) NOT NULL DEFAULT 15000,
  `RentPrice` int(11) NOT NULL DEFAULT 1,
  `Rentable` tinyint(1) NOT NULL DEFAULT 0,
  `Locked` tinyint(1) NOT NULL DEFAULT 0,
  `HasXMR` int(1) NOT NULL DEFAULT 0,
  `BareSwitch` int(11) NOT NULL DEFAULT -1,
  `BareType` tinyint(1) NOT NULL DEFAULT 0,
  `Time` tinyint(2) NOT NULL DEFAULT 12,
  `Lights` tinyint(1) NOT NULL DEFAULT 1,
  `XMRPosX` float NOT NULL,
  `XMRPosY` float NOT NULL,
  `XMRPosZ` float NOT NULL,
  `XMRRotX` float NOT NULL,
  `XMRRotY` float NOT NULL,
  `XMRRotZ` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin5;

--
-- Tablo döküm verisi `properties`
--

INSERT INTO `properties` (`id`, `OwnerSQL`, `Type`, `ComplexID`, `Faction`, `Level`, `Money`, `ExteriorX`, `ExteriorY`, `ExteriorZ`, `ExteriorA`, `ExteriorID`, `ExteriorWorld`, `InteriorX`, `InteriorY`, `InteriorZ`, `InteriorA`, `InteriorID`, `InteriorWorld`, `CheckPosX`, `CheckPosY`, `CheckPosZ`, `CheckID`, `CheckWorld`, `MarketPrice`, `RentPrice`, `Rentable`, `Locked`, `HasXMR`, `BareSwitch`, `BareType`, `Time`, `Lights`, `XMRPosX`, `XMRPosY`, `XMRPosZ`, `XMRRotX`, `XMRRotY`, `XMRRotZ`) VALUES
(1, 0, 3, 0, -1, 5, 0, 1340.7, -1416.63, 13.3828, 343.153, 0, 0, 1340.86, -1416.77, 13.3828, 323.631, 0, 52185, 0, 0, 0, 0, 0, 50000, 20, 0, 1, 0, -1, 0, 12, 0, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `property_drugs`
--

CREATE TABLE `property_drugs` (
  `id` int(11) NOT NULL,
  `drug_name` varchar(64) NOT NULL,
  `drug_type` tinyint(2) NOT NULL,
  `drug_amount` float NOT NULL DEFAULT 0,
  `drug_quality` tinyint(3) NOT NULL DEFAULT 100,
  `drug_size` tinyint(1) NOT NULL DEFAULT 1,
  `property_id` int(11) NOT NULL DEFAULT -1,
  `placed_by` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin5;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `property_weapons`
--

CREATE TABLE `property_weapons` (
  `id` int(11) NOT NULL,
  `weapon` tinyint(2) NOT NULL,
  `ammo` smallint(5) NOT NULL,
  `property_id` int(11) NOT NULL,
  `placed_by` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `questions`
--

CREATE TABLE `questions` (
  `id` int(11) NOT NULL,
  `question` varchar(256) NOT NULL,
  `answer_1` varchar(256) NOT NULL,
  `answer_2` varchar(256) NOT NULL,
  `answer_3` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin5;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `sprays`
--

CREATE TABLE `sprays` (
  `id` int(11) NOT NULL,
  `SprayModel` int(11) DEFAULT NULL,
  `SprayX` float DEFAULT NULL,
  `SprayY` float DEFAULT NULL,
  `SprayZ` float DEFAULT NULL,
  `SprayRX` float DEFAULT NULL,
  `SprayRY` float DEFAULT NULL,
  `SprayRZ` float DEFAULT NULL,
  `SprayInterior` int(11) NOT NULL DEFAULT 0,
  `SprayWorld` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin5 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `staff`
--

CREATE TABLE `staff` (
  `id` int(11) NOT NULL,
  `name` varchar(32) DEFAULT NULL,
  `forumlink` varchar(129) DEFAULT NULL,
  `adminlevel` int(11) NOT NULL DEFAULT 1,
  `yetki` varchar(255) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin5;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `streets`
--

CREATE TABLE `streets` (
  `id` int(11) NOT NULL,
  `StreetName` varchar(35) NOT NULL,
  `MaxPoints` int(11) NOT NULL,
  `StreetX` float NOT NULL,
  `StreetY` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin5;

--
-- Tablo döküm verisi `streets`
--

INSERT INTO `streets` (`id`, `StreetName`, `MaxPoints`, `StreetX`, `StreetY`) VALUES
(1, '106th Street', 18, 2081, -1670),
(2, '107th Street', 16, 2004, -1705),
(3, 'Prairie Avenue', 8, 2042, -1673),
(4, 'Winona Avenue', 34, 2112, -1755),
(5, 'Gilmore Avenue', 32, 2082, -1801),
(6, 'Unity Boulevard', 38, 1927, -1932),
(7, 'Willowfield Avenue', 12, 2219, -1871),
(8, 'Martin Luther King Drive', 24, 1942, -1694),
(9, 'Altura Street', 16, 1754, -1822),
(10, 'Artesia Avenue', 44, 1852, -1408),
(11, 'Arbor Vitae Street', 18, 1905, -1612),
(12, 'Cypress Avenue', 10, 1750, -1667),
(13, 'Lucas Avenue', 12, 1690, -1761),
(14, 'Dalerose Street', 14, 2040, -1812),
(15, 'Cesar Avenue', 16, 1389, -1800),
(16, 'Chavez Avenue', 8, 1570, -1773),
(17, '28th Street', 12, 1774, -2110),
(18, 'Kings Avenue', 24, 1822, -2059),
(19, '38th Street', 20, 1863, -2051),
(20, 'Newport Boulevard', 60, -1408, 16),
(21, 'Newport Boulevard', 60, 1895, -2166),
(22, 'Toledo Street', 28, 2042, -2110),
(23, 'Arbutus Street', 8, 2477, -2010),
(24, 'Sampson Street', 12, 2590, -1932),
(25, 'Elbert Street', 22, 2314, -1970),
(26, 'Willowfield Avenue', 14, -1408, 16),
(27, 'San Pedro Avenue', 30, 2640, -1719),
(28, 'Acacia Street', 8, 2678, -2003),
(29, 'Melrose Avenue', 32, 2714, -2011),
(30, 'Memphis Street', 12, 2749, -1995),
(31, 'Loma Avenue', 8, 2770, -1956),
(32, 'Vermont Street', 12, 2731, -1660),
(33, 'Cherry Road', 24, 2797, -1345),
(34, 'Santa Ana Street', 20, 2108, -989),
(35, 'Coronado Street', 20, 2192, -1066),
(36, 'Las Colinas Boulevard', 40, 2101, -1064),
(37, 'Saints Boulevard', 70, 2730, -1429),
(38, 'Shaw Avenue', 18, 2677, -1449),
(39, 'Laricina Avenue', 30, 1715, -1263),
(40, 'Degnan Street', 22, 1965, -1261),
(41, 'Ramona Avenue', 26, 1969, -1136),
(42, 'Lowden Avenue', 10, 1976, -1097),
(43, 'Lowden Avenue', 10, 1970, -1192),
(44, 'Rosemont Avenue', 18, 2069, -1242),
(45, 'Exton Street', 14, 2131, -1221),
(46, 'Lorraine Avenue', 8, 2271, -1265),
(47, 'Florence Avenue', 18, 2175, -1178),
(48, 'Victoria Street', 16, 1950, -1340),
(49, 'Boyd Street', 8, 1987, -1413),
(50, 'Marlton Street', 18, 1942, -1463),
(51, 'Evadonna Street', 18, 1561, -1301),
(52, 'Station Avenue', 12, 1529, -1674),
(53, 'Central Street', 22, 1521, -1592),
(54, 'Crenshaw Avenue', 18, 2110, -1429),
(55, 'Vinewood Boulevard', 64, 1113, -1145),
(56, 'Alta Avenue', 28, 962, -1068),
(57, 'Monterey Avenue', 8, 1263, -975),
(58, 'Leona Avenue', 8, 1084, -1009),
(59, 'Saint Nicholas Avenue', 16, 1163, -1084),
(60, 'Temple Drive', 52, 1204, -1039),
(61, 'Medina Avenue', 16, 1201, -1324),
(62, 'Hopkins Avenue', 8, 1257, -1345),
(63, 'Serenity Avenue', 30, 1216, -1236),
(64, 'Redmont Street', 30, 1182, -1281),
(65, 'Normandie Avenue', 28, 1058, -1288),
(66, 'Glazier Street', 12, 995, -1221),
(67, 'Idaho Avenue', 10, 942, -1218),
(68, 'Galloway Street', 28, 951, -1324),
(69, 'Waterford Street', 14, 755, -1318),
(70, 'Blanco Way', 16, 884, -952),
(71, 'Verdant Hill', 60, 1338, -1918),
(72, 'Allison Avenue', 12, 1482, -1092),
(73, 'Violeta Street', 8, 1407, -1241),
(74, 'Sunset Avenue', 50, 1455, -1320),
(75, 'Main Street', 80, 1314, -1778),
(76, 'La Brea Avenue', 8, 752, -1646),
(77, 'Aurora Avenue', 12, 753, -1674),
(78, 'Dupont Street', 26, 756, -1583),
(79, 'Mildred Avenue', 20, 782, -1525),
(80, 'Lorena Street', 8, 989, -1490),
(81, 'Wilson Avenue', 32, 1057, -1492),
(82, 'Alamosa Avenue', 26, 918, -1502),
(83, 'Alamosa Avenue', 14, 918, -1661),
(84, 'Sotella Avenue', 8, 1173, -1787),
(85, 'Orinda Street', 36, 1168, -1712),
(86, 'Alameda Street', 14, 1102, -1572),
(87, 'Cordova Avenue', 18, 1150, -1644),
(88, 'Vicenza Road', 18, 310, -1209),
(89, 'Savona Road', 14, 426, -1214),
(90, 'Somera Road', 42, 370, -1260),
(91, 'Camino del Sol', 108, 682, -1050),
(92, 'De Neve Road', 10, 267, -1478),
(93, 'Calzada Street', 32, 440, -1657),
(94, 'Lafayette Street', 32, 385, -1587),
(95, 'Highland Avenue', 8, 523, -1395),
(96, 'Highland Avenue', 10, 535, -1524),
(97, 'Via Rodeo', 10, 486, -1502),
(98, 'Mulholland Drive', 146, 437, -1322),
(99, 'Rodeo Boulevard', 52, 630, -1347),
(100, 'Market Street', 42, 519, -1419),
(101, 'Market Street', 76, 770, -1404),
(102, 'Olympia Avenue', 18, 1196, -1497),
(103, 'Entrada Road', 12, 425, -1773),
(104, 'Santa Maria Pier', 14, 370, -1719),
(105, 'Santa Maria Boulevard', 44, 544, -1732),
(106, 'Imperial Avenue', 24, 1961, -2060),
(107, 'Washington Street', 8, 2128, -1301),
(108, 'Santa Rosalia Street', 28, 2184, -1382),
(109, 'Bronson Street', 12, 2288, -1484),
(110, 'Felton Avenue', 8, 2684, -1259),
(111, 'Felton Avenue', 20, 2404, -1258),
(112, 'Laurel Avenue', 8, 2571, -1379),
(113, 'Juniper Avenue', 16, 2512, -1329),
(114, '6th Street', 20, 2451, -1342),
(115, 'Burt Drive', 10, 2333, -1303),
(116, 'Franklin Avenue', 24, 2373, -1335),
(117, 'Firmona Street', 24, 2532, -1184),
(118, 'Claremont Street', 24, 2460, -1154),
(119, 'Ferndale Avenue', 12, 2306, -1333),
(120, 'Cedar Street', 20, 2352, -1387),
(121, 'Alexandria Avenue', 24, 2343, -1485),
(122, '54th Street', 18, 2480, -1506),
(123, 'Elm Street', 12, 2390, -1521),
(124, 'Graham Avenue', 18, 2429, -1492),
(125, 'Grove Street', 8, 2160, -1634),
(126, 'Grove Street', 18, 2328, -1659),
(127, 'Grove Street', 8, 2368, -1658),
(128, 'Clarissa Street', 26, 2410, -1089),
(129, 'Ambrose Street', 20, 2399, -1051),
(130, 'Sycamore Avenue', 8, 797, -1153),
(131, 'Princeton Street', 36, 2044, -1078),
(132, 'Brailsford Street', 10, 1867, -1095),
(133, 'Van Ness Avenue', 16, 1658, -1511),
(134, 'Gaviota Avenue', 18, 2818, -1488),
(135, 'Atlantic Avenue', 62, 2875, -1439),
(136, 'Washington Street', 14, 2211, -1301),
(137, 'Fountain Avenue', 28, 1496, -1161),
(138, 'Ganton Boulevard', 36, 2446, -1730),
(139, 'Alandele Avenue', 16, 2517, -1821),
(140, 'Clifton Avenue', 34, 2414, -1806),
(141, 'Lambert Street', 8, 2757, -2049),
(142, 'Palmwood Avenue', 36, 2215, -1449),
(143, 'Azalea Street', 62, 1465, -1872),
(144, 'Gordon Street', 18, 2278, -99),
(145, 'Deep Creek Avenue', 30, 2344, 44),
(146, 'Seymour Avenue', 12, 2394, 22),
(147, 'Halm Street', 16, 2366, -28),
(148, 'Farley Street', 12, 2492, -10),
(149, 'Crest Avenue', 12, 2534, 72),
(150, 'Cornelia Street', 12, 2548, 41),
(151, 'Rowe Avenue', 12, 2464, 5),
(152, 'Haldon Street', 16, 2482, 111),
(153, 'Baker Street', 12, 2249, 140),
(154, 'Harris Avenue', 20, 2293, 86),
(155, 'Warner Avenue', 12, 2224, 112),
(156, 'Lakewood Drive', 16, 2192, 42),
(157, 'Los Altos Avenue', 8, 2223, -54),
(158, 'Little John Road', 10, 1707, 121),
(159, 'Navarra Road', 8, 1881, -52),
(160, 'San Augustine Road', 12, 941, -520),
(161, 'Liona Street', 12, 803, -593),
(162, 'East Avenue', 8, 791, -555),
(163, 'Ash Avenue', 10, 831, -567),
(164, 'Morton Street', 16, 754, -530),
(165, 'Collins Avenue', 14, 722, -551),
(166, 'Cress Avenue', 14, 641, -575),
(167, 'Lea Way', 8, 650, -624),
(168, 'Locust Street', 18, 657, -485),
(169, 'Joy Avenue', 12, 602, -511),
(170, 'Middleton Road', 38, -266, -241),
(171, 'Harvey Street', 54, 147, -212),
(172, 'Fresa Street', 24, 211, -282),
(173, 'Lindberg Avenue', 12, 183, -164),
(174, 'Saint Christopher Street', 12, 177, -73),
(175, 'Chapel Hill Avenue', 30, 333, -111),
(176, 'Pine Grove Avenue', 26, 233, -145),
(177, 'Briarwick Avenue', 18, 133, -156),
(178, 'Sierra Road', 46, 204, 55),
(179, 'Point View Road', 12, 919, -758),
(180, 'Stradella Road', 12, 1352, -576),
(181, 'Casiano Road', 8, 371, -578),
(182, 'Morgana Road', 38, 442, -509),
(183, 'Lion Avenue', 14, -345, 1130),
(184, 'Ocala Street', 8, -317, 1148),
(185, 'Arf Lane', 8, -298, 1064),
(186, 'San Luis Avenue', 24, -276, 1078),
(187, 'Fuller Street', 14, -229, 1018),
(188, 'Wilderness Avenue', 58, -188, 1048),
(189, 'Celeste Street', 12, -220, 1098),
(190, 'Mirea Road', 8, 597, -419),
(191, 'Rattlesnake Road', 40, -272, -1968),
(192, 'Salamanca Avenue', 16, -2102, -2499),
(193, 'Madison Street', 12, -2173, -2504),
(194, 'Orleans Avenue', 14, -2220, -2432),
(195, 'Woodward Street', 8, -2093, -2274),
(196, 'Owens Street', 8, -2171, -2265),
(197, 'Royce Avenue', 16, -2131, -2464),
(198, 'Tulare Avenue', 16, -2098, -2319),
(199, 'Annadale Avenue', 40, -2117, -2376),
(200, 'La Mesa Avenue', 36, -2123, -2429),
(201, 'Lincoln Avenue', 34, -2173, -2300),
(202, 'Acomo Street', 16, -2179, -2349),
(203, 'Sylvana Road', 56, -2147, -2130),
(204, 'Ashlan Street', 12, 1394, 238),
(205, 'Twain Street', 8, 1350, 262),
(206, 'Alcosta Avenue', 14, 1352, 298),
(207, 'McKinley Avenue', 12, 1343, 225),
(208, 'Redstone Lane', 12, 1233, 247),
(209, 'Mariposa Lane', 18, 1283, 355),
(210, 'Eisenhower Avenue', 54, 1304, 283),
(211, 'Morin Road', 22, -181, 1243),
(212, 'Morin Road', 20, -1572, 2733),
(213, 'Ellery Road', 14, -1612, 2644),
(214, 'Euclid Road', 10, -286, -837),
(215, 'Stone Canyon Road', 8, 607, -736),
(216, 'Fremont Avenue', 16, 2316, -1944),
(217, 'Osuna Road', 62, -185, -940),
(218, 'Delaware Road', 8, -486, -273),
(219, 'Sandrun Road', 26, 192, 1071),
(220, 'Sundown Creek Street', 44, -163, 1198),
(221, 'Duval Lane', 16, -116, 1161),
(222, 'Pinewood Avenue', 28, -64, 1060),
(223, 'Argyle Road', 38, 306, 995),
(224, 'Tangerine Street', 16, -1451, 2603),
(225, 'Santa Rosa Avenue', 16, -1495, 2584),
(226, 'Silverwood Lane', 18, -1426, 2626),
(227, 'Costa Azul Drive', 14, -297, 1435),
(228, 'Arruza Street', 24, -774, 1577),
(229, 'Alaquina Street', 18, -810, 1557),
(230, 'Agosto Road', 12, -650, 1059),
(231, 'Encina Road', 8, -746, 986),
(232, 'Siempre Viva Road', 42, -351, 2507),
(233, 'Cerrissa Street', 10, -484, 2595),
(234, 'San Ysidro Freeway', 44, -854, 1024),
(235, 'Doran Street', 12, -349, 1737),
(236, 'East Beach Freeway', 110, 2914, -1335),
(237, 'World Way', 44, 1639, -2318),
(238, 'Los Santos Airport', 40, 1961, -2183),
(239, 'Carmona Street', 12, 2232, -2200),
(240, 'Terminal Way', 20, 2156, -2207),
(241, 'Shoreline Drive', 22, 2314, -2332),
(242, 'Maple Way', 28, 2368, -2384),
(243, 'Queens Way', 48, 2491, -2510),
(244, 'Las Venturas Freeway', 42, 668, 2205),
(245, 'Eliot Street', 8, -224, 2701),
(246, 'Chester Avenue', 22, -186, 2655),
(247, 'Theresa Street', 34, -2599, 2329),
(248, 'Zapata Street', 36, -2486, 2428),
(249, 'Plaza Drive', 18, -2613, 2326),
(250, 'Vereda Avenue', 16, -2467, 2358),
(251, 'Porton Avenue', 12, 708, 1835),
(252, 'Porton Avenue', 16, 713, 1891),
(253, 'Laredo Street', 8, 687, 1916),
(254, 'Faldale Street', 12, 725, 1852),
(255, 'Magnolia Avenue', 10, -1165, -1113),
(256, 'Walnut Lane', 16, 185, -40),
(257, 'Imperial Avenue', 8, 1962, -1827),
(258, 'Deadmans Road', 24, -18, 2071),
(259, 'Idlewood Highway', 54, 1786, -1499),
(260, 'Westmont Avenue', 30, 2271, -1890),
(261, 'Cardinal Avenue', 22, 279, -144),
(262, 'Pine Grove Avenue', 12, 233, -254),
(263, 'Hill Street', 30, 1477, -1731),
(264, 'Hill Street', 8, 1642, -1734),
(265, 'Pacific Coast Highway', 42, -151, -1465),
(266, 'Elsinore Road', 86, 1045, -620),
(267, 'Galicia Way', 10, 511, -1012),
(268, 'Ashworth Street', 12, 2261, 92),
(269, 'San Lucia Avenue', 40, 680, -726),
(270, 'Santa Clara Road', 12, 1158, -892),
(271, 'Cala Moreya Street', 42, 409, -1482),
(272, 'Salermo Avenue', 10, 448, -1560),
(273, 'Salermo Avenue', 8, 447, -1611),
(274, 'Los Santos Freeway', 140, 1635, -1179),
(275, 'Siena Avenue', 8, 918, -1365);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `street_pos`
--

CREATE TABLE `street_pos` (
  `id` int(11) NOT NULL,
  `StreetID` int(11) NOT NULL,
  `StreetX` float NOT NULL,
  `StreetY` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin5;

--
-- Tablo döküm verisi `street_pos`
--

INSERT INTO `street_pos` (`id`, `StreetID`, `StreetX`, `StreetY`) VALUES
(1, 1, 2042, -1622),
(2, 1, 2101, -1622),
(3, 1, 2101, -1682),
(4, 1, 2087, -1741),
(5, 1, 2042, -1743),
(6, 1, 2042, -1681),
(7, 1, 2074, -1681),
(8, 1, 2074, -1664),
(9, 1, 2042, -1664),
(10, 2, 2040, -1622),
(11, 2, 1993, -1622),
(12, 2, 1993, -1743),
(13, 2, 2041, -1742),
(14, 2, 2041, -1681),
(15, 2, 2006, -1681),
(16, 2, 2006, -1663),
(17, 2, 2040, -1663),
(18, 3, 2006, -1663),
(19, 3, 2006, -1681),
(20, 3, 2074, -1681),
(21, 3, 2074, -1663),
(22, 4, 1832, -1805),
(23, 4, 1951, -1832),
(24, 4, 1951, -1762),
(25, 4, 1970, -1762),
(26, 4, 1970, -1784),
(27, 4, 2072, -1784),
(28, 4, 2079, -1760),
(29, 4, 2128, -1760),
(30, 4, 2128, -1791),
(31, 4, 2138, -1835),
(32, 4, 2166, -1843),
(33, 4, 2195, -1843),
(34, 4, 2195, -1735),
(35, 4, 2174, -1723),
(36, 4, 2112, -1723),
(37, 4, 2106, -1742),
(38, 4, 1832, -1742),
(39, 5, 2073, -1861),
(40, 5, 1987, -1861),
(41, 5, 2024, -1896),
(42, 5, 2033, -1926),
(43, 5, 2074, -1926),
(44, 5, 2090, -1939),
(45, 5, 2090, -1831),
(46, 5, 2137, -1834),
(47, 5, 2127, -1787),
(48, 5, 2128, -1759),
(49, 5, 2080, -1758),
(50, 5, 2072, -1784),
(51, 5, 2072, -1819),
(52, 5, 2042, -1819),
(53, 5, 2042, -1841),
(54, 5, 2073, -1841),
(55, 6, 1699, -1821),
(56, 6, 1697, -1861),
(57, 6, 1673, -1881),
(58, 6, 1685, -1881),
(59, 6, 1685, -1950),
(60, 6, 2090, -1950),
(61, 6, 2089, -1936),
(62, 6, 2073, -1925),
(63, 6, 2032, -1926),
(64, 6, 2025, -1897),
(65, 6, 2011, -1913),
(66, 6, 1971, -1867),
(67, 6, 1973, -1926),
(68, 6, 1952, -1926),
(69, 6, 1952, -1853),
(70, 6, 1829, -1823),
(71, 6, 1812, -1843),
(72, 6, 1789, -1843),
(73, 6, 1718, -1821),
(74, 7, 2217, -1656),
(75, 7, 2206, -1700),
(76, 7, 2206, -1888),
(77, 7, 2228, -1888),
(78, 7, 2228, -1694),
(79, 7, 2236, -1660),
(80, 8, 1932, -1623),
(81, 8, 1947, -1607),
(82, 8, 1934, -1598),
(83, 8, 1934, -1524),
(84, 8, 2002, -1531),
(85, 8, 2023, -1545),
(86, 8, 2033, -1573),
(87, 8, 2033, -1600),
(88, 8, 2006, -1602),
(89, 8, 1993, -1620),
(90, 8, 1993, -1740),
(91, 8, 1932, -1740),
(92, 9, 1698, -1821),
(93, 9, 1720, -1821),
(94, 9, 1787, -1842),
(95, 9, 1811, -1842),
(96, 9, 1811, -1809),
(97, 9, 1742, -1809),
(98, 9, 1742, -1795),
(99, 9, 1697, -1795),
(100, 10, 1860, -1494),
(101, 10, 1861, -1191),
(102, 10, 1838, -1191),
(103, 10, 1838, -1315),
(104, 10, 1725, -1315),
(105, 10, 1725, -1431),
(106, 10, 1746, -1431),
(107, 10, 1818, -1451),
(108, 10, 1839, -1451),
(109, 10, 1839, -1496),
(110, 10, 1827, -1526),
(111, 10, 1747, -1529),
(112, 10, 1747, -1593),
(113, 10, 1787, -1604),
(114, 10, 1810, -1604),
(115, 10, 1813, -1842),
(116, 10, 1831, -1822),
(117, 10, 1831, -1743),
(118, 10, 1932, -1743),
(119, 10, 1932, -1624),
(120, 10, 1827, -1624),
(121, 10, 1827, -1587),
(122, 11, 1918, -1527),
(123, 11, 1933, -1527),
(124, 11, 1933, -1596),
(125, 11, 1946, -1606),
(126, 11, 1930, -1624),
(127, 11, 1825, -1624),
(128, 11, 1825, -1588),
(129, 11, 1853, -1555),
(130, 11, 1893, -1545),
(131, 12, 1698, -1600),
(132, 12, 1790, -1620),
(133, 12, 1808, -1620),
(134, 12, 1808, -1725),
(135, 12, 1698, -1725),
(136, 13, 1682, -1599),
(137, 13, 1697, -1599),
(138, 13, 1697, -1859),
(139, 13, 1674, -1879),
(140, 13, 1668, -1861),
(141, 13, 1680, -1844),
(142, 14, 1969, -1784),
(143, 14, 2070, -1784),
(144, 14, 2070, -1818),
(145, 14, 2040, -1818),
(146, 14, 2040, -1841),
(147, 14, 2010, -1841),
(148, 14, 1970, -1833),
(149, 15, 1337, -1771),
(150, 15, 1337, -1818),
(151, 15, 1379, -1818),
(152, 15, 1379, -1864),
(153, 15, 1398, -1864),
(154, 15, 1398, -1743),
(155, 15, 1378, -1743),
(156, 15, 1378, -1770),
(157, 16, 1558, -1742),
(158, 16, 1558, -1862),
(159, 16, 1578, -1862),
(160, 16, 1578, -1742),
(161, 17, 1663, -2076),
(162, 17, 1652, -2094),
(163, 17, 1605, -2130),
(164, 17, 1658, -2154),
(165, 17, 1815, -2154),
(166, 17, 1815, -2077),
(167, 18, 1660, -1913),
(168, 18, 1676, -1962),
(169, 18, 1677, -2002),
(170, 18, 1658, -2063),
(171, 18, 1665, -2077),
(172, 18, 1813, -2077),
(173, 18, 1813, -2155),
(174, 18, 1832, -2155),
(175, 18, 1832, -2014),
(176, 18, 1814, -2014),
(177, 18, 1814, -1961),
(178, 18, 1692, -1961),
(179, 19, 1814, -1961),
(180, 19, 1814, -2014),
(181, 19, 1833, -2014),
(182, 19, 1833, -2102),
(183, 19, 1919, -2102),
(184, 19, 1919, -2062),
(185, 19, 1952, -2062),
(186, 19, 1952, -2043),
(187, 19, 1936, -2043),
(188, 19, 1936, -1962),
(189, 20, 1520, -1919),
(190, 20, 1520, -2024),
(191, 20, 1535, -2086),
(192, 20, 1588, -2146),
(193, 20, 1588, -2176),
(194, 20, 2044, -2176),
(195, 20, 2087, -2187),
(196, 20, 2126, -2221),
(197, 20, 2185, -2165),
(198, 20, 2148, -2131),
(199, 20, 2101, -2116),
(200, 20, 1970, -2116),
(201, 20, 1970, -2155),
(202, 20, 1919, -2155),
(203, 20, 1919, -2103),
(204, 20, 1831, -2103),
(205, 20, 1831, -2154),
(206, 20, 1657, -2154),
(207, 20, 1605, -2132),
(208, 20, 1652, -2094),
(209, 20, 1662, -2075),
(210, 20, 1657, -2064),
(211, 20, 1640, -2088),
(212, 20, 1592, -2123),
(213, 20, 1565, -2094),
(214, 20, 1615, -2060),
(215, 20, 1638, -2026),
(216, 20, 1645, -1975),
(217, 20, 1628, -1912),
(218, 20, 1538, -1912),
(219, 21, 1520, -1919),
(220, 21, 1520, -2024),
(221, 21, 1535, -2086),
(222, 21, 1588, -2146),
(223, 21, 1588, -2176),
(224, 21, 2044, -2176),
(225, 21, 2087, -2187),
(226, 21, 2126, -2221),
(227, 21, 2185, -2165),
(228, 21, 2148, -2131),
(229, 21, 2101, -2116),
(230, 21, 1970, -2116),
(231, 21, 1970, -2155),
(232, 21, 1919, -2155),
(233, 21, 1919, -2103),
(234, 21, 1831, -2103),
(235, 21, 1831, -2154),
(236, 21, 1657, -2154),
(237, 21, 1605, -2132),
(238, 21, 1652, -2094),
(239, 21, 1662, -2075),
(240, 21, 1657, -2064),
(241, 21, 1640, -2088),
(242, 21, 1592, -2123),
(243, 21, 1565, -2094),
(244, 21, 1615, -2060),
(245, 21, 1638, -2026),
(246, 21, 1645, -1975),
(247, 21, 1628, -1912),
(248, 21, 1538, -1912),
(249, 22, 1969, -1949),
(250, 22, 1969, -1979),
(251, 22, 2005, -1979),
(252, 22, 2005, -2101),
(253, 22, 1969, -2101),
(254, 22, 1969, -2116),
(255, 22, 2099, -2116),
(256, 22, 2150, -2130),
(257, 22, 2183, -2163),
(258, 22, 2269, -2081),
(259, 22, 2210, -2021),
(260, 22, 2202, -2004),
(261, 22, 2202, -1943),
(262, 22, 2181, -1949),
(263, 23, 2537, -1972),
(264, 23, 2537, -2037),
(265, 23, 2420, -2037),
(266, 23, 2420, -1971),
(267, 24, 2421, -1970),
(268, 24, 2538, -1970),
(269, 24, 2538, -1941),
(270, 24, 2705, -1941),
(271, 24, 2719, -1927),
(272, 24, 2420, -1927),
(273, 25, 2224, -1940),
(274, 25, 2224, -2000),
(275, 25, 2283, -2065),
(276, 25, 2311, -2045),
(277, 25, 2332, -2039),
(278, 25, 2402, -2039),
(279, 25, 2402, -1945),
(280, 25, 2322, -1945),
(281, 25, 2322, -1966),
(282, 25, 2303, -1966),
(283, 25, 2303, -1941),
(284, 26, 2202, -2001),
(285, 26, 2212, -2022),
(286, 26, 2585, -2392),
(287, 26, 2597, -2379),
(288, 26, 2223, -2000),
(289, 26, 2224, -1899),
(290, 26, 2204, -1899),
(291, 27, 2606, -1143),
(292, 27, 2632, -1143),
(293, 27, 2636, -1457),
(294, 27, 2624, -1597),
(295, 27, 2624, -1925),
(296, 27, 2723, -1925),
(297, 27, 2723, -1905),
(298, 27, 2816, -1905),
(299, 27, 2816, -1838),
(300, 27, 2823, -1769),
(301, 27, 2830, -1718),
(302, 27, 2843, -1668),
(303, 27, 2653, -1668),
(304, 27, 2653, -1057),
(305, 27, 2606, -1057),
(306, 28, 2625, -1976),
(307, 28, 2708, -1976),
(308, 28, 2708, -2041),
(309, 28, 2625, -2041),
(310, 29, 2626, -1940),
(311, 29, 2626, -1975),
(312, 29, 2708, -1975),
(313, 29, 2708, -2146),
(314, 29, 2740, -2146),
(315, 29, 2769, -2133),
(316, 29, 2795, -2109),
(317, 29, 2810, -2087),
(318, 29, 2816, -2057),
(319, 29, 2723, -2057),
(320, 29, 2723, -2039),
(321, 29, 2755, -2039),
(322, 29, 2755, -2019),
(323, 29, 2722, -2019),
(324, 29, 2722, -1924),
(325, 29, 2706, -1942),
(326, 30, 2722, -1985),
(327, 30, 2722, -2017),
(328, 30, 2755, -2017),
(329, 30, 2755, -2039),
(330, 30, 2816, -2039),
(331, 30, 2816, -1985),
(332, 31, 2723, -1904),
(333, 31, 2815, -1904),
(334, 31, 2815, -1983),
(335, 31, 2722, -1983),
(336, 32, 2654, -1633),
(337, 32, 2715, -1633),
(338, 32, 2715, -1651),
(339, 32, 2849, -1651),
(340, 32, 2843, -1668),
(341, 32, 2653, -1668),
(342, 33, 2747, -1249),
(343, 33, 2747, -1266),
(344, 33, 2773, -1266),
(345, 33, 2773, -1377),
(346, 33, 2787, -1399),
(347, 33, 2803, -1407),
(348, 33, 2825, -1407),
(349, 33, 2825, -1398),
(350, 33, 2867, -1398),
(351, 33, 2866, -1379),
(352, 33, 2839, -1368),
(353, 33, 2811, -1250),
(354, 34, 1950, -1015),
(355, 34, 2023, -1017),
(356, 34, 2065, -1028),
(357, 34, 2152, -1027),
(358, 34, 2156, -1014),
(359, 34, 2246, -1079),
(360, 34, 2298, -1089),
(361, 34, 2270, -1051),
(362, 34, 2374, -918),
(363, 34, 1950, -918),
(364, 35, 2156, -1014),
(365, 35, 2151, -1027),
(366, 35, 2135, -1027),
(367, 35, 2156, -1069),
(368, 35, 2209, -1099),
(369, 35, 2211, -1111),
(370, 35, 2262, -1136),
(371, 35, 2297, -1141),
(372, 35, 2297, -1089),
(373, 35, 2245, -1079),
(374, 36, 1680, -983),
(375, 36, 1728, -965),
(376, 36, 1779, -966),
(377, 36, 1950, -1014),
(378, 36, 2022, -1015),
(379, 36, 2064, -1027),
(380, 36, 2135, -1027),
(381, 36, 2154, -1066),
(382, 36, 2209, -1099),
(383, 36, 2212, -1111),
(384, 36, 2260, -1135),
(385, 36, 2208, -1125),
(386, 36, 2160, -1113),
(387, 36, 2101, -1076),
(388, 36, 2055, -1045),
(389, 36, 1993, -1038),
(390, 36, 1885, -1027),
(391, 36, 1789, -1033),
(392, 36, 1754, -1035),
(393, 36, 1723, -1022),
(394, 37, 2653, -1055),
(395, 37, 2766, -1055),
(396, 37, 2765, -1141),
(397, 37, 2745, -1143),
(398, 37, 2746, -1172),
(399, 37, 2768, -1172),
(400, 37, 2768, -1249),
(401, 37, 2747, -1249),
(402, 37, 2747, -1267),
(403, 37, 2772, -1267),
(404, 37, 2772, -1376),
(405, 37, 2786, -1399),
(406, 37, 2786, -1482),
(407, 37, 2748, -1482),
(408, 37, 2748, -1598),
(409, 37, 2768, -1598),
(410, 37, 2768, -1626),
(411, 37, 2793, -1626),
(412, 37, 2814, -1649),
(413, 37, 2715, -1649),
(414, 37, 2715, -1632),
(415, 37, 2655, -1632),
(416, 37, 2655, -1440),
(417, 37, 2667, -1446),
(418, 37, 2670, -1489),
(419, 37, 2689, -1514),
(420, 37, 2714, -1518),
(421, 37, 2714, -1441),
(422, 37, 2698, -1441),
(423, 37, 2684, -1389),
(424, 37, 2654, -1389),
(425, 37, 2654, -1265),
(426, 37, 2713, -1265),
(427, 37, 2713, -1143),
(428, 37, 2654, -1143),
(429, 38, 2654, -1388),
(430, 38, 2683, -1388),
(431, 38, 2698, -1440),
(432, 38, 2713, -1440),
(433, 38, 2713, -1518),
(434, 38, 2691, -1513),
(435, 38, 2670, -1489),
(436, 38, 2667, -1445),
(437, 38, 2654, -1439),
(438, 39, 1620, -1372),
(439, 39, 1704, -1372),
(440, 39, 1704, -1432),
(441, 39, 1726, -1432),
(442, 39, 1726, -1297),
(443, 39, 1784, -1269),
(444, 39, 1784, -1181),
(445, 39, 1726, -1168),
(446, 39, 1707, -1168),
(447, 39, 1707, -1206),
(448, 39, 1644, -1206),
(449, 39, 1637, -1287),
(450, 39, 1703, -1287),
(451, 39, 1703, -1312),
(452, 39, 1632, -1312),
(453, 40, 1860, -1189),
(454, 40, 1958, -1198),
(455, 40, 1965, -1250),
(456, 40, 1986, -1250),
(457, 40, 1980, -1198),
(458, 40, 2056, -1249),
(459, 40, 2056, -1277),
(460, 40, 2035, -1277),
(461, 40, 2035, -1307),
(462, 40, 1967, -1307),
(463, 40, 1861, -1307),
(464, 41, 1875, -1083),
(465, 41, 1965, -1088),
(466, 41, 1963, -1126),
(467, 41, 1980, -1126),
(468, 41, 1986, -1090),
(469, 41, 2056, -1104),
(470, 41, 2056, -1148),
(471, 41, 2005, -1214),
(472, 41, 1981, -1199),
(473, 41, 1979, -1146),
(474, 41, 1958, -1146),
(475, 41, 1959, -1196),
(476, 41, 1874, -1189),
(477, 42, 1971, -1058),
(478, 42, 1989, -1065),
(479, 42, 1980, -1125),
(480, 42, 1962, -1126),
(481, 42, 1965, -1087),
(482, 43, 1978, -1147),
(483, 43, 1958, -1146),
(484, 43, 1956, -1196),
(485, 43, 1963, -1248),
(486, 43, 1988, -1248),
(487, 44, 2057, -1146),
(488, 44, 2003, -1215),
(489, 44, 2055, -1248),
(490, 44, 2055, -1397),
(491, 44, 2081, -1374),
(492, 44, 2081, -1196),
(493, 44, 2112, -1196),
(494, 44, 2116, -1117),
(495, 44, 2057, -1094),
(496, 45, 2082, -1196),
(497, 45, 2112, -1194),
(498, 45, 2116, -1117),
(499, 45, 2168, -1127),
(500, 45, 2168, -1235),
(501, 45, 2162, -1259),
(502, 45, 2081, -1259),
(503, 46, 2261, -1155),
(504, 46, 2261, -1372),
(505, 46, 2280, -1372),
(506, 46, 2280, -1159),
(507, 47, 2168, -1128),
(508, 47, 2185, -1131),
(509, 47, 2186, -1231),
(510, 47, 2175, -1274),
(511, 47, 2173, -1376),
(512, 47, 2157, -1376),
(513, 47, 2157, -1292),
(514, 47, 2157, -1264),
(515, 47, 2168, -1231),
(516, 48, 1861, -1308),
(517, 48, 2034, -1306),
(518, 48, 2035, -1277),
(519, 48, 2054, -1277),
(520, 48, 2054, -1350),
(521, 48, 1977, -1350),
(522, 48, 1977, -1451),
(523, 48, 1860, -1451),
(524, 49, 1976, -1349),
(525, 49, 1996, -1349),
(526, 49, 1996, -1450),
(527, 49, 1976, -1450),
(528, 50, 1996, -1350),
(529, 50, 2053, -1349),
(530, 50, 2053, -1397),
(531, 50, 2103, -1397),
(532, 50, 2103, -1493),
(533, 50, 2029, -1478),
(534, 50, 1863, -1478),
(535, 50, 1863, -1451),
(536, 50, 1997, -1451),
(537, 51, 1608, -1204),
(538, 51, 1600, -1290),
(539, 51, 1586, -1358),
(540, 51, 1585, -1383),
(541, 51, 1557, -1434),
(542, 51, 1462, -1434),
(543, 51, 1462, -1290),
(544, 51, 1529, -1290),
(545, 51, 1529, -1204),
(546, 52, 1525, -1598),
(547, 52, 1524, -1725),
(548, 52, 1588, -1724),
(549, 52, 1584, -1702),
(550, 52, 1585, -1632),
(551, 52, 1563, -1598),
(552, 53, 1562, -1597),
(553, 53, 1555, -1583),
(554, 53, 1552, -1538),
(555, 53, 1561, -1516),
(556, 53, 1571, -1508),
(557, 53, 1457, -1508),
(558, 53, 1438, -1565),
(559, 53, 1438, -1584),
(560, 53, 1438, -1723),
(561, 53, 1524, -1723),
(562, 53, 1524, -1598),
(563, 54, 2104, -1397),
(564, 54, 2168, -1395),
(565, 54, 2167, -1493),
(566, 54, 2162, -1511),
(567, 54, 2122, -1498),
(568, 54, 2122, -1676),
(569, 54, 2102, -1745),
(570, 54, 2086, -1745),
(571, 54, 2101, -1680),
(572, 55, 805, -1133),
(573, 55, 805, -1158),
(574, 55, 949, -1158),
(575, 55, 949, -1177),
(576, 55, 1046, -1177),
(577, 55, 1046, -1156),
(578, 55, 1068, -1156),
(579, 55, 1068, -1184),
(580, 55, 1093, -1184),
(581, 55, 1119, -1177),
(582, 55, 1119, -1156),
(583, 55, 1219, -1156),
(584, 55, 1219, -1172),
(585, 55, 1316, -1172),
(586, 55, 1316, -1158),
(587, 55, 1334, -1158),
(588, 55, 1334, -1134),
(589, 55, 1310, -1110),
(590, 55, 1271, -1110),
(591, 55, 1271, -1135),
(592, 55, 1254, -1135),
(593, 55, 1254, -1114),
(594, 55, 1171, -1114),
(595, 55, 1171, -1134),
(596, 55, 1153, -1134),
(597, 55, 1153, -1108),
(598, 55, 1092, -1108),
(599, 55, 1092, -1134),
(600, 55, 1075, -1134),
(601, 55, 1075, -1108),
(602, 55, 992, -1108),
(603, 55, 992, -1132),
(604, 56, 805, -1072),
(605, 56, 805, -1131),
(606, 56, 990, -1131),
(607, 56, 990, -1108),
(608, 56, 1049, -1108),
(609, 56, 1049, -1081),
(610, 56, 990, -1081),
(611, 56, 990, -1048),
(612, 56, 974, -1048),
(613, 56, 974, -982),
(614, 56, 955, -984),
(615, 56, 955, -1056),
(616, 56, 876, -1056),
(617, 56, 876, -1071),
(618, 57, 1254, -946),
(619, 57, 1254, -1028),
(620, 57, 1272, -1028),
(621, 57, 1269, -941),
(622, 58, 1079, -969),
(623, 58, 1075, -1031),
(624, 58, 1092, -1031),
(625, 58, 1094, -968),
(626, 59, 1122, -1048),
(627, 59, 1213, -1048),
(628, 59, 1213, -1112),
(629, 59, 1172, -1112),
(630, 59, 1172, -1132),
(631, 59, 1155, -1132),
(632, 59, 1155, -1108),
(633, 59, 1121, -1108),
(634, 60, 1306, -1107),
(635, 60, 1306, -1048),
(636, 60, 1057, -1048),
(637, 60, 1057, -1080),
(638, 60, 990, -1080),
(639, 60, 990, -1048),
(640, 60, 974, -1048),
(641, 60, 974, -996),
(642, 60, 1077, -988),
(643, 60, 1077, -1030),
(644, 60, 1091, -1030),
(645, 60, 1094, -1000),
(646, 60, 1151, -1000),
(647, 60, 1152, -1030),
(648, 60, 1172, -1030),
(649, 60, 1172, -975),
(650, 60, 1253, -966),
(651, 60, 1253, -1029),
(652, 60, 1271, -1029),
(653, 60, 1271, -955),
(654, 60, 1297, -955),
(655, 60, 1297, -942),
(656, 60, 1355, -952),
(657, 60, 1348, -1023),
(658, 60, 1348, -1064),
(659, 60, 1337, -1136),
(660, 61, 1245, -1291),
(661, 61, 1245, -1385),
(662, 61, 1139, -1385),
(663, 61, 1139, -1369),
(664, 61, 1092, -1369),
(665, 61, 1083, -1359),
(666, 61, 1083, -1311),
(667, 61, 1133, -1291),
(668, 62, 1245, -1291),
(669, 62, 1331, -1291),
(670, 62, 1331, -1385),
(671, 62, 1246, -1385),
(672, 63, 1118, -1157),
(673, 63, 1118, -1176),
(674, 63, 1097, -1183),
(675, 63, 1069, -1183),
(676, 63, 1069, -1272),
(677, 63, 1142, -1272),
(678, 63, 1142, -1220),
(679, 63, 1161, -1220),
(680, 63, 1161, -1272),
(681, 63, 1224, -1272),
(682, 63, 1224, -1244),
(683, 63, 1247, -1244),
(684, 63, 1247, -1173),
(685, 63, 1218, -1173),
(686, 63, 1218, -1156),
(687, 64, 1067, -1272),
(688, 64, 1142, -1272),
(689, 64, 1142, -1220),
(690, 64, 1159, -1220),
(691, 64, 1159, -1272),
(692, 64, 1224, -1272),
(693, 64, 1224, -1243),
(694, 64, 1245, -1243),
(695, 64, 1245, -1173),
(696, 64, 1315, -1173),
(697, 64, 1315, -1158),
(698, 64, 1332, -1158),
(699, 64, 1332, -1291),
(700, 64, 1134, -1291),
(701, 64, 1083, -1311),
(702, 65, 1045, -1155),
(703, 65, 1045, -1178),
(704, 65, 1031, -1178),
(705, 65, 1031, -1213),
(706, 65, 1044, -1213),
(707, 65, 1044, -1261),
(708, 65, 1032, -1261),
(709, 65, 1032, -1300),
(710, 65, 1047, -1316),
(711, 65, 1047, -1387),
(712, 65, 1082, -1387),
(713, 65, 1082, -1311),
(714, 65, 1067, -1273),
(715, 65, 1067, -1155),
(716, 66, 949, -1178),
(717, 66, 950, -1242),
(718, 66, 1043, -1242),
(719, 66, 1043, -1215),
(720, 66, 1030, -1215),
(721, 66, 1030, -1177),
(722, 67, 805, -1158),
(723, 67, 805, -1312),
(724, 67, 961, -1312),
(725, 67, 950, -1242),
(726, 67, 950, -1158),
(727, 68, 1044, -1243),
(728, 68, 1044, -1260),
(729, 68, 1032, -1260),
(730, 68, 1032, -1300),
(731, 68, 1046, -1316),
(732, 68, 1045, -1379),
(733, 68, 926, -1379),
(734, 68, 926, -1337),
(735, 68, 908, -1337),
(736, 68, 908, -1356),
(737, 68, 806, -1356),
(738, 68, 806, -1313),
(739, 68, 961, -1313),
(740, 68, 950, -1243),
(741, 69, 638, -1221),
(742, 69, 646, -1270),
(743, 69, 646, -1326),
(744, 69, 786, -1326),
(745, 69, 786, -1141),
(746, 69, 741, -1141),
(747, 69, 696, -1201),
(748, 70, 798, -894),
(749, 70, 840, -956),
(750, 70, 916, -966),
(751, 70, 994, -954),
(752, 70, 980, -943),
(753, 70, 980, -893),
(754, 70, 872, -890),
(755, 70, 843, -874),
(756, 71, 1518, -1918),
(757, 71, 1518, -2022),
(758, 71, 1534, -2084),
(759, 71, 1548, -2101),
(760, 71, 1529, -2107),
(761, 71, 1424, -2108),
(762, 71, 1366, -2133),
(763, 71, 1318, -2174),
(764, 71, 1269, -2190),
(765, 71, 1229, -2239),
(766, 71, 1195, -2317),
(767, 71, 1164, -2342),
(768, 71, 1123, -2347),
(769, 71, 1062, -2279),
(770, 71, 1044, -2220),
(771, 71, 1020, -2234),
(772, 71, 1001, -2213),
(773, 71, 1014, -2098),
(774, 71, 1034, -2087),
(775, 71, 1060, -2084),
(776, 71, 1074, -1964),
(777, 71, 1070, -1890),
(778, 71, 1228, -1890),
(779, 71, 1228, -1879),
(780, 71, 1303, -1878),
(781, 71, 1319, -1887),
(782, 71, 1353, -1887),
(783, 71, 1354, -1901),
(784, 71, 1437, -1901),
(785, 71, 1436, -1919),
(786, 72, 1474, -1043),
(787, 72, 1474, -1151),
(788, 72, 1567, -1151),
(789, 72, 1566, -1110),
(790, 72, 1544, -1063),
(791, 72, 1513, -1043),
(792, 73, 1364, -1228),
(793, 73, 1446, -1228),
(794, 73, 1446, -1255),
(795, 73, 1365, -1255),
(796, 74, 1425, -1724),
(797, 74, 1437, -1724),
(798, 74, 1437, -1565),
(799, 74, 1455, -1507),
(800, 74, 1568, -1507),
(801, 74, 1549, -1483),
(802, 74, 1549, -1451),
(803, 74, 1461, -1451),
(804, 74, 1461, -1289),
(805, 74, 1529, -1289),
(806, 74, 1529, -1241),
(807, 74, 1463, -1241),
(808, 74, 1463, -1173),
(809, 74, 1447, -1173),
(810, 74, 1447, -1253),
(811, 74, 1406, -1253),
(812, 74, 1406, -1384),
(813, 74, 1429, -1384),
(814, 74, 1429, -1428),
(815, 74, 1444, -1428),
(816, 74, 1444, -1451),
(817, 74, 1409, -1451),
(818, 74, 1372, -1576),
(819, 74, 1400, -1584),
(820, 74, 1423, -1584),
(821, 75, 1405, -1256),
(822, 75, 1366, -1256),
(823, 75, 1366, -1133),
(824, 75, 1392, -1133),
(825, 75, 1428, -1152),
(826, 75, 1474, -1123),
(827, 75, 1474, -1043),
(828, 75, 1374, -1043),
(829, 75, 1374, -1012),
(830, 75, 1386, -958),
(831, 75, 1357, -953),
(832, 75, 1349, -1016),
(833, 75, 1335, -1134),
(834, 75, 1335, -1450),
(835, 75, 1330, -1472),
(836, 75, 1301, -1523),
(837, 75, 1207, -1523),
(838, 75, 1207, -1563),
(839, 75, 1290, -1563),
(840, 75, 1290, -1583),
(841, 75, 1277, -1601),
(842, 75, 1285, -1694),
(843, 75, 1285, -1843),
(844, 75, 1321, -1843),
(845, 75, 1321, -1821),
(846, 75, 1336, -1821),
(847, 75, 1336, -1742),
(848, 75, 1319, -1742),
(849, 75, 1319, -1724),
(850, 75, 1351, -1724),
(851, 75, 1351, -1588),
(852, 75, 1320, -1579),
(853, 75, 1320, -1563),
(854, 75, 1371, -1575),
(855, 75, 1407, -1450),
(856, 75, 1387, -1450),
(857, 75, 1387, -1413),
(858, 75, 1365, -1413),
(859, 75, 1365, -1385),
(860, 75, 1406, -1385),
(861, 76, 742, -1598),
(862, 76, 742, -1665),
(863, 76, 781, -1665),
(864, 76, 781, -1598),
(865, 77, 799, -1665),
(866, 77, 799, -1684),
(867, 77, 716, -1684),
(868, 77, 716, -1744),
(869, 77, 643, -1722),
(870, 77, 649, -1662),
(871, 78, 649, -1661),
(872, 78, 649, -1578),
(873, 78, 665, -1559),
(874, 78, 712, -1559),
(875, 78, 712, -1576),
(876, 78, 796, -1576),
(877, 78, 820, -1586),
(878, 78, 837, -1600),
(879, 78, 823, -1613),
(880, 78, 807, -1601),
(881, 78, 782, -1597),
(882, 78, 718, -1597),
(883, 78, 718, -1662),
(884, 79, 806, -1415),
(885, 79, 823, -1435),
(886, 79, 861, -1435),
(887, 79, 861, -1551),
(888, 79, 821, -1587),
(889, 79, 797, -1577),
(890, 79, 741, -1575),
(891, 79, 738, -1542),
(892, 79, 761, -1477),
(893, 79, 769, -1416),
(894, 80, 928, -1473),
(895, 80, 928, -1506),
(896, 80, 1037, -1506),
(897, 80, 1046, -1474),
(898, 81, 1051, -1415),
(899, 81, 994, -1456),
(900, 81, 994, -1473),
(901, 81, 1045, -1473),
(902, 81, 1037, -1504),
(903, 81, 934, -1504),
(904, 81, 934, -1554),
(905, 81, 1030, -1560),
(906, 81, 1030, -1583),
(907, 81, 1021, -1595),
(908, 81, 1021, -1787),
(909, 81, 1041, -1801),
(910, 81, 1047, -1775),
(911, 81, 1047, -1542),
(912, 81, 1071, -1463),
(913, 81, 1071, -1415),
(914, 82, 933, -1506),
(915, 82, 933, -1554),
(916, 82, 927, -1562),
(917, 82, 910, -1562),
(918, 82, 910, -1534),
(919, 82, 860, -1534),
(920, 82, 860, -1435),
(921, 82, 910, -1415),
(922, 82, 926, -1415),
(923, 82, 992, -1454),
(924, 82, 992, -1471),
(925, 82, 926, -1471),
(926, 82, 926, -1506),
(927, 83, 906, -1581),
(928, 83, 926, -1581),
(929, 83, 1019, -1595),
(930, 83, 1019, -1785),
(931, 83, 926, -1764),
(932, 83, 852, -1761),
(933, 83, 852, -1629),
(934, 84, 1168, -1723),
(935, 84, 1168, -1843),
(936, 84, 1188, -1843),
(937, 84, 1188, -1724),
(938, 85, 1047, -1703),
(939, 85, 1159, -1703),
(940, 85, 1159, -1633),
(941, 85, 1180, -1633),
(942, 85, 1180, -1651),
(943, 85, 1198, -1651),
(944, 85, 1198, -1609),
(945, 85, 1275, -1602),
(946, 85, 1285, -1694),
(947, 85, 1285, -1782),
(948, 85, 1186, -1782),
(949, 85, 1186, -1723),
(950, 85, 1167, -1723),
(951, 85, 1167, -1783),
(952, 85, 1105, -1783),
(953, 85, 1068, -1843),
(954, 85, 1060, -1816),
(955, 85, 1042, -1799),
(956, 86, 1289, -1563),
(957, 86, 1047, -1563),
(958, 86, 1047, -1581),
(959, 86, 1159, -1581),
(960, 86, 1198, -1609),
(961, 86, 1275, -1601),
(962, 86, 1290, -1582),
(963, 87, 1046, -1582),
(964, 87, 1156, -1582),
(965, 87, 1199, -1610),
(966, 87, 1197, -1650),
(967, 87, 1181, -1650),
(968, 87, 1181, -1634),
(969, 87, 1158, -1634),
(970, 87, 1158, -1702),
(971, 87, 1047, -1702),
(972, 88, 402, -1203),
(973, 88, 323, -1237),
(974, 88, 286, -1238),
(975, 88, 270, -1248),
(976, 88, 306, -1279),
(977, 88, 236, -1330),
(978, 88, 154, -1244),
(979, 88, 197, -1183),
(980, 88, 317, -1107),
(981, 89, 271, -1247),
(982, 89, 307, -1279),
(983, 89, 435, -1226),
(984, 89, 459, -1215),
(985, 89, 425, -1193),
(986, 89, 326, -1236),
(987, 89, 285, -1238),
(988, 90, 618, -1121),
(989, 90, 650, -1183),
(990, 90, 560, -1222),
(991, 90, 510, -1255),
(992, 90, 478, -1227),
(993, 90, 450, -1237),
(994, 90, 453, -1271),
(995, 90, 387, -1306),
(996, 90, 357, -1304),
(997, 90, 230, -1419),
(998, 90, 190, -1433),
(999, 90, 123, -1528),
(1000, 90, 66, -1517),
(1001, 90, 170, -1386),
(1002, 90, 235, -1328),
(1003, 90, 305, -1277),
(1004, 90, 459, -1215),
(1005, 90, 520, -1195),
(1006, 90, 572, -1175),
(1007, 90, 599, -1159),
(1008, 90, 602, -1131),
(1009, 91, 304, -1062),
(1010, 91, 295, -1074),
(1011, 91, 402, -1204),
(1012, 91, 422, -1193),
(1013, 91, 459, -1215),
(1014, 91, 571, -1176),
(1015, 91, 598, -1158),
(1016, 91, 599, -1132),
(1017, 91, 618, -1121),
(1018, 91, 649, -1182),
(1019, 91, 742, -1046),
(1020, 91, 765, -1011),
(1021, 91, 787, -1009),
(1022, 91, 784, -948),
(1023, 91, 779, -922),
(1024, 91, 797, -894),
(1025, 91, 844, -873),
(1026, 91, 871, -889),
(1027, 91, 977, -891),
(1028, 91, 1145, -839),
(1029, 91, 1149, -772),
(1030, 91, 1165, -770),
(1031, 91, 1165, -876),
(1032, 91, 1303, -853),
(1033, 91, 1341, -856),
(1034, 91, 1360, -925),
(1035, 91, 1391, -929),
(1036, 91, 1397, -907),
(1037, 91, 1453, -914),
(1038, 91, 1460, -925),
(1039, 91, 1515, -925),
(1040, 91, 1581, -895),
(1041, 91, 1581, -650),
(1042, 91, 1455, -650),
(1043, 91, 1414, -683),
(1044, 91, 1304, -699),
(1045, 91, 1173, -735),
(1046, 91, 1169, -756),
(1047, 91, 1149, -756),
(1048, 91, 1157, -720),
(1049, 91, 1065, -724),
(1050, 91, 996, -771),
(1051, 91, 961, -810),
(1052, 91, 931, -796),
(1053, 91, 847, -865),
(1054, 91, 815, -833),
(1055, 91, 767, -915),
(1056, 91, 701, -1002),
(1057, 91, 682, -990),
(1058, 91, 614, -1069),
(1059, 91, 537, -1120),
(1060, 91, 408, -1121),
(1061, 91, 384, -1155),
(1062, 91, 369, -1145),
(1063, 92, 197, -1561),
(1064, 92, 293, -1481),
(1065, 92, 271, -1461),
(1066, 92, 199, -1512),
(1067, 92, 189, -1531),
(1068, 93, 254, -1609),
(1069, 93, 276, -1627),
(1070, 93, 341, -1634),
(1071, 93, 357, -1627),
(1072, 93, 422, -1634),
(1073, 93, 438, -1647),
(1074, 93, 459, -1647),
(1075, 93, 459, -1622),
(1076, 93, 511, -1622),
(1077, 93, 511, -1655),
(1078, 93, 620, -1667),
(1079, 93, 616, -1717),
(1080, 93, 381, -1660),
(1081, 93, 256, -1643),
(1082, 93, 198, -1561),
(1083, 93, 249, -1583),
(1084, 94, 338, -1572),
(1085, 94, 372, -1524),
(1086, 94, 427, -1479),
(1087, 94, 438, -1507),
(1088, 94, 438, -1578),
(1089, 94, 617, -1575),
(1090, 94, 617, -1601),
(1091, 94, 513, -1603),
(1092, 94, 510, -1623),
(1093, 94, 457, -1622),
(1094, 94, 457, -1601),
(1095, 94, 432, -1602),
(1096, 94, 433, -1643),
(1097, 94, 414, -1632),
(1098, 94, 358, -1627),
(1099, 94, 338, -1635),
(1100, 95, 518, -1350),
(1101, 95, 534, -1399),
(1102, 95, 512, -1403),
(1103, 95, 500, -1359),
(1104, 96, 500, -1504),
(1105, 96, 519, -1427),
(1106, 96, 585, -1415),
(1107, 96, 585, -1575),
(1108, 96, 516, -1576),
(1109, 97, 475, -1577),
(1110, 97, 472, -1452),
(1111, 97, 517, -1427),
(1112, 97, 498, -1503),
(1113, 97, 516, -1577),
(1114, 98, 124, -1527),
(1115, 98, 176, -1571),
(1116, 98, 216, -1587),
(1117, 98, 197, -1563),
(1118, 98, 188, -1530),
(1119, 98, 197, -1511),
(1120, 98, 270, -1460),
(1121, 98, 487, -1327),
(1122, 98, 480, -1314),
(1123, 98, 495, -1302),
(1124, 98, 514, -1329),
(1125, 98, 621, -1310),
(1126, 98, 617, -1229),
(1127, 98, 697, -1199),
(1128, 98, 740, -1140),
(1129, 98, 787, -1141),
(1130, 98, 787, -1071),
(1131, 98, 874, -1071),
(1132, 98, 874, -1056),
(1133, 98, 953, -1056),
(1134, 98, 953, -982),
(1135, 98, 973, -982),
(1136, 98, 973, -997),
(1137, 98, 1076, -987),
(1138, 98, 1078, -967),
(1139, 98, 1093, -967),
(1140, 98, 1093, -999),
(1141, 98, 1152, -999),
(1142, 98, 1152, -963),
(1143, 98, 1172, -963),
(1144, 98, 1172, -974),
(1145, 98, 1253, -964),
(1146, 98, 1253, -947),
(1147, 98, 1269, -943),
(1148, 98, 1270, -953),
(1149, 98, 1297, -954),
(1150, 98, 1297, -941),
(1151, 98, 1554, -991),
(1152, 98, 1601, -983),
(1153, 98, 1639, -965),
(1154, 98, 1475, -947),
(1155, 98, 1451, -914),
(1156, 98, 1396, -907),
(1157, 98, 1390, -928),
(1158, 98, 1360, -923),
(1159, 98, 1341, -856),
(1160, 98, 1304, -853),
(1161, 98, 1165, -875),
(1162, 98, 1166, -935),
(1163, 98, 1150, -936),
(1164, 98, 1145, -839),
(1165, 98, 975, -890),
(1166, 98, 978, -941),
(1167, 98, 994, -953),
(1168, 98, 917, -965),
(1169, 98, 839, -955),
(1170, 98, 797, -894),
(1171, 98, 789, -909),
(1172, 98, 802, -939),
(1173, 98, 802, -1035),
(1174, 98, 786, -1034),
(1175, 98, 786, -1008),
(1176, 98, 763, -1011),
(1177, 98, 650, -1182),
(1178, 98, 559, -1222),
(1179, 98, 510, -1255),
(1180, 98, 494, -1267),
(1181, 98, 450, -1237),
(1182, 98, 454, -1270),
(1183, 98, 387, -1306),
(1184, 98, 356, -1305),
(1185, 98, 230, -1419),
(1186, 98, 190, -1432),
(1187, 99, 617, -1231),
(1188, 99, 636, -1221),
(1189, 99, 645, -1271),
(1190, 99, 645, -1324),
(1191, 99, 787, -1324),
(1192, 99, 787, -1385),
(1193, 99, 644, -1385),
(1194, 99, 644, -1415),
(1195, 99, 654, -1426),
(1196, 99, 688, -1426),
(1197, 99, 688, -1558),
(1198, 99, 664, -1558),
(1199, 99, 647, -1579),
(1200, 99, 649, -1661),
(1201, 99, 642, -1721),
(1202, 99, 615, -1717),
(1203, 99, 621, -1666),
(1204, 99, 616, -1602),
(1205, 99, 616, -1575),
(1206, 99, 585, -1575),
(1207, 99, 585, -1415),
(1208, 99, 619, -1412),
(1209, 99, 619, -1384),
(1210, 99, 563, -1354),
(1211, 99, 563, -1338),
(1212, 99, 622, -1328),
(1213, 100, 562, -1353),
(1214, 100, 523, -1365),
(1215, 100, 535, -1398),
(1216, 100, 512, -1402),
(1217, 100, 503, -1379),
(1218, 100, 422, -1432),
(1219, 100, 430, -1445),
(1220, 100, 412, -1457),
(1221, 100, 388, -1428),
(1222, 100, 289, -1510),
(1223, 100, 255, -1560),
(1224, 100, 314, -1572),
(1225, 100, 320, -1630),
(1226, 100, 338, -1634),
(1227, 100, 337, -1572),
(1228, 100, 372, -1523),
(1229, 100, 426, -1480),
(1230, 100, 517, -1426),
(1231, 100, 585, -1414),
(1232, 100, 618, -1411),
(1233, 100, 618, -1383),
(1234, 101, 644, -1385),
(1235, 101, 644, -1416),
(1236, 101, 654, -1425),
(1237, 101, 687, -1425),
(1238, 101, 687, -1557),
(1239, 101, 760, -1477),
(1240, 101, 768, -1415),
(1241, 101, 806, -1415),
(1242, 101, 822, -1435),
(1243, 101, 860, -1434),
(1244, 101, 909, -1415),
(1245, 101, 926, -1415),
(1246, 101, 993, -1453),
(1247, 101, 1050, -1415),
(1248, 101, 1072, -1414),
(1249, 101, 1072, -1463),
(1250, 101, 1048, -1541),
(1251, 101, 1048, -1563),
(1252, 101, 1187, -1563),
(1253, 101, 1187, -1413),
(1254, 101, 1204, -1413),
(1255, 101, 1204, -1447),
(1256, 101, 1333, -1447),
(1257, 101, 1335, -1419),
(1258, 101, 1335, -1383),
(1259, 101, 1139, -1383),
(1260, 101, 1139, -1369),
(1261, 101, 1094, -1369),
(1262, 101, 1081, -1359),
(1263, 101, 1081, -1387),
(1264, 101, 1047, -1387),
(1265, 101, 1047, -1379),
(1266, 101, 925, -1379),
(1267, 101, 925, -1387),
(1268, 101, 909, -1387),
(1269, 101, 906, -1355),
(1270, 101, 806, -1355),
(1271, 101, 806, -1385),
(1272, 102, 1188, -1414),
(1273, 102, 1203, -1414),
(1274, 102, 1204, -1446),
(1275, 102, 1333, -1447),
(1276, 102, 1330, -1471),
(1277, 102, 1300, -1523),
(1278, 102, 1208, -1523),
(1279, 102, 1206, -1562),
(1280, 102, 1187, -1562),
(1281, 103, 476, -1786),
(1282, 103, 379, -1786),
(1283, 103, 379, -1735),
(1284, 103, 452, -1736),
(1285, 103, 451, -1727),
(1286, 103, 475, -1731),
(1287, 104, 361, -1657),
(1288, 104, 361, -1903),
(1289, 104, 348, -2091),
(1290, 104, 417, -2091),
(1291, 104, 417, -1786),
(1292, 104, 378, -1786),
(1293, 104, 378, -1660),
(1294, 105, 742, -1752),
(1295, 105, 643, -1721),
(1296, 105, 379, -1661),
(1297, 105, 378, -1734),
(1298, 105, 449, -1734),
(1299, 105, 449, -1724),
(1300, 105, 474, -1731),
(1301, 105, 475, -1770),
(1302, 105, 996, -1879),
(1303, 105, 1013, -2099),
(1304, 105, 1034, -2086),
(1305, 105, 1060, -2083),
(1306, 105, 1075, -1963),
(1307, 105, 1070, -1888),
(1308, 105, 1069, -1842),
(1309, 105, 1059, -1814),
(1310, 105, 1021, -1784),
(1311, 105, 926, -1762),
(1312, 105, 853, -1759),
(1313, 105, 852, -1730),
(1314, 105, 819, -1760),
(1315, 105, 781, -1759),
(1316, 106, 1936, -1950),
(1317, 106, 1938, -2043),
(1318, 106, 1952, -2043),
(1319, 106, 1952, -2061),
(1320, 106, 1918, -2062),
(1321, 106, 1920, -2155),
(1322, 106, 1970, -2155),
(1323, 106, 1969, -2100),
(1324, 106, 2003, -2100),
(1325, 106, 2004, -1978),
(1326, 106, 1968, -1979),
(1327, 106, 1968, -1949),
(1328, 107, 2082, -1259),
(1329, 107, 2158, -1259),
(1330, 107, 2156, -1339),
(1331, 107, 2082, -1340),
(1332, 108, 2054, -1396),
(1333, 108, 2082, -1375),
(1334, 108, 2082, -1340),
(1335, 108, 2156, -1338),
(1336, 108, 2155, -1375),
(1337, 108, 2174, -1375),
(1338, 108, 2175, -1345),
(1339, 108, 2210, -1345),
(1340, 108, 2210, -1376),
(1341, 108, 2281, -1376),
(1342, 108, 2281, -1394),
(1343, 108, 2262, -1409),
(1344, 108, 2221, -1409),
(1345, 108, 2221, -1394),
(1346, 109, 2222, -1457),
(1347, 109, 2222, -1537),
(1348, 109, 2274, -1554),
(1349, 109, 2337, -1554),
(1350, 109, 2337, -1475),
(1351, 109, 2290, -1457),
(1352, 110, 2654, -1248),
(1353, 110, 2712, -1248),
(1354, 110, 2712, -1264),
(1355, 110, 2654, -1264),
(1356, 111, 2632, -1265),
(1357, 111, 2631, -1246),
(1358, 111, 2563, -1247),
(1359, 111, 2562, -1224),
(1360, 111, 2457, -1223),
(1361, 111, 2457, -1248),
(1362, 111, 2444, -1248),
(1363, 111, 2444, -1206),
(1364, 111, 2381, -1206),
(1365, 111, 2381, -1266),
(1366, 112, 2542, -1265),
(1367, 112, 2545, -1433),
(1368, 112, 2636, -1432),
(1369, 112, 2631, -1265),
(1370, 113, 2541, -1266),
(1371, 113, 2544, -1433),
(1372, 113, 2461, -1436),
(1373, 113, 2461, -1356),
(1374, 113, 2481, -1356),
(1375, 113, 2481, -1311),
(1376, 113, 2500, -1311),
(1377, 113, 2500, -1264),
(1378, 114, 2413, -1265),
(1379, 114, 2413, -1372),
(1380, 114, 2439, -1372),
(1381, 114, 2439, -1436),
(1382, 114, 2461, -1436),
(1383, 114, 2461, -1356),
(1384, 114, 2481, -1356),
(1385, 114, 2481, -1312),
(1386, 114, 2500, -1312),
(1387, 114, 2500, -1264),
(1388, 115, 2361, -1289),
(1389, 115, 2361, -1289),
(1390, 115, 2361, -1318),
(1391, 115, 2312, -1318),
(1392, 115, 2312, -1289),
(1393, 116, 2313, -1288),
(1394, 116, 2361, -1290),
(1395, 116, 2361, -1318),
(1396, 116, 2341, -1318),
(1397, 116, 2341, -1371),
(1398, 116, 2412, -1371),
(1399, 116, 2412, -1264),
(1400, 116, 2381, -1264),
(1401, 116, 2381, -1164),
(1402, 116, 2364, -1164),
(1403, 116, 2364, -1201),
(1404, 116, 2311, -1201),
(1405, 117, 2632, -1244),
(1406, 117, 2582, -1245),
(1407, 117, 2582, -1191),
(1408, 117, 2562, -1191),
(1409, 117, 2561, -1223),
(1410, 117, 2459, -1221),
(1411, 117, 2458, -1189),
(1412, 117, 2446, -1190),
(1413, 117, 2445, -1205),
(1414, 117, 2382, -1204),
(1415, 117, 2382, -1165),
(1416, 117, 2630, -1165),
(1417, 118, 2296, -1142),
(1418, 118, 2336, -1144),
(1419, 118, 2364, -1123),
(1420, 118, 2540, -1123),
(1421, 118, 2540, -1144),
(1422, 118, 2631, -1144),
(1423, 118, 2631, -1164),
(1424, 118, 2364, -1164),
(1425, 118, 2364, -1199),
(1426, 118, 2311, -1199),
(1427, 118, 2311, -1163),
(1428, 118, 2294, -1163),
(1429, 119, 2294, -1162),
(1430, 119, 2294, -1378),
(1431, 119, 2340, -1378),
(1432, 119, 2340, -1316),
(1433, 119, 2310, -1316),
(1434, 119, 2310, -1163),
(1435, 120, 2292, -1377),
(1436, 120, 2292, -1392),
(1437, 120, 2376, -1392),
(1438, 120, 2376, -1457),
(1439, 120, 2634, -1457),
(1440, 120, 2634, -1433),
(1441, 120, 2438, -1437),
(1442, 120, 2438, -1372),
(1443, 120, 2340, -1370),
(1444, 120, 2339, -1378),
(1445, 121, 2291, -1391),
(1446, 121, 2286, -1457),
(1447, 121, 2336, -1476),
(1448, 121, 2336, -1670),
(1449, 121, 2317, -1670),
(1450, 121, 2317, -1693),
(1451, 121, 2336, -1693),
(1452, 121, 2336, -1723),
(1453, 121, 2351, -1723),
(1454, 121, 2351, -1518),
(1455, 121, 2377, -1457),
(1456, 121, 2377, -1391),
(1457, 122, 2450, -1458),
(1458, 122, 2450, -1489),
(1459, 122, 2440, -1497),
(1460, 122, 2440, -1583),
(1461, 122, 2470, -1592),
(1462, 122, 2541, -1594),
(1463, 122, 2541, -1581),
(1464, 122, 2585, -1489),
(1465, 122, 2582, -1457),
(1466, 123, 2352, -1555),
(1467, 123, 2421, -1580),
(1468, 123, 2421, -1520),
(1469, 123, 2390, -1520),
(1470, 123, 2357, -1499),
(1471, 123, 2351, -1517),
(1472, 124, 2358, -1500),
(1473, 124, 2388, -1520),
(1474, 124, 2421, -1520),
(1475, 124, 2421, -1725),
(1476, 124, 2440, -1725),
(1477, 124, 2440, -1497),
(1478, 124, 2449, -1488),
(1479, 124, 2449, -1457),
(1480, 124, 2378, -1457),
(1481, 125, 2202, -1584),
(1482, 125, 2177, -1691),
(1483, 125, 2121, -1673),
(1484, 125, 2121, -1547),
(1485, 126, 2237, -1605),
(1486, 126, 2218, -1656),
(1487, 126, 2235, -1660),
(1488, 126, 2229, -1694),
(1489, 126, 2316, -1692),
(1490, 126, 2315, -1669),
(1491, 126, 2335, -1669),
(1492, 126, 2334, -1630),
(1493, 126, 2290, -1627),
(1494, 127, 2352, -1630),
(1495, 127, 2420, -1630),
(1496, 127, 2418, -1693),
(1497, 127, 2352, -1692),
(1498, 128, 2606, -1056),
(1499, 128, 2605, -1142),
(1500, 128, 2541, -1144),
(1501, 128, 2540, -1124),
(1502, 128, 2364, -1123),
(1503, 128, 2334, -1144),
(1504, 128, 2296, -1140),
(1505, 128, 2298, -1089),
(1506, 128, 2352, -1092),
(1507, 128, 2436, -1072),
(1508, 128, 2518, -1080),
(1509, 128, 2547, -1075),
(1510, 128, 2551, -1056),
(1511, 129, 2373, -918),
(1512, 129, 2835, -918),
(1513, 129, 2827, -1056),
(1514, 129, 2552, -1056),
(1515, 129, 2546, -1074),
(1516, 129, 2516, -1081),
(1517, 129, 2436, -1071),
(1518, 129, 2351, -1093),
(1519, 129, 2298, -1089),
(1520, 129, 2270, -1052),
(1521, 130, 788, -1070),
(1522, 130, 804, -1070),
(1523, 130, 804, -1383),
(1524, 130, 787, -1383),
(1525, 131, 1851, -1027),
(1526, 131, 1875, -1082),
(1527, 131, 1962, -1086),
(1528, 131, 1970, -1059),
(1529, 131, 1988, -1065),
(1530, 131, 1984, -1087),
(1531, 131, 2055, -1103),
(1532, 131, 2056, -1094),
(1533, 131, 2116, -1116),
(1534, 131, 2185, -1131),
(1535, 131, 2187, -1211),
(1536, 131, 2259, -1211),
(1537, 131, 2260, -1154),
(1538, 131, 2280, -1158),
(1539, 131, 2278, -1140),
(1540, 131, 2160, -1113),
(1541, 131, 2054, -1043),
(1542, 131, 1887, -1026),
(1543, 132, 1873, -1189),
(1544, 132, 1873, -1081),
(1545, 132, 1851, -1029),
(1546, 132, 1804, -1045),
(1547, 132, 1789, -1092),
(1548, 133, 1619, -1504),
(1549, 133, 1618, -1517),
(1550, 133, 1653, -1530),
(1551, 133, 1680, -1535),
(1552, 133, 1707, -1518),
(1553, 133, 1740, -1510),
(1554, 133, 1678, -1490),
(1555, 133, 1650, -1494),
(1556, 134, 2786, -1399),
(1557, 134, 2802, -1407),
(1558, 134, 2824, -1406),
(1559, 134, 2824, -1478),
(1560, 134, 2867, -1478),
(1561, 134, 2862, -1498),
(1562, 134, 2748, -1498),
(1563, 134, 2748, -1482),
(1564, 134, 2787, -1482),
(1565, 135, 2848, -1652),
(1566, 135, 2814, -1650),
(1567, 135, 2793, -1626),
(1568, 135, 2768, -1626),
(1569, 135, 2768, -1598),
(1570, 135, 2749, -1598),
(1571, 135, 2749, -1499),
(1572, 135, 2862, -1499),
(1573, 135, 2869, -1478),
(1574, 135, 2825, -1478),
(1575, 135, 2825, -1398),
(1576, 135, 2866, -1398),
(1577, 135, 2866, -1378),
(1578, 135, 2838, -1367),
(1579, 135, 2810, -1251),
(1580, 135, 2768, -1247),
(1581, 135, 2768, -1171),
(1582, 135, 2826, -1150),
(1583, 135, 2824, -1133),
(1584, 135, 2765, -1139),
(1585, 135, 2765, -1056),
(1586, 135, 2826, -1056),
(1587, 135, 2834, -916),
(1588, 135, 2836, -595),
(1589, 135, 2767, -490),
(1590, 135, 2783, -459),
(1591, 135, 2856, -571),
(1592, 135, 2857, -926),
(1593, 135, 2850, -1113),
(1594, 135, 2872, -1283),
(1595, 135, 2896, -1490),
(1596, 136, 2180, -1259),
(1597, 136, 2258, -1259),
(1598, 136, 2258, -1376),
(1599, 136, 2208, -1376),
(1600, 136, 2208, -1346),
(1601, 136, 2173, -1346),
(1602, 136, 2173, -1274),
(1603, 137, 1367, -1229),
(1604, 137, 1446, -1229),
(1605, 137, 1446, -1174),
(1606, 137, 1462, -1174),
(1607, 137, 1462, -1240),
(1608, 137, 1528, -1240),
(1609, 137, 1528, -1204),
(1610, 137, 1608, -1204),
(1611, 137, 1601, -1152),
(1612, 137, 1474, -1152),
(1613, 137, 1474, -1123),
(1614, 137, 1428, -1151),
(1615, 137, 1392, -1132),
(1616, 137, 1366, -1132),
(1617, 138, 2622, -1721),
(1618, 138, 2441, -1724),
(1619, 138, 2420, -1725),
(1620, 138, 2420, -1694),
(1621, 138, 2351, -1694),
(1622, 138, 2351, -1723),
(1623, 138, 2335, -1723),
(1624, 138, 2335, -1692),
(1625, 138, 2226, -1692),
(1626, 138, 2226, -1839),
(1627, 138, 2405, -1823),
(1628, 138, 2405, -1739),
(1629, 138, 2422, -1739),
(1630, 138, 2422, -1750),
(1631, 138, 2463, -1771),
(1632, 138, 2497, -1770),
(1633, 138, 2515, -1742),
(1634, 138, 2623, -1742),
(1635, 139, 2540, -1926),
(1636, 139, 2526, -1864),
(1637, 139, 2542, -1743),
(1638, 139, 2515, -1743),
(1639, 139, 2496, -1771),
(1640, 139, 2507, -1881),
(1641, 139, 2468, -1881),
(1642, 139, 2468, -1927),
(1643, 140, 2406, -1739),
(1644, 140, 2406, -1881),
(1645, 140, 2345, -1881),
(1646, 140, 2345, -1946),
(1647, 140, 2402, -1946),
(1648, 140, 2402, -2038),
(1649, 140, 2421, -2038),
(1650, 140, 2421, -1927),
(1651, 140, 2469, -1927),
(1652, 140, 2469, -1880),
(1653, 140, 2423, -1880),
(1654, 140, 2423, -1823),
(1655, 140, 2501, -1823),
(1656, 140, 2495, -1769),
(1657, 140, 2462, -1771),
(1658, 140, 2422, -1748),
(1659, 140, 2419, -1739),
(1660, 141, 2722, -2039),
(1661, 141, 2723, -2057),
(1662, 141, 2816, -2056),
(1663, 141, 2815, -2039),
(1664, 142, 2222, -1535),
(1665, 142, 2221, -1457),
(1666, 142, 2276, -1456),
(1667, 142, 2280, -1393),
(1668, 142, 2261, -1408),
(1669, 142, 2221, -1409),
(1670, 142, 2221, -1394),
(1671, 142, 2168, -1394),
(1672, 142, 2168, -1495),
(1673, 142, 2162, -1510),
(1674, 142, 2207, -1531),
(1675, 142, 2202, -1583),
(1676, 142, 2177, -1691),
(1677, 142, 2120, -1671),
(1678, 142, 2109, -1723),
(1679, 142, 2172, -1723),
(1680, 142, 2193, -1734),
(1681, 142, 2219, -1591),
(1682, 143, 1069, -1844),
(1683, 143, 1070, -1890),
(1684, 143, 1226, -1890),
(1685, 143, 1226, -1879),
(1686, 143, 1302, -1879),
(1687, 143, 1319, -1887),
(1688, 143, 1352, -1887),
(1689, 143, 1352, -1902),
(1690, 143, 1435, -1902),
(1691, 143, 1435, -1919),
(1692, 143, 1518, -1919),
(1693, 143, 1537, -1911),
(1694, 143, 1626, -1911),
(1695, 143, 1593, -1775),
(1696, 143, 1578, -1770),
(1697, 143, 1578, -1862),
(1698, 143, 1557, -1862),
(1699, 143, 1557, -1836),
(1700, 143, 1397, -1836),
(1701, 143, 1397, -1864),
(1702, 143, 1379, -1864),
(1703, 143, 1379, -1818),
(1704, 143, 1321, -1821),
(1705, 143, 1321, -1842),
(1706, 143, 1284, -1842),
(1707, 143, 1284, -1782),
(1708, 143, 1186, -1782),
(1709, 143, 1186, -1843),
(1710, 143, 1168, -1843),
(1711, 143, 1168, -1782),
(1712, 143, 1106, -1782),
(1713, 144, 2234, -89),
(1714, 144, 2246, -89),
(1715, 144, 2246, -67),
(1716, 144, 2286, -67),
(1717, 144, 2286, -89),
(1718, 144, 2338, -89),
(1719, 144, 2348, -99),
(1720, 144, 2342, -183),
(1721, 144, 2201, -134),
(1722, 145, 2302, 207),
(1723, 145, 2388, 207),
(1724, 145, 2388, 97),
(1725, 145, 2353, 97),
(1726, 145, 2353, -103),
(1727, 145, 2337, -89),
(1728, 145, 2326, -88),
(1729, 145, 2326, -46),
(1730, 145, 2336, -35),
(1731, 145, 2336, -19),
(1732, 145, 2324, -6),
(1733, 145, 2324, 84),
(1734, 145, 2334, 84),
(1735, 145, 2334, 98),
(1736, 145, 2302, 98),
(1737, 146, 2354, -19),
(1738, 146, 2354, 85),
(1739, 146, 2402, 85),
(1740, 146, 2402, 31),
(1741, 146, 2429, 31),
(1742, 146, 2429, -18),
(1743, 147, 2429, 7),
(1744, 147, 2453, 7),
(1745, 147, 2453, -16),
(1746, 147, 2473, -46),
(1747, 147, 2405, -144),
(1748, 147, 2353, -102),
(1749, 147, 2353, -19),
(1750, 147, 2429, -19),
(1751, 148, 2527, -122),
(1752, 148, 2558, -42),
(1753, 148, 2524, 3),
(1754, 148, 2524, 30),
(1755, 148, 2473, 30),
(1756, 148, 2473, -44),
(1757, 149, 2500, 78),
(1758, 149, 2500, 53),
(1759, 149, 2597, 53),
(1760, 149, 2597, 156),
(1761, 149, 2524, 103),
(1762, 149, 2524, 78),
(1763, 150, 2597, 53),
(1764, 150, 2597, 30),
(1765, 150, 2399, 30),
(1766, 150, 2399, 81),
(1767, 150, 2454, 81),
(1768, 150, 2454, 52),
(1769, 151, 2429, 30),
(1770, 151, 2429, 7),
(1771, 151, 2452, 7),
(1772, 151, 2452, -14),
(1773, 151, 2472, -45),
(1774, 151, 2472, 30),
(1775, 152, 2422, 112),
(1776, 152, 2458, 112),
(1777, 152, 2472, 105),
(1778, 152, 2472, 78),
(1779, 152, 2523, 78),
(1780, 152, 2523, 103),
(1781, 152, 2597, 156),
(1782, 152, 2421, 156),
(1783, 153, 2302, 207),
(1784, 153, 2214, 188),
(1785, 153, 2214, 146),
(1786, 153, 2230, 132),
(1787, 153, 2282, 132),
(1788, 153, 2302, 146),
(1789, 154, 2302, 146),
(1790, 154, 2283, 132),
(1791, 154, 2283, 84),
(1792, 154, 2273, 68),
(1793, 154, 2284, 53),
(1794, 154, 2284, -18),
(1795, 154, 2299, -18),
(1796, 154, 2324, -5),
(1797, 154, 2324, 84),
(1798, 154, 2302, 84),
(1799, 155, 2214, 147),
(1800, 155, 2230, 133),
(1801, 155, 2230, 84),
(1802, 155, 2243, 70),
(1803, 155, 2230, 50),
(1804, 155, 2126, 51),
(1805, 156, 2125, 51),
(1806, 156, 2125, 36),
(1807, 156, 2233, 19),
(1808, 156, 2282, 19),
(1809, 156, 2282, 53),
(1810, 156, 2272, 69),
(1811, 156, 2244, 69),
(1812, 156, 2230, 51),
(1813, 157, 2233, 21),
(1814, 157, 2233, -90),
(1815, 157, 2197, -136),
(1816, 157, 2129, -17),
(1817, 158, 1630, 125),
(1818, 158, 1670, 43),
(1819, 158, 2078, 33),
(1820, 158, 2080, 49),
(1821, 158, 1639, 144),
(1822, 159, 1895, 37),
(1823, 159, 1916, 37),
(1824, 159, 1870, -356),
(1825, 159, 1787, -335),
(1826, 160, 840, -559),
(1827, 160, 841, -575),
(1828, 160, 1234, -524),
(1829, 160, 1253, -408),
(1830, 160, 1119, -280),
(1831, 160, 1001, -283),
(1832, 161, 877, -644),
(1833, 161, 778, -644),
(1834, 161, 781, -604),
(1835, 161, 810, -574),
(1836, 161, 825, -588),
(1837, 161, 876, -588),
(1838, 162, 810, -574),
(1839, 162, 810, -539),
(1840, 162, 781, -539),
(1841, 162, 780, -605),
(1842, 163, 810, -545),
(1843, 163, 839, -533),
(1844, 163, 840, -588),
(1845, 163, 824, -587),
(1846, 163, 810, -574),
(1847, 164, 780, -537),
(1848, 164, 809, -537),
(1849, 164, 809, -546),
(1850, 164, 860, -521),
(1851, 164, 860, -436),
(1852, 164, 729, -436),
(1853, 164, 729, -576),
(1854, 164, 779, -576),
(1855, 165, 728, -435),
(1856, 165, 714, -435),
(1857, 165, 714, -593),
(1858, 165, 726, -605),
(1859, 165, 779, -605),
(1860, 165, 779, -575),
(1861, 165, 727, -575),
(1862, 166, 672, -548),
(1863, 166, 672, -594),
(1864, 166, 644, -594),
(1865, 166, 644, -618),
(1866, 166, 566, -618),
(1867, 166, 566, -535),
(1868, 166, 663, -536),
(1869, 167, 644, -593),
(1870, 167, 671, -593),
(1871, 167, 671, -652),
(1872, 167, 643, -652),
(1873, 168, 621, -506),
(1874, 168, 659, -507),
(1875, 168, 672, -493),
(1876, 168, 688, -493),
(1877, 168, 713, -504),
(1878, 168, 713, -437),
(1879, 168, 652, -437),
(1880, 168, 652, -474),
(1881, 168, 591, -474),
(1882, 169, 590, -475),
(1883, 169, 564, -475),
(1884, 169, 564, -535),
(1885, 169, 611, -535),
(1886, 169, 611, -518),
(1887, 169, 621, -507),
(1888, 170, -140, -963),
(1889, 170, -110, -999),
(1890, 170, 88, -544),
(1891, 170, 19, -344),
(1892, 170, 19, -218),
(1893, 170, -142, -195),
(1894, 170, -296, -158),
(1895, 170, -302, -135),
(1896, 170, -114, 523),
(1897, 170, -118, 533),
(1898, 170, -116, 566),
(1899, 170, -134, 562),
(1900, 170, -132, 541),
(1901, 170, -149, 470),
(1902, 170, -215, 228),
(1903, 170, -310, 8),
(1904, 170, -327, -142),
(1905, 170, -248, -287),
(1906, 170, 34, -559),
(1907, 171, -302, -136),
(1908, 171, 77, -203),
(1909, 171, 141, -203),
(1910, 171, 158, -188),
(1911, 171, 175, -202),
(1912, 171, 191, -202),
(1913, 171, 191, -154),
(1914, 171, 206, -154),
(1915, 171, 206, -166),
(1916, 171, 222, -166),
(1917, 171, 222, -202),
(1918, 171, 242, -202),
(1919, 171, 257, -188),
(1920, 171, 273, -200),
(1921, 171, 326, -200),
(1922, 171, 326, -261),
(1923, 171, 275, -261),
(1924, 171, 243, -222),
(1925, 171, 173, -222),
(1926, 171, 173, -277),
(1927, 171, 197, -295),
(1928, 171, 197, -328),
(1929, 171, 206, -347),
(1930, 171, 21, -347),
(1931, 171, 21, -219),
(1932, 171, -144, -196),
(1933, 171, -295, -158),
(1934, 172, 193, -276),
(1935, 172, 172, -276),
(1936, 172, 197, -294),
(1937, 172, 217, -295),
(1938, 172, 219, -318),
(1939, 172, 274, -318),
(1940, 172, 274, -259),
(1941, 172, 241, -259),
(1942, 172, 241, -289),
(1943, 172, 224, -276),
(1944, 172, 224, -223),
(1945, 172, 192, -223),
(1946, 173, 159, -187),
(1947, 173, 175, -201),
(1948, 173, 191, -201),
(1949, 173, 191, -152),
(1950, 173, 174, -152),
(1951, 173, 174, -187),
(1952, 174, 193, -37),
(1953, 174, 220, -37),
(1954, 174, 220, -81),
(1955, 174, 144, -81),
(1956, 174, 129, -64),
(1957, 174, 192, -64),
(1958, 175, 292, -78),
(1959, 175, 292, -131),
(1960, 175, 322, -131),
(1961, 175, 322, -152),
(1962, 175, 295, -152),
(1963, 175, 295, -183),
(1964, 175, 325, -199),
(1965, 175, 325, -227),
(1966, 175, 376, -209),
(1967, 175, 340, -151),
(1968, 175, 340, -134),
(1969, 175, 387, -134),
(1970, 175, 387, -61),
(1971, 175, 339, -61),
(1972, 175, 323, -78),
(1973, 176, 221, -201),
(1974, 176, 239, -201),
(1975, 176, 256, -189),
(1976, 176, 274, -152),
(1977, 176, 274, -79),
(1978, 176, 242, -79),
(1979, 176, 242, -39),
(1980, 176, 285, -39),
(1981, 176, 285, 10),
(1982, 176, 274, 41),
(1983, 176, 200, 41),
(1984, 176, 200, -11),
(1985, 176, 222, -11),
(1986, 177, 79, -148),
(1987, 177, 79, -202),
(1988, 177, 140, -202),
(1989, 177, 157, -186),
(1990, 177, 172, -186),
(1991, 177, 172, -151),
(1992, 177, 141, -151),
(1993, 177, 141, -80),
(1994, 177, 126, -63),
(1995, 178, -194, 226),
(1996, 178, -289, -127),
(1997, 178, 57, -191),
(1998, 178, 149, 64),
(1999, 178, 198, 42),
(2000, 178, 273, 42),
(2001, 178, 294, 4),
(2002, 178, 390, 4),
(2003, 178, 504, 219),
(2004, 178, 611, 297),
(2005, 178, 788, 219),
(2006, 178, 983, 387),
(2007, 178, 1034, 482),
(2008, 178, 1363, 445),
(2009, 178, 1533, 368),
(2010, 178, 1667, 377),
(2011, 178, 1672, 393),
(2012, 178, 1105, 588),
(2013, 178, 966, 513),
(2014, 178, 918, 376),
(2015, 178, 606, 314),
(2016, 178, 212, 121),
(2017, 178, -190, 245),
(2018, 179, 864, -785),
(2019, 179, 894, -826),
(2020, 179, 930, -795),
(2021, 179, 961, -810),
(2022, 179, 993, -770),
(2023, 179, 916, -739),
(2024, 180, 1267, -620),
(2025, 180, 1303, -699),
(2026, 180, 1414, -681),
(2027, 180, 1524, -601),
(2028, 180, 1493, -517),
(2029, 180, 1290, -580),
(2030, 181, 37, -664),
(2031, 181, 346, -782),
(2032, 181, 411, -577),
(2033, 181, 112, -494),
(2034, 182, 167, -1387),
(2035, 182, 154, -1405),
(2036, 182, 95, -1323),
(2037, 182, 354, -767),
(2038, 182, 465, -395),
(2039, 182, 522, -123),
(2040, 182, 505, 220),
(2041, 182, 525, 236),
(2042, 182, 552, -126),
(2043, 182, 534, -129),
(2044, 182, 531, -154),
(2045, 182, 493, -388),
(2046, 182, 480, -405),
(2047, 182, 423, -606),
(2048, 182, 320, -936),
(2049, 182, 260, -1020),
(2050, 182, 189, -1145),
(2051, 182, 149, -1255),
(2052, 182, 143, -1325),
(2053, 183, -358, 1204),
(2054, 183, -339, 1141),
(2055, 183, -310, 1141),
(2056, 183, -310, 1106),
(2057, 183, -337, 1106),
(2058, 183, -387, 1073),
(2059, 183, -387, 1203),
(2060, 184, -339, 1141),
(2061, 184, -286, 1141),
(2062, 184, -286, 1202),
(2063, 184, -357, 1202),
(2064, 185, -388, 1072),
(2065, 185, -360, 1093),
(2066, 185, -282, 1093),
(2067, 185, -282, 969),
(2068, 186, -285, 1211),
(2069, 186, -285, 1107),
(2070, 186, -283, 1094),
(2071, 186, -283, 1006),
(2072, 186, -269, 1024),
(2073, 186, -244, 1024),
(2074, 186, -244, 1054),
(2075, 186, -267, 1054),
(2076, 186, -267, 1106),
(2077, 186, -238, 1106),
(2078, 186, -238, 1186),
(2079, 186, -265, 1186),
(2080, 187, -268, 1025),
(2081, 187, -204, 1025),
(2082, 187, -204, 1009),
(2083, 187, -235, 1009),
(2084, 187, -235, 973),
(2085, 187, -282, 973),
(2086, 187, -282, 1009),
(2087, 188, -292, 825),
(2088, 188, -279, 805),
(2089, 188, -117, 835),
(2090, 188, -8, 893),
(2091, 188, 102, 901),
(2092, 188, 75, 1033),
(2093, 188, -2, 1049),
(2094, 188, -6, 1002),
(2095, 188, -162, 1004),
(2096, 188, -162, 1091),
(2097, 188, -184, 1091),
(2098, 188, -184, 1106),
(2099, 188, -157, 1106),
(2100, 188, -157, 1138),
(2101, 188, -184, 1138),
(2102, 188, -184, 1157),
(2103, 188, -159, 1157),
(2104, 188, -159, 1189),
(2105, 188, -218, 1189),
(2106, 188, -218, 1130),
(2107, 188, -204, 1130),
(2108, 188, -204, 1087),
(2109, 188, -227, 1087),
(2110, 188, -227, 1065),
(2111, 188, -220, 1026),
(2112, 188, -205, 1026),
(2113, 188, -205, 1009),
(2114, 188, -235, 1009),
(2115, 188, -235, 973),
(2116, 189, -267, 1053),
(2117, 189, -228, 1053),
(2118, 189, -228, 1087),
(2119, 189, -204, 1087),
(2120, 189, -204, 1106),
(2121, 189, -266, 1106),
(2122, 190, 481, -403),
(2123, 190, 461, -474),
(2124, 190, 651, -474),
(2125, 190, 651, -405),
(2126, 191, -16, -1525),
(2127, 191, -88, -1514),
(2128, 191, -243, -1665),
(2129, 191, -327, -2024),
(2130, 191, -312, -2104),
(2131, 191, -393, -2186),
(2132, 191, -637, -2135),
(2133, 191, -784, -2454),
(2134, 191, -1148, -2547),
(2135, 191, -1082, -2130),
(2136, 191, -932, -1911),
(2137, 191, -994, -1915),
(2138, 191, -1121, -2158),
(2139, 191, -1189, -2393),
(2140, 191, -1204, -2518),
(2141, 191, -1050, -2660),
(2142, 191, -773, -2533),
(2143, 191, -245, -2078),
(2144, 191, -272, -1868),
(2145, 191, 43, -1552),
(2146, 192, -2134, -2521),
(2147, 192, -2122, -2596),
(2148, 192, -2024, -2574),
(2149, 192, -2018, -2517),
(2150, 192, -2086, -2469),
(2151, 192, -2095, -2480),
(2152, 192, -2116, -2461),
(2153, 192, -2153, -2505),
(2154, 193, -2173, -2460),
(2155, 193, -2157, -2474),
(2156, 193, -2170, -2495),
(2157, 193, -2136, -2520),
(2158, 193, -2122, -2595),
(2159, 193, -2221, -2518),
(2160, 194, -2226, -2448),
(2161, 194, -2203, -2467),
(2162, 194, -2189, -2448),
(2163, 194, -2208, -2433),
(2164, 194, -2178, -2397),
(2165, 194, -2222, -2360),
(2166, 194, -2314, -2464),
(2167, 195, -2144, -2170),
(2168, 195, -2142, -2242),
(2169, 195, -2085, -2290),
(2170, 195, -1996, -2295),
(2171, 196, -2142, -2217),
(2172, 196, -2143, -2244),
(2173, 196, -2178, -2287),
(2174, 196, -2191, -2275),
(2175, 197, -2173, -2462),
(2176, 197, -2158, -2473),
(2177, 197, -2170, -2494),
(2178, 197, -2154, -2507),
(2179, 197, -2109, -2452),
(2180, 197, -2123, -2441),
(2181, 197, -2133, -2451),
(2182, 197, -2153, -2435),
(2183, 198, -2094, -2327),
(2184, 198, -2081, -2337),
(2185, 198, -1998, -2295),
(2186, 198, -2086, -2289),
(2187, 198, -2110, -2318),
(2188, 198, -2130, -2302),
(2189, 198, -2140, -2316),
(2190, 198, -2106, -2342),
(2191, 199, -2250, -2615),
(2192, 199, -2200, -2535),
(2193, 199, -2222, -2518),
(2194, 199, -2152, -2436),
(2195, 199, -2134, -2450),
(2196, 199, -2123, -2440),
(2197, 199, -2144, -2422),
(2198, 199, -2132, -2408),
(2199, 199, -2115, -2422),
(2200, 199, -2068, -2361),
(2201, 199, -2134, -2357),
(2202, 199, -2147, -2373),
(2203, 199, -2135, -2383),
(2204, 199, -2156, -2410),
(2205, 199, -2165, -2402),
(2206, 199, -2186, -2424),
(2207, 199, -2195, -2416),
(2208, 199, -2209, -2433),
(2209, 199, -2188, -2449),
(2210, 199, -2302, -2592),
(2211, 200, -2144, -2422),
(2212, 200, -2110, -2451),
(2213, 200, -2117, -2461),
(2214, 200, -2095, -2480),
(2215, 200, -2086, -2470),
(2216, 200, -2018, -2516),
(2217, 200, -2014, -2552),
(2218, 200, -1939, -2590),
(2219, 200, -1923, -2584),
(2220, 200, -1950, -2560),
(2221, 200, -1961, -2545),
(2222, 200, -1898, -2427),
(2223, 200, -2037, -2322),
(2224, 200, -2063, -2348),
(2225, 200, -2077, -2402),
(2226, 200, -2100, -2402),
(2227, 200, -2115, -2420),
(2228, 200, -2132, -2408),
(2229, 201, -2184, -2313),
(2230, 201, -2170, -2315),
(2231, 201, -2142, -2339),
(2232, 201, -2164, -2363),
(2233, 201, -2149, -2374);
INSERT INTO `street_pos` (`id`, `StreetID`, `StreetX`, `StreetY`) VALUES
(2234, 201, -2135, -2358),
(2235, 201, -2069, -2361),
(2236, 201, -2083, -2336),
(2237, 201, -2094, -2327),
(2238, 201, -2106, -2340),
(2239, 201, -2140, -2317),
(2240, 201, -2190, -2275),
(2241, 201, -2174, -2256),
(2242, 201, -2242, -2205),
(2243, 201, -2306, -2240),
(2244, 201, -2203, -2323),
(2245, 201, -2187, -2303),
(2246, 202, -2240, -2295),
(2247, 202, -2314, -2355),
(2248, 202, -2166, -2363),
(2249, 202, -2142, -2339),
(2250, 202, -2173, -2311),
(2251, 202, -2186, -2313),
(2252, 202, -2186, -2303),
(2253, 202, -2203, -2322),
(2254, 203, -933, -1913),
(2255, 203, -1172, -1918),
(2256, 203, -1367, -1675),
(2257, 203, -1737, -1691),
(2258, 203, -2072, -2034),
(2259, 203, -2164, -2175),
(2260, 203, -2242, -2205),
(2261, 203, -2417, -2303),
(2262, 203, -2442, -2300),
(2263, 203, -2477, -2307),
(2264, 203, -2479, -2295),
(2265, 203, -2420, -2279),
(2266, 203, -2491, -2151),
(2267, 203, -2243, -2148),
(2268, 203, -2077, -1951),
(2269, 203, -1885, -1523),
(2270, 203, -1724, -1647),
(2271, 203, -1603, -1597),
(2272, 203, -1498, -1602),
(2273, 203, -1306, -1673),
(2274, 203, -1130, -1854),
(2275, 203, -898, -1878),
(2276, 203, -779, -1695),
(2277, 203, -776, -1266),
(2278, 203, -601, -1169),
(2279, 203, -584, -1184),
(2280, 203, -535, -1496),
(2281, 203, -703, -1841),
(2282, 204, 1379, 219),
(2283, 204, 1451, 194),
(2284, 204, 1482, 275),
(2285, 204, 1426, 297),
(2286, 204, 1414, 281),
(2287, 204, 1400, 272),
(2288, 205, 1400, 272),
(2289, 205, 1325, 302),
(2290, 205, 1305, 253),
(2291, 205, 1380, 219),
(2292, 206, 1427, 298),
(2293, 206, 1414, 281),
(2294, 206, 1400, 271),
(2295, 206, 1326, 301),
(2296, 206, 1334, 318),
(2297, 206, 1350, 310),
(2298, 206, 1362, 329),
(2299, 207, 1305, 255),
(2300, 207, 1286, 212),
(2301, 207, 1499, 104),
(2302, 207, 1545, 121),
(2303, 207, 1506, 172),
(2304, 207, 1379, 219),
(2305, 208, 1262, 253),
(2306, 208, 1241, 204),
(2307, 208, 1257, 198),
(2308, 208, 1230, 120),
(2309, 208, 1134, 159),
(2310, 208, 1196, 281),
(2311, 209, 1264, 346),
(2312, 209, 1290, 334),
(2313, 209, 1300, 353),
(2314, 209, 1319, 343),
(2315, 209, 1346, 400),
(2316, 209, 1301, 418),
(2317, 209, 1245, 382),
(2318, 209, 1262, 374),
(2319, 209, 1270, 361),
(2320, 210, 1287, -78),
(2321, 210, 1303, -62),
(2322, 210, 1331, 190),
(2323, 210, 1286, 212),
(2324, 210, 1333, 318),
(2325, 210, 1347, 312),
(2326, 210, 1363, 330),
(2327, 210, 1417, 304),
(2328, 210, 1531, 358),
(2329, 210, 1531, 369),
(2330, 210, 1363, 445),
(2331, 210, 1318, 345),
(2332, 210, 1300, 353),
(2333, 210, 1291, 333),
(2334, 210, 1311, 323),
(2335, 210, 1305, 310),
(2336, 210, 1290, 317),
(2337, 210, 1283, 302),
(2338, 210, 1267, 309),
(2339, 210, 1251, 278),
(2340, 210, 1282, 264),
(2341, 210, 1279, 250),
(2342, 210, 1263, 254),
(2343, 210, 1241, 206),
(2344, 210, 1256, 199),
(2345, 210, 1229, 120),
(2346, 210, 1215, -18),
(2347, 211, -295, 1254),
(2348, 211, 42, 1277),
(2349, 211, 202, 1185),
(2350, 211, 183, 1154),
(2351, 211, 180, 1129),
(2352, 211, 124, 1175),
(2353, 211, 94, 1219),
(2354, 211, 13, 1251),
(2355, 211, -125, 1247),
(2356, 211, -196, 1233),
(2357, 211, -376, 1232),
(2358, 212, -1636, 2719),
(2359, 212, -1466, 2722),
(2360, 212, -1353, 2640),
(2361, 212, -1338, 2649),
(2362, 212, -1422, 2739),
(2363, 212, -1766, 2745),
(2364, 212, -1821, 2683),
(2365, 212, -1926, 2511),
(2366, 212, -1918, 2492),
(2367, 212, -1765, 2583),
(2368, 213, -1635, 2720),
(2369, 213, -1617, 2666),
(2370, 213, -1563, 2592),
(2371, 213, -1575, 2418),
(2372, 213, -1730, 2224),
(2373, 213, -1747, 2234),
(2374, 213, -1678, 2603),
(2375, 214, -344, -774),
(2376, 214, -353, -793),
(2377, 214, -303, -867),
(2378, 214, -288, -874),
(2379, 214, -268, -800),
(2380, 215, 674, -684),
(2381, 215, 581, -686),
(2382, 215, 622, -894),
(2383, 215, 642, -888),
(2384, 216, 2303, -1904),
(2385, 216, 2303, -1966),
(2386, 216, 2322, -1965),
(2387, 216, 2322, -1945),
(2388, 216, 2344, -1945),
(2389, 216, 2345, -1879),
(2390, 216, 2322, -1874),
(2391, 216, 2324, -1887),
(2392, 217, -1829, -593),
(2393, 217, -1809, -593),
(2394, 217, -1783, -803),
(2395, 217, -1635, -792),
(2396, 217, -1512, -1219),
(2397, 217, -1126, -1324),
(2398, 217, -943, -1395),
(2399, 217, -864, -990),
(2400, 217, -413, -813),
(2401, 217, -306, -866),
(2402, 217, -151, -939),
(2403, 217, -138, -966),
(2404, 217, -111, -999),
(2405, 217, 2, -1008),
(2406, 217, -43, -1277),
(2407, 217, -141, -1288),
(2408, 217, -146, -1377),
(2409, 217, -134, -1431),
(2410, 217, -146, -1442),
(2411, 217, -176, -1303),
(2412, 217, -92, -1065),
(2413, 217, -296, -884),
(2414, 217, -398, -838),
(2415, 217, -632, -1015),
(2416, 217, -878, -1170),
(2417, 217, -895, -1397),
(2418, 217, -811, -1588),
(2419, 217, -957, -1759),
(2420, 217, -1476, -1599),
(2421, 217, -1646, -1368),
(2422, 217, -1829, -1023),
(2423, 218, -937, -229),
(2424, 218, -277, -239),
(2425, 218, -233, -306),
(2426, 218, -939, -255),
(2427, 219, 250, 1223),
(2428, 219, 203, 1186),
(2429, 219, 182, 1154),
(2430, 219, 180, 1130),
(2431, 219, 73, 1134),
(2432, 219, 93, 979),
(2433, 219, 218, 974),
(2434, 219, 347, 691),
(2435, 219, 617, 321),
(2436, 219, 638, 331),
(2437, 219, 332, 750),
(2438, 219, 227, 982),
(2439, 219, 268, 1218),
(2440, 220, -302, 1232),
(2441, 220, -265, 1186),
(2442, 220, -238, 1190),
(2443, 220, -160, 1189),
(2444, 220, -159, 1157),
(2445, 220, -125, 1157),
(2446, 220, -125, 1191),
(2447, 220, -107, 1191),
(2448, 220, -107, 1157),
(2449, 220, -74, 1157),
(2450, 220, -74, 1190),
(2451, 220, -61, 1190),
(2452, 220, -61, 1155),
(2453, 220, 110, 1150),
(2454, 220, 110, 1192),
(2455, 220, 94, 1217),
(2456, 220, 14, 1250),
(2457, 220, -111, 1247),
(2458, 220, -110, 1205),
(2459, 220, -125, 1205),
(2460, 220, -128, 1247),
(2461, 220, -193, 1233),
(2462, 221, -185, 1140),
(2463, 221, -157, 1137),
(2464, 221, -157, 1107),
(2465, 221, -107, 1105),
(2466, 221, -108, 1190),
(2467, 221, -125, 1190),
(2468, 221, -126, 1157),
(2469, 221, -184, 1157),
(2470, 222, -74, 1190),
(2471, 222, -75, 1158),
(2472, 222, -107, 1158),
(2473, 222, -107, 1138),
(2474, 222, -73, 1138),
(2475, 222, -72, 1002),
(2476, 222, -7, 1002),
(2477, 222, -1, 1063),
(2478, 222, 23, 1064),
(2479, 222, 21, 1090),
(2480, 222, -21, 1090),
(2481, 222, -21, 1058),
(2482, 222, -58, 1058),
(2483, 222, -61, 1190),
(2484, 223, 227, 983),
(2485, 223, 236, 963),
(2486, 223, 321, 825),
(2487, 223, 545, 714),
(2488, 223, 813, 705),
(2489, 223, 960, 966),
(2490, 223, 806, 2345),
(2491, 223, 758, 2335),
(2492, 223, 735, 2341),
(2493, 223, 806, 2091),
(2494, 223, 803, 1912),
(2495, 223, 762, 1907),
(2496, 223, 760, 1858),
(2497, 223, 802, 1830),
(2498, 223, 810, 1762),
(2499, 223, 759, 1664),
(2500, 223, 751, 1360),
(2501, 223, 491, 1211),
(2502, 223, 268, 1182),
(2503, 224, -1491, 2545),
(2504, 224, -1412, 2545),
(2505, 224, -1384, 2607),
(2506, 224, -1436, 2607),
(2507, 224, -1436, 2631),
(2508, 224, -1476, 2645),
(2509, 224, -1475, 2607),
(2510, 224, -1489, 2607),
(2511, 225, -1522, 2665),
(2512, 225, -1478, 2665),
(2513, 225, -1476, 2606),
(2514, 225, -1492, 2606),
(2515, 225, -1492, 2545),
(2516, 225, -1506, 2579),
(2517, 225, -1506, 2633),
(2518, 225, -1521, 2633),
(2519, 226, -1617, 2665),
(2520, 226, -1479, 2665),
(2521, 226, -1477, 2645),
(2522, 226, -1437, 2631),
(2523, 226, -1437, 2607),
(2524, 226, -1384, 2608),
(2525, 226, -1379, 2658),
(2526, 226, -1466, 2721),
(2527, 226, -1633, 2717),
(2528, 227, -365, 1652),
(2529, 227, -191, 1562),
(2530, 227, -216, 1376),
(2531, 227, -294, 1293),
(2532, 227, -334, 1293),
(2533, 227, -431, 1441),
(2534, 227, -392, 1635),
(2535, 228, -802, 1574),
(2536, 228, -767, 1571),
(2537, 228, -769, 1511),
(2538, 228, -817, 1522),
(2539, 228, -838, 1571),
(2540, 228, -845, 1463),
(2541, 228, -747, 1463),
(2542, 228, -749, 1545),
(2543, 228, -707, 1619),
(2544, 228, -738, 1657),
(2545, 228, -810, 1628),
(2546, 228, -790, 1594),
(2547, 229, -854, 1623),
(2548, 229, -811, 1628),
(2549, 229, -791, 1594),
(2550, 229, -802, 1574),
(2551, 229, -769, 1571),
(2552, 229, -770, 1512),
(2553, 229, -818, 1523),
(2554, 229, -838, 1573),
(2555, 229, -838, 1595),
(2556, 230, -721, 1040),
(2557, 230, -736, 802),
(2558, 230, -767, 727),
(2559, 230, -752, 718),
(2560, 230, -652, 877),
(2561, 230, -582, 1108),
(2562, 231, -839, 1008),
(2563, 231, -839, 992),
(2564, 231, -728, 965),
(2565, 231, -724, 1023),
(2566, 232, -789, 2721),
(2567, 232, -721, 2522),
(2568, 232, -562, 2406),
(2569, 232, -331, 2468),
(2570, 232, -286, 2507),
(2571, 232, -96, 2410),
(2572, 232, -54, 2295),
(2573, 232, 321, 2273),
(2574, 232, 429, 2363),
(2575, 232, 541, 2285),
(2576, 232, 597, 1941),
(2577, 232, 514, 1703),
(2578, 232, 552, 1720),
(2579, 232, 630, 1931),
(2580, 232, 581, 2373),
(2581, 232, 319, 2709),
(2582, 232, -155, 2565),
(2583, 232, -341, 2519),
(2584, 232, -422, 2460),
(2585, 232, -597, 2446),
(2586, 232, -692, 2722),
(2587, 233, -666, 2681),
(2588, 233, -590, 2465),
(2589, 233, -420, 2472),
(2590, 233, -326, 2526),
(2591, 233, -398, 2684),
(2592, 234, -114, 647),
(2593, 234, -117, 601),
(2594, 234, -146, 593),
(2595, 234, -470, 621),
(2596, 234, -751, 719),
(2597, 234, -768, 727),
(2598, 234, -839, 993),
(2599, 234, -840, 1009),
(2600, 234, -851, 1052),
(2601, 234, -868, 1040),
(2602, 234, -858, 1005),
(2603, 234, -855, 988),
(2604, 234, -913, 1009),
(2605, 234, -931, 993),
(2606, 234, -877, 705),
(2607, 234, -479, 565),
(2608, 234, -148, 501),
(2609, 234, -135, 561),
(2610, 234, -117, 565),
(2611, 234, -88, 532),
(2612, 234, 346, 692),
(2613, 234, 298, 795),
(2614, 235, -396, 1745),
(2615, 235, -370, 1753),
(2616, 235, -361, 1901),
(2617, 235, -242, 1899),
(2618, 235, -289, 1720),
(2619, 235, -397, 1727),
(2620, 236, 2385, -2164),
(2621, 236, 2418, -2152),
(2622, 236, 2541, -2142),
(2623, 236, 2622, -2143),
(2624, 236, 2707, -2146),
(2625, 236, 2742, -2146),
(2626, 236, 2771, -2132),
(2627, 236, 2796, -2107),
(2628, 236, 2810, -2083),
(2629, 236, 2815, -2055),
(2630, 236, 2815, -1838),
(2631, 236, 2830, -1719),
(2632, 236, 2896, -1490),
(2633, 236, 2850, -1115),
(2634, 236, 2857, -884),
(2635, 236, 2855, -571),
(2636, 236, 2783, -459),
(2637, 236, 2661, -303),
(2638, 236, 2753, 35),
(2639, 236, 2751, 55),
(2640, 236, 2713, 255),
(2641, 236, 2510, 285),
(2642, 236, 2331, 276),
(2643, 236, 2183, 305),
(2644, 236, 2031, 290),
(2645, 236, 1826, 250),
(2646, 236, 1686, 237),
(2647, 236, 1666, 268),
(2648, 236, 1678, 302),
(2649, 236, 1710, 320),
(2650, 236, 2030, 329),
(2651, 236, 2251, 331),
(2652, 236, 2267, 406),
(2653, 236, 2419, 408),
(2654, 236, 2424, 337),
(2655, 236, 2733, 339),
(2656, 236, 2791, 181),
(2657, 236, 2778, 54),
(2658, 236, 2778, 35),
(2659, 236, 2798, -114),
(2660, 236, 2729, -282),
(2661, 236, 2887, -518),
(2662, 236, 2923, -602),
(2663, 236, 2913, -1118),
(2664, 236, 2957, -1450),
(2665, 236, 2883, -1735),
(2666, 236, 2865, -1980),
(2667, 236, 2864, -2058),
(2668, 236, 2847, -2060),
(2669, 236, 2837, -2105),
(2670, 236, 2805, -2151),
(2671, 236, 2756, -2177),
(2672, 236, 2653, -2183),
(2673, 236, 2440, -2183),
(2674, 236, 2412, -2193),
(2675, 237, 1269, -2190),
(2676, 237, 1249, -2217),
(2677, 237, 1257, -2259),
(2678, 237, 1291, -2277),
(2679, 237, 1324, -2270),
(2680, 237, 1324, -2205),
(2681, 237, 1353, -2204),
(2682, 237, 1354, -2371),
(2683, 237, 1323, -2369),
(2684, 237, 1322, -2306),
(2685, 237, 1292, -2295),
(2686, 237, 1259, -2314),
(2687, 237, 1251, -2350),
(2688, 237, 1270, -2382),
(2689, 237, 1296, -2388),
(2690, 237, 1804, -2388),
(2691, 237, 1834, -2379),
(2692, 237, 1849, -2351),
(2693, 237, 1848, -2220),
(2694, 237, 1836, -2200),
(2695, 237, 1807, -2186),
(2696, 237, 1289, -2185),
(2697, 238, 1804, -2177),
(2698, 238, 1805, -2185),
(2699, 238, 1848, -2205),
(2700, 238, 1849, -2376),
(2701, 238, 1804, -2388),
(2702, 238, 1365, -2388),
(2703, 238, 1362, -2586),
(2704, 238, 1428, -2658),
(2705, 238, 1929, -2660),
(2706, 238, 2061, -2663),
(2707, 238, 2122, -2638),
(2708, 238, 2148, -2581),
(2709, 238, 2150, -2428),
(2710, 238, 2171, -2370),
(2711, 238, 2130, -2336),
(2712, 238, 2090, -2331),
(2713, 238, 2092, -2257),
(2714, 238, 2125, -2221),
(2715, 238, 2089, -2189),
(2716, 238, 2044, -2176),
(2717, 239, 2112, -2314),
(2718, 239, 2145, -2321),
(2719, 239, 2187, -2355),
(2720, 239, 2364, -2174),
(2721, 239, 2281, -2092),
(2722, 239, 2111, -2270),
(2723, 240, 2270, -2079),
(2724, 240, 2281, -2091),
(2725, 240, 2113, -2269),
(2726, 240, 2111, -2313),
(2727, 240, 2146, -2320),
(2728, 240, 2187, -2354),
(2729, 240, 2171, -2371),
(2730, 240, 2129, -2336),
(2731, 240, 2089, -2330),
(2732, 240, 2091, -2258),
(2733, 241, 2061, -2693),
(2734, 241, 2061, -2705),
(2735, 241, 2275, -2707),
(2736, 241, 2281, -2529),
(2737, 241, 2332, -2364),
(2738, 241, 2442, -2253),
(2739, 241, 2390, -2200),
(2740, 241, 2228, -2358),
(2741, 241, 2189, -2420),
(2742, 241, 2183, -2613),
(2743, 241, 2119, -2692),
(2744, 242, 2404, -2435),
(2745, 242, 2373, -2469),
(2746, 242, 2375, -2496),
(2747, 242, 2470, -2495),
(2748, 242, 2562, -2459),
(2749, 242, 2587, -2474),
(2750, 242, 2643, -2473),
(2751, 242, 2642, -2458),
(2752, 242, 2609, -2457),
(2753, 242, 2608, -2413),
(2754, 242, 2513, -2327),
(2755, 242, 2419, -2418),
(2756, 242, 2349, -2348),
(2757, 242, 2331, -2363),
(2758, 243, 2276, -2672),
(2759, 243, 2378, -2673),
(2760, 243, 2376, -2695),
(2761, 243, 2453, -2723),
(2762, 243, 2525, -2696),
(2763, 243, 2564, -2567),
(2764, 243, 2750, -2584),
(2765, 243, 2818, -2575),
(2766, 243, 2814, -2328),
(2767, 243, 2702, -2302),
(2768, 243, 2541, -2322),
(2769, 243, 2597, -2379),
(2770, 243, 2587, -2392),
(2771, 243, 2608, -2411),
(2772, 243, 2610, -2455),
(2773, 243, 2642, -2457),
(2774, 243, 2643, -2473),
(2775, 243, 2588, -2474),
(2776, 243, 2563, -2460),
(2777, 243, 2470, -2495),
(2778, 243, 2359, -2496),
(2779, 243, 2360, -2550),
(2780, 243, 2374, -2652),
(2781, 243, 2277, -2650),
(2782, 244, 770, 2649),
(2783, 244, 638, 2606),
(2784, 244, 609, 2437),
(2785, 244, 648, 2075),
(2786, 244, 659, 2114),
(2787, 244, 672, 2074),
(2788, 244, 686, 2284),
(2789, 244, 711, 2347),
(2790, 244, 755, 2335),
(2791, 244, 805, 2345),
(2792, 244, 893, 2397),
(2793, 244, 855, 2521),
(2794, 244, 839, 2508),
(2795, 244, 754, 2350),
(2796, 244, 736, 2352),
(2797, 244, 713, 2363),
(2798, 244, 728, 2479),
(2799, 244, 820, 2665),
(2800, 244, 428, 2690),
(2801, 244, 412, 2688),
(2802, 244, 419, 2649),
(2803, 245, -250, 2741),
(2804, 245, -250, 2645),
(2805, 245, -197, 2645),
(2806, 245, -197, 2741),
(2807, 246, -335, 2762),
(2808, 246, -290, 2711),
(2809, 246, -266, 2709),
(2810, 246, -264, 2645),
(2811, 246, -251, 2646),
(2812, 246, -250, 2741),
(2813, 246, -198, 2741),
(2814, 246, -197, 2645),
(2815, 246, -179, 2645),
(2816, 246, -80, 2679),
(2817, 246, -222, 2849),
(2818, 247, -2609, 2340),
(2819, 247, -2609, 2324),
(2820, 247, -2550, 2325),
(2821, 247, -2545, 2295),
(2822, 247, -2474, 2295),
(2823, 247, -2474, 2321),
(2824, 247, -2428, 2320),
(2825, 247, -2310, 2283),
(2826, 247, -2326, 2380),
(2827, 247, -2362, 2400),
(2828, 247, -2377, 2382),
(2829, 247, -2460, 2363),
(2830, 247, -2459, 2338),
(2831, 247, -2471, 2338),
(2832, 247, -2486, 2371),
(2833, 247, -2550, 2371),
(2834, 247, -2553, 2340),
(2835, 248, -2553, 2341),
(2836, 248, -2573, 2342),
(2837, 248, -2563, 2384),
(2838, 248, -2521, 2423),
(2839, 248, -2498, 2435),
(2840, 248, -2568, 2539),
(2841, 248, -2342, 2572),
(2842, 248, -2166, 2417),
(2843, 248, -2204, 2269),
(2844, 248, -2298, 2219),
(2845, 248, -2326, 2381),
(2846, 248, -2362, 2401),
(2847, 248, -2377, 2383),
(2848, 248, -2434, 2369),
(2849, 248, -2471, 2427),
(2850, 248, -2508, 2411),
(2851, 248, -2516, 2371),
(2852, 248, -2550, 2371),
(2853, 249, -2522, 2423),
(2854, 249, -2630, 2454),
(2855, 249, -2658, 2278),
(2856, 249, -2621, 2242),
(2857, 249, -2584, 2241),
(2858, 249, -2609, 2325),
(2859, 249, -2609, 2340),
(2860, 249, -2574, 2342),
(2861, 249, -2563, 2383),
(2862, 250, -2514, 2372),
(2863, 250, -2486, 2372),
(2864, 250, -2471, 2339),
(2865, 250, -2460, 2339),
(2866, 250, -2459, 2363),
(2867, 250, -2435, 2371),
(2868, 250, -2471, 2427),
(2869, 250, -2508, 2412),
(2870, 251, 659, 1825),
(2871, 251, 701, 1817),
(2872, 251, 707, 1852),
(2873, 251, 735, 1845),
(2874, 251, 726, 1791),
(2875, 251, 654, 1805),
(2876, 252, 708, 1864),
(2877, 252, 708, 1931),
(2878, 252, 673, 1933),
(2879, 252, 676, 2006),
(2880, 252, 731, 2005),
(2881, 252, 733, 1933),
(2882, 252, 720, 1929),
(2883, 252, 717, 1862),
(2884, 253, 669, 1923),
(2885, 253, 707, 1922),
(2886, 253, 705, 1908),
(2887, 253, 668, 1907),
(2888, 254, 662, 1870),
(2889, 254, 736, 1858),
(2890, 254, 737, 1846),
(2891, 254, 708, 1851),
(2892, 254, 698, 1817),
(2893, 254, 658, 1826),
(2894, 255, -1249, -897),
(2895, 255, -1214, -1129),
(2896, 255, -1082, -1338),
(2897, 255, -1023, -1362),
(2898, 255, -985, -902),
(2899, 256, 148, 64),
(2900, 256, 124, -64),
(2901, 256, 191, -63),
(2902, 256, 192, -36),
(2903, 256, 220, -36),
(2904, 256, 220, -11),
(2905, 256, 198, -10),
(2906, 256, 197, 41),
(2907, 257, 1951, -1762),
(2908, 257, 1967, -1762),
(2909, 257, 1971, -1925),
(2910, 257, 1951, -1924),
(2911, 258, -80, 1268),
(2912, 258, -114, 1383),
(2913, 258, -127, 1682),
(2914, 258, -195, 2084),
(2915, 258, 170, 2167),
(2916, 258, 466, 2118),
(2917, 258, 431, 1715),
(2918, 258, -99, 1601),
(2919, 258, 61, 1392),
(2920, 258, 49, 1319),
(2921, 258, -58, 1312),
(2922, 258, -63, 1271),
(2923, 259, 1618, -1379),
(2924, 259, 1621, -1431),
(2925, 259, 1651, -1471),
(2926, 259, 1620, -1481),
(2927, 259, 1618, -1503),
(2928, 259, 1648, -1493),
(2929, 259, 1676, -1489),
(2930, 259, 1742, -1509),
(2931, 259, 1707, -1519),
(2932, 259, 1681, -1534),
(2933, 259, 1651, -1529),
(2934, 259, 1620, -1517),
(2935, 259, 1620, -1542),
(2936, 259, 1653, -1550),
(2937, 259, 1618, -1600),
(2938, 259, 1623, -1628),
(2939, 259, 1659, -1575),
(2940, 259, 1703, -1540),
(2941, 259, 1745, -1528),
(2942, 259, 1824, -1526),
(2943, 259, 1838, -1496),
(2944, 259, 1837, -1482),
(2945, 259, 1748, -1459),
(2946, 259, 1790, -1492),
(2947, 259, 1746, -1488),
(2948, 259, 1689, -1471),
(2949, 259, 1668, -1456),
(2950, 260, 2090, -1864),
(2951, 260, 2193, -1863),
(2952, 260, 2193, -1888),
(2953, 260, 2227, -1888),
(2954, 260, 2228, -1862),
(2955, 260, 2321, -1873),
(2956, 260, 2323, -1888),
(2957, 260, 2302, -1905),
(2958, 260, 2301, -1941),
(2959, 260, 2223, -1939),
(2960, 260, 2223, -1899),
(2961, 260, 2203, -1899),
(2962, 260, 2202, -1943),
(2963, 260, 2179, -1949),
(2964, 260, 2090, -1948),
(2965, 261, 274, -78),
(2966, 261, 290, -78),
(2967, 261, 292, -131),
(2968, 261, 320, -131),
(2969, 261, 322, -151),
(2970, 261, 295, -152),
(2971, 261, 295, -182),
(2972, 261, 322, -199),
(2973, 261, 273, -199),
(2974, 261, 258, -188),
(2975, 261, 274, -152),
(2976, 262, 225, -222),
(2977, 262, 243, -222),
(2978, 262, 271, -257),
(2979, 262, 241, -259),
(2980, 262, 239, -288),
(2981, 262, 222, -274),
(2982, 263, 1320, -1725),
(2983, 263, 1319, -1741),
(2984, 263, 1335, -1742),
(2985, 263, 1336, -1770),
(2986, 263, 1378, -1770),
(2987, 263, 1379, -1742),
(2988, 263, 1398, -1743),
(2989, 263, 1398, -1837),
(2990, 263, 1557, -1836),
(2991, 263, 1559, -1742),
(2992, 263, 1578, -1742),
(2993, 263, 1579, -1770),
(2994, 263, 1593, -1775),
(2995, 263, 1588, -1740),
(2996, 263, 1586, -1724),
(2997, 264, 1622, -1725),
(2998, 264, 1628, -1753),
(2999, 264, 1679, -1763),
(3000, 264, 1680, -1723),
(3001, 265, -349, -2138),
(3002, 265, -315, -2104),
(3003, 265, -334, -1972),
(3004, 265, -262, -1673),
(3005, 265, -123, -1480),
(3006, 265, -113, -1472),
(3007, 265, -62, -1503),
(3008, 265, 10, -1511),
(3009, 265, 17, -1422),
(3010, 265, -1, -1375),
(3011, 265, 105, -1286),
(3012, 265, 78, -1247),
(3013, 265, -28, -1334),
(3014, 265, -75, -1280),
(3015, 265, -140, -1289),
(3016, 265, -145, -1376),
(3017, 265, -133, -1428),
(3018, 265, -146, -1440),
(3019, 265, -300, -1616),
(3020, 265, -375, -1866),
(3021, 265, -391, -1932),
(3022, 266, 153, -1243),
(3023, 266, 195, -1184),
(3024, 266, 316, -1106),
(3025, 266, 295, -1074),
(3026, 266, 332, -1036),
(3027, 266, 368, -1025),
(3028, 266, 466, -1022),
(3029, 266, 650, -906),
(3030, 266, 719, -823),
(3031, 266, 774, -812),
(3032, 266, 790, -872),
(3033, 266, 814, -833),
(3034, 266, 846, -865),
(3035, 266, 892, -824),
(3036, 266, 863, -783),
(3037, 266, 916, -739),
(3038, 266, 1138, -693),
(3039, 266, 1164, -638),
(3040, 266, 1266, -622),
(3041, 266, 1289, -579),
(3042, 266, 1618, -485),
(3043, 266, 1635, -465),
(3044, 266, 1552, -411),
(3045, 266, 1442, -403),
(3046, 266, 1274, -532),
(3047, 266, 1222, -615),
(3048, 266, 1162, -625),
(3049, 266, 1077, -601),
(3050, 266, 962, -631),
(3051, 266, 882, -642),
(3052, 266, 845, -720),
(3053, 266, 784, -744),
(3054, 266, 766, -791),
(3055, 266, 725, -797),
(3056, 266, 699, -814),
(3057, 266, 668, -859),
(3058, 266, 643, -888),
(3059, 266, 621, -893),
(3060, 266, 499, -884),
(3061, 266, 486, -986),
(3062, 266, 305, -1017),
(3063, 266, 281, -1057),
(3064, 266, 198, -1128),
(3065, 267, 471, -1019),
(3066, 267, 519, -1022),
(3067, 267, 565, -1036),
(3068, 267, 670, -978),
(3069, 267, 499, -1000),
(3070, 268, 2230, 133),
(3071, 268, 2231, 84),
(3072, 268, 2244, 70),
(3073, 268, 2271, 69),
(3074, 268, 2283, 85),
(3075, 268, 2281, 133),
(3076, 269, 660, -507),
(3077, 269, 672, -517),
(3078, 269, 662, -536),
(3079, 269, 671, -547),
(3080, 269, 671, -647),
(3081, 269, 672, -657),
(3082, 269, 674, -682),
(3083, 269, 684, -833),
(3084, 269, 698, -817),
(3085, 269, 715, -623),
(3086, 269, 705, -624),
(3087, 269, 689, -609),
(3088, 269, 691, -590),
(3089, 269, 713, -592),
(3090, 269, 713, -558),
(3091, 269, 689, -537),
(3092, 269, 688, -522),
(3093, 269, 712, -503),
(3094, 269, 688, -492),
(3095, 269, 673, -492),
(3096, 270, 1149, -934),
(3097, 270, 1165, -934),
(3098, 270, 1164, -875),
(3099, 270, 1163, -770),
(3100, 270, 1149, -771),
(3101, 270, 1144, -839),
(3102, 271, 202, -1560),
(3103, 271, 246, -1581),
(3104, 271, 254, -1558),
(3105, 271, 287, -1510),
(3106, 271, 386, -1430),
(3107, 271, 412, -1455),
(3108, 271, 429, -1443),
(3109, 271, 421, -1431),
(3110, 271, 502, -1379),
(3111, 271, 498, -1360),
(3112, 271, 516, -1349),
(3113, 271, 522, -1364),
(3114, 271, 561, -1352),
(3115, 271, 562, -1339),
(3116, 271, 619, -1327),
(3117, 271, 619, -1310),
(3118, 271, 514, -1330),
(3119, 271, 495, -1338),
(3120, 271, 486, -1327),
(3121, 271, 270, -1460),
(3122, 271, 291, -1481),
(3123, 272, 426, -1480),
(3124, 272, 438, -1505),
(3125, 272, 438, -1577),
(3126, 272, 474, -1575),
(3127, 272, 471, -1452),
(3128, 273, 434, -1603),
(3129, 273, 435, -1646),
(3130, 273, 458, -1646),
(3131, 273, 455, -1601),
(3132, 274, 1564, -2094),
(3133, 274, 1592, -2122),
(3134, 274, 1638, -2089),
(3135, 274, 1656, -2061),
(3136, 274, 1676, -2001),
(3137, 274, 1676, -1963),
(3138, 274, 1660, -1915),
(3139, 274, 1630, -1780),
(3140, 274, 1619, -1703),
(3141, 274, 1623, -1628),
(3142, 274, 1617, -1599),
(3143, 274, 1618, -1372),
(3144, 274, 1637, -1286),
(3145, 274, 1644, -1205),
(3146, 274, 1666, -1163),
(3147, 274, 1702, -1105),
(3148, 274, 1722, -1091),
(3149, 274, 1825, -1031),
(3150, 274, 1753, -1035),
(3151, 274, 1722, -1022),
(3152, 274, 1679, -983),
(3153, 274, 1726, -964),
(3154, 274, 1779, -965),
(3155, 274, 1823, -978),
(3156, 274, 1711, -765),
(3157, 274, 1730, -622),
(3158, 274, 1744, -485),
(3159, 274, 1669, -37),
(3160, 274, 1630, 125),
(3161, 274, 1684, 237),
(3162, 274, 1665, 269),
(3163, 274, 1677, 304),
(3164, 274, 1717, 324),
(3165, 274, 1707, 376),
(3166, 274, 1712, 391),
(3167, 274, 1790, 584),
(3168, 274, 1820, 822),
(3169, 274, 1772, 825),
(3170, 274, 1758, 649),
(3171, 274, 1666, 379),
(3172, 274, 1580, 372),
(3173, 274, 1546, 256),
(3174, 274, 1603, 140),
(3175, 274, 1595, 116),
(3176, 274, 1598, 38),
(3177, 274, 1649, -164),
(3178, 274, 1653, -337),
(3179, 274, 1638, -467),
(3180, 274, 1691, -627),
(3181, 274, 1580, -895),
(3182, 274, 1512, -925),
(3183, 274, 1459, -925),
(3184, 274, 1475, -947),
(3185, 274, 1638, -965),
(3186, 274, 1600, -983),
(3187, 274, 1551, -991),
(3188, 274, 1463, -973),
(3189, 274, 1493, -991),
(3190, 274, 1549, -1036),
(3191, 274, 1579, -1091),
(3192, 274, 1599, -1152),
(3193, 274, 1607, -1202),
(3194, 274, 1598, -1292),
(3195, 274, 1586, -1357),
(3196, 274, 1583, -1705),
(3197, 274, 1592, -1774),
(3198, 274, 1626, -1910),
(3199, 274, 1644, -1974),
(3200, 274, 1638, -2026),
(3201, 274, 1614, -2062),
(3202, 275, 909, -1338),
(3203, 275, 925, -1338),
(3204, 275, 925, -1387),
(3205, 275, 909, -1386),
(3206, 1, 2042, -1622),
(3207, 1, 2101, -1622),
(3208, 1, 2101, -1682),
(3209, 1, 2087, -1741),
(3210, 1, 2042, -1743),
(3211, 1, 2042, -1681),
(3212, 1, 2074, -1681),
(3213, 1, 2074, -1664),
(3214, 1, 2042, -1664),
(3215, 2, 2040, -1622),
(3216, 2, 1993, -1622),
(3217, 2, 1993, -1743),
(3218, 2, 2041, -1742),
(3219, 2, 2041, -1681),
(3220, 2, 2006, -1681),
(3221, 2, 2006, -1663),
(3222, 2, 2040, -1663),
(3223, 3, 2006, -1663),
(3224, 3, 2006, -1681),
(3225, 3, 2074, -1681),
(3226, 3, 2074, -1663),
(3227, 4, 1832, -1805),
(3228, 4, 1951, -1832),
(3229, 4, 1951, -1762),
(3230, 4, 1970, -1762),
(3231, 4, 1970, -1784),
(3232, 4, 2072, -1784),
(3233, 4, 2079, -1760),
(3234, 4, 2128, -1760),
(3235, 4, 2128, -1791),
(3236, 4, 2138, -1835),
(3237, 4, 2166, -1843),
(3238, 4, 2195, -1843),
(3239, 4, 2195, -1735),
(3240, 4, 2174, -1723),
(3241, 4, 2112, -1723),
(3242, 4, 2106, -1742),
(3243, 4, 1832, -1742),
(3244, 10, 2073, -1861),
(3245, 10, 1987, -1861),
(3246, 10, 2024, -1896),
(3247, 10, 2033, -1926),
(3248, 10, 2074, -1926),
(3249, 10, 2090, -1939),
(3250, 10, 2090, -1831),
(3251, 10, 2137, -1834),
(3252, 10, 2127, -1787),
(3253, 10, 2128, -1759),
(3254, 10, 2080, -1758),
(3255, 10, 2072, -1784),
(3256, 10, 2072, -1819),
(3257, 10, 2042, -1819),
(3258, 10, 2042, -1841),
(3259, 10, 2073, -1841),
(3260, 29, 1699, -1821),
(3261, 29, 1697, -1861),
(3262, 29, 1673, -1881),
(3263, 29, 1685, -1881),
(3264, 29, 1685, -1950),
(3265, 29, 2090, -1950),
(3266, 29, 2089, -1936),
(3267, 29, 2073, -1925),
(3268, 29, 2032, -1926),
(3269, 29, 2025, -1897),
(3270, 29, 2011, -1913),
(3271, 29, 1971, -1867),
(3272, 29, 1973, -1926),
(3273, 29, 1952, -1926),
(3274, 29, 1952, -1853),
(3275, 29, 1829, -1823),
(3276, 29, 1812, -1843),
(3277, 29, 1789, -1843),
(3278, 29, 1718, -1821),
(3279, 51, 2217, -1656),
(3280, 51, 2206, -1700),
(3281, 51, 2206, -1888),
(3282, 51, 2228, -1888),
(3283, 51, 2228, -1694),
(3284, 51, 2236, -1660),
(3285, 59, 1932, -1623),
(3286, 59, 1947, -1607),
(3287, 59, 1934, -1598),
(3288, 59, 1934, -1524),
(3289, 59, 2002, -1531),
(3290, 59, 2023, -1545),
(3291, 59, 2033, -1573),
(3292, 59, 2033, -1600),
(3293, 59, 2006, -1602),
(3294, 59, 1993, -1620),
(3295, 59, 1993, -1740),
(3296, 59, 1932, -1740),
(3297, 73, 1698, -1821),
(3298, 73, 1720, -1821),
(3299, 73, 1787, -1842),
(3300, 73, 1811, -1842),
(3301, 73, 1811, -1809),
(3302, 73, 1742, -1809),
(3303, 73, 1742, -1795),
(3304, 73, 1697, -1795),
(3305, 82, 1860, -1494),
(3306, 82, 1861, -1191),
(3307, 82, 1838, -1191),
(3308, 82, 1838, -1315),
(3309, 82, 1725, -1315),
(3310, 82, 1725, -1431),
(3311, 82, 1746, -1431),
(3312, 82, 1818, -1451),
(3313, 82, 1839, -1451),
(3314, 82, 1839, -1496),
(3315, 82, 1827, -1526),
(3316, 82, 1747, -1529),
(3317, 82, 1747, -1593),
(3318, 82, 1787, -1604),
(3319, 82, 1810, -1604),
(3320, 82, 1813, -1842),
(3321, 82, 1831, -1822),
(3322, 82, 1831, -1743),
(3323, 82, 1932, -1743),
(3324, 82, 1932, -1624),
(3325, 82, 1827, -1624),
(3326, 82, 1827, -1587),
(3327, 109, 1918, -1527),
(3328, 109, 1933, -1527),
(3329, 109, 1933, -1596),
(3330, 109, 1946, -1606),
(3331, 109, 1930, -1624),
(3332, 109, 1825, -1624),
(3333, 109, 1825, -1588),
(3334, 109, 1853, -1555),
(3335, 109, 1893, -1545),
(3336, 122, 1698, -1600),
(3337, 122, 1790, -1620),
(3338, 122, 1808, -1620),
(3339, 122, 1808, -1725),
(3340, 122, 1698, -1725),
(3341, 128, 1682, -1599),
(3342, 128, 1697, -1599),
(3343, 128, 1697, -1859),
(3344, 128, 1674, -1879),
(3345, 128, 1668, -1861),
(3346, 128, 1680, -1844),
(3347, 136, 1969, -1784),
(3348, 136, 2070, -1784),
(3349, 136, 2070, -1818),
(3350, 136, 2040, -1818),
(3351, 136, 2040, -1841),
(3352, 136, 2010, -1841),
(3353, 136, 1970, -1833),
(3354, 147, 1337, -1771),
(3355, 147, 1337, -1818),
(3356, 147, 1379, -1818),
(3357, 147, 1379, -1864),
(3358, 147, 1398, -1864),
(3359, 147, 1398, -1743),
(3360, 147, 1378, -1743),
(3361, 147, 1378, -1770),
(3362, 157, 1558, -1742),
(3363, 157, 1558, -1862),
(3364, 157, 1578, -1862),
(3365, 157, 1578, -1742),
(3366, 163, 1663, -2076),
(3367, 163, 1652, -2094),
(3368, 163, 1605, -2130),
(3369, 163, 1658, -2154),
(3370, 163, 1815, -2154),
(3371, 163, 1815, -2077),
(3372, 171, 1660, -1913),
(3373, 171, 1676, -1962),
(3374, 171, 1677, -2002),
(3375, 171, 1658, -2063),
(3376, 171, 1665, -2077),
(3377, 171, 1813, -2077),
(3378, 171, 1813, -2155),
(3379, 171, 1832, -2155),
(3380, 171, 1832, -2014),
(3381, 171, 1814, -2014),
(3382, 171, 1814, -1961),
(3383, 171, 1692, -1961),
(3384, 185, 1814, -1961),
(3385, 185, 1814, -2014),
(3386, 185, 1833, -2014),
(3387, 185, 1833, -2102),
(3388, 185, 1919, -2102),
(3389, 185, 1919, -2062),
(3390, 185, 1952, -2062),
(3391, 185, 1952, -2043),
(3392, 185, 1936, -2043),
(3393, 185, 1936, -1962),
(3394, 196, 1520, -1919),
(3395, 196, 1520, -2024),
(3396, 196, 1535, -2086),
(3397, 196, 1588, -2146),
(3398, 196, 1588, -2176),
(3399, 196, 2044, -2176),
(3400, 196, 2087, -2187),
(3401, 196, 2126, -2221),
(3402, 196, 2185, -2165),
(3403, 196, 2148, -2131),
(3404, 196, 2101, -2116),
(3405, 196, 1970, -2116),
(3406, 196, 1970, -2155),
(3407, 196, 1919, -2155),
(3408, 196, 1919, -2103),
(3409, 196, 1831, -2103),
(3410, 196, 1831, -2154),
(3411, 196, 1657, -2154),
(3412, 196, 1605, -2132),
(3413, 196, 1652, -2094),
(3414, 196, 1662, -2075),
(3415, 196, 1657, -2064),
(3416, 196, 1640, -2088),
(3417, 196, 1592, -2123),
(3418, 196, 1565, -2094),
(3419, 196, 1615, -2060),
(3420, 196, 1638, -2026),
(3421, 196, 1645, -1975),
(3422, 196, 1628, -1912),
(3423, 196, 1538, -1912),
(3424, 228, 1520, -1919),
(3425, 228, 1520, -2024),
(3426, 228, 1535, -2086),
(3427, 228, 1588, -2146),
(3428, 228, 1588, -2176),
(3429, 228, 2044, -2176),
(3430, 228, 2087, -2187),
(3431, 228, 2126, -2221),
(3432, 228, 2185, -2165),
(3433, 228, 2148, -2131),
(3434, 228, 2101, -2116),
(3435, 228, 1970, -2116),
(3436, 228, 1970, -2155),
(3437, 228, 1919, -2155),
(3438, 228, 1919, -2103),
(3439, 228, 1831, -2103),
(3440, 228, 1831, -2154),
(3441, 228, 1657, -2154),
(3442, 228, 1605, -2132),
(3443, 228, 1652, -2094),
(3444, 228, 1662, -2075),
(3445, 228, 1657, -2064),
(3446, 228, 1640, -2088),
(3447, 228, 1592, -2123),
(3448, 228, 1565, -2094),
(3449, 228, 1615, -2060),
(3450, 228, 1638, -2026),
(3451, 228, 1645, -1975),
(3452, 228, 1628, -1912),
(3453, 228, 1538, -1912),
(3454, 260, 1969, -1949),
(3455, 260, 1969, -1979),
(3456, 260, 2005, -1979),
(3457, 260, 2005, -2101),
(3458, 260, 1969, -2101),
(3459, 260, 1969, -2116),
(3460, 260, 2099, -2116),
(3461, 260, 2150, -2130),
(3462, 260, 2183, -2163),
(3463, 260, 2269, -2081),
(3464, 260, 2210, -2021),
(3465, 260, 2202, -2004),
(3466, 260, 2202, -1943),
(3467, 260, 2181, -1949),
(3468, 276, 2537, -1972),
(3469, 276, 2537, -2037),
(3470, 276, 2420, -2037),
(3471, 276, 2420, -1971),
(3472, 282, 2421, -1970),
(3473, 282, 2538, -1970),
(3474, 282, 2538, -1941),
(3475, 282, 2705, -1941),
(3476, 282, 2719, -1927),
(3477, 282, 2420, -1927),
(3478, 290, 2224, -1940),
(3479, 290, 2224, -2000),
(3480, 290, 2283, -2065),
(3481, 290, 2311, -2045),
(3482, 290, 2332, -2039),
(3483, 290, 2402, -2039),
(3484, 290, 2402, -1945),
(3485, 290, 2322, -1945),
(3486, 290, 2322, -1966),
(3487, 290, 2303, -1966),
(3488, 290, 2303, -1941),
(3489, 300, 2202, -2001),
(3490, 300, 2212, -2022),
(3491, 300, 2585, -2392),
(3492, 300, 2597, -2379),
(3493, 300, 2223, -2000),
(3494, 300, 2224, -1899),
(3495, 300, 2204, -1899),
(3496, 301, 2606, -1143),
(3497, 301, 2632, -1143),
(3498, 301, 2636, -1457),
(3499, 301, 2624, -1597),
(3500, 301, 2624, -1925),
(3501, 301, 2723, -1925),
(3502, 301, 2723, -1905),
(3503, 301, 2816, -1905),
(3504, 301, 2816, -1838),
(3505, 301, 2823, -1769),
(3506, 301, 2830, -1718),
(3507, 301, 2843, -1668),
(3508, 301, 2653, -1668),
(3509, 301, 2653, -1057),
(3510, 301, 2606, -1057),
(3511, 302, 2625, -1976),
(3512, 302, 2708, -1976),
(3513, 302, 2708, -2041),
(3514, 302, 2625, -2041),
(3515, 303, 2626, -1940),
(3516, 303, 2626, -1975),
(3517, 303, 2708, -1975),
(3518, 303, 2708, -2146),
(3519, 303, 2740, -2146),
(3520, 303, 2769, -2133),
(3521, 303, 2795, -2109),
(3522, 303, 2810, -2087),
(3523, 303, 2816, -2057),
(3524, 303, 2723, -2057),
(3525, 303, 2723, -2039),
(3526, 303, 2755, -2039),
(3527, 303, 2755, -2019),
(3528, 303, 2722, -2019),
(3529, 303, 2722, -1924),
(3530, 303, 2706, -1942),
(3531, 304, 2722, -1985),
(3532, 304, 2722, -2017),
(3533, 304, 2755, -2017),
(3534, 304, 2755, -2039),
(3535, 304, 2816, -2039),
(3536, 304, 2816, -1985),
(3537, 305, 2723, -1904),
(3538, 305, 2815, -1904),
(3539, 305, 2815, -1983),
(3540, 305, 2722, -1983),
(3541, 306, 2654, -1633),
(3542, 306, 2715, -1633),
(3543, 306, 2715, -1651),
(3544, 306, 2849, -1651),
(3545, 306, 2843, -1668),
(3546, 306, 2653, -1668),
(3547, 307, 2747, -1249),
(3548, 307, 2747, -1266),
(3549, 307, 2773, -1266),
(3550, 307, 2773, -1377),
(3551, 307, 2787, -1399),
(3552, 307, 2803, -1407),
(3553, 307, 2825, -1407),
(3554, 307, 2825, -1398),
(3555, 307, 2867, -1398),
(3556, 307, 2866, -1379),
(3557, 307, 2839, -1368),
(3558, 307, 2811, -1250),
(3559, 308, 1950, -1015),
(3560, 308, 2023, -1017),
(3561, 308, 2065, -1028),
(3562, 308, 2152, -1027),
(3563, 308, 2156, -1014),
(3564, 308, 2246, -1079),
(3565, 308, 2298, -1089),
(3566, 308, 2270, -1051),
(3567, 308, 2374, -918),
(3568, 308, 1950, -918),
(3569, 309, 2156, -1014),
(3570, 309, 2151, -1027),
(3571, 309, 2135, -1027),
(3572, 309, 2156, -1069),
(3573, 309, 2209, -1099),
(3574, 309, 2211, -1111),
(3575, 309, 2262, -1136),
(3576, 309, 2297, -1141),
(3577, 309, 2297, -1089),
(3578, 309, 2245, -1079),
(3579, 310, 1680, -983),
(3580, 310, 1728, -965),
(3581, 310, 1779, -966),
(3582, 310, 1950, -1014),
(3583, 310, 2022, -1015),
(3584, 310, 2064, -1027),
(3585, 310, 2135, -1027),
(3586, 310, 2154, -1066),
(3587, 310, 2209, -1099),
(3588, 310, 2212, -1111),
(3589, 310, 2260, -1135),
(3590, 310, 2208, -1125),
(3591, 310, 2160, -1113),
(3592, 310, 2101, -1076),
(3593, 310, 2055, -1045),
(3594, 310, 1993, -1038),
(3595, 310, 1885, -1027),
(3596, 310, 1789, -1033),
(3597, 310, 1754, -1035),
(3598, 310, 1723, -1022),
(3599, 311, 2653, -1055),
(3600, 311, 2766, -1055),
(3601, 311, 2765, -1141),
(3602, 311, 2745, -1143),
(3603, 311, 2746, -1172),
(3604, 311, 2768, -1172),
(3605, 311, 2768, -1249),
(3606, 311, 2747, -1249),
(3607, 311, 2747, -1267),
(3608, 311, 2772, -1267),
(3609, 311, 2772, -1376),
(3610, 311, 2786, -1399),
(3611, 311, 2786, -1482),
(3612, 311, 2748, -1482),
(3613, 311, 2748, -1598),
(3614, 311, 2768, -1598),
(3615, 311, 2768, -1626),
(3616, 311, 2793, -1626),
(3617, 311, 2814, -1649),
(3618, 311, 2715, -1649),
(3619, 311, 2715, -1632),
(3620, 311, 2655, -1632),
(3621, 311, 2655, -1440),
(3622, 311, 2667, -1446),
(3623, 311, 2670, -1489),
(3624, 311, 2689, -1514),
(3625, 311, 2714, -1518),
(3626, 311, 2714, -1441),
(3627, 311, 2698, -1441),
(3628, 311, 2684, -1389),
(3629, 311, 2654, -1389),
(3630, 311, 2654, -1265),
(3631, 311, 2713, -1265),
(3632, 311, 2713, -1143),
(3633, 311, 2654, -1143),
(3634, 312, 2654, -1388),
(3635, 312, 2683, -1388),
(3636, 312, 2698, -1440),
(3637, 312, 2713, -1440),
(3638, 312, 2713, -1518),
(3639, 312, 2691, -1513),
(3640, 312, 2670, -1489),
(3641, 312, 2667, -1445),
(3642, 312, 2654, -1439),
(3643, 313, 1620, -1372),
(3644, 313, 1704, -1372),
(3645, 313, 1704, -1432),
(3646, 313, 1726, -1432),
(3647, 313, 1726, -1297),
(3648, 313, 1784, -1269),
(3649, 313, 1784, -1181),
(3650, 313, 1726, -1168),
(3651, 313, 1707, -1168),
(3652, 313, 1707, -1206),
(3653, 313, 1644, -1206),
(3654, 313, 1637, -1287),
(3655, 313, 1703, -1287),
(3656, 313, 1703, -1312),
(3657, 313, 1632, -1312),
(3658, 314, 1860, -1189),
(3659, 314, 1958, -1198),
(3660, 314, 1965, -1250),
(3661, 314, 1986, -1250),
(3662, 314, 1980, -1198),
(3663, 314, 2056, -1249),
(3664, 314, 2056, -1277),
(3665, 314, 2035, -1277),
(3666, 314, 2035, -1307),
(3667, 314, 1967, -1307),
(3668, 314, 1861, -1307),
(3669, 315, 1875, -1083),
(3670, 315, 1965, -1088),
(3671, 315, 1963, -1126),
(3672, 315, 1980, -1126),
(3673, 315, 1986, -1090),
(3674, 315, 2056, -1104),
(3675, 315, 2056, -1148),
(3676, 315, 2005, -1214),
(3677, 315, 1981, -1199),
(3678, 315, 1979, -1146),
(3679, 315, 1958, -1146),
(3680, 315, 1959, -1196),
(3681, 315, 1874, -1189),
(3682, 316, 1971, -1058),
(3683, 316, 1989, -1065),
(3684, 316, 1980, -1125),
(3685, 316, 1962, -1126),
(3686, 316, 1965, -1087),
(3687, 317, 1978, -1147),
(3688, 317, 1958, -1146),
(3689, 317, 1956, -1196),
(3690, 317, 1963, -1248),
(3691, 317, 1988, -1248),
(3692, 318, 2057, -1146),
(3693, 318, 2003, -1215),
(3694, 318, 2055, -1248),
(3695, 318, 2055, -1397),
(3696, 318, 2081, -1374),
(3697, 318, 2081, -1196),
(3698, 318, 2112, -1196),
(3699, 318, 2116, -1117),
(3700, 318, 2057, -1094),
(3701, 319, 2082, -1196),
(3702, 319, 2112, -1194),
(3703, 319, 2116, -1117),
(3704, 319, 2168, -1127),
(3705, 319, 2168, -1235),
(3706, 319, 2162, -1259),
(3707, 319, 2081, -1259),
(3708, 320, 2261, -1155),
(3709, 320, 2261, -1372),
(3710, 320, 2280, -1372),
(3711, 320, 2280, -1159),
(3712, 321, 2168, -1128),
(3713, 321, 2185, -1131),
(3714, 321, 2186, -1231),
(3715, 321, 2175, -1274),
(3716, 321, 2173, -1376),
(3717, 321, 2157, -1376),
(3718, 321, 2157, -1292),
(3719, 321, 2157, -1264),
(3720, 321, 2168, -1231),
(3721, 322, 1861, -1308),
(3722, 322, 2034, -1306),
(3723, 322, 2035, -1277),
(3724, 322, 2054, -1277),
(3725, 322, 2054, -1350),
(3726, 322, 1977, -1350),
(3727, 322, 1977, -1451),
(3728, 322, 1860, -1451),
(3729, 323, 1976, -1349),
(3730, 323, 1996, -1349),
(3731, 323, 1996, -1450),
(3732, 323, 1976, -1450),
(3733, 324, 1996, -1350),
(3734, 324, 2053, -1349),
(3735, 324, 2053, -1397),
(3736, 324, 2103, -1397),
(3737, 324, 2103, -1493),
(3738, 324, 2029, -1478),
(3739, 324, 1863, -1478),
(3740, 324, 1863, -1451),
(3741, 324, 1997, -1451),
(3742, 325, 1608, -1204),
(3743, 325, 1600, -1290),
(3744, 325, 1586, -1358),
(3745, 325, 1585, -1383),
(3746, 325, 1557, -1434),
(3747, 325, 1462, -1434),
(3748, 325, 1462, -1290),
(3749, 325, 1529, -1290),
(3750, 325, 1529, -1204),
(3751, 326, 1525, -1598),
(3752, 326, 1524, -1725),
(3753, 326, 1588, -1724),
(3754, 326, 1584, -1702),
(3755, 326, 1585, -1632),
(3756, 326, 1563, -1598),
(3757, 327, 1562, -1597),
(3758, 327, 1555, -1583),
(3759, 327, 1552, -1538),
(3760, 327, 1561, -1516),
(3761, 327, 1571, -1508),
(3762, 327, 1457, -1508),
(3763, 327, 1438, -1565),
(3764, 327, 1438, -1584),
(3765, 327, 1438, -1723),
(3766, 327, 1524, -1723),
(3767, 327, 1524, -1598),
(3768, 328, 2104, -1397),
(3769, 328, 2168, -1395),
(3770, 328, 2167, -1493),
(3771, 328, 2162, -1511),
(3772, 328, 2122, -1498),
(3773, 328, 2122, -1676),
(3774, 328, 2102, -1745),
(3775, 328, 2086, -1745),
(3776, 328, 2101, -1680),
(3777, 329, 805, -1133),
(3778, 329, 805, -1158),
(3779, 329, 949, -1158),
(3780, 329, 949, -1177),
(3781, 329, 1046, -1177),
(3782, 329, 1046, -1156),
(3783, 329, 1068, -1156),
(3784, 329, 1068, -1184),
(3785, 329, 1093, -1184),
(3786, 329, 1119, -1177),
(3787, 329, 1119, -1156),
(3788, 329, 1219, -1156),
(3789, 329, 1219, -1172),
(3790, 329, 1316, -1172),
(3791, 329, 1316, -1158),
(3792, 329, 1334, -1158),
(3793, 329, 1334, -1134),
(3794, 329, 1310, -1110),
(3795, 329, 1271, -1110),
(3796, 329, 1271, -1135),
(3797, 329, 1254, -1135),
(3798, 329, 1254, -1114),
(3799, 329, 1171, -1114),
(3800, 329, 1171, -1134),
(3801, 329, 1153, -1134),
(3802, 329, 1153, -1108),
(3803, 329, 1092, -1108),
(3804, 329, 1092, -1134),
(3805, 329, 1075, -1134),
(3806, 329, 1075, -1108),
(3807, 329, 992, -1108),
(3808, 329, 992, -1132),
(3809, 330, 805, -1072),
(3810, 330, 805, -1131),
(3811, 330, 990, -1131),
(3812, 330, 990, -1108),
(3813, 330, 1049, -1108),
(3814, 330, 1049, -1081),
(3815, 330, 990, -1081),
(3816, 330, 990, -1048),
(3817, 330, 974, -1048),
(3818, 330, 974, -982),
(3819, 330, 955, -984),
(3820, 330, 955, -1056),
(3821, 330, 876, -1056),
(3822, 330, 876, -1071),
(3823, 331, 1254, -946),
(3824, 331, 1254, -1028),
(3825, 331, 1272, -1028),
(3826, 331, 1269, -941),
(3827, 332, 1079, -969),
(3828, 332, 1075, -1031),
(3829, 332, 1092, -1031),
(3830, 332, 1094, -968),
(3831, 333, 1122, -1048),
(3832, 333, 1213, -1048),
(3833, 333, 1213, -1112),
(3834, 333, 1172, -1112),
(3835, 333, 1172, -1132),
(3836, 333, 1155, -1132),
(3837, 333, 1155, -1108),
(3838, 333, 1121, -1108),
(3839, 334, 1306, -1107),
(3840, 334, 1306, -1048),
(3841, 334, 1057, -1048),
(3842, 334, 1057, -1080),
(3843, 334, 990, -1080),
(3844, 334, 990, -1048),
(3845, 334, 974, -1048),
(3846, 334, 974, -996),
(3847, 334, 1077, -988),
(3848, 334, 1077, -1030),
(3849, 334, 1091, -1030),
(3850, 334, 1094, -1000),
(3851, 334, 1151, -1000),
(3852, 334, 1152, -1030),
(3853, 334, 1172, -1030),
(3854, 334, 1172, -975),
(3855, 334, 1253, -966),
(3856, 334, 1253, -1029),
(3857, 334, 1271, -1029),
(3858, 334, 1271, -955),
(3859, 334, 1297, -955),
(3860, 334, 1297, -942),
(3861, 334, 1355, -952),
(3862, 334, 1348, -1023),
(3863, 334, 1348, -1064),
(3864, 334, 1337, -1136),
(3865, 335, 1245, -1291),
(3866, 335, 1245, -1385),
(3867, 335, 1139, -1385),
(3868, 335, 1139, -1369),
(3869, 335, 1092, -1369),
(3870, 335, 1083, -1359),
(3871, 335, 1083, -1311),
(3872, 335, 1133, -1291),
(3873, 336, 1245, -1291),
(3874, 336, 1331, -1291),
(3875, 336, 1331, -1385),
(3876, 336, 1246, -1385),
(3877, 337, 1118, -1157),
(3878, 337, 1118, -1176),
(3879, 337, 1097, -1183),
(3880, 337, 1069, -1183),
(3881, 337, 1069, -1272),
(3882, 337, 1142, -1272),
(3883, 337, 1142, -1220),
(3884, 337, 1161, -1220),
(3885, 337, 1161, -1272),
(3886, 337, 1224, -1272),
(3887, 337, 1224, -1244),
(3888, 337, 1247, -1244),
(3889, 337, 1247, -1173),
(3890, 337, 1218, -1173),
(3891, 337, 1218, -1156),
(3892, 338, 1067, -1272),
(3893, 338, 1142, -1272),
(3894, 338, 1142, -1220),
(3895, 338, 1159, -1220),
(3896, 338, 1159, -1272),
(3897, 338, 1224, -1272),
(3898, 338, 1224, -1243),
(3899, 338, 1245, -1243),
(3900, 338, 1245, -1173),
(3901, 338, 1315, -1173),
(3902, 338, 1315, -1158),
(3903, 338, 1332, -1158),
(3904, 338, 1332, -1291),
(3905, 338, 1134, -1291),
(3906, 338, 1083, -1311),
(3907, 339, 1045, -1155),
(3908, 339, 1045, -1178),
(3909, 339, 1031, -1178),
(3910, 339, 1031, -1213),
(3911, 339, 1044, -1213),
(3912, 339, 1044, -1261),
(3913, 339, 1032, -1261),
(3914, 339, 1032, -1300),
(3915, 339, 1047, -1316),
(3916, 339, 1047, -1387),
(3917, 339, 1082, -1387),
(3918, 339, 1082, -1311),
(3919, 339, 1067, -1273),
(3920, 339, 1067, -1155),
(3921, 340, 949, -1178),
(3922, 340, 950, -1242),
(3923, 340, 1043, -1242),
(3924, 340, 1043, -1215),
(3925, 340, 1030, -1215),
(3926, 340, 1030, -1177),
(3927, 341, 805, -1158),
(3928, 341, 805, -1312),
(3929, 341, 961, -1312),
(3930, 341, 950, -1242),
(3931, 341, 950, -1158),
(3932, 342, 1044, -1243),
(3933, 342, 1044, -1260),
(3934, 342, 1032, -1260),
(3935, 342, 1032, -1300),
(3936, 342, 1046, -1316),
(3937, 342, 1045, -1379),
(3938, 342, 926, -1379),
(3939, 342, 926, -1337),
(3940, 342, 908, -1337),
(3941, 342, 908, -1356),
(3942, 342, 806, -1356),
(3943, 342, 806, -1313),
(3944, 342, 961, -1313),
(3945, 342, 950, -1243),
(3946, 343, 638, -1221),
(3947, 343, 646, -1270),
(3948, 343, 646, -1326),
(3949, 343, 786, -1326),
(3950, 343, 786, -1141),
(3951, 343, 741, -1141),
(3952, 343, 696, -1201),
(3953, 344, 798, -894),
(3954, 344, 840, -956),
(3955, 344, 916, -966),
(3956, 344, 994, -954),
(3957, 344, 980, -943),
(3958, 344, 980, -893),
(3959, 344, 872, -890),
(3960, 344, 843, -874),
(3961, 345, 1518, -1918),
(3962, 345, 1518, -2022),
(3963, 345, 1534, -2084),
(3964, 345, 1548, -2101),
(3965, 345, 1529, -2107),
(3966, 345, 1424, -2108),
(3967, 345, 1366, -2133),
(3968, 345, 1318, -2174),
(3969, 345, 1269, -2190),
(3970, 345, 1229, -2239),
(3971, 345, 1195, -2317),
(3972, 345, 1164, -2342),
(3973, 345, 1123, -2347),
(3974, 345, 1062, -2279),
(3975, 345, 1044, -2220),
(3976, 345, 1020, -2234),
(3977, 345, 1001, -2213),
(3978, 345, 1014, -2098),
(3979, 345, 1034, -2087),
(3980, 345, 1060, -2084),
(3981, 345, 1074, -1964),
(3982, 345, 1070, -1890),
(3983, 345, 1228, -1890),
(3984, 345, 1228, -1879),
(3985, 345, 1303, -1878),
(3986, 345, 1319, -1887),
(3987, 345, 1353, -1887),
(3988, 345, 1354, -1901),
(3989, 345, 1437, -1901),
(3990, 345, 1436, -1919),
(3991, 346, 1474, -1043),
(3992, 346, 1474, -1151),
(3993, 346, 1567, -1151),
(3994, 346, 1566, -1110),
(3995, 346, 1544, -1063),
(3996, 346, 1513, -1043),
(3997, 347, 1364, -1228),
(3998, 347, 1446, -1228),
(3999, 347, 1446, -1255),
(4000, 347, 1365, -1255),
(4001, 348, 1425, -1724),
(4002, 348, 1437, -1724),
(4003, 348, 1437, -1565),
(4004, 348, 1455, -1507),
(4005, 348, 1568, -1507),
(4006, 348, 1549, -1483),
(4007, 348, 1549, -1451),
(4008, 348, 1461, -1451),
(4009, 348, 1461, -1289),
(4010, 348, 1529, -1289),
(4011, 348, 1529, -1241),
(4012, 348, 1463, -1241),
(4013, 348, 1463, -1173),
(4014, 348, 1447, -1173),
(4015, 348, 1447, -1253),
(4016, 348, 1406, -1253),
(4017, 348, 1406, -1384),
(4018, 348, 1429, -1384),
(4019, 348, 1429, -1428),
(4020, 348, 1444, -1428),
(4021, 348, 1444, -1451),
(4022, 348, 1409, -1451),
(4023, 348, 1372, -1576),
(4024, 348, 1400, -1584),
(4025, 348, 1423, -1584),
(4026, 349, 1405, -1256),
(4027, 349, 1366, -1256),
(4028, 349, 1366, -1133),
(4029, 349, 1392, -1133),
(4030, 349, 1428, -1152),
(4031, 349, 1474, -1123),
(4032, 349, 1474, -1043),
(4033, 349, 1374, -1043),
(4034, 349, 1374, -1012),
(4035, 349, 1386, -958),
(4036, 349, 1357, -953),
(4037, 349, 1349, -1016),
(4038, 349, 1335, -1134),
(4039, 349, 1335, -1450),
(4040, 349, 1330, -1472),
(4041, 349, 1301, -1523),
(4042, 349, 1207, -1523),
(4043, 349, 1207, -1563),
(4044, 349, 1290, -1563),
(4045, 349, 1290, -1583),
(4046, 349, 1277, -1601),
(4047, 349, 1285, -1694),
(4048, 349, 1285, -1843),
(4049, 349, 1321, -1843),
(4050, 349, 1321, -1821),
(4051, 349, 1336, -1821),
(4052, 349, 1336, -1742),
(4053, 349, 1319, -1742),
(4054, 349, 1319, -1724),
(4055, 349, 1351, -1724),
(4056, 349, 1351, -1588),
(4057, 349, 1320, -1579),
(4058, 349, 1320, -1563),
(4059, 349, 1371, -1575),
(4060, 349, 1407, -1450),
(4061, 349, 1387, -1450),
(4062, 349, 1387, -1413),
(4063, 349, 1365, -1413),
(4064, 349, 1365, -1385),
(4065, 349, 1406, -1385),
(4066, 350, 742, -1598),
(4067, 350, 742, -1665),
(4068, 350, 781, -1665),
(4069, 350, 781, -1598),
(4070, 351, 799, -1665),
(4071, 351, 799, -1684),
(4072, 351, 716, -1684),
(4073, 351, 716, -1744),
(4074, 351, 643, -1722),
(4075, 351, 649, -1662),
(4076, 352, 649, -1661),
(4077, 352, 649, -1578),
(4078, 352, 665, -1559),
(4079, 352, 712, -1559),
(4080, 352, 712, -1576),
(4081, 352, 796, -1576),
(4082, 352, 820, -1586),
(4083, 352, 837, -1600),
(4084, 352, 823, -1613),
(4085, 352, 807, -1601),
(4086, 352, 782, -1597),
(4087, 352, 718, -1597),
(4088, 352, 718, -1662),
(4089, 353, 806, -1415),
(4090, 353, 823, -1435),
(4091, 353, 861, -1435),
(4092, 353, 861, -1551),
(4093, 353, 821, -1587),
(4094, 353, 797, -1577),
(4095, 353, 741, -1575),
(4096, 353, 738, -1542),
(4097, 353, 761, -1477),
(4098, 353, 769, -1416),
(4099, 354, 928, -1473),
(4100, 354, 928, -1506),
(4101, 354, 1037, -1506),
(4102, 354, 1046, -1474),
(4103, 355, 1051, -1415),
(4104, 355, 994, -1456),
(4105, 355, 994, -1473),
(4106, 355, 1045, -1473),
(4107, 355, 1037, -1504),
(4108, 355, 934, -1504),
(4109, 355, 934, -1554),
(4110, 355, 1030, -1560),
(4111, 355, 1030, -1583),
(4112, 355, 1021, -1595),
(4113, 355, 1021, -1787),
(4114, 355, 1041, -1801),
(4115, 355, 1047, -1775),
(4116, 355, 1047, -1542),
(4117, 355, 1071, -1463),
(4118, 355, 1071, -1415),
(4119, 356, 933, -1506),
(4120, 356, 933, -1554),
(4121, 356, 927, -1562),
(4122, 356, 910, -1562),
(4123, 356, 910, -1534),
(4124, 356, 860, -1534),
(4125, 356, 860, -1435),
(4126, 356, 910, -1415),
(4127, 356, 926, -1415),
(4128, 356, 992, -1454),
(4129, 356, 992, -1471),
(4130, 356, 926, -1471),
(4131, 356, 926, -1506),
(4132, 357, 906, -1581),
(4133, 357, 926, -1581),
(4134, 357, 1019, -1595),
(4135, 357, 1019, -1785),
(4136, 357, 926, -1764),
(4137, 357, 852, -1761),
(4138, 357, 852, -1629),
(4139, 358, 1168, -1723),
(4140, 358, 1168, -1843),
(4141, 358, 1188, -1843),
(4142, 358, 1188, -1724),
(4143, 359, 1047, -1703),
(4144, 359, 1159, -1703),
(4145, 359, 1159, -1633),
(4146, 359, 1180, -1633),
(4147, 359, 1180, -1651),
(4148, 359, 1198, -1651),
(4149, 359, 1198, -1609),
(4150, 359, 1275, -1602),
(4151, 359, 1285, -1694),
(4152, 359, 1285, -1782),
(4153, 359, 1186, -1782),
(4154, 359, 1186, -1723),
(4155, 359, 1167, -1723),
(4156, 359, 1167, -1783),
(4157, 359, 1105, -1783),
(4158, 359, 1068, -1843),
(4159, 359, 1060, -1816),
(4160, 359, 1042, -1799),
(4161, 360, 1289, -1563),
(4162, 360, 1047, -1563),
(4163, 360, 1047, -1581),
(4164, 360, 1159, -1581),
(4165, 360, 1198, -1609),
(4166, 360, 1275, -1601),
(4167, 360, 1290, -1582),
(4168, 361, 1046, -1582),
(4169, 361, 1156, -1582),
(4170, 361, 1199, -1610),
(4171, 361, 1197, -1650),
(4172, 361, 1181, -1650),
(4173, 361, 1181, -1634),
(4174, 361, 1158, -1634),
(4175, 361, 1158, -1702),
(4176, 361, 1047, -1702),
(4177, 362, 402, -1203),
(4178, 362, 323, -1237),
(4179, 362, 286, -1238),
(4180, 362, 270, -1248),
(4181, 362, 306, -1279),
(4182, 362, 236, -1330),
(4183, 362, 154, -1244),
(4184, 362, 197, -1183),
(4185, 362, 317, -1107),
(4186, 363, 271, -1247),
(4187, 363, 307, -1279),
(4188, 363, 435, -1226),
(4189, 363, 459, -1215),
(4190, 363, 425, -1193),
(4191, 363, 326, -1236),
(4192, 363, 285, -1238),
(4193, 364, 618, -1121),
(4194, 364, 650, -1183),
(4195, 364, 560, -1222),
(4196, 364, 510, -1255),
(4197, 364, 478, -1227),
(4198, 364, 450, -1237),
(4199, 364, 453, -1271),
(4200, 364, 387, -1306),
(4201, 364, 357, -1304),
(4202, 364, 230, -1419),
(4203, 364, 190, -1433),
(4204, 364, 123, -1528),
(4205, 364, 66, -1517),
(4206, 364, 170, -1386),
(4207, 364, 235, -1328),
(4208, 364, 305, -1277),
(4209, 364, 459, -1215),
(4210, 364, 520, -1195),
(4211, 364, 572, -1175),
(4212, 364, 599, -1159),
(4213, 364, 602, -1131),
(4214, 365, 304, -1062),
(4215, 365, 295, -1074),
(4216, 365, 402, -1204),
(4217, 365, 422, -1193),
(4218, 365, 459, -1215),
(4219, 365, 571, -1176),
(4220, 365, 598, -1158),
(4221, 365, 599, -1132),
(4222, 365, 618, -1121),
(4223, 365, 649, -1182),
(4224, 365, 742, -1046),
(4225, 365, 765, -1011),
(4226, 365, 787, -1009),
(4227, 365, 784, -948),
(4228, 365, 779, -922),
(4229, 365, 797, -894),
(4230, 365, 844, -873),
(4231, 365, 871, -889),
(4232, 365, 977, -891),
(4233, 365, 1145, -839),
(4234, 365, 1149, -772),
(4235, 365, 1165, -770),
(4236, 365, 1165, -876),
(4237, 365, 1303, -853),
(4238, 365, 1341, -856),
(4239, 365, 1360, -925),
(4240, 365, 1391, -929),
(4241, 365, 1397, -907),
(4242, 365, 1453, -914),
(4243, 365, 1460, -925),
(4244, 365, 1515, -925),
(4245, 365, 1581, -895),
(4246, 365, 1581, -650),
(4247, 365, 1455, -650),
(4248, 365, 1414, -683),
(4249, 365, 1304, -699),
(4250, 365, 1173, -735),
(4251, 365, 1169, -756),
(4252, 365, 1149, -756),
(4253, 365, 1157, -720),
(4254, 365, 1065, -724),
(4255, 365, 996, -771),
(4256, 365, 961, -810),
(4257, 365, 931, -796),
(4258, 365, 847, -865),
(4259, 365, 815, -833),
(4260, 365, 767, -915),
(4261, 365, 701, -1002),
(4262, 365, 682, -990),
(4263, 365, 614, -1069),
(4264, 365, 537, -1120),
(4265, 365, 408, -1121),
(4266, 365, 384, -1155),
(4267, 365, 369, -1145),
(4268, 366, 197, -1561),
(4269, 366, 293, -1481),
(4270, 366, 271, -1461),
(4271, 366, 199, -1512),
(4272, 366, 189, -1531),
(4273, 367, 254, -1609),
(4274, 367, 276, -1627),
(4275, 367, 341, -1634),
(4276, 367, 357, -1627),
(4277, 367, 422, -1634),
(4278, 367, 438, -1647),
(4279, 367, 459, -1647),
(4280, 367, 459, -1622),
(4281, 367, 511, -1622),
(4282, 367, 511, -1655),
(4283, 367, 620, -1667),
(4284, 367, 616, -1717),
(4285, 367, 381, -1660),
(4286, 367, 256, -1643),
(4287, 367, 198, -1561),
(4288, 367, 249, -1583),
(4289, 368, 338, -1572),
(4290, 368, 372, -1524),
(4291, 368, 427, -1479),
(4292, 368, 438, -1507),
(4293, 368, 438, -1578),
(4294, 368, 617, -1575),
(4295, 368, 617, -1601),
(4296, 368, 513, -1603),
(4297, 368, 510, -1623),
(4298, 368, 457, -1622),
(4299, 368, 457, -1601),
(4300, 368, 432, -1602),
(4301, 368, 433, -1643),
(4302, 368, 414, -1632),
(4303, 368, 358, -1627),
(4304, 368, 338, -1635),
(4305, 369, 518, -1350),
(4306, 369, 534, -1399),
(4307, 369, 512, -1403),
(4308, 369, 500, -1359),
(4309, 370, 500, -1504),
(4310, 370, 519, -1427),
(4311, 370, 585, -1415),
(4312, 370, 585, -1575),
(4313, 370, 516, -1576),
(4314, 1, 475, -1577),
(4315, 1, 472, -1452),
(4316, 1, 517, -1427),
(4317, 1, 498, -1503),
(4318, 1, 516, -1577),
(4319, 2, 124, -1527),
(4320, 2, 176, -1571),
(4321, 2, 216, -1587),
(4322, 2, 197, -1563),
(4323, 2, 188, -1530),
(4324, 2, 197, -1511),
(4325, 2, 270, -1460),
(4326, 2, 487, -1327),
(4327, 2, 480, -1314),
(4328, 2, 495, -1302),
(4329, 2, 514, -1329),
(4330, 2, 621, -1310),
(4331, 2, 617, -1229),
(4332, 2, 697, -1199),
(4333, 2, 740, -1140),
(4334, 2, 787, -1141),
(4335, 2, 787, -1071),
(4336, 2, 874, -1071),
(4337, 2, 874, -1056),
(4338, 2, 953, -1056),
(4339, 2, 953, -982),
(4340, 2, 973, -982),
(4341, 2, 973, -997),
(4342, 2, 1076, -987),
(4343, 2, 1078, -967),
(4344, 2, 1093, -967),
(4345, 2, 1093, -999),
(4346, 2, 1152, -999),
(4347, 2, 1152, -963),
(4348, 2, 1172, -963),
(4349, 2, 1172, -974),
(4350, 2, 1253, -964),
(4351, 2, 1253, -947),
(4352, 2, 1269, -943),
(4353, 2, 1270, -953),
(4354, 2, 1297, -954),
(4355, 2, 1297, -941),
(4356, 2, 1554, -991),
(4357, 2, 1601, -983),
(4358, 2, 1639, -965),
(4359, 2, 1475, -947),
(4360, 2, 1451, -914),
(4361, 2, 1396, -907),
(4362, 2, 1390, -928),
(4363, 2, 1360, -923),
(4364, 2, 1341, -856),
(4365, 2, 1304, -853),
(4366, 2, 1165, -875),
(4367, 2, 1166, -935),
(4368, 2, 1150, -936),
(4369, 2, 1145, -839),
(4370, 2, 975, -890),
(4371, 2, 978, -941),
(4372, 2, 994, -953),
(4373, 2, 917, -965),
(4374, 2, 839, -955),
(4375, 2, 797, -894),
(4376, 2, 789, -909),
(4377, 2, 802, -939);
INSERT INTO `street_pos` (`id`, `StreetID`, `StreetX`, `StreetY`) VALUES
(4378, 2, 802, -1035),
(4379, 2, 786, -1034),
(4380, 2, 786, -1008),
(4381, 2, 763, -1011),
(4382, 2, 650, -1182),
(4383, 2, 559, -1222),
(4384, 2, 510, -1255),
(4385, 2, 494, -1267),
(4386, 2, 450, -1237),
(4387, 2, 454, -1270),
(4388, 2, 387, -1306),
(4389, 2, 356, -1305),
(4390, 2, 230, -1419),
(4391, 2, 190, -1432),
(4392, 3, 617, -1231),
(4393, 3, 636, -1221),
(4394, 3, 645, -1271),
(4395, 3, 645, -1324),
(4396, 3, 787, -1324),
(4397, 3, 787, -1385),
(4398, 3, 644, -1385),
(4399, 3, 644, -1415),
(4400, 3, 654, -1426),
(4401, 3, 688, -1426),
(4402, 3, 688, -1558),
(4403, 3, 664, -1558),
(4404, 3, 647, -1579),
(4405, 3, 649, -1661),
(4406, 3, 642, -1721),
(4407, 3, 615, -1717),
(4408, 3, 621, -1666),
(4409, 3, 616, -1602),
(4410, 3, 616, -1575),
(4411, 3, 585, -1575),
(4412, 3, 585, -1415),
(4413, 3, 619, -1412),
(4414, 3, 619, -1384),
(4415, 3, 563, -1354),
(4416, 3, 563, -1338),
(4417, 3, 622, -1328),
(4418, 4, 562, -1353),
(4419, 4, 523, -1365),
(4420, 4, 535, -1398),
(4421, 4, 512, -1402),
(4422, 4, 503, -1379),
(4423, 4, 422, -1432),
(4424, 4, 430, -1445),
(4425, 4, 412, -1457),
(4426, 4, 388, -1428),
(4427, 4, 289, -1510),
(4428, 4, 255, -1560),
(4429, 4, 314, -1572),
(4430, 4, 320, -1630),
(4431, 4, 338, -1634),
(4432, 4, 337, -1572),
(4433, 4, 372, -1523),
(4434, 4, 426, -1480),
(4435, 4, 517, -1426),
(4436, 4, 585, -1414),
(4437, 4, 618, -1411),
(4438, 4, 618, -1383),
(4439, 5, 644, -1385),
(4440, 5, 644, -1416),
(4441, 5, 654, -1425),
(4442, 5, 687, -1425),
(4443, 5, 687, -1557),
(4444, 5, 760, -1477),
(4445, 5, 768, -1415),
(4446, 5, 806, -1415),
(4447, 5, 822, -1435),
(4448, 5, 860, -1434),
(4449, 5, 909, -1415),
(4450, 5, 926, -1415),
(4451, 5, 993, -1453),
(4452, 5, 1050, -1415),
(4453, 5, 1072, -1414),
(4454, 5, 1072, -1463),
(4455, 5, 1048, -1541),
(4456, 5, 1048, -1563),
(4457, 5, 1187, -1563),
(4458, 5, 1187, -1413),
(4459, 5, 1204, -1413),
(4460, 5, 1204, -1447),
(4461, 5, 1333, -1447),
(4462, 5, 1335, -1419),
(4463, 5, 1335, -1383),
(4464, 5, 1139, -1383),
(4465, 5, 1139, -1369),
(4466, 5, 1094, -1369),
(4467, 5, 1081, -1359),
(4468, 5, 1081, -1387),
(4469, 5, 1047, -1387),
(4470, 5, 1047, -1379),
(4471, 5, 925, -1379),
(4472, 5, 925, -1387),
(4473, 5, 909, -1387),
(4474, 5, 906, -1355),
(4475, 5, 806, -1355),
(4476, 5, 806, -1385),
(4477, 6, 1188, -1414),
(4478, 6, 1203, -1414),
(4479, 6, 1204, -1446),
(4480, 6, 1333, -1447),
(4481, 6, 1330, -1471),
(4482, 6, 1300, -1523),
(4483, 6, 1208, -1523),
(4484, 6, 1206, -1562),
(4485, 6, 1187, -1562),
(4486, 7, 476, -1786),
(4487, 7, 379, -1786),
(4488, 7, 379, -1735),
(4489, 7, 452, -1736),
(4490, 7, 451, -1727),
(4491, 7, 475, -1731),
(4492, 8, 361, -1657),
(4493, 8, 361, -1903),
(4494, 8, 348, -2091),
(4495, 8, 417, -2091),
(4496, 8, 417, -1786),
(4497, 8, 378, -1786),
(4498, 8, 378, -1660),
(4499, 9, 742, -1752),
(4500, 9, 643, -1721),
(4501, 9, 379, -1661),
(4502, 9, 378, -1734),
(4503, 9, 449, -1734),
(4504, 9, 449, -1724),
(4505, 9, 474, -1731),
(4506, 9, 475, -1770),
(4507, 9, 996, -1879),
(4508, 9, 1013, -2099),
(4509, 9, 1034, -2086),
(4510, 9, 1060, -2083),
(4511, 9, 1075, -1963),
(4512, 9, 1070, -1888),
(4513, 9, 1069, -1842),
(4514, 9, 1059, -1814),
(4515, 9, 1021, -1784),
(4516, 9, 926, -1762),
(4517, 9, 853, -1759),
(4518, 9, 852, -1730),
(4519, 9, 819, -1760),
(4520, 9, 781, -1759),
(4521, 10, 1936, -1950),
(4522, 10, 1938, -2043),
(4523, 10, 1952, -2043),
(4524, 10, 1952, -2061),
(4525, 10, 1918, -2062),
(4526, 10, 1920, -2155),
(4527, 10, 1970, -2155),
(4528, 10, 1969, -2100),
(4529, 10, 2003, -2100),
(4530, 10, 2004, -1978),
(4531, 10, 1968, -1979),
(4532, 10, 1968, -1949),
(4533, 11, 2082, -1259),
(4534, 11, 2158, -1259),
(4535, 11, 2156, -1339),
(4536, 11, 2082, -1340),
(4537, 12, 2054, -1396),
(4538, 12, 2082, -1375),
(4539, 12, 2082, -1340),
(4540, 12, 2156, -1338),
(4541, 12, 2155, -1375),
(4542, 12, 2174, -1375),
(4543, 12, 2175, -1345),
(4544, 12, 2210, -1345),
(4545, 12, 2210, -1376),
(4546, 12, 2281, -1376),
(4547, 12, 2281, -1394),
(4548, 12, 2262, -1409),
(4549, 12, 2221, -1409),
(4550, 12, 2221, -1394),
(4551, 13, 2222, -1457),
(4552, 13, 2222, -1537),
(4553, 13, 2274, -1554),
(4554, 13, 2337, -1554),
(4555, 13, 2337, -1475),
(4556, 13, 2290, -1457),
(4557, 14, 2654, -1248),
(4558, 14, 2712, -1248),
(4559, 14, 2712, -1264),
(4560, 14, 2654, -1264),
(4561, 15, 2632, -1265),
(4562, 15, 2631, -1246),
(4563, 15, 2563, -1247),
(4564, 15, 2562, -1224),
(4565, 15, 2457, -1223),
(4566, 15, 2457, -1248),
(4567, 15, 2444, -1248),
(4568, 15, 2444, -1206),
(4569, 15, 2381, -1206),
(4570, 15, 2381, -1266),
(4571, 16, 2542, -1265),
(4572, 16, 2545, -1433),
(4573, 16, 2636, -1432),
(4574, 16, 2631, -1265),
(4575, 17, 2541, -1266),
(4576, 17, 2544, -1433),
(4577, 17, 2461, -1436),
(4578, 17, 2461, -1356),
(4579, 17, 2481, -1356),
(4580, 17, 2481, -1311),
(4581, 17, 2500, -1311),
(4582, 17, 2500, -1264),
(4583, 18, 2413, -1265),
(4584, 18, 2413, -1372),
(4585, 18, 2439, -1372),
(4586, 18, 2439, -1436),
(4587, 18, 2461, -1436),
(4588, 18, 2461, -1356),
(4589, 18, 2481, -1356),
(4590, 18, 2481, -1312),
(4591, 18, 2500, -1312),
(4592, 18, 2500, -1264),
(4593, 19, 2361, -1289),
(4594, 19, 2361, -1289),
(4595, 19, 2361, -1318),
(4596, 19, 2312, -1318),
(4597, 19, 2312, -1289),
(4598, 20, 2313, -1288),
(4599, 20, 2361, -1290),
(4600, 20, 2361, -1318),
(4601, 20, 2341, -1318),
(4602, 20, 2341, -1371),
(4603, 20, 2412, -1371),
(4604, 20, 2412, -1264),
(4605, 20, 2381, -1264),
(4606, 20, 2381, -1164),
(4607, 20, 2364, -1164),
(4608, 20, 2364, -1201),
(4609, 20, 2311, -1201),
(4610, 21, 2632, -1244),
(4611, 21, 2582, -1245),
(4612, 21, 2582, -1191),
(4613, 21, 2562, -1191),
(4614, 21, 2561, -1223),
(4615, 21, 2459, -1221),
(4616, 21, 2458, -1189),
(4617, 21, 2446, -1190),
(4618, 21, 2445, -1205),
(4619, 21, 2382, -1204),
(4620, 21, 2382, -1165),
(4621, 21, 2630, -1165),
(4622, 22, 2296, -1142),
(4623, 22, 2336, -1144),
(4624, 22, 2364, -1123),
(4625, 22, 2540, -1123),
(4626, 22, 2540, -1144),
(4627, 22, 2631, -1144),
(4628, 22, 2631, -1164),
(4629, 22, 2364, -1164),
(4630, 22, 2364, -1199),
(4631, 22, 2311, -1199),
(4632, 22, 2311, -1163),
(4633, 22, 2294, -1163),
(4634, 23, 2294, -1162),
(4635, 23, 2294, -1378),
(4636, 23, 2340, -1378),
(4637, 23, 2340, -1316),
(4638, 23, 2310, -1316),
(4639, 23, 2310, -1163),
(4640, 24, 2292, -1377),
(4641, 24, 2292, -1392),
(4642, 24, 2376, -1392),
(4643, 24, 2376, -1457),
(4644, 24, 2634, -1457),
(4645, 24, 2634, -1433),
(4646, 24, 2438, -1437),
(4647, 24, 2438, -1372),
(4648, 24, 2340, -1370),
(4649, 24, 2339, -1378),
(4650, 25, 2291, -1391),
(4651, 25, 2286, -1457),
(4652, 25, 2336, -1476),
(4653, 25, 2336, -1670),
(4654, 25, 2317, -1670),
(4655, 25, 2317, -1693),
(4656, 25, 2336, -1693),
(4657, 25, 2336, -1723),
(4658, 25, 2351, -1723),
(4659, 25, 2351, -1518),
(4660, 25, 2377, -1457),
(4661, 25, 2377, -1391),
(4662, 26, 2450, -1458),
(4663, 26, 2450, -1489),
(4664, 26, 2440, -1497),
(4665, 26, 2440, -1583),
(4666, 26, 2470, -1592),
(4667, 26, 2541, -1594),
(4668, 26, 2541, -1581),
(4669, 26, 2585, -1489),
(4670, 26, 2582, -1457),
(4671, 27, 2352, -1555),
(4672, 27, 2421, -1580),
(4673, 27, 2421, -1520),
(4674, 27, 2390, -1520),
(4675, 27, 2357, -1499),
(4676, 27, 2351, -1517),
(4677, 28, 2358, -1500),
(4678, 28, 2388, -1520),
(4679, 28, 2421, -1520),
(4680, 28, 2421, -1725),
(4681, 28, 2440, -1725),
(4682, 28, 2440, -1497),
(4683, 28, 2449, -1488),
(4684, 28, 2449, -1457),
(4685, 28, 2378, -1457),
(4686, 29, 2202, -1584),
(4687, 29, 2177, -1691),
(4688, 29, 2121, -1673),
(4689, 29, 2121, -1547),
(4690, 30, 2237, -1605),
(4691, 30, 2218, -1656),
(4692, 30, 2235, -1660),
(4693, 30, 2229, -1694),
(4694, 30, 2316, -1692),
(4695, 30, 2315, -1669),
(4696, 30, 2335, -1669),
(4697, 30, 2334, -1630),
(4698, 30, 2290, -1627),
(4699, 31, 2352, -1630),
(4700, 31, 2420, -1630),
(4701, 31, 2418, -1693),
(4702, 31, 2352, -1692),
(4703, 32, 2606, -1056),
(4704, 32, 2605, -1142),
(4705, 32, 2541, -1144),
(4706, 32, 2540, -1124),
(4707, 32, 2364, -1123),
(4708, 32, 2334, -1144),
(4709, 32, 2296, -1140),
(4710, 32, 2298, -1089),
(4711, 32, 2352, -1092),
(4712, 32, 2436, -1072),
(4713, 32, 2518, -1080),
(4714, 32, 2547, -1075),
(4715, 32, 2551, -1056),
(4716, 33, 2373, -918),
(4717, 33, 2835, -918),
(4718, 33, 2827, -1056),
(4719, 33, 2552, -1056),
(4720, 33, 2546, -1074),
(4721, 33, 2516, -1081),
(4722, 33, 2436, -1071),
(4723, 33, 2351, -1093),
(4724, 33, 2298, -1089),
(4725, 33, 2270, -1052),
(4726, 34, 788, -1070),
(4727, 34, 804, -1070),
(4728, 34, 804, -1383),
(4729, 34, 787, -1383),
(4730, 35, 1851, -1027),
(4731, 35, 1875, -1082),
(4732, 35, 1962, -1086),
(4733, 35, 1970, -1059),
(4734, 35, 1988, -1065),
(4735, 35, 1984, -1087),
(4736, 35, 2055, -1103),
(4737, 35, 2056, -1094),
(4738, 35, 2116, -1116),
(4739, 35, 2185, -1131),
(4740, 35, 2187, -1211),
(4741, 35, 2259, -1211),
(4742, 35, 2260, -1154),
(4743, 35, 2280, -1158),
(4744, 35, 2278, -1140),
(4745, 35, 2160, -1113),
(4746, 35, 2054, -1043),
(4747, 35, 1887, -1026),
(4748, 36, 1873, -1189),
(4749, 36, 1873, -1081),
(4750, 36, 1851, -1029),
(4751, 36, 1804, -1045),
(4752, 36, 1789, -1092),
(4753, 37, 1619, -1504),
(4754, 37, 1618, -1517),
(4755, 37, 1653, -1530),
(4756, 37, 1680, -1535),
(4757, 37, 1707, -1518),
(4758, 37, 1740, -1510),
(4759, 37, 1678, -1490),
(4760, 37, 1650, -1494),
(4761, 38, 2786, -1399),
(4762, 38, 2802, -1407),
(4763, 38, 2824, -1406),
(4764, 38, 2824, -1478),
(4765, 38, 2867, -1478),
(4766, 38, 2862, -1498),
(4767, 38, 2748, -1498),
(4768, 38, 2748, -1482),
(4769, 38, 2787, -1482),
(4770, 39, 2848, -1652),
(4771, 39, 2814, -1650),
(4772, 39, 2793, -1626),
(4773, 39, 2768, -1626),
(4774, 39, 2768, -1598),
(4775, 39, 2749, -1598),
(4776, 39, 2749, -1499),
(4777, 39, 2862, -1499),
(4778, 39, 2869, -1478),
(4779, 39, 2825, -1478),
(4780, 39, 2825, -1398),
(4781, 39, 2866, -1398),
(4782, 39, 2866, -1378),
(4783, 39, 2838, -1367),
(4784, 39, 2810, -1251),
(4785, 39, 2768, -1247),
(4786, 39, 2768, -1171),
(4787, 39, 2826, -1150),
(4788, 39, 2824, -1133),
(4789, 39, 2765, -1139),
(4790, 39, 2765, -1056),
(4791, 39, 2826, -1056),
(4792, 39, 2834, -916),
(4793, 39, 2836, -595),
(4794, 39, 2767, -490),
(4795, 39, 2783, -459),
(4796, 39, 2856, -571),
(4797, 39, 2857, -926),
(4798, 39, 2850, -1113),
(4799, 39, 2872, -1283),
(4800, 39, 2896, -1490),
(4801, 40, 2180, -1259),
(4802, 40, 2258, -1259),
(4803, 40, 2258, -1376),
(4804, 40, 2208, -1376),
(4805, 40, 2208, -1346),
(4806, 40, 2173, -1346),
(4807, 40, 2173, -1274),
(4808, 41, 1367, -1229),
(4809, 41, 1446, -1229),
(4810, 41, 1446, -1174),
(4811, 41, 1462, -1174),
(4812, 41, 1462, -1240),
(4813, 41, 1528, -1240),
(4814, 41, 1528, -1204),
(4815, 41, 1608, -1204),
(4816, 41, 1601, -1152),
(4817, 41, 1474, -1152),
(4818, 41, 1474, -1123),
(4819, 41, 1428, -1151),
(4820, 41, 1392, -1132),
(4821, 41, 1366, -1132),
(4822, 42, 2622, -1721),
(4823, 42, 2441, -1724),
(4824, 42, 2420, -1725),
(4825, 42, 2420, -1694),
(4826, 42, 2351, -1694),
(4827, 42, 2351, -1723),
(4828, 42, 2335, -1723),
(4829, 42, 2335, -1692),
(4830, 42, 2226, -1692),
(4831, 42, 2226, -1839),
(4832, 42, 2405, -1823),
(4833, 42, 2405, -1739),
(4834, 42, 2422, -1739),
(4835, 42, 2422, -1750),
(4836, 42, 2463, -1771),
(4837, 42, 2497, -1770),
(4838, 42, 2515, -1742),
(4839, 42, 2623, -1742),
(4840, 43, 2540, -1926),
(4841, 43, 2526, -1864),
(4842, 43, 2542, -1743),
(4843, 43, 2515, -1743),
(4844, 43, 2496, -1771),
(4845, 43, 2507, -1881),
(4846, 43, 2468, -1881),
(4847, 43, 2468, -1927),
(4848, 44, 2406, -1739),
(4849, 44, 2406, -1881),
(4850, 44, 2345, -1881),
(4851, 44, 2345, -1946),
(4852, 44, 2402, -1946),
(4853, 44, 2402, -2038),
(4854, 44, 2421, -2038),
(4855, 44, 2421, -1927),
(4856, 44, 2469, -1927),
(4857, 44, 2469, -1880),
(4858, 44, 2423, -1880),
(4859, 44, 2423, -1823),
(4860, 44, 2501, -1823),
(4861, 44, 2495, -1769),
(4862, 44, 2462, -1771),
(4863, 44, 2422, -1748),
(4864, 44, 2419, -1739),
(4865, 45, 2722, -2039),
(4866, 45, 2723, -2057),
(4867, 45, 2816, -2056),
(4868, 45, 2815, -2039),
(4869, 46, 2222, -1535),
(4870, 46, 2221, -1457),
(4871, 46, 2276, -1456),
(4872, 46, 2280, -1393),
(4873, 46, 2261, -1408),
(4874, 46, 2221, -1409),
(4875, 46, 2221, -1394),
(4876, 46, 2168, -1394),
(4877, 46, 2168, -1495),
(4878, 46, 2162, -1510),
(4879, 46, 2207, -1531),
(4880, 46, 2202, -1583),
(4881, 46, 2177, -1691),
(4882, 46, 2120, -1671),
(4883, 46, 2109, -1723),
(4884, 46, 2172, -1723),
(4885, 46, 2193, -1734),
(4886, 46, 2219, -1591),
(4887, 47, 1069, -1844),
(4888, 47, 1070, -1890),
(4889, 47, 1226, -1890),
(4890, 47, 1226, -1879),
(4891, 47, 1302, -1879),
(4892, 47, 1319, -1887),
(4893, 47, 1352, -1887),
(4894, 47, 1352, -1902),
(4895, 47, 1435, -1902),
(4896, 47, 1435, -1919),
(4897, 47, 1518, -1919),
(4898, 47, 1537, -1911),
(4899, 47, 1626, -1911),
(4900, 47, 1593, -1775),
(4901, 47, 1578, -1770),
(4902, 47, 1578, -1862),
(4903, 47, 1557, -1862),
(4904, 47, 1557, -1836),
(4905, 47, 1397, -1836),
(4906, 47, 1397, -1864),
(4907, 47, 1379, -1864),
(4908, 47, 1379, -1818),
(4909, 47, 1321, -1821),
(4910, 47, 1321, -1842),
(4911, 47, 1284, -1842),
(4912, 47, 1284, -1782),
(4913, 47, 1186, -1782),
(4914, 47, 1186, -1843),
(4915, 47, 1168, -1843),
(4916, 47, 1168, -1782),
(4917, 47, 1106, -1782),
(4918, 48, 2234, -89),
(4919, 48, 2246, -89),
(4920, 48, 2246, -67),
(4921, 48, 2286, -67),
(4922, 48, 2286, -89),
(4923, 48, 2338, -89),
(4924, 48, 2348, -99),
(4925, 48, 2342, -183),
(4926, 48, 2201, -134),
(4927, 49, 2302, 207),
(4928, 49, 2388, 207),
(4929, 49, 2388, 97),
(4930, 49, 2353, 97),
(4931, 49, 2353, -103),
(4932, 49, 2337, -89),
(4933, 49, 2326, -88),
(4934, 49, 2326, -46),
(4935, 49, 2336, -35),
(4936, 49, 2336, -19),
(4937, 49, 2324, -6),
(4938, 49, 2324, 84),
(4939, 49, 2334, 84),
(4940, 49, 2334, 98),
(4941, 49, 2302, 98),
(4942, 50, 2354, -19),
(4943, 50, 2354, 85),
(4944, 50, 2402, 85),
(4945, 50, 2402, 31),
(4946, 50, 2429, 31),
(4947, 50, 2429, -18),
(4948, 51, 2429, 7),
(4949, 51, 2453, 7),
(4950, 51, 2453, -16),
(4951, 51, 2473, -46),
(4952, 51, 2405, -144),
(4953, 51, 2353, -102),
(4954, 51, 2353, -19),
(4955, 51, 2429, -19),
(4956, 52, 2527, -122),
(4957, 52, 2558, -42),
(4958, 52, 2524, 3),
(4959, 52, 2524, 30),
(4960, 52, 2473, 30),
(4961, 52, 2473, -44),
(4962, 53, 2500, 78),
(4963, 53, 2500, 53),
(4964, 53, 2597, 53),
(4965, 53, 2597, 156),
(4966, 53, 2524, 103),
(4967, 53, 2524, 78),
(4968, 54, 2597, 53),
(4969, 54, 2597, 30),
(4970, 54, 2399, 30),
(4971, 54, 2399, 81),
(4972, 54, 2454, 81),
(4973, 54, 2454, 52),
(4974, 55, 2429, 30),
(4975, 55, 2429, 7),
(4976, 55, 2452, 7),
(4977, 55, 2452, -14),
(4978, 55, 2472, -45),
(4979, 55, 2472, 30),
(4980, 56, 2422, 112),
(4981, 56, 2458, 112),
(4982, 56, 2472, 105),
(4983, 56, 2472, 78),
(4984, 56, 2523, 78),
(4985, 56, 2523, 103),
(4986, 56, 2597, 156),
(4987, 56, 2421, 156),
(4988, 57, 2302, 207),
(4989, 57, 2214, 188),
(4990, 57, 2214, 146),
(4991, 57, 2230, 132),
(4992, 57, 2282, 132),
(4993, 57, 2302, 146),
(4994, 58, 2302, 146),
(4995, 58, 2283, 132),
(4996, 58, 2283, 84),
(4997, 58, 2273, 68),
(4998, 58, 2284, 53),
(4999, 58, 2284, -18),
(5000, 58, 2299, -18),
(5001, 58, 2324, -5),
(5002, 58, 2324, 84),
(5003, 58, 2302, 84),
(5004, 59, 2214, 147),
(5005, 59, 2230, 133),
(5006, 59, 2230, 84),
(5007, 59, 2243, 70),
(5008, 59, 2230, 50);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `teleports`
--

CREATE TABLE `teleports` (
  `id` int(11) NOT NULL,
  `TeleportName` varchar(30) NOT NULL DEFAULT 'Yok',
  `TeleportX` float NOT NULL,
  `TeleportY` float NOT NULL,
  `TeleportZ` float NOT NULL,
  `TeleportA` float NOT NULL,
  `TeleportInterior` int(11) NOT NULL DEFAULT 0,
  `TeleportWorld` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin5;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `tolls`
--

CREATE TABLE `tolls` (
  `id` int(11) NOT NULL,
  `TollName` varchar(25) NOT NULL,
  `TollModel` int(11) NOT NULL DEFAULT 968,
  `TollPrice` smallint(5) NOT NULL DEFAULT 20,
  `PosX` float NOT NULL,
  `PosY` float NOT NULL,
  `PosZ` float NOT NULL,
  `RotX` float NOT NULL,
  `RotY` float NOT NULL,
  `RotZ` float NOT NULL,
  `TollInterior` int(11) NOT NULL DEFAULT 0,
  `TollWorld` int(11) NOT NULL DEFAULT 0,
  `OpenX` float NOT NULL,
  `OpenY` float NOT NULL,
  `OpenZ` float NOT NULL,
  `OpenRotX` float NOT NULL,
  `OpenRotY` float NOT NULL,
  `OpenRotZ` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin5;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `truck_cargo`
--

CREATE TABLE `truck_cargo` (
  `id` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `name` varchar(64) NOT NULL,
  `storage` int(11) NOT NULL,
  `storage_size` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_amount` int(11) NOT NULL,
  `pack` int(11) NOT NULL,
  `x` float NOT NULL,
  `y` float NOT NULL,
  `z` float NOT NULL,
  `locked` tinyint(1) NOT NULL,
  `gps` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin5;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `ucp_applications_pool`
--

CREATE TABLE `ucp_applications_pool` (
  `id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL DEFAULT 0,
  `char_name` varchar(22) NOT NULL,
  `story` longtext NOT NULL,
  `background` longtext NOT NULL,
  `policy` longtext NOT NULL,
  `terms` longtext NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `time` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin5;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `ucp_blocks`
--

CREATE TABLE `ucp_blocks` (
  `id` int(11) NOT NULL,
  `ucp_name` varchar(22) NOT NULL,
  `ip_address` varchar(16) NOT NULL,
  `blocked_time` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin5;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `ucp_mailboxes`
--

CREATE TABLE `ucp_mailboxes` (
  `id` int(11) NOT NULL,
  `from_id` int(11) NOT NULL,
  `to_id` int(11) NOT NULL,
  `msg_title` varchar(256) NOT NULL,
  `msg_content` varchar(1024) NOT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT 0,
  `time` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin5;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `ucp_news`
--

CREATE TABLE `ucp_news` (
  `id` int(11) NOT NULL,
  `title` varchar(128) NOT NULL,
  `img` varchar(256) NOT NULL,
  `author` tinyint(11) NOT NULL DEFAULT 0,
  `time` int(12) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin5;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `ucp_news_comments`
--

CREATE TABLE `ucp_news_comments` (
  `id` int(11) NOT NULL,
  `news_id` int(11) NOT NULL DEFAULT 0,
  `account_id` int(11) NOT NULL DEFAULT 0,
  `active_id` int(11) DEFAULT 0,
  `msg` varchar(255) NOT NULL,
  `time` int(12) DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=latin5;

--
-- Tablo döküm verisi `ucp_news_comments`
--

INSERT INTO `ucp_news_comments` (`id`, `news_id`, `account_id`, `active_id`, `msg`, `time`) VALUES
(1, 1, 1, 1, '', 0);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `vehicles`
--

CREATE TABLE `vehicles` (
  `id` int(11) NOT NULL,
  `ModelID` int(11) NOT NULL,
  `OwnerID` int(11) NOT NULL DEFAULT 0,
  `FactionID` int(11) NOT NULL DEFAULT -1,
  `RentalID` int(11) NOT NULL DEFAULT 0,
  `RentalPrice` int(11) NOT NULL DEFAULT 2500,
  `RentedBy` int(11) NOT NULL DEFAULT 0,
  `Plate` varchar(20) NOT NULL DEFAULT '-',
  `VehicleName` varchar(35) NOT NULL DEFAULT '-',
  `CarSign` varchar(45) NOT NULL DEFAULT '-',
  `PosX` float NOT NULL DEFAULT 1708.04,
  `PosY` float NOT NULL DEFAULT -1035.8,
  `PosZ` float NOT NULL DEFAULT 23.9063,
  `PosA` float NOT NULL DEFAULT 358.535,
  `Interior` int(11) NOT NULL DEFAULT 0,
  `World` int(11) NOT NULL DEFAULT 0,
  `Color1` int(11) NOT NULL DEFAULT 0,
  `Color2` int(11) NOT NULL DEFAULT 0,
  `XMR` tinyint(1) NOT NULL DEFAULT 0,
  `Siren` tinyint(1) NOT NULL DEFAULT 0,
  `Locked` tinyint(1) NOT NULL DEFAULT 0,
  `Impounded` smallint(5) NOT NULL DEFAULT -1,
  `Fuel` float NOT NULL DEFAULT 100,
  `Mileage` float NOT NULL DEFAULT 0,
  `Armour` float NOT NULL DEFAULT 0,
  `EngineLife` float NOT NULL DEFAULT 100,
  `BatteryLife` float NOT NULL DEFAULT 100,
  `LockLevel` tinyint(1) NOT NULL DEFAULT 1,
  `AlarmLevel` tinyint(1) NOT NULL DEFAULT 1,
  `ImmobLevel` tinyint(1) NOT NULL DEFAULT 1,
  `Insurance` tinyint(1) NOT NULL DEFAULT 0,
  `InsuranceTime` int(11) NOT NULL DEFAULT 0,
  `InsurancePrice` int(11) NOT NULL DEFAULT 0,
  `TimesDestroyed` int(11) NOT NULL DEFAULT 0,
  `ReportedStolen` tinyint(1) NOT NULL DEFAULT 0,
  `ReportedStolenDate` int(11) NOT NULL DEFAULT 0,
  `Paintjob` int(11) NOT NULL DEFAULT -1,
  `CarMods1` int(11) NOT NULL DEFAULT -1,
  `CarMods2` int(11) NOT NULL DEFAULT -1,
  `CarMods3` int(11) NOT NULL DEFAULT -1,
  `CarMods4` int(11) NOT NULL DEFAULT -1,
  `CarMods5` int(11) NOT NULL DEFAULT -1,
  `CarMods6` int(11) NOT NULL DEFAULT -1,
  `CarMods7` int(11) NOT NULL DEFAULT -1,
  `CarMods8` int(11) NOT NULL DEFAULT -1,
  `CarMods9` int(11) NOT NULL DEFAULT -1,
  `CarMods10` int(11) NOT NULL DEFAULT -1,
  `CarMods11` int(11) NOT NULL DEFAULT -1,
  `CarMods12` int(11) NOT NULL DEFAULT -1,
  `CarMods13` int(11) NOT NULL DEFAULT -1,
  `CarMods14` int(11) NOT NULL DEFAULT -1,
  `CarDoors1` tinyint(1) NOT NULL DEFAULT 0,
  `CarDoors2` tinyint(1) NOT NULL DEFAULT 0,
  `CarDoors3` tinyint(1) NOT NULL DEFAULT 0,
  `CarDoors4` tinyint(1) NOT NULL DEFAULT 0,
  `CarWindows1` tinyint(1) NOT NULL DEFAULT 1,
  `CarWindows2` tinyint(1) NOT NULL DEFAULT 1,
  `CarWindows3` tinyint(1) NOT NULL DEFAULT 1,
  `CarWindows4` tinyint(1) NOT NULL DEFAULT 1,
  `LastDriver` int(11) NOT NULL DEFAULT 0,
  `LastPassenger` int(11) NOT NULL DEFAULT 0,
  `LastHealth` float NOT NULL DEFAULT 1000,
  `Panels` int(11) NOT NULL DEFAULT 0,
  `Doors` int(11) NOT NULL DEFAULT 0,
  `Lights` int(11) NOT NULL DEFAULT 0,
  `Tires` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin5;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `vehicle_drugs`
--

CREATE TABLE `vehicle_drugs` (
  `id` int(11) NOT NULL,
  `drug_name` varchar(64) NOT NULL,
  `drug_type` tinyint(2) NOT NULL,
  `drug_amount` float NOT NULL DEFAULT 0,
  `drug_quality` tinyint(3) NOT NULL DEFAULT 100,
  `drug_size` tinyint(1) NOT NULL DEFAULT 1,
  `vehicle_id` int(11) NOT NULL,
  `placed_by` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin5;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `vehicle_fines`
--

CREATE TABLE `vehicle_fines` (
  `id` int(11) NOT NULL,
  `vehicle_dbid` int(11) NOT NULL,
  `vehicle_x` float NOT NULL,
  `vehicle_y` float NOT NULL,
  `vehicle_z` float NOT NULL,
  `issuer_name` varchar(34) NOT NULL,
  `fine_amount` int(11) NOT NULL,
  `fine_faction` smallint(5) NOT NULL DEFAULT 0,
  `fine_reason` varchar(128) NOT NULL,
  `fine_date` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin5;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `vehicle_logs`
--

CREATE TABLE `vehicle_logs` (
  `log_id` int(11) NOT NULL,
  `vehicle_dbid` int(11) NOT NULL,
  `log_detail` varchar(256) COLLATE utf8_turkish_ci NOT NULL,
  `time` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `vehicle_weapons`
--

CREATE TABLE `vehicle_weapons` (
  `id` int(11) NOT NULL,
  `weapon` tinyint(2) NOT NULL,
  `ammo` smallint(5) NOT NULL,
  `vehicle_id` mediumint(5) NOT NULL,
  `offsetX` float NOT NULL,
  `offsetY` float NOT NULL,
  `offsetZ` float NOT NULL,
  `rotX` float NOT NULL,
  `rotY` float NOT NULL,
  `rotZ` float NOT NULL,
  `placed_by` mediumint(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin5;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `weapon_attachments`
--

CREATE TABLE `weapon_attachments` (
  `id` int(11) NOT NULL,
  `playerdbid` int(11) NOT NULL,
  `WeaponID` smallint(3) NOT NULL,
  `BoneID` smallint(3) NOT NULL,
  `Hidden` tinyint(1) NOT NULL DEFAULT 0,
  `PosX` float NOT NULL,
  `PosY` float NOT NULL,
  `PosZ` float NOT NULL,
  `RotX` float NOT NULL,
  `RotY` float NOT NULL,
  `RotZ` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin5;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `xmr_data`
--

CREATE TABLE `xmr_data` (
  `id` int(11) NOT NULL,
  `xmr_name` varchar(90) NOT NULL,
  `xmr_url` varchar(128) NOT NULL,
  `category` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `xmr_sub`
--

CREATE TABLE `xmr_sub` (
  `id` int(11) NOT NULL,
  `cat_name` varchar(90) NOT NULL DEFAULT '',
  `category_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dökümü yapılmış tablolar için indeksler
--

--
-- Tablo için indeksler `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `actors`
--
ALTER TABLE `actors`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `admin_logs`
--
ALTER TABLE `admin_logs`
  ADD PRIMARY KEY (`log_id`);

--
-- Tablo için indeksler `adverts`
--
ALTER TABLE `adverts`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `answers`
--
ALTER TABLE `answers`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `antenna`
--
ALTER TABLE `antenna`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `atms`
--
ALTER TABLE `atms`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `bans`
--
ALTER TABLE `bans`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `billboards`
--
ALTER TABLE `billboards`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `bulletins`
--
ALTER TABLE `bulletins`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `businesses`
--
ALTER TABLE `businesses`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `cameras`
--
ALTER TABLE `cameras`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `chopshop`
--
ALTER TABLE `chopshop`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `clothings`
--
ALTER TABLE `clothings`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `connections`
--
ALTER TABLE `connections`
  ADD PRIMARY KEY (`conn_id`);

--
-- Tablo için indeksler `criminal_record`
--
ALTER TABLE `criminal_record`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `dealerships`
--
ALTER TABLE `dealerships`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `dealership_categories`
--
ALTER TABLE `dealership_categories`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `doors`
--
ALTER TABLE `doors`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `entrances`
--
ALTER TABLE `entrances`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `event_participants`
--
ALTER TABLE `event_participants`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `factions`
--
ALTER TABLE `factions`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `faction_attachments`
--
ALTER TABLE `faction_attachments`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `faction_ranks`
--
ALTER TABLE `faction_ranks`
  ADD PRIMARY KEY (`faction_id`);

--
-- Tablo için indeksler `faction_roadblocks`
--
ALTER TABLE `faction_roadblocks`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `faction_uniforms`
--
ALTER TABLE `faction_uniforms`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `furnitures`
--
ALTER TABLE `furnitures`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `furniture_categories`
--
ALTER TABLE `furniture_categories`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `furniture_lists`
--
ALTER TABLE `furniture_lists`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `furniture_subcategories`
--
ALTER TABLE `furniture_subcategories`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `garages`
--
ALTER TABLE `garages`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `garbages`
--
ALTER TABLE `garbages`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `gates`
--
ALTER TABLE `gates`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `impoundlots`
--
ALTER TABLE `impoundlots`
  ADD PRIMARY KEY (`impoundID`);

--
-- Tablo için indeksler `log_ajail`
--
ALTER TABLE `log_ajail`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `log_anotes`
--
ALTER TABLE `log_anotes`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `log_kicks`
--
ALTER TABLE `log_kicks`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `models`
--
ALTER TABLE `models`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `objects`
--
ALTER TABLE `objects`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `paynsprays`
--
ALTER TABLE `paynsprays`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `players`
--
ALTER TABLE `players`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `player_anotes`
--
ALTER TABLE `player_anotes`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `player_clothing`
--
ALTER TABLE `player_clothing`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `player_contacts`
--
ALTER TABLE `player_contacts`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `player_drugs`
--
ALTER TABLE `player_drugs`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `player_fines`
--
ALTER TABLE `player_fines`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `player_logs`
--
ALTER TABLE `player_logs`
  ADD PRIMARY KEY (`log_id`);

--
-- Tablo için indeksler `player_notes`
--
ALTER TABLE `player_notes`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `player_packages`
--
ALTER TABLE `player_packages`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `properties`
--
ALTER TABLE `properties`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `property_drugs`
--
ALTER TABLE `property_drugs`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `property_weapons`
--
ALTER TABLE `property_weapons`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `questions`
--
ALTER TABLE `questions`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `sprays`
--
ALTER TABLE `sprays`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `staff`
--
ALTER TABLE `staff`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `streets`
--
ALTER TABLE `streets`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `street_pos`
--
ALTER TABLE `street_pos`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `teleports`
--
ALTER TABLE `teleports`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `tolls`
--
ALTER TABLE `tolls`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `truck_cargo`
--
ALTER TABLE `truck_cargo`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `ucp_applications_pool`
--
ALTER TABLE `ucp_applications_pool`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `ucp_blocks`
--
ALTER TABLE `ucp_blocks`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `ucp_mailboxes`
--
ALTER TABLE `ucp_mailboxes`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `ucp_news`
--
ALTER TABLE `ucp_news`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `ucp_news_comments`
--
ALTER TABLE `ucp_news_comments`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `vehicles`
--
ALTER TABLE `vehicles`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `vehicle_drugs`
--
ALTER TABLE `vehicle_drugs`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `vehicle_fines`
--
ALTER TABLE `vehicle_fines`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `vehicle_logs`
--
ALTER TABLE `vehicle_logs`
  ADD PRIMARY KEY (`log_id`);

--
-- Tablo için indeksler `vehicle_weapons`
--
ALTER TABLE `vehicle_weapons`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `weapon_attachments`
--
ALTER TABLE `weapon_attachments`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `xmr_data`
--
ALTER TABLE `xmr_data`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `xmr_sub`
--
ALTER TABLE `xmr_sub`
  ADD PRIMARY KEY (`id`);

--
-- Dökümü yapılmış tablolar için AUTO_INCREMENT değeri
--

--
-- Tablo için AUTO_INCREMENT değeri `accounts`
--
ALTER TABLE `accounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Tablo için AUTO_INCREMENT değeri `actors`
--
ALTER TABLE `actors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `admin_logs`
--
ALTER TABLE `admin_logs`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `adverts`
--
ALTER TABLE `adverts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `antenna`
--
ALTER TABLE `antenna`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `atms`
--
ALTER TABLE `atms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `bans`
--
ALTER TABLE `bans`
  MODIFY `id` mediumint(8) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `billboards`
--
ALTER TABLE `billboards`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `bulletins`
--
ALTER TABLE `bulletins`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `businesses`
--
ALTER TABLE `businesses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Tablo için AUTO_INCREMENT değeri `cameras`
--
ALTER TABLE `cameras`
  MODIFY `id` smallint(5) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `chopshop`
--
ALTER TABLE `chopshop`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `clothings`
--
ALTER TABLE `clothings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `connections`
--
ALTER TABLE `connections`
  MODIFY `conn_id` int(8) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Tablo için AUTO_INCREMENT değeri `criminal_record`
--
ALTER TABLE `criminal_record`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `dealerships`
--
ALTER TABLE `dealerships`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `dealership_categories`
--
ALTER TABLE `dealership_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `doors`
--
ALTER TABLE `doors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `entrances`
--
ALTER TABLE `entrances`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `events`
--
ALTER TABLE `events`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `event_participants`
--
ALTER TABLE `event_participants`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `factions`
--
ALTER TABLE `factions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `faction_attachments`
--
ALTER TABLE `faction_attachments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `faction_roadblocks`
--
ALTER TABLE `faction_roadblocks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `faction_uniforms`
--
ALTER TABLE `faction_uniforms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `furnitures`
--
ALTER TABLE `furnitures`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `furniture_categories`
--
ALTER TABLE `furniture_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `furniture_lists`
--
ALTER TABLE `furniture_lists`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `furniture_subcategories`
--
ALTER TABLE `furniture_subcategories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `garages`
--
ALTER TABLE `garages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `garbages`
--
ALTER TABLE `garbages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `gates`
--
ALTER TABLE `gates`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `impoundlots`
--
ALTER TABLE `impoundlots`
  MODIFY `impoundID` int(12) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `log_ajail`
--
ALTER TABLE `log_ajail`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `log_anotes`
--
ALTER TABLE `log_anotes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `log_kicks`
--
ALTER TABLE `log_kicks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `models`
--
ALTER TABLE `models`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `objects`
--
ALTER TABLE `objects`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `paynsprays`
--
ALTER TABLE `paynsprays`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `players`
--
ALTER TABLE `players`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Tablo için AUTO_INCREMENT değeri `player_anotes`
--
ALTER TABLE `player_anotes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Tablo için AUTO_INCREMENT değeri `player_clothing`
--
ALTER TABLE `player_clothing`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Tablo için AUTO_INCREMENT değeri `player_contacts`
--
ALTER TABLE `player_contacts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Tablo için AUTO_INCREMENT değeri `player_drugs`
--
ALTER TABLE `player_drugs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Tablo için AUTO_INCREMENT değeri `player_fines`
--
ALTER TABLE `player_fines`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `player_logs`
--
ALTER TABLE `player_logs`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Tablo için AUTO_INCREMENT değeri `player_notes`
--
ALTER TABLE `player_notes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `player_packages`
--
ALTER TABLE `player_packages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `properties`
--
ALTER TABLE `properties`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Tablo için AUTO_INCREMENT değeri `property_weapons`
--
ALTER TABLE `property_weapons`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `questions`
--
ALTER TABLE `questions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `sprays`
--
ALTER TABLE `sprays`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `staff`
--
ALTER TABLE `staff`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `streets`
--
ALTER TABLE `streets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=276;

--
-- Tablo için AUTO_INCREMENT değeri `street_pos`
--
ALTER TABLE `street_pos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5009;

--
-- Tablo için AUTO_INCREMENT değeri `teleports`
--
ALTER TABLE `teleports`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `tolls`
--
ALTER TABLE `tolls`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `truck_cargo`
--
ALTER TABLE `truck_cargo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `ucp_applications_pool`
--
ALTER TABLE `ucp_applications_pool`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `ucp_blocks`
--
ALTER TABLE `ucp_blocks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `ucp_mailboxes`
--
ALTER TABLE `ucp_mailboxes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `ucp_news`
--
ALTER TABLE `ucp_news`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `ucp_news_comments`
--
ALTER TABLE `ucp_news_comments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Tablo için AUTO_INCREMENT değeri `vehicles`
--
ALTER TABLE `vehicles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `vehicle_drugs`
--
ALTER TABLE `vehicle_drugs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `vehicle_fines`
--
ALTER TABLE `vehicle_fines`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `vehicle_logs`
--
ALTER TABLE `vehicle_logs`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `vehicle_weapons`
--
ALTER TABLE `vehicle_weapons`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `weapon_attachments`
--
ALTER TABLE `weapon_attachments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `xmr_data`
--
ALTER TABLE `xmr_data`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `xmr_sub`
--
ALTER TABLE `xmr_sub`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
