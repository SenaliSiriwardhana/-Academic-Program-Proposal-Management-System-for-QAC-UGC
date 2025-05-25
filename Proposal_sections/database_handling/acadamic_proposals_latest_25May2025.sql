-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 25, 2025 at 08:11 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `acadamic_proposals`
--

-- --------------------------------------------------------

--
-- Table structure for table `proposals`
--

CREATE TABLE `proposals` (
  `proposal_id` int(11) NOT NULL,
  `university_id` int(11) NOT NULL,
  `created_by` int(11) NOT NULL,
  `status` enum('fresh','draft','submitted','under_review','approvedbydean','rejectedbydean','rejectedbyvc','approvedbyvc','approvedbycqa','rejectedbycqa','approvedbyugcfinance','rejectedbyugcfinance','approvedbyugchr','rejectedbyugchr','approvedbyugcidd','rejecteddbyugcidd','approvedbyugclegal','rejectedbyugclegal','approvedbyugcacademic','rejectedbyugcacademic','approvedbyugcadmission','rejectedbyugcadmission','approvedbyqachead','rejectedbyqachead') DEFAULT 'draft',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `submitted_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `proposals`
--

INSERT INTO `proposals` (`proposal_id`, `university_id`, `created_by`, `status`, `created_at`, `updated_at`, `submitted_at`, `id`) VALUES
(1, 1, 2, 'approvedbyugcacademic', '2025-03-08 13:35:50', '2025-03-08 14:35:44', '2025-03-08 09:56:02', NULL),
(2, 1, 2, 'approvedbyugcidd', '2025-03-08 15:02:06', '2025-03-16 02:47:04', '2025-03-16 02:47:04', NULL),
(3, 1, 2, 'rejectedbyqachead', '2025-03-08 17:02:06', '2025-05-15 17:59:06', '2025-05-15 17:59:06', NULL),
(4, 1, 2, 'fresh', '2025-03-08 17:44:13', '2025-03-08 17:44:13', NULL, NULL),
(5, 1, 2, 'fresh', '2025-03-08 17:44:34', '2025-03-08 17:44:34', NULL, NULL),
(6, 1, 2, 'submitted', '2025-03-08 17:46:41', '2025-05-25 18:01:55', '2025-05-25 14:31:55', NULL),
(7, 1, 2, 'approvedbyqachead', '2025-03-08 18:38:45', '2025-03-16 06:32:16', '2025-03-16 06:32:16', NULL),
(8, 1, 2, 'fresh', '2025-03-09 07:25:48', '2025-03-09 07:25:48', NULL, NULL),
(9, 1, 2, 'fresh', '2025-03-09 09:06:12', '2025-03-09 09:06:12', NULL, NULL),
(10, 1, 2, 'fresh', '2025-03-09 13:51:22', '2025-03-09 13:51:22', NULL, NULL),
(11, 1, 2, 'fresh', '2025-03-09 14:11:23', '2025-03-09 14:11:23', NULL, NULL),
(12, 1, 2, 'fresh', '2025-03-09 14:29:36', '2025-03-09 14:29:36', NULL, NULL),
(13, 1, 2, 'rejectedbycqa', '2025-03-14 18:32:17', '2025-05-16 07:09:58', '2025-05-16 07:09:58', NULL),
(14, 1, 2, 'draft', '2025-03-15 07:08:06', '2025-03-15 07:12:14', NULL, NULL),
(15, 1, 2, 'fresh', '2025-03-15 08:39:59', '2025-03-15 08:39:59', NULL, NULL),
(16, 1, 2, 'submitted', '2025-03-15 18:32:21', '2025-03-16 06:30:24', '2025-03-16 02:00:24', NULL),
(18, 3, 20, 'submitted', '2025-03-15 19:32:13', '2025-03-15 19:41:23', '2025-03-15 19:41:23', NULL),
(19, 1, 2, 'draft', '2025-03-16 06:15:43', '2025-03-16 06:16:46', '2025-03-16 06:16:46', NULL),
(20, 1, 2, 'fresh', '2025-05-15 17:29:27', '2025-05-15 17:29:27', NULL, NULL),
(21, 1, 2, 'fresh', '2025-05-16 03:24:58', '2025-05-16 03:24:58', NULL, NULL),
(22, 1, 2, 'fresh', '2025-05-16 06:30:41', '2025-05-16 06:30:41', NULL, NULL),
(23, 1, 2, 'draft', '2025-05-16 09:07:13', '2025-05-16 09:17:14', '2025-05-16 09:17:14', NULL),
(24, 1, 2, 'draft', '2025-05-25 17:37:48', '2025-05-25 17:46:47', '2025-05-25 17:46:47', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `proposal_assessment_rules`
--

CREATE TABLE `proposal_assessment_rules` (
  `proposal_id` int(11) NOT NULL,
  `formative_summative` text NOT NULL,
  `grading_scheme` text NOT NULL,
  `gpa_calculation` text NOT NULL,
  `semester_contribution` text NOT NULL,
  `inplant_training` text NOT NULL,
  `repeat_exams` text NOT NULL,
  `degree_requirements` text NOT NULL,
  `class_requirements` text NOT NULL,
  `assessment_rule_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `proposal_assessment_rules`
--

INSERT INTO `proposal_assessment_rules` (`proposal_id`, `formative_summative`, `grading_scheme`, `gpa_calculation`, `semester_contribution`, `inplant_training`, `repeat_exams`, `degree_requirements`, `class_requirements`, `assessment_rule_id`) VALUES
(1, 'x', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 1),
(2, 'xa', 'xa', 'ax', 'xa', 'xa', 'xa', 'xa', 'ax', 2),
(3, 'cdc', 'dc', 'ecdc', 'dc', 'dsc', 'dsc', 'dc', 'dsc', 3),
(7, 'fv', 'efve', 'cv', 'evr', 'erv', 'verev', 'r', 'ver', 4),
(6, 'fwe', 'fwe', 'few', 'wef', 'wef', 'wef', 'ewf', 'wef', 5),
(16, 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 6),
(13, 'dcds', 'fc', 'sdf', 'sdf', 'sdf', 'dsf', 'sdf', 'sdf', 7),
(18, 'sdf', 'sdf', 'sdf', 'sdf', 'sdf', 'dsf', 'sdf', 'sdf', 9),
(14, 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 10);

-- --------------------------------------------------------

--
-- Table structure for table `proposal_comments`
--

CREATE TABLE `proposal_comments` (
  `comment_id` int(11) NOT NULL,
  `proposal_id` int(11) NOT NULL,
  `comment` varchar(1000) NOT NULL,
  `seal_and_sign` varchar(10000) DEFAULT NULL,
  `proposal_status` varchar(1000) NOT NULL,
  `id` int(11) NOT NULL,
  `Date` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `proposal_comments`
--

INSERT INTO `proposal_comments` (`comment_id`, `proposal_id`, `comment`, `seal_and_sign`, `proposal_status`, `id`, `Date`) VALUES
(1, 1, 'Reviewer Details wrong.', NULL, 'rejectedbydean', 3, '2025-03-08'),
(2, 1, 'Lot of Reviewer Details.', NULL, 'rejectedbydean', 3, '2025-03-08'),
(3, 1, 'Cooperate evidence file type should be pdf.', NULL, 'rejectedbydean', 3, '2025-03-08'),
(4, 1, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1741444025_action.pdf', 'approvedbydean', 3, '2025-03-08'),
(5, 1, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1741444096_action.pdf', 'approvedbyvc', 5, '2025-03-08'),
(6, 1, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1741444162_action.pdf', 'approvedbycqa', 6, '2025-03-08'),
(7, 1, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1741444237_action.pdf', 'approvedbyqachead', 7, '2025-03-08'),
(8, 1, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1741444359_action.pdf', 'approvedbyugcfinance', 8, '2025-03-08'),
(9, 1, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1741444396_action.pdf', 'approvedbyugchr', 9, '2025-03-08'),
(10, 1, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1741444424_action.pdf', 'approvedbyugcidd', 10, '2025-03-08'),
(11, 1, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1741444455_action.pdf', 'approvedbyugclegal', 11, '2025-03-08'),
(12, 1, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1741444515_action.pdf', 'approvedbyugcadmission', 13, '2025-03-08'),
(13, 1, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1741444544_action.pdf', 'approvedbyugcacademic', 12, '2025-03-08'),
(14, 2, 'Rejected.', NULL, 'rejectedbydean', 3, '2025-03-08'),
(15, 2, 'REJECTED', NULL, 'rejectedbydean', 3, '2025-03-08'),
(16, 2, 'Mandate Availability Attachments are wrong.', NULL, 'rejectedbydean', 3, '2025-03-08'),
(17, 2, 'Rejected', NULL, 'rejectedbydean', 3, '2025-03-08'),
(18, 2, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1741451051_action.pdf', 'approvedbydean', 3, '2025-03-08'),
(20, 2, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1741452160_action.pdf', 'approvedbyvc', 5, '2025-03-08'),
(21, 2, 'REJECTED', NULL, 'rejectedbycqa', 6, '2025-03-08'),
(22, 2, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1741452483_action.pdf', 'approvedbydean', 3, '2025-03-08'),
(23, 2, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1741454397_action.pdf', 'approvedbyvc', 5, '2025-03-08'),
(24, 3, 'Approved.', NULL, '', 3, '2025-03-09'),
(25, 3, 'Approved.', NULL, '', 3, '2025-03-09'),
(26, 3, '', NULL, '', 3, '2025-03-09'),
(27, 3, 'Approved.', NULL, '', 3, '2025-03-09'),
(28, 3, 'Approved.', NULL, '', 3, '2025-03-09'),
(29, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1741461607_action.pdf', 'approvedbydean', 3, '2025-03-09'),
(30, 3, 'Degree name wrong.', NULL, 'rejectedbyvc', 5, '2025-03-09'),
(31, 3, 'Rejected. Check Mandate availability file uploads.', NULL, 'rejectedbydean', 3, '2025-03-09'),
(32, 3, 'Rejected.', NULL, 'rejectedbydean', 3, '2025-03-09'),
(33, 6, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1741514462_action.pdf', 'approvedbydean', 3, '2025-03-09'),
(34, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742020550_1738158952_dummy.pdf', 'approvedbydean', 3, '2025-03-15'),
(35, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742020589_1739894675_action.pdf', 'approvedbyvc', 5, '2025-03-15'),
(36, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742020645_1739894675_action.pdf', 'approvedbycqa', 6, '2025-03-15'),
(37, 3, 'Rejected.', NULL, 'rejectedbyqachead', 7, '2025-03-15'),
(38, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742020774_1739894675_action.pdf', 'approvedbydean', 3, '2025-03-15'),
(39, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742020808_1739894675_action.pdf', 'approvedbyvc', 5, '2025-03-15'),
(40, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742020834_1739894675_action.pdf', 'approvedbycqa', 6, '2025-03-15'),
(41, 3, 'Rejected', NULL, 'rejectedbyqachead', 7, '2025-03-15'),
(42, 3, 'Approved', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742020911_1739894675_action.pdf', 'approvedbydean', 3, '2025-03-15'),
(43, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742020944_1739894675_action.pdf', 'approvedbyvc', 5, '2025-03-15'),
(44, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742020974_1739894675_action.pdf', 'approvedbycqa', 6, '2025-03-15'),
(45, 3, '', NULL, 'rejectedbyqachead', 7, '2025-03-15'),
(46, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742021076_1739894675_action.pdf', 'approvedbydean', 3, '2025-03-15'),
(47, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742021105_1739894675_action.pdf', 'approvedbyvc', 5, '2025-03-15'),
(48, 3, 'Approved', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742021131_1739894675_action.pdf', 'approvedbycqa', 6, '2025-03-15'),
(49, 3, 'Rejected', NULL, 'rejectedbyqachead', 7, '2025-03-15'),
(50, 7, 'Approved', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742028101_1739894675_action.pdf', 'approvedbydean', 3, '2025-03-15'),
(51, 7, 'Approved', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742028219_1739894675_action.pdf', 'approvedbyvc', 5, '2025-03-15'),
(52, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742050546_1739894675_action.pdf', 'approvedbydean', 3, '2025-03-15'),
(53, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742050715_1739894675_action.pdf', 'approvedbydean', 3, '2025-03-15'),
(54, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742050733_1739894675_action.pdf', 'approvedbydean', 3, '2025-03-15'),
(55, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742050746_1739894675_action.pdf', 'rejectedbydean', 3, '2025-03-15'),
(56, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742050984_1739894675_action.pdf', 'approvedbydean', 3, '2025-03-15'),
(57, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742051008_1739894675_action.pdf', 'approvedbycqa', 6, '2025-03-15'),
(58, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742051029_1739894675_action.pdf', 'approvedbyvc', 5, '2025-03-15'),
(59, 6, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742051138_1739894675_action.pdf', 'approvedbycqa', 6, '2025-03-15'),
(60, 3, '', NULL, 'rejectedbyqachead', 7, '2025-03-15'),
(61, 3, 'Rejected.', NULL, 'rejectedbyqachead', 7, '2025-03-15'),
(62, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742051507_1739894675_action.pdf', 'approvedbydean', 3, '2025-03-15'),
(63, 3, 'REJECTED', NULL, 'rejectedbycqa', 6, '2025-03-15'),
(64, 3, 'Approved.', NULL, '', 3, '2025-03-15'),
(65, 3, 'Approved.', NULL, '', 3, '2025-03-15'),
(66, 3, 'Approved.', NULL, '', 3, '2025-03-15'),
(67, 3, 'A', NULL, '', 3, '2025-03-15'),
(68, 3, 'A', NULL, '', 3, '2025-03-15'),
(69, 3, 'Rejected.', NULL, 'rejectedbydean', 3, '2025-03-15'),
(70, 3, 'Rejected.', NULL, 'rejectedbydean', 3, '2025-03-15'),
(71, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742052970_1739894675_action.pdf', 'approvedbydean', 3, '2025-03-15'),
(72, 3, 'Approved.', NULL, '', 6, '2025-03-15'),
(73, 3, 'Approved.', NULL, '', 6, '2025-03-15'),
(74, 3, 'Approved.', NULL, '', 6, '2025-03-15'),
(75, 3, 'Rejected.', NULL, 'rejectedbycqa', 6, '2025-03-15'),
(76, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742054852_1739894675_action.pdf', 'approvedbydean', 3, '2025-03-15'),
(77, 2, 'Approved.', NULL, '', 7, '2025-03-15'),
(78, 2, 'Rejected.', NULL, 'rejectedbyqachead', 7, '2025-03-15'),
(79, 3, 'Approved.', NULL, '', 7, '2025-03-15'),
(80, 3, 'Rejected.', NULL, 'rejectedbyqachead', 7, '2025-03-15'),
(81, 3, 'Approved.', NULL, '', 7, '2025-03-15'),
(82, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742055767_1739894675_action.pdf', 'approvedbyqachead', 7, '2025-03-15'),
(83, 3, 'Rejected.', NULL, 'rejectedbyqachead', 7, '2025-03-15'),
(84, 3, 'Approved.', NULL, '', 3, '2025-03-15'),
(85, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742055875_1739894675_action.pdf', 'approvedbydean', 3, '2025-03-15'),
(86, 6, 'Rejected.', NULL, 'rejectedbyvc', 5, '2025-03-15'),
(87, 3, 'Approved.', NULL, '', 6, '2025-03-15'),
(88, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742055963_1739894675_action.pdf', 'approvedbycqa', 6, '2025-03-15'),
(89, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742055990_1739894675_action.pdf', 'approvedbyvc', 5, '2025-03-15'),
(90, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742056008_1739894675_action.pdf', 'approvedbyqachead', 7, '2025-03-15'),
(91, 3, 'Approved.', NULL, '', 8, '2025-03-15'),
(92, 3, 'Rejected.', NULL, 'rejectedbyugcfinance', 8, '2025-03-15'),
(93, 13, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742065107_1739894675_action.pdf', 'approvedbydean', 3, '2025-03-16'),
(94, 13, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742065138_1739894675_action.pdf', 'approvedbycqa', 6, '2025-03-16'),
(95, 13, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742065177_1739894675_action.pdf', 'approvedbyvc', 5, '2025-03-16'),
(96, 13, 'Rejected', NULL, 'rejectedbyqachead', 7, '2025-03-16'),
(97, 16, 'Approved', NULL, '', 3, '2025-03-16'),
(98, 16, 'Approved', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742106406_Application_Summary - 2025-03-16T002508.601.pdf', 'approvedbydean', 3, '2025-03-16'),
(99, 16, 'Approved', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742106488_Application_Summary - 2025-03-16T010522.989.pdf', 'approvedbycqa', 6, '2025-03-16'),
(100, 16, 'rejected', NULL, 'rejectedbyvc', 5, '2025-03-16'),
(101, 7, 'Approved', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742106736_Application_Summary - 2025-03-16T010522.989.pdf', 'approvedbyqachead', 7, '2025-03-16'),
(102, 3, 'Approved_M', 'http://localhost/qac_ugc/Proposal_sections/uploads/1743622196_Application_Summary - 2025-03-16T115318.196.pdf', 'approvedbydean', 3, '2025-04-03'),
(103, 3, 'A', NULL, 'rejectedbydean', 3, '2025-05-15'),
(104, 13, '', NULL, 'rejectedbydean', 3, '2025-05-16'),
(105, 13, 'Approved.', NULL, '', 3, '2025-05-16'),
(106, 13, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1747366738_1738158952_dummy.pdf', 'approvedbydean', 3, '2025-05-16'),
(107, 13, 'aa', NULL, 'rejectedbycqa', 6, '2025-05-16');

-- --------------------------------------------------------

--
-- Table structure for table `proposal_compliance_check`
--

CREATE TABLE `proposal_compliance_check` (
  `proposal_id` int(11) NOT NULL,
  `resources_commence` enum('Yes','No') NOT NULL,
  `fallback_options` enum('Yes','No') NOT NULL,
  `fallback_qualification` varchar(1000) DEFAULT NULL,
  `collaboration` enum('Yes','No') NOT NULL,
  `collaboration_details` varchar(1000) DEFAULT NULL,
  `access_facilities` varchar(1000) NOT NULL,
  `professional_membership` varchar(1000) NOT NULL,
  `compliance_check_id` int(11) NOT NULL,
  `fallback_attachment` varchar(1000) DEFAULT NULL,
  `collaboration_attachment` varchar(1000) DEFAULT NULL,
  `access_facilities_attachment` varchar(1000) DEFAULT NULL,
  `membership_attachment` varchar(1000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `proposal_compliance_check`
--

INSERT INTO `proposal_compliance_check` (`proposal_id`, `resources_commence`, `fallback_options`, `fallback_qualification`, `collaboration`, `collaboration_details`, `access_facilities`, `professional_membership`, `compliance_check_id`, `fallback_attachment`, `collaboration_attachment`, `access_facilities_attachment`, `membership_attachment`) VALUES
(1, 'Yes', 'Yes', 'Higher Diploma (SLQF 4)', 'Yes', 'R4R', 'Yes', 'Yes', 1, '/qac_ugc/Proposal_sections/uploads/1741441846_Application_Summary - 2025-03-08T183205.888.pdf', '/qac_ugc/Proposal_sections/uploads/1741441846_Application_Summary - 2025-03-08T183205.888.pdf', '/qac_ugc/Proposal_sections/uploads/1741441846_Application_Summary - 2025-03-08T183205.888.pdf', '/qac_ugc/Proposal_sections/uploads/1741441846_Application_Summary (100).pdf'),
(2, 'Yes', 'Yes', 'Higher Diploma (SLQF 4)', 'Yes', 'ceds', 'Yes', 'Yes', 2, '/qac_ugc/Proposal_sections/uploads/1741446353_benchmark.pdf', '/qac_ugc/Proposal_sections/uploads/1741446353_benchmark.pdf', '', ''),
(3, 'Yes', 'Yes', 'Higher Diploma (SLQF 4)', 'Yes', 'cerv', 'Yes', 'Yes', 3, '', '', '', ''),
(7, 'Yes', 'Yes', 'Higher Diploma (SLQF 4)', 'No', '', 'Yes', 'Yes', 4, '', '', '', ''),
(6, 'Yes', 'Yes', 'Higher Diploma (SLQF 4)', 'Yes', 'YES...', 'No', 'No', 5, '/qac_ugc/Proposal_sections/uploads/1748196112_1739894675_council.pdf', '/qac_ugc/Proposal_sections/uploads/1741509453_Application_Summary - 2025-03-09T131834.935.pdf', '', ''),
(16, 'Yes', 'Yes', 'Bachelors Degree (SLQF 5)', 'Yes', 'A', 'Yes', 'Yes', 6, '/qac_ugc/Proposal_sections/uploads/1742063885_1739718211_action.pdf', '', '', ''),
(13, 'Yes', 'Yes', 'Bachelors Degree (SLQF 5)', 'Yes', 'gfbh', 'Yes', 'Yes', 7, '/qac_ugc/Proposal_sections/uploads/1742064226_1739718375_fallback.pdf', '', '', ''),
(18, 'Yes', 'Yes', 'Higher Diploma (SLQF 4)', 'Yes', 'regtrg', 'Yes', 'Yes', 9, '/qac_ugc/Proposal_sections/uploads/1742067320_1739720192_benchmark.pdf', '', '', ''),
(14, 'Yes', 'Yes', 'Bachelors Degree (SLQF 5)', 'Yes', '', 'Yes', 'Yes', 10, '', '', '', ''),
(23, 'Yes', 'Yes', 'Higher Diploma (SLQF 4)', 'Yes', '', 'Yes', 'Yes', 11, '/qac_ugc/Proposal_sections/uploads/1748189046_1739894675_cooperate.pdf', '', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `proposal_degree_details`
--

CREATE TABLE `proposal_degree_details` (
  `background_to_program` text NOT NULL,
  `mandate_faculty` text NOT NULL,
  `faculty_status` text NOT NULL,
  `student_intake` text NOT NULL,
  `staff_cadres` text NOT NULL,
  `educational_facilities` text NOT NULL,
  `common_facilities` text NOT NULL,
  `program_benefits` text NOT NULL,
  `eligibility_req` text NOT NULL,
  `indicate_program` text NOT NULL,
  `admission_process` text NOT NULL,
  `other_criteria` text NOT NULL,
  `intake` int(11) NOT NULL,
  `degree_type` varchar(100) NOT NULL,
  `duration` varchar(50) NOT NULL,
  `coursework_credits` int(11) NOT NULL,
  `thesis_credits` int(11) NOT NULL,
  `total_credits` int(11) NOT NULL,
  `medium_of_instruction` set('English','Sinhala','Tamil') NOT NULL,
  `degree_id` int(11) NOT NULL,
  `proposal_id` int(11) NOT NULL,
  `subject_benchmark` varchar(1000) DEFAULT NULL,
  `slqf_level` set('Level 5 (Bachelors)','Level 6 (Bachelors Honours - 4 year programme)') DEFAULT NULL,
  `rec_in_review_report` text NOT NULL,
  `degree_details_objective` varchar(1000) NOT NULL,
  `degree_details_justification` varchar(1000) NOT NULL,
  `slqf_filled` set('Yes','No') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `proposal_degree_details`
--

INSERT INTO `proposal_degree_details` (`background_to_program`, `mandate_faculty`, `faculty_status`, `student_intake`, `staff_cadres`, `educational_facilities`, `common_facilities`, `program_benefits`, `eligibility_req`, `indicate_program`, `admission_process`, `other_criteria`, `intake`, `degree_type`, `duration`, `coursework_credits`, `thesis_credits`, `total_credits`, `medium_of_instruction`, `degree_id`, `proposal_id`, `subject_benchmark`, `slqf_level`, `rec_in_review_report`, `degree_details_objective`, `degree_details_justification`, `slqf_filled`) VALUES
('B2', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', ' A   ', 'UGC Z score based selection', '', 50, 'Bachelor Honours Degree', '4', 5, 5, 120, 'Sinhala', 1, 1, '/qac_ugc/Proposal_sections/uploads/1741441633_Application_Summary (70).pdf', 'Level 6 (Bachelors Honours - 4 year programme)', '', '', '', ''),
('axsasx', 'asx', 'asx', 'sxa', 'sax', 'sxas', 'ax', 'sxa', 'sxa', ' sax', 'UGC Z score based selection', '', 50, 'Bachelor', '3', 5, 5, 90, 'Sinhala', 2, 2, '/qac_ugc/Proposal_sections/uploads/1741446181_cooperate.pdf', 'Level 6 (Bachelors Honours - 4 year programme)', '', '', '', ''),
('xes', 'xwex', 'ewx', 'xew', 'xew', 'xwe', 'wex', 'xewew', 'xw', ' xw', 'UGC Z score based selection', '', 50, 'Bachelor Honours Degree', '4', 5, 5, 120, 'English', 3, 3, '/qac_ugc/Proposal_sections/uploads/1741455633_benchmark.pdf', 'Level 6 (Bachelors Honours - 4 year programme)', '', '', '', ''),
('cecre', 'erc', 'ec', 'erc', 'cr', 'ce', 'ce', 'cee', 'fceds', ' rfeerf ', 'UGC Z score based selection', '', 50, 'Bachelor', '3', 5, 5, 90, 'Sinhala', 4, 7, '/qac_ugc/Proposal_sections/uploads/1741459368_Application_Summary - 2025-03-08T192630.651.pdf', 'Level 6 (Bachelors Honours - 4 year programme)', '', '', '', ''),
('dww', 'fwef', 'wef', 'ewf', 'wefw', 'efwef', 'wef', 'wefwf', 'few', ' f  ', 'UGC Z score based selection', '', 50, 'Bachelor Honours Degree', '4', 5, 5, 120, 'Sinhala', 5, 6, '/qac_ugc/Proposal_sections/uploads/1741509290_Application_Summary - 2025-03-09T131234.588.pdf', 'Level 6 (Bachelors Honours - 4 year programme)', 'dcsdc', '/qac_ugc/Proposal_sections/uploads/1748196065_1739720192_benchmark.pdf', '/qac_ugc/Proposal_sections/uploads/1748196065_1739720192_benchmark.pdf', 'Yes'),
('sad', 'asda', 'sdasd', 'sad', 'sad', 'asd', 'asd', 'asdsa', 'sad', ' asd', 'UGC Z score based selection', '', 50, 'Bachelor Honours Degree', '4', 5, 5, 120, 'English', 6, 13, '/qac_ugc/Proposal_sections/uploads/1742064065_1739720192_benchmark.pdf', 'Level 6 (Bachelors Honours - 4 year programme)', '', '', '', ''),
('ewd', 'ewf', 'wef', 'efw', 'wef', 'wef', 'ewf', 'ewf', 'ewf', ' wef', 'UGC Z score based selection', '', 50, 'Bachelor Honours Degree', '4', 5, 5, 120, 'English', 8, 18, '/qac_ugc/Proposal_sections/uploads/1742067193_1739720192_benchmark.pdf', 'Level 6 (Bachelors Honours - 4 year programme)', '', '', '', ''),
('A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', ' A', 'UGC Z score based selection', '', 50, 'Bachelor Degree', '3', 5, 5, 90, 'English', 9, 16, '/qac_ugc/Proposal_sections/uploads/1742106018_Application_Summary - 2025-03-16T002508.601.pdf', 'Level 6 (Bachelors Honours - 4 year programme)', '', '', '', ''),
('A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', ' A    ', 'UGC Z score based selection', '', 50, '', '', 5, 5, 0, 'Sinhala', 10, 14, NULL, 'Level 6 (Bachelors Honours - 4 year programme)', '', '', '', ''),
('SS', 'S', 'S', 'S', 'S', 's', 'ss', 'sss', 's', ' s                ', 'UGC Z score based selection', '', 50, 'Bachelor Honours Degree', '4', 5, 5, 120, 'Sinhala', 11, 23, '/qac_ugc/Proposal_sections/uploads/1747393878_1739718375_fallback.pdf', 'Level 6 (Bachelors Honours - 4 year programme)', 'EEEEE', '/qac_ugc/Proposal_sections/uploads/1747393878_1739894675_senate.pdf', '/qac_ugc/Proposal_sections/uploads/1747393878_1739894675_council.pdf', 'No'),
('s', 's', 'sax', 'sax', 'asx', 'asx', 'sax', 'asx', 'sx', ' sx    ', 'UGC Z score based selection', '', 50, 'Bachelor Honours Degree', '4', 5, 5, 120, 'Sinhala', 12, 24, '/qac_ugc/Proposal_sections/uploads/1748194711_1739718375_fallback.pdf', 'Level 6 (Bachelors Honours - 4 year programme)', 'sx', '/qac_ugc/Proposal_sections/uploads/1748194711_1739720192_benchmark.pdf', '/qac_ugc/Proposal_sections/uploads/1748194711_1739720192_benchmark.pdf', 'Yes');

-- --------------------------------------------------------

--
-- Table structure for table `proposal_financial_resource`
--

CREATE TABLE `proposal_financial_resource` (
  `financial_resource_id` int(11) NOT NULL,
  `financial_type` varchar(1000) NOT NULL,
  `year1` varchar(1000) NOT NULL,
  `year2` varchar(1000) NOT NULL,
  `year3` varchar(1000) NOT NULL,
  `year4` varchar(1000) NOT NULL,
  `proposal_id` int(11) NOT NULL,
  `resource_requirement_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `proposal_financial_resource`
--

INSERT INTO `proposal_financial_resource` (`financial_resource_id`, `financial_type`, `year1`, `year2`, `year3`, `year4`, `proposal_id`, `resource_requirement_id`) VALUES
(1, 'Capital Expenditure', '45', '3', '3', '3', 1, 1),
(2, 'Recurrent Expenditure', '3', '3', '3', '3', 1, 1),
(3, 'Capital Expenditure', 'ax', 'ax', 'xa', 'xax', 2, 2),
(4, 'Recurrent Expenditure', 'axax', 'axax', 'ax', 'a', 2, 2),
(5, 'Capital Expenditure', 'dc', 'csd', 'csdc', 'ccd', 3, 3),
(6, 'Recurrent Expenditure', 'cdsd', 'csd', 'sdcs', 'sdd', 3, 3),
(7, 'Capital Expenditure', 'erv', 'erv', 'verv', 'verv', 7, 4),
(8, 'Recurrent Expenditure', 'erv', 'erv', 'erver', 'erverv', 7, 4),
(9, 'Capital Expenditure', 'fw', 'wef', 'ewf', 'fe', 6, 5),
(10, 'Recurrent Expenditure', 'wef', 'wef', 'ewfew', 'few', 6, 5),
(11, 'Capital Expenditure', '1', '1', '1', '1', 16, 6),
(12, 'Recurrent Expenditure', '1', '1', '1', '1', 16, 6),
(13, 'Capital Expenditure', 'sdf', 'sdf', 'sdf', 'fds', 13, 7),
(14, 'Recurrent Expenditure', 'sdf', 'sdf', 'dsf', 'sdf', 13, 7),
(17, 'Capital Expenditure', 'df', 'dsf', 'dsf', 'dsf', 18, 9),
(18, 'Recurrent Expenditure', 'sdf', 'dsf', 'dsf', 'dsf', 18, 9),
(19, 'Capital Expenditure', 'A', 'A', 'A', 'A', 14, 10),
(20, 'Recurrent Expenditure', 'A', 'A', 'A', 'A', 14, 10);

-- --------------------------------------------------------

--
-- Table structure for table `proposal_general_info`
--

CREATE TABLE `proposal_general_info` (
  `proposal_id` int(11) NOT NULL,
  `degree_name_english` varchar(255) NOT NULL,
  `degree_name_sinhala` varchar(255) NOT NULL,
  `degree_name_tamil` varchar(255) NOT NULL,
  `abbreviated_qualification` varchar(50) NOT NULL,
  `general_info_id` int(11) NOT NULL,
  `qua_name_english` varchar(1000) NOT NULL,
  `qua_name_sinhala` varchar(1000) NOT NULL,
  `qua_name_tamil` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `proposal_general_info`
--

INSERT INTO `proposal_general_info` (`proposal_id`, `degree_name_english`, `degree_name_sinhala`, `degree_name_tamil`, `abbreviated_qualification`, `general_info_id`, `qua_name_english`, `qua_name_sinhala`, `qua_name_tamil`) VALUES
(1, 'B', 'A', 'A', 'BSc', 1, '', '', ''),
(2, 'xssx', 'sxas', 'xsax', 'sax', 2, '', '', ''),
(3, 'Bsc (Hons) Software Engineering', 'Bsc (Hons) Software Engineering', 'Bsc (Hons) Software Engineering', 'BSc', 3, '', '', ''),
(6, 'fre', 'erferf', 'erfer', 'ff', 4, 'dcs', 'dsc', 'sdc'),
(7, 'rtg', 'trgrt', 'gtrg', 'trg', 5, '', '', ''),
(13, 'Bsc (Hons) Software Engineering', 'මෘදුකාංග ඉංජිනේරු විද්‍යාව පිළිබඳ විද්‍යාවේදී ගෞරව උපාධිය', 'பிஎஸ்சி ஹானர்ஸ் மென்பொருள் பொறியியல்', 'BSc', 6, '', '', ''),
(14, 'Bsc (Hons) Computer Science', 'පරිගණක විද්‍යාව පිළිබඳ විද්‍යාවේදී ගෞරව උපාධිය', 'பிஎஸ்சி ஹானர்ஸ் கணினி அறிவியல்', 'BSc', 7, '', '', ''),
(16, 'Bsc (Hons) Computer Science', 'පරිගණක විද්‍යාව පිළිබඳ විද්‍යාවේදී ගෞරව උපාධිය', 'பிஎஸ்சி ஹானர்ஸ் கணினி அறிவியல்', 'BSc', 8, '', '', ''),
(18, 'Bsc (Hons) Computer Science', 'පරිගණක විද්‍යාව පිළිබඳ විද්‍යාවේදී ගෞරව උපාධිය', 'பிஎஸ்சி ஹானர்ஸ் கணினி அறிவியல்', 'BSc', 10, '', '', ''),
(19, 'Bsc (Hons) Computer Science', 'පරිගණක විද්‍යාව පිළිබඳ විද්‍යාවේදී ගෞරව උපාධිය', 'பிஎஸ்சி ஹானர்ஸ் கணினி அறிவியல்', 'BSc', 11, '', '', ''),
(23, 'a', 'a', 'a', 'a', 12, 'a', 'a', 'aa');

-- --------------------------------------------------------

--
-- Table structure for table `proposal_grades_received`
--

CREATE TABLE `proposal_grades_received` (
  `degree_id` int(11) NOT NULL,
  `program_id` int(11) NOT NULL,
  `program_name` varchar(1000) NOT NULL,
  `program_year` varchar(1000) NOT NULL,
  `grade` varchar(1000) NOT NULL,
  `proposal_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `proposal_grades_received`
--

INSERT INTO `proposal_grades_received` (`degree_id`, `program_id`, `program_name`, `program_year`, `grade`, `proposal_id`) VALUES
(1, 25, 'A', 'A', 'A', 1),
(4, 37, 'ec', 'ec', 'ec', 7),
(2, 58, 'sax', 'sxa', 'sxa', 2),
(8, 64, 'ewf', 'ewf', 'ewf', 18),
(9, 80, 'A', 'A', 'A', 16),
(3, 89, 'exw', 'xw', 'xw', 3),
(10, 90, 'ABC', '2025', 'A', 14),
(6, 91, 'd', 'sad', 'sad', 13),
(12, 102, 's', 's', 's', 24),
(11, 103, 's', 's', 's', 23),
(5, 104, 'ew', 'ewe', 'wefew', 6);

-- --------------------------------------------------------

--
-- Table structure for table `proposal_human_resource`
--

CREATE TABLE `proposal_human_resource` (
  `proposal_id` int(11) NOT NULL,
  `human_resource_id` int(11) NOT NULL,
  `staff_type` varchar(100) NOT NULL,
  `year1` varchar(100) NOT NULL,
  `year2` varchar(100) NOT NULL,
  `year3` varchar(100) NOT NULL,
  `year4` varchar(100) NOT NULL,
  `resource_requirement_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `proposal_human_resource`
--

INSERT INTO `proposal_human_resource` (`proposal_id`, `human_resource_id`, `staff_type`, `year1`, `year2`, `year3`, `year4`, `resource_requirement_id`) VALUES
(1, 1, 'Lecturers', '45', '3', '3', '3', 1),
(1, 2, 'Instructors/Demonstrators', '3', '3', '3', '3', 1),
(1, 3, 'Technical Grades', '3', '3', '3', '33', 1),
(1, 4, 'Management Assistants', '3', '3', '3', '3', 1),
(1, 5, 'Minor Staff', '3', '33', '3', '3', 1),
(2, 6, 'Lecturers', 'xa', 'xa', 'x', 'axa', 2),
(2, 7, 'Instructors/Demonstrators', 'xa', 'xa', 'xa', 'xa', 2),
(2, 8, 'Technical Grades', 'axax', 'axxa', 'xa', 'xa', 2),
(2, 9, 'Management Assistants', 'axax', 'xa', 'x', 'ax', 2),
(2, 10, 'Minor Staff', 'xax', 'axa', 'axa', 'xax', 2),
(3, 11, 'Lecturers', 'ssdc', 'csdc', 'sdcds', 'sdcsd', 3),
(3, 12, 'Instructors/Demonstrators', 'sdc', 'csd', 'cdsc', 'csdc', 3),
(3, 13, 'Technical Grades', 'sc', 'dscds', 'dcs', 'sdsdc', 3),
(3, 14, 'Management Assistants', 'scd', 'sdc', 'sc', 'sdc', 3),
(3, 15, 'Minor Staff', 'sdc', 'sdc', 'sdc', 'csdc', 3),
(7, 16, 'Lecturers', 'evr', 'evr', 'verv', 'ever', 4),
(7, 17, 'Instructors/Demonstrators', 'ver', 've', 'v', 'erv', 4),
(7, 18, 'Technical Grades', 'ev', 'veerv', 'verv', 'ver', 4),
(7, 19, 'Management Assistants', 'vre', 'c', 'erver', 'rvver', 4),
(7, 20, 'Minor Staff', 'verver', 'ver', 'ver', 'verv', 4),
(6, 21, 'Lecturers', 'fw', 'wefwe', 'ewf', 'wef', 5),
(6, 22, 'Instructors/Demonstrators', 'ew', 'wf', 'f', 'ewf', 5),
(6, 23, 'Technical Grades', 'we', 'wee', 'few', 'ewf', 5),
(6, 24, 'Management Assistants', 'wewe', 'fwe', 'few', 'wef', 5),
(6, 25, 'Minor Staff', 'ew', 'we', 'ewf', 'ewf', 5),
(16, 26, 'Lecturers', '1', '1', '1', '1', 6),
(16, 27, 'Instructors/Demonstrators', '1', '1', '1', '1', 6),
(16, 28, 'Technical Grades', '1', '1', '1', '1', 6),
(16, 29, 'Management Assistants', '1', '1', '1', '1', 6),
(16, 30, 'Minor Staff', '1', '1', '1', '1', 6),
(13, 31, 'Lecturers', 'df', 'sdf', 'sdfs', 'sdf', 7),
(13, 32, 'Instructors/Demonstrators', 'sdf', 'df', 'df', 'sdf', 7),
(13, 33, 'Technical Grades', 'sdf', 'sdsf', 'sdf', 'sdf', 7),
(13, 34, 'Management Assistants', 'sdf', 'sdf', 'fds', 'dsf', 7),
(13, 35, 'Minor Staff', 'fds', 'sfd', 'dsf', 'dfs', 7),
(18, 41, 'Lecturers', 'sdf', 'sdf', 'dsf', 'dsf', 9),
(18, 42, 'Instructors/Demonstrators', 'dsf', 'dfs', 'dsf', 'dsf', 9),
(18, 43, 'Technical Grades', 'dsf', 'dfs', 'dsf', 'dsf', 9),
(18, 44, 'Management Assistants', 'dsfdsf', 'dsfds', 'dsf', 'dsf', 9),
(18, 45, 'Minor Staff', 'dsf', 'sdf', 'dsf', 'dsf', 9),
(14, 46, 'Lecturers', 'A', 'A', 'A', 'A', 10),
(14, 47, 'Instructors/Demonstrators', 'A', 'A', 'A', 'A', 10),
(14, 48, 'Technical Grades', 'A', 'A', 'A', 'A', 10),
(14, 49, 'Management Assistants', 'A', 'A', 'A', 'A', 10),
(14, 50, 'Minor Staff', 'A', 'A', 'A', 'A', 10);

-- --------------------------------------------------------

--
-- Table structure for table `proposal_mandate_availability`
--

CREATE TABLE `proposal_mandate_availability` (
  `mandate_availability_type` varchar(1000) NOT NULL,
  `reference_no` varchar(1000) DEFAULT NULL,
  `date_of_approval` date NOT NULL,
  `evidence` varchar(1000) NOT NULL,
  `mandate_availability_id` int(11) NOT NULL,
  `proposal_id` int(11) NOT NULL,
  `program_entity_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `proposal_mandate_availability`
--

INSERT INTO `proposal_mandate_availability` (`mandate_availability_type`, `reference_no`, `date_of_approval`, `evidence`, `mandate_availability_id`, `proposal_id`, `program_entity_id`) VALUES
('Corporate / Strategic Plan of the University', '1', '2025-03-04', '/qac_ugc/Proposal_sections/uploads/1741443959_Application_Summary - 2025-03-08T192630.651.pdf', 1, 1, 1),
('Action Plan of the Faculty/Institute/Center/Unit', '2', '2025-03-26', '/qac_ugc/Proposal_sections/uploads/1741443959_Application_Summary - 2025-03-08T183205.888.pdf', 2, 1, 1),
('Senate Approval', '3', '2025-03-25', '/qac_ugc/Proposal_sections/uploads/1741443959_Application_Summary (100).pdf', 3, 1, 1),
('Council Approval', '4', '2025-03-12', '/qac_ugc/Proposal_sections/uploads/1741443959_Application_Summary (100).pdf', 4, 1, 1),
('Corporate / Strategic Plan of the University', 'saxsx', '2025-03-04', '/qac_ugc/Proposal_sections/uploads/1741446156_benchmark.pdf', 5, 2, 2),
('Action Plan of the Faculty/Institute/Center/Unit', 'a', '2025-03-25', '/qac_ugc/Proposal_sections/uploads/1741446156_benchmark.pdf', 6, 2, 2),
('Senate Approval', 'sxa', '2025-04-02', '/qac_ugc/Proposal_sections/uploads/1741446156_benchmark.pdf', 7, 2, 2),
('Council Approval', 'sx', '2025-03-27', '/qac_ugc/Proposal_sections/uploads/1741446156_cooperate.pdf', 8, 2, 2),
('Corporate / Strategic Plan of the University', 'dcdc', '2025-03-10', '/qac_ugc/Proposal_sections/uploads/1741455490_benchmark.pdf', 9, 3, 3),
('Action Plan of the Faculty/Institute/Center/Unit', 'dc', '2025-03-25', '/qac_ugc/Proposal_sections/uploads/1741455490_cooperate.pdf', 10, 3, 3),
('Senate Approval', 'cd', '2025-03-25', '/qac_ugc/Proposal_sections/uploads/1741455490_council.pdf', 11, 3, 3),
('Council Approval', 'cd', '2025-03-26', '/qac_ugc/Proposal_sections/uploads/1741455490_council.pdf', 12, 3, 3),
('Corporate / Strategic Plan of the University', 'tgr', '2025-02-25', '/qac_ugc/Proposal_sections/uploads/1741506202_Application_Summary - 2025-03-09T130611.020.pdf', 13, 7, 4),
('Action Plan of the Faculty/Institute/Center/Unit', 'trg', '2025-03-25', '/qac_ugc/Proposal_sections/uploads/1741506202_Application_Summary - 2025-03-09T130611.020.pdf', 14, 7, 4),
('Senate Approval', 'tgr', '2025-03-25', '/qac_ugc/Proposal_sections/uploads/1741506202_Application_Summary - 2025-03-09T130611.020.pdf', 15, 7, 4),
('Council Approval', 'tgr', '2025-03-27', '/qac_ugc/Proposal_sections/uploads/1741506202_Application_Summary - 2025-03-09T130611.020.pdf', 16, 7, 4),
('Corporate / Strategic Plan of the University', 'reg', '0000-00-00', '/qac_ugc/Proposal_sections/uploads/1748196031_1739720192_benchmark.pdf', 17, 6, 5),
('Action Plan of the Faculty/Institute/Center/Unit', 'reg', '2025-03-20', '/qac_ugc/Proposal_sections/uploads/1748196031_1739720192_benchmark.pdf', 18, 6, 5),
('Senate Approval', 'rferf', '2025-03-19', '/qac_ugc/Proposal_sections/uploads/1748196031_1739720192_benchmark.pdf', 19, 6, 5),
('Council Approval', 'erferf', '2025-03-19', '/qac_ugc/Proposal_sections/uploads/1748196031_1739720192_benchmark.pdf', 20, 6, 5),
('Corporate / Strategic Plan of the University', '1', '2025-03-12', '/qac_ugc/Proposal_sections/uploads/1742063622_1739894675_cooperate.pdf', 21, 16, 6),
('Action Plan of the Faculty/Institute/Center/Unit', '2', '2025-03-19', '/qac_ugc/Proposal_sections/uploads/1742063622_1739894675_action.pdf', 22, 16, 6),
('Senate Approval', '3', '2025-03-20', '/qac_ugc/Proposal_sections/uploads/1742063622_1739894675_senate.pdf', 23, 16, 6),
('Council Approval', '4', '2025-03-13', '/qac_ugc/Proposal_sections/uploads/1742063622_1739894675_council.pdf', 24, 16, 6),
('Corporate / Strategic Plan of the University', 'sad', '2025-03-12', '/qac_ugc/Proposal_sections/uploads/1742064039_1739894675_action.pdf', 25, 13, 7),
('Action Plan of the Faculty/Institute/Center/Unit', 'sada', '2025-03-26', '/qac_ugc/Proposal_sections/uploads/1742064039_1739894675_council.pdf', 26, 13, 7),
('Senate Approval', 'sdsa', '2025-03-20', '/qac_ugc/Proposal_sections/uploads/1742064039_1739720192_benchmark.pdf', 27, 13, 7),
('Council Approval', 'd', '2025-03-13', '/qac_ugc/Proposal_sections/uploads/1742064039_1739720192_benchmark.pdf', 28, 13, 7),
('Corporate / Strategic Plan of the University', '1', '2025-03-04', '/qac_ugc/Proposal_sections/uploads/1742067168_1739894675_senate.pdf', 33, 18, 9),
('Action Plan of the Faculty/Institute/Center/Unit', '2', '2025-03-18', '/qac_ugc/Proposal_sections/uploads/1742067168_1739720192_benchmark.pdf', 34, 18, 9),
('Senate Approval', '3', '2025-03-19', '/qac_ugc/Proposal_sections/uploads/1742067168_1739720192_benchmark.pdf', 35, 18, 9),
('Council Approval', '4', '2025-03-19', '/qac_ugc/Proposal_sections/uploads/1742067168_1739720192_benchmark.pdf', 36, 18, 9),
('Corporate / Strategic Plan of the University', '1', '2025-03-05', '/qac_ugc/Proposal_sections/uploads/1742105895_Application_Summary - 2025-03-16T002508.601.pdf', 37, 19, 10),
('Action Plan of the Faculty/Institute/Center/Unit', '2', '2025-03-12', '/qac_ugc/Proposal_sections/uploads/1742105895_Application_Summary - 2025-03-16T002346.856.pdf', 38, 19, 10),
('Senate Approval', '3', '2025-03-26', '/qac_ugc/Proposal_sections/uploads/1742105895_Application_Summary - 2025-03-16T002508.601.pdf', 39, 19, 10),
('Council Approval', '4', '2025-03-12', '/qac_ugc/Proposal_sections/uploads/1742105895_Application_Summary - 2025-03-16T002346.856.pdf', 40, 19, 10),
('Corporate / Strategic Plan of the University', '1', '2025-05-21', '/qac_ugc/Proposal_sections/uploads/1747387880_1739894675_senate.pdf', 45, 23, 11),
('Action Plan of the Faculty/Institute/Center/Unit', '2', '2025-05-21', '/qac_ugc/Proposal_sections/uploads/1747387880_1739720192_benchmark.pdf', 46, 23, 11),
('Senate Approval', '4', '2025-05-21', '/qac_ugc/Proposal_sections/uploads/1747387880_1739718375_fallback.pdf', 47, 23, 11),
('Council Approval', '5', '2025-05-21', '/qac_ugc/Proposal_sections/uploads/1747387880_1739718375_fallback.pdf', 48, 23, 11),
('Faculty Approval', '3', '2025-05-25', '/qac_ugc/Proposal_sections/uploads/1747387880_1739720192_benchmark.pdf', 49, 23, 11),
('Faculty Approval', 'dc', '2025-05-21', '/qac_ugc/Proposal_sections/uploads/1748196031_1739894675_cooperate.pdf', 50, 6, 5);

-- --------------------------------------------------------

--
-- Table structure for table `proposal_panel_of_teachers`
--

CREATE TABLE `proposal_panel_of_teachers` (
  `teacher_id` int(11) NOT NULL,
  `proposal_id` int(11) NOT NULL,
  `lecturer_name` varchar(1000) NOT NULL,
  `designation` varchar(1000) NOT NULL,
  `internal_ug_hours` int(11) NOT NULL,
  `internal_pg_hours` int(11) NOT NULL,
  `external_ug_hours` int(11) NOT NULL,
  `external_pg_hours` int(11) NOT NULL,
  `proposed_program_hours` int(11) NOT NULL,
  `total_hours` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `proposal_panel_of_teachers`
--

INSERT INTO `proposal_panel_of_teachers` (`teacher_id`, `proposal_id`, `lecturer_name`, `designation`, `internal_ug_hours`, `internal_pg_hours`, `external_ug_hours`, `external_pg_hours`, `proposed_program_hours`, `total_hours`) VALUES
(41, 1, 'RGG', 'GR', 4, 3, 3, 3, 3, 16),
(42, 1, 'RGG', 'GR', 4, 3, 3, 3, 3, 16),
(43, 1, 'RGG', 'GR', 4, 3, 3, 3, 3, 16),
(44, 1, 'RGG', 'GR', 4, 3, 3, 3, 3, 16),
(83, 7, 'A', 'Lecturer', 2, 3, 3, 5, 4, 17),
(84, 7, 'A', 'Lecturer', 2, 3, 3, 5, 4, 17),
(85, 7, 'A', 'Lecturer', 2, 3, 3, 5, 4, 17),
(86, 7, 'A', 'Lecturer', 2, 3, 3, 5, 4, 17),
(231, 2, 'A', 'A', 1, 1, 1, 1, 1, 5),
(241, 18, 'dfs', 'sdf', 3, 2, 2, 2, 3, 12),
(267, 3, '2', '2', 5, 5, 4, 4, 3, 21),
(268, 3, '4', '4', 2, 1, 1, 1, 1, 6),
(270, 14, 'L', 'Lecturer', 1, 2, 3, 4, 5, 15),
(271, 14, 'P', 'Lecturer', 1, 3, 2, 2, 2, 10),
(273, 13, 'A', 'B', 3, 3, 3, 3, 3, 15),
(285, 6, 'xc', 'dc', 3, 2, 2, 2, 2, 11);

-- --------------------------------------------------------

--
-- Table structure for table `proposal_payments`
--

CREATE TABLE `proposal_payments` (
  `payment_id` int(11) NOT NULL,
  `proposal_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `order_id` varchar(50) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `proposal_payments`
--

INSERT INTO `proposal_payments` (`payment_id`, `proposal_id`, `user_id`, `order_id`, `amount`, `status`, `created_at`, `updated_at`) VALUES
(1, 3, 2, 'PROP_3_1742022021', 1000.00, 'completed_used', '2025-03-15 07:00:21', '2025-03-16 02:34:59'),
(2, 3, 2, 'PROP_3_1742092524', 1000.00, 'pending', '2025-03-16 02:35:24', '2025-03-16 02:35:24'),
(3, 3, 2, 'PROP_3_1742092739', 1000.00, 'pending', '2025-03-16 02:38:59', '2025-03-16 02:38:59'),
(4, 3, 2, 'PROP_3_1742092746', 1000.00, 'completed_used', '2025-03-16 02:39:06', '2025-03-16 02:43:49'),
(5, 3, 2, 'PROP_3_1742093248', 1000.00, 'completed_used', '2025-03-16 02:47:28', '2025-03-16 02:48:05'),
(6, 3, 2, 'PROP_3_1742093362', 1000.00, 'completed_used', '2025-03-16 02:49:22', '2025-03-16 02:49:48'),
(7, 3, 2, 'PROP_3_1742093400', 1000.00, 'completed_used', '2025-03-16 02:50:00', '2025-03-16 02:50:25'),
(8, 3, 2, 'PROP_3_1743620526', 1000.00, 'completed_used', '2025-04-02 19:02:06', '2025-04-02 19:08:14'),
(9, 3, 2, 'PROP_3_1743622494', 1000.00, 'completed_used', '2025-04-02 19:34:54', '2025-04-02 19:39:50'),
(10, 3, 2, 'PROP_3_1743622897', 1000.00, 'completed_used', '2025-04-02 19:41:37', '2025-05-15 16:21:29'),
(11, 3, 2, 'PROP_3_1747365843', 1000.00, 'pending', '2025-05-16 03:24:03', '2025-05-16 03:24:03'),
(12, 3, 2, 'PROP_3_1747365852', 1000.00, 'pending', '2025-05-16 03:24:12', '2025-05-16 03:24:12'),
(13, 3, 2, 'PROP_3_1747365861', 1000.00, 'pending', '2025-05-16 03:24:21', '2025-05-16 03:24:21');

-- --------------------------------------------------------

--
-- Table structure for table `proposal_physical_resource`
--

CREATE TABLE `proposal_physical_resource` (
  `proposal_id` int(11) NOT NULL,
  `physical_type` varchar(100) NOT NULL,
  `existing_amount` varchar(100) DEFAULT NULL,
  `year1` varchar(100) DEFAULT NULL,
  `year2` varchar(100) DEFAULT NULL,
  `year3` varchar(100) DEFAULT NULL,
  `year4` varchar(100) DEFAULT NULL,
  `resource_requirement_id` int(11) NOT NULL,
  `physical_resource_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `proposal_physical_resource`
--

INSERT INTO `proposal_physical_resource` (`proposal_id`, `physical_type`, `existing_amount`, `year1`, `year2`, `year3`, `year4`, `resource_requirement_id`, `physical_resource_id`) VALUES
(1, 'Land extent (Acre/Hectare)', '45', '2', '3', '4', '5', 1, 1),
(1, 'Office Space', '1', '2', '34', '3', '3', 1, 2),
(1, 'No. of Lecture Theatres', '3', '3', '3', '3', '33', 1, 3),
(1, 'No. of Laboratories', '3', '3', '33', '3', '3', 1, 4),
(1, 'No. of Computers with Internet Facilities', '3', '3', '3', '3', '3', 1, 5),
(1, 'Reading Rooms/Halls', '3', '3', '3', '3', '3', 1, 6),
(1, 'Staff Common Rooms/Amenities', '33', '3', '3', '3', '3', 1, 7),
(1, 'Student Common Rooms/Amenities', '3', '33', '3', '3', '3', 1, 8),
(1, 'Other', '3', '3', '3', '3', '3', 1, 9),
(2, 'Land extent (Acre/Hectare)', 'xa', 'axax', 'x', 'xa', 'x', 2, 10),
(2, 'Office Space', 'xax', 'ax', 'aax', 'axx', 'xa', 2, 11),
(2, 'No. of Lecture Theatres', 'xax', 'xaa', 'a', 'xaa', 'xa', 2, 12),
(2, 'No. of Laboratories', 'xa', 'xa', 'xax', 'xax', 'axa', 2, 13),
(2, 'No. of Computers with Internet Facilities', 'xaa', 'x', 'a', 'xa', 'xa', 2, 14),
(2, 'Reading Rooms/Halls', 'ax', 'ax', 'xaa', 'ax', 'xaxa', 2, 15),
(2, 'Staff Common Rooms/Amenities', 'ax', 'ax', 'xa', 'x', 'x', 2, 16),
(2, 'Student Common Rooms/Amenities', 'ax', 'xa', 'xaxa', 'x', 'x', 2, 17),
(2, 'Other', 'x', 'xa', 'xa', 'xx', 'xx', 2, 18),
(3, 'Land extent (Acre/Hectare)', 'c', 'dsc', 'dcs', 'dc', 'sdc', 3, 19),
(3, 'Office Space', 'sdc', 'sdccd', 'sdcsdc', 'sdcscd', 'cs', 3, 20),
(3, 'No. of Lecture Theatres', 'sdc', 'sdc', 'sdc', 'cds', 'sdc', 3, 21),
(3, 'No. of Laboratories', 'cds', 'sdcs', 'sdc', 'sdc', 'sdc', 3, 22),
(3, 'No. of Computers with Internet Facilities', 'dc', 'csdc', 'sdc', 'sdc', 'dscsdc', 3, 23),
(3, 'Reading Rooms/Halls', 'sdc', 'sdcsd', 'csdcds', 'sdc', 'sdc', 3, 24),
(3, 'Staff Common Rooms/Amenities', 'sdc', 'dsdc', 'cdcs', 'scd', 'cds', 3, 25),
(3, 'Student Common Rooms/Amenities', 'sdc', 'sscd', 'sdc', 'sdc', 'cd', 3, 26),
(3, 'Other', 'cds', 'sdc', 'scd', 'sdc', 'ssdc', 3, 27),
(7, 'Land extent (Acre/Hectare)', 'ver', 'rve', 'erv', 'v', 'rev', 4, 28),
(7, 'Office Space', 'erv', 'rve', 'eve', 'vver', 'erver', 4, 29),
(7, 'No. of Lecture Theatres', 'erv', 'rev', 'vreer', 'evrer', 'ver', 4, 30),
(7, 'No. of Laboratories', 'erv', 'er', 'rev', 'vre', 'erv', 4, 31),
(7, 'No. of Computers with Internet Facilities', 'ev', 'erv', 'vev', 'rverv', 'erv', 4, 32),
(7, 'Reading Rooms/Halls', 'erver', 'vev', 'erverv', 'erv', 'ver', 4, 33),
(7, 'Staff Common Rooms/Amenities', 'erv', 'ver', 'rev', 'erverv', 'ver', 4, 34),
(7, 'Student Common Rooms/Amenities', 'ver', 'verve', 'verv', 'erv', 'ver', 4, 35),
(7, 'Other', 'ver', 'r', 'er', 'erv', 'erver', 4, 36),
(6, 'Land extent (Acre/Hectare)', 'wefw', 'ef', 'ewf', 'ef', 'ef', 5, 37),
(6, 'Office Space', 'efe', 'f', 'fe', 'e', 'ef', 5, 38),
(6, 'No. of Lecture Theatres', 'e', 'fef', 'fe', 'f', 'ef', 5, 39),
(6, 'No. of Laboratories', 'ee', 'e', 'fe', 'fe', 'efe', 5, 40),
(6, 'No. of Computers with Internet Facilities', 'ee', 'e', 'e', 'e', 'e', 5, 41),
(6, 'Reading Rooms/Halls', 'e', 'e', 'fe', 'e', 'ee', 5, 42),
(6, 'Staff Common Rooms/Amenities', 'ewf', 'wf', 'wef', 'we', 'fwef', 5, 43),
(6, 'Student Common Rooms/Amenities', 'wef', 'wef', 'wef', 'fewf', 'ewf', 5, 44),
(6, 'Other', 'e', 'ewfwf', 'efew', 'efw', 'wfe', 5, 45),
(16, 'Land extent (Acre/Hectare)', '1', '1', '1', '1', '1', 6, 46),
(16, 'Office Space', '1', '1', '1', '1', '1', 6, 47),
(16, 'No. of Lecture Theatres', '1', '1', '1', '1', '1', 6, 48),
(16, 'No. of Laboratories', '1', '1', '1', '1', '1', 6, 49),
(16, 'No. of Computers with Internet Facilities', '1', '1', '1', '1', '1', 6, 50),
(16, 'Reading Rooms/Halls', '1', '1', '1', '1', '1', 6, 51),
(16, 'Staff Common Rooms/Amenities', '1', '1', '1', '1', '1', 6, 52),
(16, 'Student Common Rooms/Amenities', '1', '1', '1', '1', '1', 6, 53),
(16, 'Other', '1', '1', '1', '1', '1', 6, 54),
(13, 'Land extent (Acre/Hectare)', 'sdf', 'sdf', 'sdf', 'sdf', 'sdf', 7, 55),
(13, 'Office Space', 'sdfsdf', 'sdf', 'sdf', 'sdf', 'fsd', 7, 56),
(13, 'No. of Lecture Theatres', 'fds', 'sdf', 'sdf', 'sdf', 'sdf', 7, 57),
(13, 'No. of Laboratories', 'sdf', 'sdf', 'sd', 'f', 'sdf', 7, 58),
(13, 'No. of Computers with Internet Facilities', 'sdf', 'sdf', 'sfsdd', 'sdf', 'df', 7, 59),
(13, 'Reading Rooms/Halls', 'sdf', 'sdf', 'fsdf', 'sdf', 'df', 7, 60),
(13, 'Staff Common Rooms/Amenities', 'sdf', 'sdf', 'sfd', 'dsf', 'sdf', 7, 61),
(13, 'Student Common Rooms/Amenities', 'sdf', 'sdf', 'df', 'sdf', 'fds', 7, 62),
(13, 'Other', 'sdf', 'fds', 'ddff', 'df', 'dsf', 7, 63),
(18, 'Land extent (Acre/Hectare)', 'sdf', 'sdf', 'sdf', 'sdf', 'sdf', 9, 73),
(18, 'Office Space', 'fds', 'sdf', 'sdf', 'dsf', 'fsd', 9, 74),
(18, 'No. of Lecture Theatres', 'dsf', 'dsf', 'ds', 'f', 'sdf', 9, 75),
(18, 'No. of Laboratories', 'dsf', 'sdf', 'ssdf', 'df', 'sdf', 9, 76),
(18, 'No. of Computers with Internet Facilities', 'sdf', 'sdf', 'sdf', 'df', 'sdf', 9, 77),
(18, 'Reading Rooms/Halls', 'df', 'dfs', 'sdf', 'sdf', 'sdf', 9, 78),
(18, 'Staff Common Rooms/Amenities', 'sdf', 'dsf', 'dsf', 'dsf', 'df', 9, 79),
(18, 'Student Common Rooms/Amenities', 'sdf', 'sdf', 'sdf', 'sdf', 'sdf', 9, 80),
(18, 'Other', 'sdf', 'dsf', 'dsf', 'dsf', 'df', 9, 81),
(14, 'Land extent (Acre/Hectare)', 'A', 'A', 'A', 'A', 'A', 10, 82),
(14, 'Office Space', 'A', 'A', 'A', 'A', 'A', 10, 83),
(14, 'No. of Lecture Theatres', 'A', 'A', 'A', 'A', 'A', 10, 84),
(14, 'No. of Laboratories', 'AA', 'A', 'A', 'A', 'A', 10, 85),
(14, 'No. of Computers with Internet Facilities', 'A', 'A', 'AA', 'A', 'A', 10, 86),
(14, 'Reading Rooms/Halls', 'A', 'A', 'A', 'A', 'A', 10, 87),
(14, 'Staff Common Rooms/Amenities', 'A', 'A', 'A', 'A', 'A', 10, 88),
(14, 'Student Common Rooms/Amenities', 'A', 'A', 'A', 'A', 'A', 10, 89),
(14, 'Other', 'A', 'A', 'AA', 'A', 'A', 10, 90);

-- --------------------------------------------------------

--
-- Table structure for table `proposal_program_content`
--

CREATE TABLE `proposal_program_content` (
  `content_id` int(11) NOT NULL,
  `proposal_id` int(11) NOT NULL,
  `semester` int(11) NOT NULL,
  `module_code` varchar(1000) NOT NULL,
  `module_name` varchar(1000) NOT NULL,
  `credit_value` int(11) NOT NULL,
  `core_optional` enum('Core','Optional') NOT NULL,
  `lecture_hours` int(11) NOT NULL,
  `practical_hours` int(11) NOT NULL,
  `independent_hours` int(11) NOT NULL,
  `learning_outcomes` varchar(1000) NOT NULL,
  `module_content` varchar(1000) NOT NULL,
  `teaching_methods` varchar(1000) NOT NULL,
  `continuous_assessment_percentage` int(11) NOT NULL,
  `final_assessment_percentage` int(11) NOT NULL,
  `recommended_reading` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `proposal_program_content`
--

INSERT INTO `proposal_program_content` (`content_id`, `proposal_id`, `semester`, `module_code`, `module_name`, `credit_value`, `core_optional`, `lecture_hours`, `practical_hours`, `independent_hours`, `learning_outcomes`, `module_content`, `teaching_methods`, `continuous_assessment_percentage`, `final_assessment_percentage`, `recommended_reading`) VALUES
(2, 1, 4, 'S', 'S', 120, 'Optional', 3, 3, 3, 'S', 'S', 'S', 3, 2, 'S'),
(4, 2, 2, 'xs', 'xa', 90, 'Optional', 3, 3, 3, 'sx', 'sx', 'sx', 2, 2, 'sx'),
(6, 3, 3, 'c', 'dc', 120, 'Optional', 2, 2, 2, 'cdc', 'dcd', 'cc', 2, 2, 'cdd'),
(8, 7, 2, 'rtg', 'trg', 90, 'Optional', 3, 3, 3, 'rtg', 'rtg', 'rtrtgg', 2, 2, 'tgr'),
(10, 6, 3, 'ewd', 'wed', 120, 'Optional', 3, 2, 2, 'de', 'ewd', 'wed', 3, 3, 'edwed'),
(12, 13, 2, 'ed', 'ed', 120, 'Optional', 3, 2, 2, 'efw', 'ewf', 'ewf', 2, 2, 'ewfwef'),
(16, 18, 3, 'df', 'dsf', 120, 'Optional', 2, 2, 2, 'sdfv', 'sdfdsf', 'sdf', 3, 2, 'sf'),
(18, 16, 2, 'd', 'dscx', 90, 'Core', 2, 2, 2, 'dc', 'd', 'aas', 2, 2, 'we'),
(20, 14, 1, 'A', 'xsx', 120, 'Optional', 3, 3, 3, 'A', 'A', 'A', 2, 3, 'A');

-- --------------------------------------------------------

--
-- Table structure for table `proposal_program_delivery`
--

CREATE TABLE `proposal_program_delivery` (
  `proposal_id` int(11) NOT NULL,
  `program_delivery_description` text NOT NULL,
  `program_delivery_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `proposal_program_delivery`
--

INSERT INTO `proposal_program_delivery` (`proposal_id`, `program_delivery_description`, `program_delivery_id`) VALUES
(1, 'SSSD', 1),
(2, 'sx', 2),
(3, 'cdscc', 3),
(7, 'gvrgb', 4),
(6, 'wefwef', 5),
(16, 'A', 6),
(13, 'sdcsdf', 7),
(18, 'sdfsdf', 9),
(14, 'A', 10);

-- --------------------------------------------------------

--
-- Table structure for table `proposal_program_entity`
--

CREATE TABLE `proposal_program_entity` (
  `proposal_id` int(11) NOT NULL,
  `faculty` varchar(255) NOT NULL,
  `department` varchar(255) DEFAULT NULL,
  `program_entity_id` int(11) NOT NULL,
  `university` varchar(1000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `proposal_program_entity`
--

INSERT INTO `proposal_program_entity` (`proposal_id`, `faculty`, `department`, `program_entity_id`, `university`) VALUES
(1, 'School of computing', 'School of computing', 1, 'University of Colombo'),
(2, 'sxa', 'sxa', 2, 'University of Colombo'),
(3, 'dcd', 'cdc', 3, 'University of Colombo'),
(7, 'tgrrg', 'rtg', 4, 'University of Colombo'),
(6, 'gtrg', 'rgfreg', 5, 'University of Colombo'),
(16, 'Faculty of Computing', 'Faculty of Computing', 6, 'University of Colombo'),
(13, 'sadsad', 'asdsad', 7, 'University of Colombo'),
(18, 'School of computing', 'School of computing', 9, 'University of Peradeniya'),
(19, 'School of computing', 'School of computing', 10, 'University of Colombo'),
(23, 'School of computing', 'School of computing', 11, 'University of Colombo');

-- --------------------------------------------------------

--
-- Table structure for table `proposal_program_structure`
--

CREATE TABLE `proposal_program_structure` (
  `program_structure_id` int(11) NOT NULL,
  `proposal_id` int(11) NOT NULL,
  `semester` int(11) NOT NULL,
  `module_code` varchar(50) NOT NULL,
  `module_name` varchar(255) NOT NULL,
  `credit_value` int(11) NOT NULL,
  `module_status` enum('Compulsory','Optional') NOT NULL,
  `qualifier1_related` varchar(1000) DEFAULT '0',
  `qualifier2_related` varchar(1000) DEFAULT '0',
  `module_type` enum('Existing','New') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `proposal_program_structure`
--

INSERT INTO `proposal_program_structure` (`program_structure_id`, `proposal_id`, `semester`, `module_code`, `module_name`, `credit_value`, `module_status`, `qualifier1_related`, `qualifier2_related`, `module_type`) VALUES
(3, 1, 1, 's', '1', 120, 'Optional', 'Yes', 'Yes', 'New'),
(5, 2, 1, 'sxsx', 'x', 90, 'Optional', 'Yes', 'No', 'Existing'),
(7, 3, 0, 'rfrf', 'rf', 120, '', 'Yes', 'Yes', 'New'),
(9, 7, 1, 'A', 'A', 1, 'Compulsory', 'Yes', 'No', 'Existing'),
(11, 6, 1, '2', 'fdg', 120, 'Compulsory', 'Yes', 'No', 'Existing'),
(13, 13, 1, 'ef', 'ewf', 120, 'Compulsory', 'Yes', 'No', 'New'),
(17, 18, 4, 'fdv', 'fdv', 120, '', 'Yes', 'No', 'Existing'),
(19, 16, 1, 's', 'sx', 90, '', 'Yes', 'No', 'Existing'),
(21, 14, 0, 'A', 'A', 1, 'Compulsory', 'Yes', 'No', 'Existing'),
(22, 14, 0, 'B', 'B', 49, 'Compulsory', 'No', 'Yes', 'New'),
(23, 14, 0, 'C', 'C', 70, 'Compulsory', 'Yes', 'No', 'Existing');

-- --------------------------------------------------------

--
-- Table structure for table `proposal_resource_requirements`
--

CREATE TABLE `proposal_resource_requirements` (
  `proposal_id` int(11) NOT NULL,
  `resource_requirement_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `proposal_resource_requirements`
--

INSERT INTO `proposal_resource_requirements` (`proposal_id`, `resource_requirement_id`) VALUES
(1, 1),
(2, 2),
(3, 3),
(6, 5),
(7, 4),
(13, 7),
(14, 10),
(16, 6),
(18, 9);

-- --------------------------------------------------------

--
-- Table structure for table `proposal_reviewers_report`
--

CREATE TABLE `proposal_reviewers_report` (
  `report_id` int(11) NOT NULL,
  `proposal_id` int(11) NOT NULL,
  `aspect` varchar(10000) NOT NULL,
  `main_proposal_comment` varchar(1000) NOT NULL,
  `fallback_qualification_comment` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `proposal_reviewers_report`
--

INSERT INTO `proposal_reviewers_report` (`report_id`, `proposal_id`, `aspect`, `main_proposal_comment`, `fallback_qualification_comment`) VALUES
(1, 1, '', '', ''),
(2, 1, 'Acceptability of the Background and the Justification', 'RD', '4RD'),
(3, 1, 'Relevance of proposed degree program to Society', '3R', '3R3'),
(4, 1, 'Entry Qualification and Admission Process', 'RR', '3'),
(5, 1, 'Program Structure', 'E', '3RE'),
(6, 1, 'Program Content', 'R', 'RR'),
(7, 1, 'Teaching Learning Methods', '33', 'R'),
(8, 1, 'Assessment Strategy/Procedure', 'R3', '3R3'),
(9, 1, 'Resource Availability - Physical', 'R', '3R'),
(10, 1, 'Qualifications of Panel of Teachers (Internal & External)', 'R3', 'R3'),
(11, 1, 'Recommended Reading', 'R3', 'R3'),
(12, 1, 'Recommendation (a, b, or c)', 'R3', 'R3'),
(13, 2, '', '', ''),
(14, 2, 'Acceptability of the Background and the Justification', 'ax', 'ax'),
(15, 2, 'Relevance of proposed degree program to Society', 'ax', 'axa'),
(16, 2, 'Entry Qualification and Admission Process', 'xa', 'xa'),
(17, 2, 'Program Structure', 'xa', 'xxa'),
(18, 2, 'Program Content', 'axax', 'x'),
(19, 2, 'Teaching Learning Methods', 'axa', 'xa'),
(20, 2, 'Assessment Strategy/Procedure', 'ax', 'xaa'),
(21, 2, 'Resource Availability - Physical', 'x', 'axx'),
(22, 2, 'Qualifications of Panel of Teachers (Internal & External)', 'ax', 'axxa'),
(23, 2, 'Recommended Reading', 'x', 'xaa'),
(24, 2, 'Recommendation (a, b, or c)', 'xaxa', 'xa'),
(25, 3, '', '', ''),
(26, 3, 'Acceptability of the Background and the Justification', 'rfe', 'erfe'),
(27, 3, 'Relevance of proposed degree program to Society', 'rf', 'erfe'),
(28, 3, 'Entry Qualification and Admission Process', 'rf', 'erf'),
(29, 3, 'Program Structure', 'erf', 'erf'),
(30, 3, 'Program Content', 'fe', 'fer'),
(31, 3, 'Teaching Learning Methods', 'fer', 'rfer'),
(32, 3, 'Assessment Strategy/Procedure', 'fer', 'ferf'),
(33, 3, 'Resource Availability - Physical', 'er', 'ferff'),
(34, 3, 'Qualifications of Panel of Teachers (Internal & External)', 'er', 'erf'),
(35, 3, 'Recommended Reading', 'fer', 'ferf'),
(36, 3, 'Recommendation (a, b, or c)', 'erf', 'erff'),
(37, 7, '', '', ''),
(38, 7, 'Acceptability of the Background and the Justification', 'evf', 'erv'),
(39, 7, 'Relevance of proposed degree program to Society', 'erv', 'everr'),
(40, 7, 'Entry Qualification and Admission Process', 'v', 'ervev'),
(41, 7, 'Program Structure', 'r', 'erve'),
(42, 7, 'Program Content', 'erv', 'erv'),
(43, 7, 'Teaching Learning Methods', 'rv', 'erv'),
(44, 7, 'Assessment Strategy/Procedure', 'erv', 'erv'),
(45, 7, 'Resource Availability - Physical', 'erv', 'erverv'),
(46, 7, 'Qualifications of Panel of Teachers (Internal & External)', 'erv', 'erver'),
(47, 7, 'Recommended Reading', 'v', 'erv'),
(48, 7, 'Recommendation (a, b, or c)', 'erv', 'ver'),
(49, 6, '', '', ''),
(50, 6, 'Acceptability of the Background and the Justification', 'w', 'ewf'),
(51, 6, 'Relevance of proposed degree program to Society', 'wef', 'ewf'),
(52, 6, 'Entry Qualification and Admission Process', 'ew', 'fe'),
(53, 6, 'Program Structure', 'wf', 'ewf'),
(54, 6, 'Program Content', 'fwe', 'ewf'),
(55, 6, 'Teaching Learning Methods', 'ewf', 'f'),
(56, 6, 'Assessment Strategy/Procedure', 'ewf', 'we'),
(57, 6, 'Resource Availability - Physical', 'ewf', 'wef'),
(58, 6, 'Qualifications of Panel of Teachers (Internal & External)', 'ew', 'fw'),
(59, 6, 'Recommended Reading', 'ef', 'ewf'),
(60, 6, 'Recommendation (a, b, or c)', 'wef', 'ewf'),
(61, 16, '', '', ''),
(62, 16, 'Acceptability of the Background and the Justification', 'A', 'A'),
(63, 16, 'Relevance of proposed degree program to Society', 'A', 'A'),
(64, 16, 'Entry Qualification and Admission Process', 'A', 'A'),
(65, 16, 'Program Structure', 'A', 'A'),
(66, 16, 'Program Content', 'A', 'A'),
(67, 16, 'Teaching Learning Methods', 'A', 'A'),
(68, 16, 'Assessment Strategy/Procedure', 'A', 'A'),
(69, 16, 'Resource Availability - Physical', 'A', 'A'),
(70, 16, 'Qualifications of Panel of Teachers (Internal & External)', 'A', 'A'),
(71, 16, 'Recommended Reading', 'A', 'A'),
(72, 16, 'Recommendation (a, b, or c)', 'A', 'A'),
(73, 13, '', '', ''),
(74, 13, 'Acceptability of the Background and the Justification', 'sdf', 'dsf'),
(75, 13, 'Relevance of proposed degree program to Society', 'sd', 'f'),
(76, 13, 'Entry Qualification and Admission Process', 'sdf', 'sdf'),
(77, 13, 'Program Structure', 'sdf', 'sdf'),
(78, 13, 'Program Content', 'sdf', 'sdf'),
(79, 13, 'Teaching Learning Methods', 'sdf', 'sdf'),
(80, 13, 'Assessment Strategy/Procedure', 'sd', 'fsd'),
(81, 13, 'Resource Availability - Physical', 'fsd', 'f'),
(82, 13, 'Qualifications of Panel of Teachers (Internal & External)', 'sdf', 'sdf'),
(83, 13, 'Recommended Reading', 'sdf', 'dsf'),
(84, 13, 'Recommendation (a, b, or c)', 'sd', 'fsdf'),
(97, 18, '', '', ''),
(98, 18, 'Acceptability of the Background and the Justification', 'dsf', 'dsf'),
(99, 18, 'Relevance of proposed degree program to Society', 'dsf', 'sdf'),
(100, 18, 'Entry Qualification and Admission Process', 'sdf', 'sdf'),
(101, 18, 'Program Structure', 'sdf', 'sdf'),
(102, 18, 'Program Content', 'sdf', 'sdf'),
(103, 18, 'Teaching Learning Methods', 'sdf', 'sdf'),
(104, 18, 'Assessment Strategy/Procedure', 'sd', 'fsdf'),
(105, 18, 'Resource Availability - Physical', 'sd', 'fsd'),
(106, 18, 'Qualifications of Panel of Teachers (Internal & External)', 'f', 'dsf'),
(107, 18, 'Recommended Reading', 'sdf', 'dsf'),
(108, 18, 'Recommendation (a, b, or c)', 'dsf', 'sdf'),
(109, 14, '', '', ''),
(110, 14, 'Acceptability of the Background and the Justification', 'A', 'A'),
(111, 14, 'Relevance of proposed degree program to Society', 'A', 'A'),
(112, 14, 'Entry Qualification and Admission Process', 'A', 'A'),
(113, 14, 'Program Structure', 'A', 'A'),
(114, 14, 'Program Content', 'A', 'A'),
(115, 14, 'Teaching Learning Methods', 'A', 'A'),
(116, 14, 'Assessment Strategy/Procedure', 'A', 'A'),
(117, 14, 'Resource Availability - Physical', 'A', 'A'),
(118, 14, 'Qualifications of Panel of Teachers (Internal & External)', 'A', 'A'),
(119, 14, 'Recommended Reading', 'A', 'A'),
(120, 14, 'Recommendation (a, b, or c)', 'A', 'A');

-- --------------------------------------------------------

--
-- Table structure for table `proposal_reviewer_details`
--

CREATE TABLE `proposal_reviewer_details` (
  `report_id` int(11) NOT NULL,
  `proposal_id` int(11) NOT NULL,
  `reviewer_id` int(11) NOT NULL,
  `name` varchar(1000) NOT NULL,
  `designation` varchar(1000) NOT NULL,
  `qualification` varchar(1000) NOT NULL,
  `signature` varchar(1000) NOT NULL,
  `date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `proposal_reviewer_details`
--

INSERT INTO `proposal_reviewer_details` (`report_id`, `proposal_id`, `reviewer_id`, `name`, `designation`, `qualification`, `signature`, `date`) VALUES
(12, 1, 1, 'B', '4', 'R4Rf', 'T', '2025-04-02'),
(12, 1, 6, 'AAAA', 'T', 'RRf', '3RH', '2025-03-27'),
(24, 2, 7, 'xa', 'ax', 'xa', 'xa', '2025-03-20'),
(24, 2, 8, 'cd', 'sc', 'ax', 'az', '2025-04-02'),
(36, 3, 9, 'ref', 'reff', 'ref', 'erfer', '2025-03-20'),
(36, 3, 10, 'gbb', 'f', 'erfer', 'erf', '2025-03-25'),
(48, 7, 11, 'd', 'vferv', 'evr', 'rev', '2025-03-26'),
(48, 7, 12, 'r', 'v', 'erver', 'evr', '2025-03-27'),
(60, 6, 13, 'efwt', 'e', 'ewf', 'wef', '2025-03-20'),
(60, 6, 14, 'g', 'ewf', 'wef', 'efw', '2025-03-26'),
(72, 16, 15, 'A', 'A', 'A', 'A', '2025-03-17'),
(84, 13, 16, 'dfs', 'sdfsd', 'sdf', 'sdf', '2025-03-06'),
(84, 13, 17, 'f', 'sdf', 'dfsfd', 's', '2025-03-11'),
(108, 18, 20, 'dfs', 'sdf', 'sdf', 'dsf', '2025-03-27'),
(108, 18, 21, 't', '5rt4', 'tg', 'fg', '2025-03-24'),
(72, 16, 22, 'Z', 'wwddwwddw', 'sw', 'ws', '2025-03-19'),
(120, 14, 23, 'A', 'A', 'A', 'A', '2025-05-16'),
(120, 14, 24, 'B', 'B', 'B', 'B', '2025-05-16');

-- --------------------------------------------------------

--
-- Table structure for table `proposal_section_status`
--

CREATE TABLE `proposal_section_status` (
  `proposal_id` int(11) NOT NULL,
  `section_number` int(11) NOT NULL,
  `status` enum('Not Started','In Progress','Completed') DEFAULT 'Not Started',
  `last_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `proposal_status_history`
--

CREATE TABLE `proposal_status_history` (
  `history_id` int(11) NOT NULL,
  `proposal_id` int(11) NOT NULL,
  `updated_by` int(11) NOT NULL,
  `previous_status` varchar(50) DEFAULT NULL,
  `new_status` varchar(50) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `proposal_status_history`
--

INSERT INTO `proposal_status_history` (`history_id`, `proposal_id`, `updated_by`, `previous_status`, `new_status`, `updated_at`) VALUES
(1, 1, 3, 'submitted', 'rejectedbydean', '2025-03-08 14:00:51'),
(2, 1, 3, 'submitted', 'rejectedbydean', '2025-03-08 14:05:50'),
(3, 1, 3, 'submitted', 'rejectedbydean', '2025-03-08 14:23:43'),
(4, 1, 3, 'submitted', 'approvedbydean', '2025-03-08 14:27:05'),
(5, 1, 5, 'approvedbydean', 'approvedbyvc', '2025-03-08 14:28:16'),
(6, 1, 6, 'approvedbyvc', 'approvedbycqa', '2025-03-08 14:29:22'),
(7, 1, 7, 'approvedbycqa', 'approvedbyqachead', '2025-03-08 14:30:37'),
(8, 1, 8, 'approvedbyqachead', 'approvedbyugcfinance', '2025-03-08 14:32:39'),
(9, 1, 9, 'approvedbyugcfinance', 'approvedbyugchr', '2025-03-08 14:33:16'),
(10, 1, 10, 'approvedbyugchr', 'approvedbyugcidd', '2025-03-08 14:33:44'),
(11, 1, 11, 'approvedbyugcidd', 'approvedbyugclegal', '2025-03-08 14:34:15'),
(12, 1, 13, 'approvedbyugclegal', 'approvedbyugcadmission', '2025-03-08 14:35:15'),
(13, 1, 12, 'approvedbyugcadmission', 'approvedbyugcacademic', '2025-03-08 14:35:44'),
(14, 2, 3, 'submitted', 'rejectedbyugcidd', '2025-03-08 15:23:51'),
(15, 2, 3, 'submitted', 'rejectedbydean', '2025-03-08 15:25:39'),
(16, 2, 3, 'submitted', 'rejectedbydean', '2025-03-08 15:34:25'),
(17, 2, 3, 'submitted', 'rejectedbydean', '2025-03-08 15:56:23'),
(18, 2, 3, 'submitted', 'approvedbydean', '2025-03-08 16:24:11'),
(19, 2, 5, 'approvedbydean', 'approvedbyvc', '2025-03-08 16:41:36'),
(20, 2, 5, 'approvedbydean', 'approvedbyvc', '2025-03-08 16:42:40'),
(21, 2, 6, 'approvedbyvc', 'rejectedbycqa', '2025-03-08 16:44:19'),
(22, 2, 3, 'submitted', 'approvedbydean', '2025-03-08 16:48:03'),
(23, 2, 5, 'approvedbydean', 'approvedbyvc', '2025-03-08 17:19:57'),
(24, 3, 3, 'submitted', 'rejectedbyugcadmission', '2025-03-08 19:11:19'),
(25, 3, 3, 'submitted', 'rejectedbyugcfinance', '2025-03-08 19:11:51'),
(26, 3, 3, 'submitted', '', '2025-03-08 19:12:18'),
(27, 3, 3, '', '', '2025-03-08 19:12:23'),
(28, 3, 3, '', '', '2025-03-08 19:12:35'),
(29, 3, 3, 'submitted', '', '2025-03-08 19:13:53'),
(30, 3, 3, '', '', '2025-03-08 19:15:31'),
(31, 3, 3, 'submitted', 'approvedbydean', '2025-03-08 19:18:59'),
(32, 3, 3, 'submitted', 'approvedbydean', '2025-03-08 19:20:07'),
(33, 3, 5, 'approvedbydean', 'rejectedbyvc', '2025-03-09 09:19:19'),
(34, 3, 3, 'submitted', 'rejectedbydean', '2025-03-09 09:44:06'),
(35, 3, 3, 'submitted', 'rejectedbydean', '2025-03-09 09:52:08'),
(36, 6, 3, 'submitted', 'approvedbydean', '2025-03-09 10:01:02'),
(37, 3, 3, 'submitted', 'approvedbydean', '2025-03-15 06:35:50'),
(38, 3, 5, 'approvedbydean', 'approvedbyvc', '2025-03-15 06:36:29'),
(39, 3, 6, 'approvedbyvc', 'approvedbycqa', '2025-03-15 06:37:25'),
(40, 3, 7, 'approvedbycqa', 'rejectedbyqachead', '2025-03-15 06:38:23'),
(41, 3, 3, 'submitted', 'approvedbydean', '2025-03-15 06:39:34'),
(42, 3, 5, 'approvedbydean', 'approvedbyvc', '2025-03-15 06:40:08'),
(43, 3, 6, 'approvedbyvc', 'approvedbycqa', '2025-03-15 06:40:34'),
(44, 3, 7, 'approvedbycqa', 'rejectedbyqachead', '2025-03-15 06:40:58'),
(45, 3, 3, 'submitted', 'approvedbydean', '2025-03-15 06:41:51'),
(46, 3, 5, 'approvedbydean', 'approvedbyvc', '2025-03-15 06:42:24'),
(47, 3, 6, 'approvedbyvc', 'approvedbycqa', '2025-03-15 06:42:54'),
(48, 3, 7, 'approvedbycqa', 'rejectedbyqachead', '2025-03-15 06:43:12'),
(49, 3, 3, 'submitted', 'approvedbydean', '2025-03-15 06:44:36'),
(50, 3, 5, 'approvedbydean', 'approvedbyvc', '2025-03-15 06:45:05'),
(51, 3, 6, 'approvedbyvc', 'approvedbycqa', '2025-03-15 06:45:31'),
(52, 3, 7, 'approvedbycqa', 'rejectedbyqachead', '2025-03-15 07:00:03'),
(53, 7, 3, 'submitted', 'approvedbydean', '2025-03-15 08:41:41'),
(54, 7, 5, 'approvedbydean', 'approvedbyvc', '2025-03-15 08:43:39'),
(55, 3, 3, 'submitted', 'approvedbydean', '2025-03-15 14:55:46'),
(56, 3, 3, 'approvedbydean', 'approvedbydean', '2025-03-15 14:58:35'),
(57, 3, 3, 'approvedbydean', 'approvedbydean', '2025-03-15 14:58:53'),
(58, 3, 3, 'approvedbydean', 'rejectedbydean', '2025-03-15 14:59:06'),
(59, 3, 3, 'submitted', 'approvedbydean', '2025-03-15 15:03:04'),
(60, 3, 6, 'approvedbydean', 'approvedbycqa', '2025-03-15 15:03:28'),
(61, 3, 5, 'approvedbycqa', 'approvedbyvc', '2025-03-15 15:03:49'),
(62, 6, 6, 'approvedbydean', 'approvedbycqa', '2025-03-15 15:05:38'),
(63, 3, 7, 'approvedbyvc', 'rejectedbyqachead', '2025-03-15 15:06:37'),
(64, 3, 7, 'rejectedbyqachead', 'rejectedbyqachead', '2025-03-15 15:06:59'),
(65, 3, 3, 'submitted', 'approvedbydean', '2025-03-15 15:11:47'),
(66, 3, 6, 'approvedbydean', 'rejectedbycqa', '2025-03-15 15:14:15'),
(67, 3, 3, 'submitted', '', '2025-03-15 15:19:53'),
(68, 3, 3, '', '', '2025-03-15 15:20:34'),
(69, 3, 3, '', '', '2025-03-15 15:25:20'),
(70, 3, 3, 'submitted', '', '2025-03-15 15:27:29'),
(71, 3, 3, 'submitted', '', '2025-03-15 15:29:37'),
(72, 3, 3, '', 'rejectedbydean', '2025-03-15 15:32:02'),
(73, 3, 3, 'rejectedbydean', 'rejectedbydean', '2025-03-15 15:35:28'),
(74, 3, 3, 'submitted', 'approvedbydean', '2025-03-15 15:36:10'),
(75, 3, 6, 'approvedbydean', '', '2025-03-15 15:37:12'),
(76, 3, 6, '', '', '2025-03-15 16:02:28'),
(77, 3, 6, '', '', '2025-03-15 16:06:23'),
(78, 3, 6, '', 'rejectedbycqa', '2025-03-15 16:06:32'),
(79, 3, 3, 'submitted', 'approvedbydean', '2025-03-15 16:07:32'),
(80, 2, 7, 'approvedbyvc', '', '2025-03-15 16:10:06'),
(81, 2, 7, '', 'rejectedbyqachead', '2025-03-15 16:10:15'),
(82, 3, 7, 'approvedbyvc', '', '2025-03-15 16:18:01'),
(83, 3, 7, '', 'rejectedbyqachead', '2025-03-15 16:18:15'),
(84, 3, 7, 'approvedbyvc', '', '2025-03-15 16:22:36'),
(85, 3, 7, '', 'approvedbyqachead', '2025-03-15 16:22:47'),
(86, 3, 7, 'approvedbyvc', 'rejectedbyqachead', '2025-03-15 16:23:28'),
(87, 3, 3, 'submitted', '', '2025-03-15 16:24:22'),
(88, 3, 3, '', 'approvedbydean', '2025-03-15 16:24:35'),
(89, 6, 5, 'approvedbycqa', 'rejectedbyvc', '2025-03-15 16:24:58'),
(90, 3, 6, 'approvedbydean', '', '2025-03-15 16:25:57'),
(91, 3, 6, '', 'approvedbycqa', '2025-03-15 16:26:03'),
(92, 3, 5, 'approvedbycqa', 'approvedbyvc', '2025-03-15 16:26:30'),
(93, 3, 7, 'approvedbyvc', 'approvedbyqachead', '2025-03-15 16:26:49'),
(94, 3, 8, 'approvedbyqachead', '', '2025-03-15 16:27:06'),
(95, 3, 8, '', 'rejectedbyugcfinance', '2025-03-15 16:27:35'),
(96, 13, 3, 'submitted', 'approvedbydean', '2025-03-15 18:58:27'),
(97, 13, 6, 'approvedbydean', 'approvedbycqa', '2025-03-15 18:58:58'),
(98, 13, 5, 'approvedbycqa', 'approvedbyvc', '2025-03-15 18:59:37'),
(99, 13, 7, 'approvedbyvc', 'rejectedbyqachead', '2025-03-15 19:01:03'),
(100, 16, 3, 'submitted', '', '2025-03-16 06:26:39'),
(101, 16, 3, '', 'approvedbydean', '2025-03-16 06:26:46'),
(102, 16, 6, 'approvedbydean', 'approvedbycqa', '2025-03-16 06:28:08'),
(103, 16, 5, 'approvedbycqa', 'rejectedbyvc', '2025-03-16 06:29:23'),
(104, 7, 7, 'approvedbyvc', 'approvedbyqachead', '2025-03-16 06:32:16'),
(105, 3, 3, 'submitted', 'rejectedbyqachead', '2025-04-02 19:29:56'),
(106, 3, 3, 'submitted', 'rejectedbydean', '2025-05-15 16:23:57'),
(107, 13, 3, 'submitted', 'rejectedbydean', '2025-05-16 03:37:42'),
(108, 13, 3, 'submitted', '', '2025-05-16 03:38:40'),
(109, 13, 3, '', 'approvedbydean', '2025-05-16 03:38:58'),
(110, 13, 6, 'approvedbydean', 'rejectedbycqa', '2025-05-16 07:09:58');

-- --------------------------------------------------------

--
-- Table structure for table `universities`
--

CREATE TABLE `universities` (
  `university_id` int(11) NOT NULL,
  `university_name` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `universities`
--

INSERT INTO `universities` (`university_id`, `university_name`) VALUES
(1, 'University of Colombo'),
(2, 'University of Moratuwa'),
(3, 'University of Peradeniya'),
(4, 'University of Sri Jayawardenepura'),
(5, 'University of Kelaniya'),
(6, 'University of Jaffna'),
(7, 'University of Ruhuna'),
(8, 'Eastern University of SriLanka'),
(9, 'Rajarata University of SriLanka'),
(10, 'Sabaragamuwa University of SriLanka'),
(11, 'Wayamba University of SriLanka'),
(12, 'University of Visual and Performing Arts'),
(13, 'University of Uwa Wellassa'),
(14, 'South Eastern University of SriLanka'),
(15, 'Open University'),
(16, 'QAC-UGC');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) NOT NULL,
  `first_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `university` varchar(100) NOT NULL,
  `role` varchar(100) NOT NULL,
  `username` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `university_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `university`, `role`, `username`, `password`, `university_id`) VALUES
(2, 'Pro.', 'Coordinator UCSC', 'a@gmail.com', 'University of Colombo', 'Program Coordinator of the university', 'pccol', '$2y$10$AZypU4KIY87Uxif4Y8e6Zu5XJPaq9NxlLMqqFCq1z/353q6Rw4mWK', 1),
(3, 'Dr.A', 'B', 'ab@ucsc.ac.lk', 'University of Colombo', 'Dean/Rector/Director of the university', 'deancol', '$2y$10$AZypU4KIY87Uxif4Y8e6Zu5XJPaq9NxlLMqqFCq1z/353q6Rw4mWK', 1),
(5, 'Prof.A', 'S', 'weerasinghe@ucsc.ac.lk', 'University of Colombo', 'Vice Chancellor of the university', 'vccol', '$2y$10$AZypU4KIY87Uxif4Y8e6Zu5XJPaq9NxlLMqqFCq1z/353q6Rw4mWK', 1),
(6, 'B', 'B', 'b@ucsc.ac.lk', 'University of Colombo', 'CQA Director of the university', 'cqacol', '$2y$10$AZypU4KIY87Uxif4Y8e6Zu5XJPaq9NxlLMqqFCq1z/353q6Rw4mWK', 1),
(7, 'C', 'C', 'cc@qac.ugc.ac.lk', 'QAC-UGC', 'Head of the QAC-UGC Department', 'ugchead', '$2y$10$AZypU4KIY87Uxif4Y8e6Zu5XJPaq9NxlLMqqFCq1z/353q6Rw4mWK', 16),
(8, 'd', 'd', 'dd@qac.ugc.ac.lk', 'QAC-UGC', 'UGC - Finance Department', 'finance', '$2y$10$AZypU4KIY87Uxif4Y8e6Zu5XJPaq9NxlLMqqFCq1z/353q6Rw4mWK', 16),
(9, 'e', 'e', 'hr@qac.ugc.ac.lk', 'QAC-UGC', 'UGC - HR Department', 'hr', '$2y$10$AZypU4KIY87Uxif4Y8e6Zu5XJPaq9NxlLMqqFCq1z/353q6Rw4mWK', 16),
(10, 'i', 'dd', 'idd@qac.ugc.ac.lk', 'QAC-UGC', 'UGC - IDD Department', 'idd', '$2y$10$AZypU4KIY87Uxif4Y8e6Zu5XJPaq9NxlLMqqFCq1z/353q6Rw4mWK', 16),
(11, 'D', 'E', 'legal@ugc.qac.ac.lk', 'QAC-UGC', 'UGC - Legal Department', 'legal', '$2y$10$AZypU4KIY87Uxif4Y8e6Zu5XJPaq9NxlLMqqFCq1z/353q6Rw4mWK', 16),
(12, 'ac', 'ac', 'academic@ugc.ac.lk', 'QAC-UGC', 'UGC - Academic Department', 'ac', '$2y$10$AZypU4KIY87Uxif4Y8e6Zu5XJPaq9NxlLMqqFCq1z/353q6Rw4mWK', 16),
(13, 'admission', 'admission', 'admission@qac.ugc.ac.lk', 'QAC-UGC', 'UGC - Admission Department', 'ad', '$2y$10$AZypU4KIY87Uxif4Y8e6Zu5XJPaq9NxlLMqqFCq1z/353q6Rw4mWK', 16),
(20, 'A', 'B', 'pc@peradeniya.ac.lk', 'University of Peradeniya', 'Program Coordinator of the university', 'pcpera', '$2y$10$AZypU4KIY87Uxif4Y8e6Zu5XJPaq9NxlLMqqFCq1z/353q6Rw4mWK', 3),
(21, 'Dean', 'D', 'dean@peradeniya.ac.lk', 'University of Peradeniya', 'Dean/Rector/Director of the university', 'deanpera', '$2y$10$AZypU4KIY87Uxif4Y8e6Zu5XJPaq9NxlLMqqFCq1z/353q6Rw4mWK', 3),
(22, 'CQA', 'Director', 'cqa@pera.ac.lk', 'University of Peradeniya', 'CQA Director of the university', 'cqapera', '$2y$10$AZypU4KIY87Uxif4Y8e6Zu5XJPaq9NxlLMqqFCq1z/353q6Rw4mWK', 3),
(23, 'VC', 'Peradeniya', 'vc@pera.ac.lk', 'University of Peradeniya', 'Vice Chancellor of the university', 'vcpera', '$2y$10$AZypU4KIY87Uxif4Y8e6Zu5XJPaq9NxlLMqqFCq1z/353q6Rw4mWK', 3),
(25, 'A', 'B', 'pceastern@ac.lk', 'Eastern University of SriLanka', 'Program Coordinator of the university', 'pceastern', '$2y$10$AZypU4KIY87Uxif4Y8e6Zu5XJPaq9NxlLMqqFCq1z/353q6Rw4mWK', 8);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `proposals`
--
ALTER TABLE `proposals`
  ADD PRIMARY KEY (`proposal_id`),
  ADD KEY `fk_proposal_user` (`id`),
  ADD KEY `fk_uni_pro` (`university_id`);

--
-- Indexes for table `proposal_assessment_rules`
--
ALTER TABLE `proposal_assessment_rules`
  ADD PRIMARY KEY (`assessment_rule_id`),
  ADD KEY `fk_proposal` (`proposal_id`);

--
-- Indexes for table `proposal_comments`
--
ALTER TABLE `proposal_comments`
  ADD PRIMARY KEY (`comment_id`),
  ADD KEY `fk_proposals` (`proposal_id`),
  ADD KEY `fk_users` (`id`);

--
-- Indexes for table `proposal_compliance_check`
--
ALTER TABLE `proposal_compliance_check`
  ADD PRIMARY KEY (`compliance_check_id`),
  ADD KEY `fk_proposal_2` (`proposal_id`);

--
-- Indexes for table `proposal_degree_details`
--
ALTER TABLE `proposal_degree_details`
  ADD PRIMARY KEY (`degree_id`),
  ADD KEY `fk_proposal_3` (`proposal_id`);

--
-- Indexes for table `proposal_financial_resource`
--
ALTER TABLE `proposal_financial_resource`
  ADD PRIMARY KEY (`financial_resource_id`),
  ADD KEY `fk_proposal_7` (`proposal_id`),
  ADD KEY `fk_resource_b` (`resource_requirement_id`);

--
-- Indexes for table `proposal_general_info`
--
ALTER TABLE `proposal_general_info`
  ADD PRIMARY KEY (`general_info_id`),
  ADD KEY `fk_proposal_9` (`proposal_id`);

--
-- Indexes for table `proposal_grades_received`
--
ALTER TABLE `proposal_grades_received`
  ADD PRIMARY KEY (`program_id`),
  ADD KEY `fk_proposal_4` (`proposal_id`),
  ADD KEY `fk_degree` (`degree_id`);

--
-- Indexes for table `proposal_human_resource`
--
ALTER TABLE `proposal_human_resource`
  ADD PRIMARY KEY (`human_resource_id`),
  ADD KEY `fk_proposal_6` (`proposal_id`),
  ADD KEY `fk_resource_a` (`resource_requirement_id`);

--
-- Indexes for table `proposal_mandate_availability`
--
ALTER TABLE `proposal_mandate_availability`
  ADD PRIMARY KEY (`mandate_availability_id`),
  ADD KEY `fk_proposal_ma` (`proposal_id`),
  ADD KEY `fk_pe_ma` (`program_entity_id`);

--
-- Indexes for table `proposal_panel_of_teachers`
--
ALTER TABLE `proposal_panel_of_teachers`
  ADD PRIMARY KEY (`teacher_id`),
  ADD KEY `fk_proposal_10` (`proposal_id`);

--
-- Indexes for table `proposal_payments`
--
ALTER TABLE `proposal_payments`
  ADD PRIMARY KEY (`payment_id`),
  ADD UNIQUE KEY `order_id` (`order_id`),
  ADD KEY `proposal_id` (`proposal_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `proposal_physical_resource`
--
ALTER TABLE `proposal_physical_resource`
  ADD PRIMARY KEY (`physical_resource_id`),
  ADD KEY `fk_proposal_8` (`proposal_id`),
  ADD KEY `fk_resource_c` (`resource_requirement_id`);

--
-- Indexes for table `proposal_program_content`
--
ALTER TABLE `proposal_program_content`
  ADD PRIMARY KEY (`content_id`),
  ADD KEY `fk_proposal_11` (`proposal_id`);

--
-- Indexes for table `proposal_program_delivery`
--
ALTER TABLE `proposal_program_delivery`
  ADD PRIMARY KEY (`program_delivery_id`),
  ADD KEY `fk_proposal_12` (`proposal_id`);

--
-- Indexes for table `proposal_program_entity`
--
ALTER TABLE `proposal_program_entity`
  ADD PRIMARY KEY (`program_entity_id`),
  ADD KEY `fk_proposal_13` (`proposal_id`);

--
-- Indexes for table `proposal_program_structure`
--
ALTER TABLE `proposal_program_structure`
  ADD PRIMARY KEY (`program_structure_id`),
  ADD KEY `fk_proposal_14` (`proposal_id`);

--
-- Indexes for table `proposal_resource_requirements`
--
ALTER TABLE `proposal_resource_requirements`
  ADD PRIMARY KEY (`resource_requirement_id`),
  ADD KEY `fk_proposal_5` (`proposal_id`);

--
-- Indexes for table `proposal_reviewers_report`
--
ALTER TABLE `proposal_reviewers_report`
  ADD PRIMARY KEY (`report_id`),
  ADD KEY `fk_proposal_15` (`proposal_id`);

--
-- Indexes for table `proposal_reviewer_details`
--
ALTER TABLE `proposal_reviewer_details`
  ADD PRIMARY KEY (`reviewer_id`),
  ADD KEY `fk_proposal_16` (`proposal_id`),
  ADD KEY `fk_report` (`report_id`);

--
-- Indexes for table `proposal_section_status`
--
ALTER TABLE `proposal_section_status`
  ADD PRIMARY KEY (`proposal_id`,`section_number`);

--
-- Indexes for table `proposal_status_history`
--
ALTER TABLE `proposal_status_history`
  ADD PRIMARY KEY (`history_id`),
  ADD KEY `proposal_id` (`proposal_id`),
  ADD KEY `updated_by` (`updated_by`);

--
-- Indexes for table `universities`
--
ALTER TABLE `universities`
  ADD PRIMARY KEY (`university_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_uid` (`university_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `proposals`
--
ALTER TABLE `proposals`
  MODIFY `proposal_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `proposal_assessment_rules`
--
ALTER TABLE `proposal_assessment_rules`
  MODIFY `assessment_rule_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `proposal_comments`
--
ALTER TABLE `proposal_comments`
  MODIFY `comment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=108;

--
-- AUTO_INCREMENT for table `proposal_compliance_check`
--
ALTER TABLE `proposal_compliance_check`
  MODIFY `compliance_check_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `proposal_degree_details`
--
ALTER TABLE `proposal_degree_details`
  MODIFY `degree_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `proposal_financial_resource`
--
ALTER TABLE `proposal_financial_resource`
  MODIFY `financial_resource_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `proposal_general_info`
--
ALTER TABLE `proposal_general_info`
  MODIFY `general_info_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `proposal_grades_received`
--
ALTER TABLE `proposal_grades_received`
  MODIFY `program_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=105;

--
-- AUTO_INCREMENT for table `proposal_human_resource`
--
ALTER TABLE `proposal_human_resource`
  MODIFY `human_resource_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `proposal_mandate_availability`
--
ALTER TABLE `proposal_mandate_availability`
  MODIFY `mandate_availability_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `proposal_panel_of_teachers`
--
ALTER TABLE `proposal_panel_of_teachers`
  MODIFY `teacher_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=286;

--
-- AUTO_INCREMENT for table `proposal_payments`
--
ALTER TABLE `proposal_payments`
  MODIFY `payment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `proposal_physical_resource`
--
ALTER TABLE `proposal_physical_resource`
  MODIFY `physical_resource_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=91;

--
-- AUTO_INCREMENT for table `proposal_program_content`
--
ALTER TABLE `proposal_program_content`
  MODIFY `content_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `proposal_program_delivery`
--
ALTER TABLE `proposal_program_delivery`
  MODIFY `program_delivery_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `proposal_program_entity`
--
ALTER TABLE `proposal_program_entity`
  MODIFY `program_entity_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `proposal_program_structure`
--
ALTER TABLE `proposal_program_structure`
  MODIFY `program_structure_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `proposal_resource_requirements`
--
ALTER TABLE `proposal_resource_requirements`
  MODIFY `resource_requirement_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `proposal_reviewers_report`
--
ALTER TABLE `proposal_reviewers_report`
  MODIFY `report_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=121;

--
-- AUTO_INCREMENT for table `proposal_reviewer_details`
--
ALTER TABLE `proposal_reviewer_details`
  MODIFY `reviewer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `proposal_status_history`
--
ALTER TABLE `proposal_status_history`
  MODIFY `history_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=111;

--
-- AUTO_INCREMENT for table `universities`
--
ALTER TABLE `universities`
  MODIFY `university_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `proposals`
--
ALTER TABLE `proposals`
  ADD CONSTRAINT `fk_proposal_user` FOREIGN KEY (`id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_uni_pro` FOREIGN KEY (`university_id`) REFERENCES `universities` (`university_id`);

--
-- Constraints for table `proposal_assessment_rules`
--
ALTER TABLE `proposal_assessment_rules`
  ADD CONSTRAINT `fk_proposal` FOREIGN KEY (`proposal_id`) REFERENCES `proposals` (`proposal_id`) ON DELETE CASCADE;

--
-- Constraints for table `proposal_comments`
--
ALTER TABLE `proposal_comments`
  ADD CONSTRAINT `fk_proposals` FOREIGN KEY (`proposal_id`) REFERENCES `proposals` (`proposal_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_users` FOREIGN KEY (`id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `proposal_compliance_check`
--
ALTER TABLE `proposal_compliance_check`
  ADD CONSTRAINT `fk_proposal_2` FOREIGN KEY (`proposal_id`) REFERENCES `proposals` (`proposal_id`) ON DELETE CASCADE;

--
-- Constraints for table `proposal_degree_details`
--
ALTER TABLE `proposal_degree_details`
  ADD CONSTRAINT `fk_proposal_3` FOREIGN KEY (`proposal_id`) REFERENCES `proposals` (`proposal_id`) ON DELETE CASCADE;

--
-- Constraints for table `proposal_financial_resource`
--
ALTER TABLE `proposal_financial_resource`
  ADD CONSTRAINT `fk_proposal_7` FOREIGN KEY (`proposal_id`) REFERENCES `proposals` (`proposal_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_resource_b` FOREIGN KEY (`resource_requirement_id`) REFERENCES `proposal_resource_requirements` (`resource_requirement_id`) ON DELETE CASCADE;

--
-- Constraints for table `proposal_general_info`
--
ALTER TABLE `proposal_general_info`
  ADD CONSTRAINT `fk_proposal_9` FOREIGN KEY (`proposal_id`) REFERENCES `proposals` (`proposal_id`) ON DELETE CASCADE;

--
-- Constraints for table `proposal_grades_received`
--
ALTER TABLE `proposal_grades_received`
  ADD CONSTRAINT `fk_degree` FOREIGN KEY (`degree_id`) REFERENCES `proposal_degree_details` (`degree_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_proposal_4` FOREIGN KEY (`proposal_id`) REFERENCES `proposals` (`proposal_id`) ON DELETE CASCADE;

--
-- Constraints for table `proposal_human_resource`
--
ALTER TABLE `proposal_human_resource`
  ADD CONSTRAINT `fk_proposal_6` FOREIGN KEY (`proposal_id`) REFERENCES `proposals` (`proposal_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_resource_a` FOREIGN KEY (`resource_requirement_id`) REFERENCES `proposal_resource_requirements` (`resource_requirement_id`) ON DELETE CASCADE;

--
-- Constraints for table `proposal_mandate_availability`
--
ALTER TABLE `proposal_mandate_availability`
  ADD CONSTRAINT `fk_pe_ma` FOREIGN KEY (`program_entity_id`) REFERENCES `proposal_program_entity` (`program_entity_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_proposal_ma` FOREIGN KEY (`proposal_id`) REFERENCES `proposals` (`proposal_id`) ON DELETE CASCADE;

--
-- Constraints for table `proposal_panel_of_teachers`
--
ALTER TABLE `proposal_panel_of_teachers`
  ADD CONSTRAINT `fk_proposal_10` FOREIGN KEY (`proposal_id`) REFERENCES `proposals` (`proposal_id`) ON DELETE CASCADE;

--
-- Constraints for table `proposal_payments`
--
ALTER TABLE `proposal_payments`
  ADD CONSTRAINT `proposal_payments_ibfk_1` FOREIGN KEY (`proposal_id`) REFERENCES `proposals` (`proposal_id`),
  ADD CONSTRAINT `proposal_payments_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `proposal_physical_resource`
--
ALTER TABLE `proposal_physical_resource`
  ADD CONSTRAINT `fk_proposal_8` FOREIGN KEY (`proposal_id`) REFERENCES `proposals` (`proposal_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_resource_c` FOREIGN KEY (`resource_requirement_id`) REFERENCES `proposal_resource_requirements` (`resource_requirement_id`) ON DELETE CASCADE;

--
-- Constraints for table `proposal_program_content`
--
ALTER TABLE `proposal_program_content`
  ADD CONSTRAINT `fk_proposal_11` FOREIGN KEY (`proposal_id`) REFERENCES `proposals` (`proposal_id`) ON DELETE CASCADE;

--
-- Constraints for table `proposal_program_delivery`
--
ALTER TABLE `proposal_program_delivery`
  ADD CONSTRAINT `fk_proposal_12` FOREIGN KEY (`proposal_id`) REFERENCES `proposals` (`proposal_id`) ON DELETE CASCADE;

--
-- Constraints for table `proposal_program_entity`
--
ALTER TABLE `proposal_program_entity`
  ADD CONSTRAINT `fk_proposal_13` FOREIGN KEY (`proposal_id`) REFERENCES `proposals` (`proposal_id`) ON DELETE CASCADE;

--
-- Constraints for table `proposal_program_structure`
--
ALTER TABLE `proposal_program_structure`
  ADD CONSTRAINT `fk_proposal_14` FOREIGN KEY (`proposal_id`) REFERENCES `proposals` (`proposal_id`) ON DELETE CASCADE;

--
-- Constraints for table `proposal_resource_requirements`
--
ALTER TABLE `proposal_resource_requirements`
  ADD CONSTRAINT `fk_proposal_5` FOREIGN KEY (`proposal_id`) REFERENCES `proposals` (`proposal_id`) ON DELETE CASCADE;

--
-- Constraints for table `proposal_reviewers_report`
--
ALTER TABLE `proposal_reviewers_report`
  ADD CONSTRAINT `fk_proposal_15` FOREIGN KEY (`proposal_id`) REFERENCES `proposals` (`proposal_id`) ON DELETE CASCADE;

--
-- Constraints for table `proposal_reviewer_details`
--
ALTER TABLE `proposal_reviewer_details`
  ADD CONSTRAINT `fk_proposal_16` FOREIGN KEY (`proposal_id`) REFERENCES `proposals` (`proposal_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_report` FOREIGN KEY (`report_id`) REFERENCES `proposal_reviewers_report` (`report_id`) ON DELETE CASCADE;

--
-- Constraints for table `proposal_status_history`
--
ALTER TABLE `proposal_status_history`
  ADD CONSTRAINT `proposal_status_history_ibfk_1` FOREIGN KEY (`proposal_id`) REFERENCES `proposals` (`proposal_id`),
  ADD CONSTRAINT `proposal_status_history_ibfk_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `fk_uid` FOREIGN KEY (`university_id`) REFERENCES `universities` (`university_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
