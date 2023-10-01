-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 01, 2023 at 11:25 AM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `stock`
--

-- --------------------------------------------------------

--
-- Table structure for table `item_category_list`
--

CREATE TABLE `item_category_list` (
  `Item_CateID` int(11) NOT NULL,
  `Item_Cate_Name` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `item_category_list`
--

INSERT INTO `item_category_list` (`Item_CateID`, `Item_Cate_Name`) VALUES
(1, 'Bread'),
(2, 'Cake');

-- --------------------------------------------------------

--
-- Table structure for table `item_component`
--

CREATE TABLE `item_component` (
  `Item_DID` int(11) NOT NULL,
  `Item_ID` int(11) NOT NULL,
  `Item_CID` int(11) NOT NULL,
  `Amount` int(11) NOT NULL,
  `Unit_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `item_component`
--

INSERT INTO `item_component` (`Item_DID`, `Item_ID`, `Item_CID`, `Amount`, `Unit_ID`) VALUES
(1, 1, 1, 10, 1),
(2, 1, 2, 5, 1),
(3, 1, 3, 5, 1);

-- --------------------------------------------------------

--
-- Table structure for table `item_component_list`
--

CREATE TABLE `item_component_list` (
  `Item_CID` int(11) NOT NULL,
  `Item_CName` text NOT NULL,
  `item_CAmount` int(11) NOT NULL,
  `Item_Cost` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `item_component_list`
--

INSERT INTO `item_component_list` (`Item_CID`, `Item_CName`, `item_CAmount`, `Item_Cost`) VALUES
(1, 'Sugar', 100, 3),
(2, 'Egg', 1, 5),
(3, 'Flour', 100, 5),
(4, 'Yeast', 10, 10),
(5, 'Salt', 100, 3),
(6, 'Milk', 100, 6);

-- --------------------------------------------------------

--
-- Table structure for table `item_list`
--

CREATE TABLE `item_list` (
  `Item_ID` int(11) NOT NULL,
  `Item_Name` text NOT NULL,
  `Item_Description` text DEFAULT NULL,
  `Item_Price` int(11) NOT NULL,
  `Item_Category` text NOT NULL,
  `Quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `item_list`
--

INSERT INTO `item_list` (`Item_ID`, `Item_Name`, `Item_Description`, `Item_Price`, `Item_Category`, `Quantity`) VALUES
(1, 'Cake', 'cake', 10, '2', 0);

-- --------------------------------------------------------

--
-- Table structure for table `role`
--

CREATE TABLE `role` (
  `Role_ID` int(11) NOT NULL,
  `Role_Name` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `role`
--

INSERT INTO `role` (`Role_ID`, `Role_Name`) VALUES
(1, 'Manager');

-- --------------------------------------------------------

--
-- Table structure for table `transaction_detail`
--

CREATE TABLE `transaction_detail` (
  `TDetail_ID` int(11) NOT NULL,
  `Transaction_ID` int(11) NOT NULL,
  `Item_ID` int(11) NOT NULL,
  `Amount` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `transaction_history`
--

CREATE TABLE `transaction_history` (
  `Transaction_ID` int(11) NOT NULL,
  `User_ID` int(11) NOT NULL,
  `Total_Price` int(11) NOT NULL DEFAULT 0,
  `Timestamp` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `unit_list`
--

CREATE TABLE `unit_list` (
  `Unit_ID` int(11) NOT NULL,
  `Unit_Name` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `unit_list`
--

INSERT INTO `unit_list` (`Unit_ID`, `Unit_Name`) VALUES
(1, 'g'),
(2, 'ml');

-- --------------------------------------------------------

--
-- Table structure for table `user_list`
--

CREATE TABLE `user_list` (
  `User_ID` int(11) NOT NULL,
  `Username` text NOT NULL,
  `Password` text NOT NULL,
  `Firstname` text NOT NULL,
  `Surname` text NOT NULL,
  `Email` text DEFAULT NULL,
  `Address` text DEFAULT NULL,
  `Phone` text DEFAULT NULL,
  `Role_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user_list`
--

INSERT INTO `user_list` (`User_ID`, `Username`, `Password`, `Firstname`, `Surname`, `Email`, `Address`, `Phone`, `Role_ID`) VALUES
(1, 'Patipon', 'f5f8e19ed4acf4d2ebc670abd188a488', 'Patipon', 'Chuasiriporn', 'Patipon@gmail.com ', 'Street:  740/4-5 Soi Phyanark Phetburi Road  City:  Rajthevee  State/province/area:    Bangkok', '06622158439', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `item_category_list`
--
ALTER TABLE `item_category_list`
  ADD PRIMARY KEY (`Item_CateID`);

--
-- Indexes for table `item_component`
--
ALTER TABLE `item_component`
  ADD PRIMARY KEY (`Item_DID`);

--
-- Indexes for table `item_component_list`
--
ALTER TABLE `item_component_list`
  ADD PRIMARY KEY (`Item_CID`);

--
-- Indexes for table `item_list`
--
ALTER TABLE `item_list`
  ADD PRIMARY KEY (`Item_ID`);

--
-- Indexes for table `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`Role_ID`);

--
-- Indexes for table `transaction_detail`
--
ALTER TABLE `transaction_detail`
  ADD PRIMARY KEY (`TDetail_ID`);

--
-- Indexes for table `transaction_history`
--
ALTER TABLE `transaction_history`
  ADD PRIMARY KEY (`Transaction_ID`);

--
-- Indexes for table `unit_list`
--
ALTER TABLE `unit_list`
  ADD PRIMARY KEY (`Unit_ID`);

--
-- Indexes for table `user_list`
--
ALTER TABLE `user_list`
  ADD PRIMARY KEY (`User_ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `item_category_list`
--
ALTER TABLE `item_category_list`
  MODIFY `Item_CateID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `item_component`
--
ALTER TABLE `item_component`
  MODIFY `Item_DID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `item_component_list`
--
ALTER TABLE `item_component_list`
  MODIFY `Item_CID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `item_list`
--
ALTER TABLE `item_list`
  MODIFY `Item_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `role`
--
ALTER TABLE `role`
  MODIFY `Role_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `transaction_detail`
--
ALTER TABLE `transaction_detail`
  MODIFY `TDetail_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `transaction_history`
--
ALTER TABLE `transaction_history`
  MODIFY `Transaction_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `unit_list`
--
ALTER TABLE `unit_list`
  MODIFY `Unit_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `user_list`
--
ALTER TABLE `user_list`
  MODIFY `User_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
