-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 25, 2025 at 11:47 PM
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
  `status` enum('fresh','draft','submitted','under_review','approvedbydean','rejectedbydean','rejectedbyvc','approvedbyvc','approvedbycqa','rejectedbycqa','approvedbyugcfinance','rejectedbyugcfinance','approvedbyugchr','rejectedbyugchr','approvedbyugcidd','rejecteddbyugcidd','approvedbyugcacademic','rejectedbyugcacademic','approvedbyugcadmission','rejectedbyugcadmission','approvedbyqachead','rejectedbyqachead','approvedbyTA','rejectedbyTA','approvedbysecretary','rejectedbysecretary','approvedbyStandardCommittee','rejectedbyStandardCommittee','approvedbyqachead_revised','approvedbydean_revised','approvedbycqa_revised','approvedbyvc_revised','resignature_request_from_university','re-signed_dean','re-signed_cqa','re-signed_vc','approvedbyalldepartments','under_review_by_ATechAssistant','under_review_by_BTechAssistant') DEFAULT 'draft',
  `university_visible_status` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `submitted_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `id` int(11) DEFAULT NULL,
  `proposal_code` varchar(1000) NOT NULL,
  `proposal_type` varchar(100) NOT NULL,
  `last_updated_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `proposals`
--

INSERT INTO `proposals` (`proposal_id`, `university_id`, `created_by`, `status`, `university_visible_status`, `created_at`, `updated_at`, `submitted_at`, `id`, `proposal_code`, `proposal_type`, `last_updated_by`) VALUES
(1, 1, 2, 'approvedbyugcacademic', 'approvedbyqachead', '2025-03-08 13:35:50', '2025-07-13 11:01:42', '2025-07-13 11:01:42', NULL, 'UG1', 'initial_proposal', NULL),
(2, 1, 2, 'approvedbyStandardCommittee', 'approvedbyStandardCommittee', '2025-03-08 15:02:06', '2025-07-12 22:13:32', '2025-07-12 22:13:32', NULL, 'UG2', 'revised_1', NULL),
(3, 1, 2, 'approvedbyTA', 'approvedbyTA', '2025-03-08 17:02:06', '2025-07-13 19:31:12', '2025-07-13 19:31:12', NULL, 'UG3', 'initial_proposal', NULL),
(4, 1, 2, 'fresh', 'fresh', '2025-03-08 17:44:13', '2025-07-11 19:32:42', '2025-07-11 19:32:42', NULL, 'UG4', '', NULL),
(5, 1, 2, 'fresh', 'fresh', '2025-03-08 17:44:34', '2025-07-11 19:32:42', '2025-07-11 19:32:42', NULL, 'UG5', '', NULL),
(6, 1, 2, 'approvedbydean', 'approvedbydean', '2025-03-08 17:46:41', '2025-07-13 16:58:54', '2025-07-13 16:58:54', NULL, 'UG6', 'revised_ST', NULL),
(7, 1, 2, 'approvedbyalldepartments', 'approvedbyqachead', '2025-03-08 18:38:45', '2025-07-11 22:23:43', '2025-07-11 22:23:43', NULL, 'UG7', 'initial_proposal', NULL),
(8, 1, 2, 'fresh', 'fresh', '2025-03-09 07:25:48', '2025-07-11 19:32:42', '2025-07-11 19:32:42', NULL, 'UG8', '', NULL),
(9, 1, 2, 'fresh', 'fresh', '2025-03-09 09:06:12', '2025-07-11 19:32:42', '2025-07-11 19:32:42', NULL, 'UG9', '', NULL),
(10, 1, 2, 'fresh', 'fresh', '2025-03-09 13:51:22', '2025-07-11 19:32:42', '2025-07-11 19:32:42', NULL, 'UG10', '', NULL),
(11, 1, 2, 'fresh', 'fresh', '2025-03-09 14:11:23', '2025-07-11 19:32:42', '2025-07-11 19:32:42', NULL, 'UG11', '', NULL),
(12, 1, 2, 'fresh', 'fresh', '2025-03-09 14:29:36', '2025-07-11 19:32:42', '2025-07-11 19:32:42', NULL, 'UG12', '', NULL),
(13, 1, 2, 're-signed_vc', 're-signed_vc', '2025-03-14 18:32:17', '2025-07-13 16:21:59', '2025-07-13 16:21:59', NULL, 'UG13', 'revised_1', NULL),
(14, 1, 2, 'approvedbyTA', 'approvedbyTA', '2025-03-15 07:08:06', '2025-07-25 19:17:09', '2025-07-25 19:17:09', NULL, 'UG14', 'revised_ST', NULL),
(15, 1, 2, 'fresh', 'fresh', '2025-03-15 08:39:59', '2025-07-11 19:32:42', '2025-07-11 19:32:42', NULL, 'UG15', '', NULL),
(16, 1, 2, 'approvedbyalldepartments', 'approvedbyqachead_revised', '2025-03-15 18:32:21', '2025-07-11 23:11:12', '2025-07-11 23:11:12', NULL, 'UG16', 'revised_3', NULL),
(18, 3, 20, 'submitted', 'submitted', '2025-03-15 19:32:13', '2025-07-11 19:32:42', '2025-07-11 19:32:42', NULL, 'UG18', '', NULL),
(19, 1, 2, 'approvedbyalldepartments', 'approvedbyqachead', '2025-03-16 06:15:43', '2025-07-11 20:42:26', '2025-07-11 20:42:26', NULL, 'UG19', 'revised_3', NULL),
(20, 1, 2, 'fresh', 'fresh', '2025-05-15 17:29:27', '2025-07-11 19:32:42', '2025-07-11 19:32:42', NULL, 'UG20', '', NULL),
(21, 1, 2, 'fresh', 'fresh', '2025-05-16 03:24:58', '2025-07-11 19:32:42', '2025-07-11 19:32:42', NULL, 'UG21', '', NULL),
(23, 1, 2, 'draft', 'draft', '2025-05-16 09:07:13', '2025-07-11 19:32:42', '2025-07-11 19:32:42', NULL, 'UG23', '', NULL),
(49, 1, 2, 'approvedbyugcfinance', 'approvedbyqachead_revised', '2025-06-08 16:29:01', '2025-07-11 20:42:26', '2025-07-11 20:42:26', NULL, 'UG49', 'revised_2', NULL),
(50, 1, 2, 'fresh', 'fresh', '2025-06-25 18:04:47', '2025-07-11 19:32:42', '2025-07-11 19:32:42', NULL, 'UG50', '', NULL),
(51, 1, 2, 'fresh', 'fresh', '2025-06-27 06:15:23', '2025-07-11 19:32:42', '2025-07-11 19:32:42', NULL, 'UG51', '', NULL),
(52, 1, 2, 'fresh', 'fresh', '2025-06-27 06:39:13', '2025-07-11 19:32:42', '2025-07-11 19:32:42', NULL, 'UG52', '', NULL),
(53, 1, 2, 'approvedbyalldepartments', 're-signed_vc', '2025-07-09 20:17:09', '2025-07-11 20:42:26', '2025-07-11 20:42:26', NULL, 'UG53', 'revised_1', NULL),
(69, 1, 2, 'approvedbyalldepartments', 're-signed_vc', '2025-07-12 12:23:04', '2025-07-12 20:59:07', '2025-07-12 20:59:07', NULL, 'UG69', 'revised_1', 26),
(70, 1, 2, 'fresh', '', '2025-07-12 12:30:21', '2025-07-12 12:30:21', '2025-07-12 12:30:21', NULL, 'UG70', '', NULL),
(71, 1, 2, 'fresh', 'fresh', '2025-07-19 20:15:40', '2025-07-19 20:15:40', '2025-07-19 20:15:40', NULL, 'UG71', '', NULL),
(72, 1, 2, 'draft', 'draft', '2025-07-19 20:16:29', '2025-07-19 20:16:49', '2025-07-19 20:16:49', NULL, 'UG72', '', NULL),
(73, 1, 2, 'fresh', 'fresh', '2025-07-19 20:43:46', '2025-07-19 20:43:46', '2025-07-19 20:43:46', NULL, 'UG73', '', NULL),
(74, 1, 2, 'fresh', 'fresh', '2025-07-19 20:55:43', '2025-07-19 20:55:43', '2025-07-19 20:55:43', NULL, 'UG74', '', NULL),
(75, 1, 2, 'draft', 'draft', '2025-07-19 20:57:01', '2025-07-19 20:57:22', '2025-07-19 20:57:22', NULL, 'UG75', '', NULL),
(76, 1, 2, 'fresh', 'fresh', '2025-07-19 22:26:37', '2025-07-19 22:26:37', '2025-07-19 22:26:37', NULL, 'UG76', '', NULL),
(77, 1, 2, 'fresh', 'fresh', '2025-07-19 23:40:43', '2025-07-19 23:40:43', '2025-07-19 23:40:43', NULL, 'UG77', '', NULL);

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
(14, 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'ABC', 10),
(19, 'FV', 'DFVDF', 'V', 'FV', 'DFV', 'DFV', 'DFV', 'DFV', 11),
(49, 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 12),
(53, 'sdc', 'sdc', 'sdc', 'dsc', 'sdc', 'sdc', 'sdc', 'sdc', 13),
(69, 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 14),
(23, 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 15);

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
  `Date` date NOT NULL DEFAULT current_timestamp(),
  `Time` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `proposal_comments`
--

INSERT INTO `proposal_comments` (`comment_id`, `proposal_id`, `comment`, `seal_and_sign`, `proposal_status`, `id`, `Date`, `Time`) VALUES
(1, 1, 'Reviewer Details wrong.', NULL, 'rejectedbydean', 3, '2025-03-08', '00:00:00'),
(2, 1, 'Lot of Reviewer Details.', NULL, 'rejectedbydean', 3, '2025-03-08', '00:00:00'),
(3, 1, 'Cooperate evidence file type should be pdf.', NULL, 'rejectedbydean', 3, '2025-03-08', '00:00:00'),
(4, 1, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1741444025_action.pdf', 'approvedbydean', 3, '2025-03-08', '00:00:00'),
(5, 1, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1741444096_action.pdf', 'approvedbyvc', 5, '2025-03-08', '00:00:00'),
(6, 1, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1741444162_action.pdf', 'approvedbycqa', 6, '2025-03-08', '00:00:00'),
(7, 1, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1741444237_action.pdf', 'approvedbyqachead', 7, '2025-03-08', '00:00:00'),
(8, 1, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1741444359_action.pdf', 'approvedbyugcfinance', 8, '2025-03-08', '00:00:00'),
(9, 1, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1741444396_action.pdf', 'approvedbyugchr', 9, '2025-03-08', '00:00:00'),
(10, 1, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1741444424_action.pdf', 'approvedbyugcidd', 10, '2025-03-08', '00:00:00'),
(12, 1, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1741444515_action.pdf', 'approvedbyugcadmission', 13, '2025-03-08', '00:00:00'),
(13, 1, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1741444544_action.pdf', 'approvedbyugcacademic', 12, '2025-03-08', '00:00:00'),
(25, 3, 'Approved.', NULL, '', 3, '2025-03-09', '00:00:00'),
(26, 3, '', NULL, '', 3, '2025-03-09', '00:00:00'),
(27, 3, 'Approved.', NULL, '', 3, '2025-03-09', '00:00:00'),
(28, 3, 'Approved.', NULL, '', 3, '2025-03-09', '00:00:00'),
(29, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1741461607_action.pdf', 'approvedbydean', 3, '2025-03-09', '00:00:00'),
(30, 3, 'Degree name wrong.', NULL, 'rejectedbyvc', 5, '2025-03-09', '00:00:00'),
(31, 3, 'Rejected. Check Mandate availability file uploads.', NULL, 'rejectedbydean', 3, '2025-03-09', '00:00:00'),
(32, 3, 'Rejected.', NULL, 'rejectedbydean', 3, '2025-03-09', '00:00:00'),
(33, 6, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1741514462_action.pdf', 'approvedbydean', 3, '2025-03-09', '00:00:00'),
(34, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742020550_1738158952_dummy.pdf', 'approvedbydean', 3, '2025-03-15', '00:00:00'),
(35, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742020589_1739894675_action.pdf', 'approvedbyvc', 5, '2025-03-15', '00:00:00'),
(36, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742020645_1739894675_action.pdf', 'approvedbycqa', 6, '2025-03-15', '00:00:00'),
(37, 3, 'Rejected.', NULL, 'rejectedbyqachead', 7, '2025-03-15', '00:00:00'),
(38, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742020774_1739894675_action.pdf', 'approvedbydean', 3, '2025-03-15', '00:00:00'),
(39, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742020808_1739894675_action.pdf', 'approvedbyvc', 5, '2025-03-15', '00:00:00'),
(40, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742020834_1739894675_action.pdf', 'approvedbycqa', 6, '2025-03-15', '00:00:00'),
(41, 3, 'Rejected', NULL, 'rejectedbyqachead', 7, '2025-03-15', '00:00:00'),
(42, 3, 'Approved', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742020911_1739894675_action.pdf', 'approvedbydean', 3, '2025-03-15', '00:00:00'),
(43, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742020944_1739894675_action.pdf', 'approvedbyvc', 5, '2025-03-15', '00:00:00'),
(44, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742020974_1739894675_action.pdf', 'approvedbycqa', 6, '2025-03-15', '00:00:00'),
(45, 3, '', NULL, 'rejectedbyqachead', 7, '2025-03-15', '00:00:00'),
(46, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742021076_1739894675_action.pdf', 'approvedbydean', 3, '2025-03-15', '00:00:00'),
(47, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742021105_1739894675_action.pdf', 'approvedbyvc', 5, '2025-03-15', '00:00:00'),
(48, 3, 'Approved', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742021131_1739894675_action.pdf', 'approvedbycqa', 6, '2025-03-15', '00:00:00'),
(49, 3, 'Rejected', NULL, 'rejectedbyqachead', 7, '2025-03-15', '00:00:00'),
(50, 7, 'Approved', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742028101_1739894675_action.pdf', 'approvedbydean', 3, '2025-03-15', '00:00:00'),
(51, 7, 'Approved', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742028219_1739894675_action.pdf', 'approvedbyvc', 5, '2025-03-15', '00:00:00'),
(52, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742050546_1739894675_action.pdf', 'approvedbydean', 3, '2025-03-15', '00:00:00'),
(53, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742050715_1739894675_action.pdf', 'approvedbydean', 3, '2025-03-15', '00:00:00'),
(54, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742050733_1739894675_action.pdf', 'approvedbydean', 3, '2025-03-15', '00:00:00'),
(55, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742050746_1739894675_action.pdf', 'rejectedbydean', 3, '2025-03-15', '00:00:00'),
(56, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742050984_1739894675_action.pdf', 'approvedbydean', 3, '2025-03-15', '00:00:00'),
(57, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742051008_1739894675_action.pdf', 'approvedbycqa', 6, '2025-03-15', '00:00:00'),
(58, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742051029_1739894675_action.pdf', 'approvedbyvc', 5, '2025-03-15', '00:00:00'),
(59, 6, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742051138_1739894675_action.pdf', 'approvedbycqa', 6, '2025-03-15', '00:00:00'),
(60, 3, '', NULL, 'rejectedbyqachead', 7, '2025-03-15', '00:00:00'),
(61, 3, 'Rejected.', NULL, 'rejectedbyqachead', 7, '2025-03-15', '00:00:00'),
(62, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742051507_1739894675_action.pdf', 'approvedbydean', 3, '2025-03-15', '00:00:00'),
(63, 3, 'REJECTED', NULL, 'rejectedbycqa', 6, '2025-03-15', '00:00:00'),
(64, 3, 'Approved.', NULL, '', 3, '2025-03-15', '00:00:00'),
(65, 3, 'Approved.', NULL, '', 3, '2025-03-15', '00:00:00'),
(66, 3, 'Approved.', NULL, '', 3, '2025-03-15', '00:00:00'),
(67, 3, 'A', NULL, '', 3, '2025-03-15', '00:00:00'),
(68, 3, 'A', NULL, '', 3, '2025-03-15', '00:00:00'),
(69, 3, 'Rejected.', NULL, 'rejectedbydean', 3, '2025-03-15', '00:00:00'),
(70, 3, 'Rejected.', NULL, 'rejectedbydean', 3, '2025-03-15', '00:00:00'),
(71, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742052970_1739894675_action.pdf', 'approvedbydean', 3, '2025-03-15', '00:00:00'),
(72, 3, 'Approved.', NULL, '', 6, '2025-03-15', '00:00:00'),
(73, 3, 'Approved.', NULL, '', 6, '2025-03-15', '00:00:00'),
(74, 3, 'Approved.', NULL, '', 6, '2025-03-15', '00:00:00'),
(75, 3, 'Rejected.', NULL, 'rejectedbycqa', 6, '2025-03-15', '00:00:00'),
(76, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742054852_1739894675_action.pdf', 'approvedbydean', 3, '2025-03-15', '00:00:00'),
(77, 2, 'Approved.', NULL, '', 7, '2025-03-15', '00:00:00'),
(78, 2, 'Rejected.', NULL, 'rejectedbyqachead', 7, '2025-03-15', '00:00:00'),
(79, 3, 'Approved.', NULL, '', 7, '2025-03-15', '00:00:00'),
(80, 3, 'Rejected.', NULL, 'rejectedbyqachead', 7, '2025-03-15', '00:00:00'),
(81, 3, 'Approved.', NULL, '', 7, '2025-03-15', '00:00:00'),
(82, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742055767_1739894675_action.pdf', 'approvedbyqachead', 7, '2025-03-15', '00:00:00'),
(83, 3, 'Rejected.', NULL, 'rejectedbyqachead', 7, '2025-03-15', '00:00:00'),
(84, 3, 'Approved.', NULL, '', 3, '2025-03-15', '00:00:00'),
(85, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742055875_1739894675_action.pdf', 'approvedbydean', 3, '2025-03-15', '00:00:00'),
(86, 6, 'Rejected.', NULL, 'rejectedbyvc', 5, '2025-03-15', '00:00:00'),
(87, 3, 'Approved.', NULL, '', 6, '2025-03-15', '00:00:00'),
(88, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742055963_1739894675_action.pdf', 'approvedbycqa', 6, '2025-03-15', '00:00:00'),
(89, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742055990_1739894675_action.pdf', 'approvedbyvc', 5, '2025-03-15', '00:00:00'),
(90, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742056008_1739894675_action.pdf', 'approvedbyqachead', 7, '2025-03-15', '00:00:00'),
(91, 3, 'Approved.', NULL, '', 8, '2025-03-15', '00:00:00'),
(92, 3, 'Rejected.', NULL, 'rejectedbyugcfinance', 8, '2025-03-15', '00:00:00'),
(93, 13, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742065107_1739894675_action.pdf', 'approvedbydean', 3, '2025-03-16', '00:00:00'),
(94, 13, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742065138_1739894675_action.pdf', 'approvedbycqa', 6, '2025-03-16', '00:00:00'),
(95, 13, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742065177_1739894675_action.pdf', 'approvedbyvc', 5, '2025-03-16', '00:00:00'),
(96, 13, 'Rejected', NULL, 'rejectedbyqachead', 7, '2025-03-16', '00:00:00'),
(97, 16, '', NULL, 'rejectedbydean', 3, '2025-03-16', '00:00:00'),
(98, 16, '', NULL, 'rejectedbydean', 3, '2025-03-16', '00:00:00'),
(99, 16, '', NULL, 'rejectedbydean', 3, '2025-03-16', '00:00:00'),
(100, 16, '', NULL, 'rejectedbydean', 3, '2025-03-16', '00:00:00'),
(101, 7, 'Approved', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742106736_Application_Summary - 2025-03-16T010522.989.pdf', 'approvedbyqachead', 7, '2025-03-16', '00:00:00'),
(102, 3, 'Approved_M', 'http://localhost/qac_ugc/Proposal_sections/uploads/1743622196_Application_Summary - 2025-03-16T115318.196.pdf', 'approvedbydean', 3, '2025-04-03', '00:00:00'),
(103, 3, 'A', NULL, 'rejectedbydean', 3, '2025-05-15', '00:00:00'),
(104, 13, '', NULL, 'rejectedbydean', 3, '2025-05-16', '00:00:00'),
(105, 13, 'Approved.', NULL, '', 3, '2025-05-16', '00:00:00'),
(106, 13, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1747366738_1738158952_dummy.pdf', 'approvedbydean', 3, '2025-05-16', '00:00:00'),
(107, 13, 'aa', NULL, 'rejectedbycqa', 6, '2025-05-16', '00:00:00'),
(108, 6, 'Approved', 'http://localhost/qac_ugc/Proposal_sections/uploads/1749405580_1748196112_1739894675_council.pdf', 'approvedbydean', 3, '2025-06-08', '00:00:00'),
(109, 6, 'Approved', 'http://localhost/qac_ugc/Proposal_sections/uploads/1749405618_1748196031_1739720192_benchmark.pdf', 'approvedbycqa', 6, '2025-06-08', '00:00:00'),
(110, 6, 'Approved', 'http://localhost/qac_ugc/Proposal_sections/uploads/1749405637_1748196031_1739720192_benchmark.pdf', 'approvedbyvc', 5, '2025-06-08', '00:00:00'),
(111, 16, '', NULL, 'rejectedbydean', 3, '2025-06-18', '00:00:00'),
(112, 16, '', NULL, 'rejectedbydean', 3, '2025-06-18', '00:00:00'),
(113, 16, '', NULL, 'rejectedbydean', 3, '2025-06-18', '00:00:00'),
(114, 16, '', NULL, 'rejectedbydean', 3, '2025-06-18', '00:00:00'),
(115, 16, '', NULL, 'rejectedbydean', 3, '2025-06-18', '00:00:00'),
(116, 16, '', NULL, 'rejectedbydean', 3, '2025-06-18', '00:00:00'),
(117, 16, '', NULL, 'rejectedbydean', 3, '2025-06-18', '00:00:00'),
(118, 16, '', NULL, 'approvedbydean', 3, '2025-06-18', '00:00:00'),
(119, 16, '', NULL, 'approvedbycqa', 6, '2025-06-18', '00:00:00'),
(120, 16, '', NULL, 'approvedbycqa', 6, '2025-06-18', '00:00:00'),
(121, 16, 'Approved.A', '', 'approvedbycqa', 6, '2025-06-18', '00:00:00'),
(122, 16, 'Approved.', '', 'approvedbyvc', 5, '2025-06-18', '00:00:00'),
(123, 16, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1750188891_1739894675_action.pdf', 'approvedbyvc', 5, '2025-06-18', '00:00:00'),
(124, 16, 'Rejected.', NULL, 'rejectedbyqachead', 7, '2025-06-18', '00:00:00'),
(125, 16, '', NULL, '', 3, '2025-06-26', '00:00:00'),
(126, 16, '', NULL, '', 3, '2025-06-26', '00:00:00'),
(127, 3, 'Approved.', NULL, '', 3, '2025-06-26', '00:00:00'),
(128, 16, 'Approved.', NULL, 'approvedbydean', 3, '2025-06-27', '00:00:00'),
(129, 16, 'Approved.', NULL, 'approvedbycqa', 6, '2025-06-27', '00:00:00'),
(130, 16, 'REJECTED_TEST_DEAN_REJECT', NULL, 'rejectedbyvc', 5, '2025-06-27', '00:00:00'),
(131, 3, 'Approved.', NULL, 'approvedbydean', 3, '2025-06-27', '00:00:00'),
(132, 3, 'Approved.', NULL, 'approvedbycqa', 6, '2025-06-27', '00:00:00'),
(133, 3, 'Approved.', NULL, 'approvedbyvc', 5, '2025-06-27', '00:00:00'),
(134, 3, 'Approved.', NULL, 'rejectedbyvc', 5, '2025-06-27', '00:00:00'),
(135, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1750964529_1748196031_1739720192_benchmark.pdf', 'approvedbyvc', 5, '2025-06-27', '00:00:00'),
(136, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1750965013_1748196031_1739720192_benchmark.pdf', 'approvedbyvc', 5, '2025-06-27', '00:00:00'),
(137, 3, 'App', 'http://localhost/qac_ugc/Proposal_sections/uploads/1750965150_1748196031_1739720192_benchmark.pdf', 'approvedbyvc', 5, '2025-06-27', '00:00:00'),
(138, 3, 'Approved_New', 'http://localhost/qac_ugc/Proposal_sections/uploads/1750965205_1748196031_1739720192_benchmark.pdf', 'approvedbyqachead', 7, '2025-06-27', '00:00:00'),
(139, 2, 'Approved.', NULL, '', 3, '2025-06-28', '00:00:00'),
(140, 2, 'Approved.', NULL, '', 6, '2025-06-28', '00:00:00'),
(141, 2, 'Recommended.', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751134143.png', 'approvedbydean', 3, '2025-06-28', '00:00:00'),
(147, 2, 'Recommended.', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751135512.png', 'approvedbydean', 3, '2025-06-29', '00:00:00'),
(148, 2, 'A', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751135625.png', 'approvedbydean', 3, '2025-06-29', '00:00:00'),
(149, 2, 'A', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751135658.png', 'approvedbydean', 3, '2025-06-29', '00:00:00'),
(150, 2, 'A_TEST_ALERT.', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751136057.png', 'approvedbydean', 3, '2025-06-29', '00:00:00'),
(151, 2, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751136497.png', 'rejectedbycqa', 6, '2025-06-29', '00:00:00'),
(152, 2, 'REJECT_CHECK_3', NULL, 'rejectedbydean', 3, '2025-06-29', '00:00:00'),
(153, 2, 'A', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751137142.png', 'approvedbydean', 3, '2025-06-29', '00:00:00'),
(154, 2, 'CQA_DIRECTOR', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751137267.png', 'approvedbycqa', 6, '2025-06-29', '00:00:00'),
(155, 2, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751137350.png', 'rejectedbyvc', 5, '2025-06-29', '00:00:00'),
(156, 2, 'DEAN_1_TEST', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751137414.png', 'approvedbydean', 3, '2025-06-29', '00:00:00'),
(157, 2, 'E', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751137477.png', 'approvedbycqa', 6, '2025-06-29', '00:00:00'),
(158, 2, 'VC_TEST_1', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751137502.png', 'approvedbyvc', 5, '2025-06-29', '00:00:00'),
(159, 2, '', NULL, 'rejectedbydean', 3, '2025-06-29', '00:00:00'),
(160, 2, 'AQ', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751140750.png', 'approvedbydean', 3, '2025-06-29', '00:00:00'),
(161, 2, 'CHECK_NAME_DATE_WITH-SIGN', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751141312.png', 'approvedbycqa', 6, '2025-06-29', '00:00:00'),
(162, 2, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751141899.png', 'approvedbyvc', 5, '2025-06-29', '00:00:00'),
(163, 6, '', NULL, 'rejectedbyqachead', 7, '2025-06-30', '00:00:00'),
(165, 3, '', NULL, 'rejectedbycqa', 6, '2025-06-30', '00:00:00'),
(167, 2, 'TEST_REJECT_AFTER_TA', NULL, 'rejectedbydean', 3, '2025-06-30', '00:00:00'),
(168, 3, '', NULL, 'rejectedbyTA', 26, '2025-06-30', '00:00:00'),
(169, 3, '', NULL, 'rejectedbyTA', 26, '2025-06-30', '00:00:00'),
(170, 3, '', NULL, 'rejectedbyTA', 26, '2025-06-30', '00:00:00'),
(171, 3, '', NULL, 'rejectedbyTA', 26, '2025-06-30', '00:00:00'),
(172, 3, '', NULL, 'rejectedbyTA', 26, '2025-06-30', '00:00:00'),
(173, 3, '', NULL, 'rejectedbyTA', 30, '2025-06-30', '00:00:00'),
(174, 19, '', NULL, 'rejectedbydean', 3, '2025-07-06', '00:00:00'),
(175, 19, 'Approved. (A)', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751825474.png', 'approvedbydean', 3, '2025-07-06', '00:00:00'),
(176, 19, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751825508.png', 'approvedbycqa', 6, '2025-07-06', '00:00:00'),
(177, 19, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751825581.png', 'approvedbyvc', 5, '2025-07-06', '00:00:00'),
(178, 19, 'REJECTED_TYPE_CHECK', NULL, 'rejectedbyTA', 26, '2025-07-06', '00:00:00'),
(179, 19, 'A2', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751825928.png', 'approvedbydean', 3, '2025-07-06', '00:00:00'),
(180, 19, 'A2', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751825952.png', 'approvedbycqa', 6, '2025-07-06', '00:00:00'),
(181, 19, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751825973.png', 'approvedbyvc', 5, '2025-07-06', '00:00:00'),
(182, 19, '', NULL, 'rejectedbyTA', 26, '2025-07-06', '00:00:00'),
(183, 19, '', NULL, 'rejectedbyqachead', 7, '2025-07-07', '00:00:00'),
(184, 19, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751826818.png', 'approvedbydean', 3, '2025-07-07', '00:00:00'),
(185, 19, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751826871.png', 'approvedbycqa', 6, '2025-07-07', '00:00:00'),
(186, 19, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751826886.png', 'approvedbyvc', 5, '2025-07-07', '00:00:00'),
(187, 19, '', NULL, 'rejectedbyTA', 26, '2025-07-07', '00:00:00'),
(188, 19, 'Ap', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751827893.png', 'approvedbyqachead', 7, '2025-07-07', '00:00:00'),
(189, 13, '', NULL, 'rejectedbydean', 3, '2025-07-07', '00:00:00'),
(190, 2, 'A', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751909597.png', 'approvedbyTA', 30, '2025-07-07', '00:00:00'),
(191, 2, 'APPROVED_BY_TA2', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751909949.png', 'approvedbyTA', 30, '2025-07-07', '00:00:00'),
(192, 2, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751910283.png', 'approvedbysecretary', 28, '2025-07-07', '00:00:00'),
(193, 2, 'Approved.', NULL, '', 7, '2025-07-08', '00:00:00'),
(194, 2, 'Approved.', NULL, '', 7, '2025-07-08', '00:00:00'),
(195, 2, 'A', NULL, '', 7, '2025-07-08', '00:00:00'),
(196, 2, 'A', NULL, '', 7, '2025-07-08', '00:00:00'),
(197, 2, 'A', NULL, '', 7, '2025-07-08', '00:00:00'),
(198, 2, 'R', NULL, '', 7, '2025-07-08', '00:00:00'),
(199, 2, 'A', NULL, '', 7, '2025-07-08', '00:00:00'),
(200, 2, 'A', NULL, '', 7, '2025-07-08', '00:00:00'),
(201, 2, 'R', NULL, '', 7, '2025-07-08', '00:00:00'),
(202, 2, 'R', NULL, '', 7, '2025-07-08', '00:00:00'),
(203, 2, 'R', NULL, '', 7, '2025-07-08', '00:00:00'),
(204, 2, 'R', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751915830.png', '', 7, '2025-07-08', '00:00:00'),
(205, 2, 'R', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751915951.png', '', 7, '2025-07-08', '00:00:00'),
(206, 2, 'RE_1', NULL, 'rejectedbyqachead', 7, '2025-07-08', '00:00:00'),
(207, 2, 'Ap', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751916603.png', 'approvedbyqachead', 7, '2025-07-08', '00:00:00'),
(208, 2, 'RE_2', NULL, 'rejectedbyqachead', 7, '2025-07-08', '00:00:00'),
(209, 2, 'RE_TEST', NULL, 'rejectedbyqachead', 7, '2025-07-08', '00:00:00'),
(210, 49, '', NULL, 'rejectedbydean', 3, '2025-07-08', '00:00:00'),
(211, 49, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751918261.png', 'approvedbydean', 3, '2025-07-08', '00:00:00'),
(212, 49, 'A', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751918289.png', 'approvedbycqa', 6, '2025-07-08', '00:00:00'),
(213, 49, 'A', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751918307.png', 'approvedbyvc', 5, '2025-07-08', '00:00:00'),
(214, 49, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751918383.png', 'approvedbyTA', 26, '2025-07-08', '00:00:00'),
(215, 49, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751918414.png', 'approvedbysecretary', 28, '2025-07-08', '00:00:00'),
(216, 49, 'Panel_of teachers duplicate....\r\n\r\nProgram_structure module_status missing.', NULL, 'rejectedbyqachead', 7, '2025-07-08', '00:00:00'),
(217, 49, '2A', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751920178.png', 'approvedbydean', 3, '2025-07-08', '00:00:00'),
(218, 49, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751920232.png', 'approvedbycqa', 6, '2025-07-08', '00:00:00'),
(219, 49, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751920244.png', 'approvedbyvc', 5, '2025-07-08', '00:00:00'),
(220, 49, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751920262.png', 'approvedbyTA', 26, '2025-07-08', '00:00:00'),
(221, 49, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751920281.png', 'approvedbysecretary', 28, '2025-07-08', '00:00:00'),
(222, 49, '', NULL, 'rejectedbyqachead', 7, '2025-07-08', '00:00:00'),
(223, 49, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751920524.png', 'approvedbydean', 3, '2025-07-08', '00:00:00'),
(224, 49, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751920537.png', 'approvedbycqa', 6, '2025-07-08', '00:00:00'),
(225, 49, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751920550.png', 'approvedbyvc', 5, '2025-07-08', '00:00:00'),
(226, 49, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751920562.png', 'approvedbyTA', 26, '2025-07-08', '00:00:00'),
(227, 49, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751920579.png', 'approvedbysecretary', 28, '2025-07-08', '00:00:00'),
(228, 49, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751920652.png', 'approvedbyqachead_revised', 7, '2025-07-08', '00:00:00'),
(229, 13, '', NULL, 'rejectedbydean', 3, '2025-07-08', '00:00:00'),
(230, 13, '', NULL, 'rejectedbydean', 3, '2025-07-09', '00:00:00'),
(231, 13, '', NULL, 'rejectedbydean', 3, '2025-07-09', '00:00:00'),
(232, 13, '', NULL, 'rejectedbydean', 3, '2025-07-09', '00:00:00'),
(233, 13, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1752011740.png', 'approvedbydean', 3, '2025-07-09', '00:00:00'),
(234, 13, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1752011768.png', 'approvedbycqa', 6, '2025-07-09', '00:00:00'),
(235, 13, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1752013115.png', 'approvedbyTA', 26, '2025-07-09', '00:00:00'),
(236, 13, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1752013137.png', 'approvedbysecretary', 28, '2025-07-09', '00:00:00'),
(237, 13, '', NULL, 'approvedbyqachead', 7, '2025-07-09', '00:00:00'),
(238, 13, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1752085723.png', 'resignature_request_from_university', 7, '2025-07-09', '00:00:00'),
(239, 13, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1752085855.png', 'approvedbydean', 3, '2025-07-10', '00:00:00'),
(240, 13, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1752085877.png', 'approvedbycqa', 6, '2025-07-10', '00:00:00'),
(241, 13, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1752089562.png', 'resignature_request_from_university', 7, '2025-07-10', '00:00:00'),
(242, 13, 'Signed.', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1752089591.png', 're-signed_dean', 3, '2025-07-10', '00:00:00'),
(243, 13, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1752089853.png', 're-signed_cqa', 6, '2025-07-10', '00:00:00'),
(244, 13, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1752089961.png', 're-signed_cqa', 6, '2025-07-10', '00:00:00'),
(245, 13, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1752090390.png', 're-signed_vc', 5, '2025-07-10', '00:00:00'),
(246, 49, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1752091908.png', 'approvedbyugcfinance', 8, '2025-07-10', '00:00:00'),
(247, 53, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1752096344.png', 'approvedbydean', 3, '2025-07-10', '00:00:00'),
(248, 53, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1752096370.png', 'approvedbycqa', 6, '2025-07-10', '00:00:00'),
(249, 53, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1752096380.png', 'approvedbyvc', 5, '2025-07-10', '00:00:00'),
(250, 53, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1752096393.png', 'approvedbyTA', 26, '2025-07-10', '00:00:00'),
(251, 53, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1752096410.png', 'approvedbysecretary', 28, '2025-07-10', '00:00:00'),
(252, 53, '', NULL, 'rejectedbyqachead', 7, '2025-07-10', '00:00:00'),
(253, 53, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1752096514.png', 'approvedbydean', 3, '2025-07-10', '00:00:00'),
(254, 53, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1752096532.png', 'approvedbycqa', 6, '2025-07-10', '00:00:00'),
(255, 53, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1752097155.png', 'approvedbyTA', 26, '2025-07-10', '00:00:00'),
(256, 53, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1752097183.png', 'approvedbysecretary', 28, '2025-07-10', '00:00:00'),
(257, 53, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1752097204.png', 'approvedbyqachead_revised', 7, '2025-07-10', '00:00:00'),
(258, 53, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1752097283.png', 'resignature_request_from_university', 7, '2025-07-10', '00:00:00'),
(259, 53, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1752097301.png', 're-signed_dean', 3, '2025-07-10', '00:00:00'),
(260, 53, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1752097336.png', 're-signed_cqa', 6, '2025-07-10', '00:00:00'),
(261, 53, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1752097347.png', 're-signed_vc', 5, '2025-07-10', '00:00:00'),
(262, 13, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1752170212.png', 'approvedbyugcfinance', 8, '2025-07-10', '00:00:00'),
(263, 13, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1752179119.png', 'approvedbyugchr', 9, '2025-07-11', '00:00:00'),
(264, 13, 'Approved', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1752180717.png', '', 10, '2025-07-11', '00:00:00'),
(265, 19, 'APPROVED-TEST', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_8_1752183921.png', 'approvedbyugcfinance', 8, '2025-07-11', '00:00:00'),
(266, 19, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_9_1752183970.png', 'approvedbyugchr', 9, '2025-07-11', '00:00:00'),
(267, 19, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_10_1752183995.png', 'approvedbyugcidd', 10, '2025-07-11', '00:00:00'),
(268, 19, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_13_1752184013.png', 'approvedbyugcadmission', 13, '2025-07-11', '00:00:00'),
(269, 19, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_12_1752184026.png', 'approvedbyugcacademic', 12, '2025-07-11', '00:00:00'),
(270, 2, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_3_1752184824.png', 'approvedbydean', 3, '2025-07-11', '00:00:00'),
(271, 2, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_6_1752184895.png', 'approvedbycqa', 6, '2025-07-11', '00:00:00'),
(272, 2, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_26_1752188165.png', 'approvedbyTA', 26, '2025-07-11', '00:00:00'),
(273, 2, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_28_1752188233.png', 'approvedbysecretary', 28, '2025-07-11', '00:00:00'),
(274, 2, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_7_1752188259.png', 'approvedbyqachead_revised', 7, '2025-07-11', '00:00:00'),
(275, 2, 'A', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_12_1752188988.png', 'approvedbyqachead_revised', 12, '2025-07-11', '00:00:00'),
(276, 2, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_12_1752189555.png', 'approvedbyugcacademic', 12, '2025-07-11', '00:00:00'),
(277, 2, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_8_1752189668.png', 'approvedbyugcfinance', 8, '2025-07-11', '00:00:00'),
(278, 2, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_9_1752189679.png', 'approvedbyugchr', 9, '2025-07-11', '00:00:00'),
(279, 2, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_10_1752189703.png', 'approvedbyugcidd', 10, '2025-07-11', '00:00:00'),
(280, 2, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_13_1752189718.png', 'approvedbyugcadmission', 13, '2025-07-11', '00:00:00'),
(281, 53, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_8_1752189932.png', 'approvedbyugcfinance', 8, '2025-07-11', '00:00:00'),
(282, 53, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_9_1752189979.png', 'approvedbyugchr', 9, '2025-07-11', '00:00:00'),
(283, 53, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_10_1752190083.png', 'approvedbyugcidd', 10, '2025-07-11', '00:00:00'),
(284, 53, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_12_1752190100.png', 'approvedbyugcacademic', 12, '2025-07-11', '00:00:00'),
(285, 53, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_13_1752190126.png', 'approvedbyugcadmission', 13, '2025-07-11', '00:00:00'),
(286, 7, 'AP', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_3_1752269514.png', 'approvedbydean', 3, '2025-07-12', '00:00:00'),
(287, 7, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_6_1752269545.png', 'approvedbycqa', 6, '2025-07-12', '00:00:00'),
(288, 7, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_5_1752269556.png', 'approvedbyvc', 5, '2025-07-12', '00:00:00'),
(289, 7, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_26_1752269570.png', 'approvedbyTA', 26, '2025-07-12', '00:00:00'),
(290, 7, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_28_1752269601.png', 'approvedbysecretary', 28, '2025-07-12', '00:00:00'),
(291, 7, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_7_1752269640.png', 'approvedbyqachead', 7, '2025-07-12', '00:00:00'),
(292, 7, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_8_1752269670.png', 'approvedbyugcfinance', 8, '2025-07-12', '00:00:00'),
(293, 7, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_9_1752269730.png', 'approvedbyugchr', 9, '2025-07-12', '00:00:00'),
(294, 7, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_10_1752269744.png', 'approvedbyugcidd', 10, '2025-07-12', '00:00:00'),
(295, 7, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_12_1752269754.png', 'approvedbyugcacademic', 12, '2025-07-12', '00:00:00'),
(296, 7, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_13_1752269771.png', 'approvedbyugcadmission', 13, '2025-07-12', '00:00:00'),
(297, 16, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_3_1752270547.png', 'approvedbydean', 3, '2025-07-12', '00:00:00'),
(298, 16, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_6_1752270568.png', 'approvedbycqa', 6, '2025-07-12', '00:00:00'),
(299, 16, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_26_1752270614.png', 'approvedbyTA', 26, '2025-07-12', '00:00:00'),
(300, 16, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_28_1752270829.png', 'approvedbysecretary', 28, '2025-07-12', '00:00:00'),
(301, 16, 'APPROVED_REVISED', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_7_1752270873.png', 'approvedbyqachead_revised', 7, '2025-07-12', '00:00:00'),
(302, 16, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_8_1752270897.png', 'approvedbyugcfinance', 8, '2025-07-12', '00:00:00'),
(303, 16, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_9_1752270916.png', 'approvedbyugchr', 9, '2025-07-12', '00:00:00'),
(304, 16, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_10_1752270927.png', 'approvedbyugcidd', 10, '2025-07-12', '00:00:00'),
(305, 16, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_13_1752270937.png', 'approvedbyugcadmission', 13, '2025-07-12', '00:00:00'),
(306, 16, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_12_1752270954.png', 'approvedbyugcacademic', 12, '2025-07-12', '00:00:00'),
(307, 6, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_3_1752271121.png', 'approvedbydean', 3, '2025-07-12', '00:00:00'),
(308, 6, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_6_1752271136.png', 'approvedbycqa', 6, '2025-07-12', '00:00:00'),
(309, 6, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_30_1752271156.png', 'approvedbyTA', 30, '2025-07-12', '00:00:00'),
(310, 6, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_28_1752271170.png', 'approvedbysecretary', 28, '2025-07-12', '00:00:00'),
(311, 6, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_7_1752271622.png', 'approvedbyqachead_revised', 7, '2025-07-12', '00:00:00'),
(312, 6, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_8_1752271641.png', 'approvedbyugcfinance', 8, '2025-07-12', '00:00:00'),
(313, 6, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_9_1752271655.png', 'approvedbyugchr', 9, '2025-07-12', '00:00:00'),
(314, 6, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_12_1752271667.png', 'approvedbyugcacademic', 12, '2025-07-12', '00:00:00'),
(315, 6, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_10_1752271685.png', 'approvedbyugcidd', 10, '2025-07-12', '00:00:00'),
(316, 6, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_13_1752271699.png', 'approvedbyugcadmission', 13, '2025-07-12', '00:00:00'),
(317, 7, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_3_1752272100.png', 're-signed_dean', 3, '2025-07-12', '00:00:00'),
(318, 7, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_6_1752272120.png', 're-signed_cqa', 6, '2025-07-12', '00:00:00'),
(319, 7, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_5_1752272130.png', 're-signed_vc', 5, '2025-07-12', '00:00:00'),
(320, 13, 'RE-SIGNED', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_3_1752276106.png', 'approvedbyugcfinance', 8, '2025-07-12', '00:00:00'),
(321, 69, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_3_1752327004.png', 'approvedbydean', 3, '2025-07-12', '02:05:00'),
(322, 13, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_6_1752344522.png', 're-signed_cqa', 6, '2025-07-12', '00:00:00'),
(323, 13, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_5_1752344536.png', 're-signed_vc', 5, '2025-07-12', '00:00:00'),
(324, 69, 'Approved', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_6_1752344619.png', 'approvedbycqa', 6, '2025-07-12', '02:06:00'),
(325, 69, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_5_1752344633.png', 'approvedbyvc', 5, '2025-07-12', '02:07:00'),
(326, 69, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_30_1752350681.png', 'approvedbyTA', 30, '2025-07-13', '02:08:00'),
(327, 69, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_28_1752353456.png', 'approvedbysecretary', 28, '2025-07-13', '02:10:00'),
(328, 69, 'REVISION', NULL, 'rejectedbyqachead', 7, '2025-07-13', '02:11:00'),
(329, 69, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_3_1752353514.png', 'approvedbydean', 3, '2025-07-13', '02:12:00'),
(330, 69, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_6_1752353526.png', 'approvedbycqa', 6, '2025-07-13', '02:13:00'),
(331, 69, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_26_1752353546.png', 'approvedbyTA', 26, '2025-07-13', '02:14:00'),
(332, 69, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_28_1752353570.png', 'approvedbysecretary', 28, '2025-07-13', '02:15:00'),
(333, 69, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_7_1752353601.png', 'resignature_request_from_university', 7, '2025-07-13', '02:16:00'),
(334, 69, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_3_1752353619.png', 're-signed_dean', 3, '2025-07-13', '02:17:00'),
(335, 69, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_6_1752353629.png', 're-signed_cqa', 6, '2025-07-13', '02:18:00'),
(336, 69, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_5_1752353642.png', 're-signed_vc', 5, '2025-07-13', '02:19:00'),
(337, 69, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_8_1752353873.png', 'approvedbyugcfinance', 8, '2025-07-13', '02:20:00'),
(338, 69, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_9_1752353895.png', 'approvedbyugchr', 9, '2025-07-13', '02:21:00'),
(339, 69, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_10_1752353908.png', 'approvedbyugcidd', 10, '2025-07-13', '02:22:00'),
(340, 69, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_13_1752353934.png', 'approvedbyugcadmission', 13, '2025-07-13', '02:23:00'),
(341, 69, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_12_1752353947.png', 'approvedbyugcacademic', 12, '2025-07-13', '02:24:00'),
(343, 2, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_29_1752358412.png', 'approvedbyStandardCommittee', 29, '2025-07-13', '00:00:00'),
(344, 6, '', NULL, 'rejectedbyStandardCommittee', 29, '2025-07-13', '00:00:00'),
(345, 13, '', NULL, 'rejectedbyugcidd', 10, '2025-07-13', '00:00:00'),
(346, 6, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_3_1752425934.png', 'approvedbydean', 3, '2025-07-13', '00:00:00'),
(347, 3, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_3_1752426026.png', 'approvedbydean', 3, '2025-07-13', '00:00:00'),
(348, 3, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_6_1752430672.png', 'approvedbycqa', 6, '2025-07-13', '00:00:00'),
(349, 3, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_5_1752430689.png', 'approvedbyvc', 5, '2025-07-13', '00:00:00'),
(350, 3, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_26_1752435072.png', 'approvedbyTA', 26, '2025-07-14', '00:00:00'),
(351, 14, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_3_1752846640.png', 'approvedbydean', 3, '2025-07-18', '00:00:00'),
(352, 14, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_6_1752846661.png', 'approvedbycqa', 6, '2025-07-18', '00:00:00'),
(353, 14, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_5_1752846675.png', 'approvedbyvc', 5, '2025-07-18', '00:00:00'),
(354, 14, 'Approved with non-compliance fields to review secretary.', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_26_1752846881.png', 'approvedbyTA', 26, '2025-07-18', '00:00:00'),
(355, 14, '', '/qac_ugc/Proposal_sections/uploads/signature_26_1752847485.png', 'approvedbyTA', 26, '2025-07-18', '00:00:00'),
(356, 14, 'Non compliance field -1', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_26_1752847706.png', 'approvedbyTA', 26, '2025-07-18', '00:00:00'),
(357, 14, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_26_1752847953.png', 'approvedbyTA', 26, '2025-07-18', '00:00:00'),
(358, 14, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_26_1752848017.png', 'approvedbyTA', 26, '2025-07-18', '00:00:00'),
(359, 14, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_26_1752848206.png', 'approvedbyTA', 26, '2025-07-18', '00:00:00'),
(360, 14, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_26_1752848656.png', 'approvedbyTA', 26, '2025-07-18', '00:00:00'),
(361, 14, 'TEST_DB_DATA', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_26_1752849049.png', 'approvedbyTA', 26, '2025-07-18', '00:00:00'),
(362, 14, 'TEST_DB_DATA', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_26_1752849302.png', 'approvedbyTA', 26, '2025-07-18', '00:00:00'),
(363, 14, 'TEST_DB_DATA', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_26_1752849375.png', 'approvedbyTA', 26, '2025-07-18', '00:00:00'),
(364, 14, 'TEST_DB_DATA', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_26_1752849716.png', 'approvedbyTA', 26, '2025-07-18', '00:00:00'),
(365, 14, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_26_1752850617.png', 'approvedbyTA', 26, '2025-07-18', '00:00:00'),
(366, 14, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_26_1752851260.png', 'approvedbyTA', 26, '2025-07-18', '00:00:00'),
(367, 14, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_30_1752906818.png', 'approvedbyTA', 30, '2025-07-19', '00:00:00'),
(368, 14, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_28_1752906890.png', 'approvedbysecretary', 28, '2025-07-19', '00:00:00'),
(369, 14, '', NULL, 'rejectedbyqachead', 7, '2025-07-19', '00:00:00'),
(370, 14, 'APPROVED', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_3_1753214613.png', 'approvedbydean', 3, '2025-07-23', '00:00:00'),
(371, 14, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_6_1753214650.png', 'approvedbycqa', 6, '2025-07-23', '00:00:00'),
(372, 14, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_26_1753218478.png', 'approvedbyTA', 26, '2025-07-23', '00:00:00'),
(373, 14, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_28_1753218575.png', 'approvedbysecretary', 28, '2025-07-23', '00:00:00'),
(374, 14, 'APPROVED REVISED VERSION', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_7_1753218610.png', 'resignature_request_from_university', 7, '2025-07-23', '00:00:00'),
(375, 14, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_3_1753219078.png', 're-signed_dean', 3, '2025-07-23', '00:00:00'),
(376, 14, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_6_1753219101.png', 're-signed_cqa', 6, '2025-07-23', '00:00:00'),
(377, 14, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_5_1753220513.png', 're-signed_vc', 5, '2025-07-23', '00:00:00'),
(378, 14, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_8_1753220587.png', 'approvedbyugcfinance', 8, '2025-07-23', '00:00:00'),
(379, 14, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_9_1753220604.png', 'approvedbyugchr', 9, '2025-07-23', '00:00:00'),
(380, 14, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_10_1753220617.png', 'approvedbyugcidd', 10, '2025-07-23', '00:00:00'),
(381, 14, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_12_1753220655.png', 'approvedbyugcacademic', 12, '2025-07-23', '00:00:00'),
(382, 14, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_13_1753220724.png', 'approvedbyugcadmission', 13, '2025-07-23', '00:00:00'),
(383, 14, 'REVISIONS', NULL, 'rejectedbyStandardCommittee', 29, '2025-07-23', '00:00:00'),
(384, 14, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_3_1753470967.png', 'approvedbydean', 3, '2025-07-26', '00:00:00'),
(385, 14, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_6_1753470984.png', 'approvedbycqa', 6, '2025-07-26', '00:00:00'),
(386, 14, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_30_1753471029.png', 'approvedbyTA', 30, '2025-07-26', '00:00:00');

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
(14, 'Yes', 'Yes', 'Bachelors Degree (SLQF 5)', 'Yes', '', 'Yes', 'Yes', 10, '', '/qac_ugc/Proposal_sections/uploads/1747393878_1739894675_senate.pdf', '', ''),
(23, 'Yes', 'Yes', 'Higher Diploma (SLQF 4)', 'Yes', '', 'Yes', 'Yes', 11, '/qac_ugc/Proposal_sections/uploads/1748189046_1739894675_cooperate.pdf', '', '', ''),
(19, 'Yes', 'Yes', 'Higher Diploma (SLQF 4)', 'Yes', 'FV', 'Yes', 'Yes', 12, '', '', '', ''),
(49, 'Yes', 'Yes', 'Higher Diploma (SLQF 4)', 'No', '', 'Yes', 'Yes', 13, '/qac_ugc/Proposal_sections/uploads/1751917767_1748196112_1739894675_council.pdf', '/qac_ugc/Proposal_sections/uploads/1751917767_1748196112_1739894675_council.pdf', '', ''),
(53, 'Yes', 'Yes', 'Higher Diploma (SLQF 4)', 'Yes', '', 'Yes', 'Yes', 14, '/qac_ugc/Proposal_sections/uploads/1752092541_1742064039_1739720192_benchmark.pdf', '', '', ''),
(69, 'Yes', 'Yes', 'Higher Diploma (SLQF 4)', 'Yes', '', 'Yes', 'Yes', 15, '', '', '', '');

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
('sad', 'asda', 'sdasd', 'sad', 'sad', 'asd', 'asd', 'asdsa', 'sad', ' asd  ', 'UGC Z score based selection', '', 50, 'Bachelor Honours Degree', '4', 5, 5, 120, 'English', 6, 13, '/qac_ugc/Proposal_sections/uploads/1742064065_1739720192_benchmark.pdf', 'Level 6 (Bachelors Honours - 4 year programme)', 'g', '', '', 'No'),
('ewd', 'ewf', 'wef', 'efw', 'wef', 'wef', 'ewf', 'ewf', 'ewf', ' wef', 'UGC Z score based selection', '', 50, 'Bachelor Honours Degree', '4', 5, 5, 120, 'English', 8, 18, '/qac_ugc/Proposal_sections/uploads/1742067193_1739720192_benchmark.pdf', 'Level 6 (Bachelors Honours - 4 year programme)', '', '', '', ''),
('A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', ' A', 'UGC Z score based selection', '', 50, 'Bachelor Degree', '3', 5, 5, 90, 'English', 9, 16, '/qac_ugc/Proposal_sections/uploads/1742106018_Application_Summary - 2025-03-16T002508.601.pdf', 'Level 6 (Bachelors Honours - 4 year programme)', 'A', '/qac_ugc/Proposal_sections/uploads/1747393878_1739894675_senate.pdf', '/qac_ugc/Proposal_sections/uploads/1747393878_1739894675_senate.pdf', 'Yes'),
('A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', ' A    ', 'UGC Z score based selection', '', 50, 'Bachelor Honours Degree', '4', 5, 5, 0, 'Sinhala', 10, 14, NULL, 'Level 6 (Bachelors Honours - 4 year programme)', 'SE', '', '', 'No'),
('SS', 'S', 'S', 'S', 'S', 's', 'ss', 'sss', 's', ' s                ', 'UGC Z score based selection', '', 50, 'Bachelor Honours Degree', '4', 5, 5, 120, 'Sinhala', 11, 23, '/qac_ugc/Proposal_sections/uploads/1747393878_1739718375_fallback.pdf', 'Level 6 (Bachelors Honours - 4 year programme)', 'EEEEE', '/qac_ugc/Proposal_sections/uploads/1747393878_1739894675_senate.pdf', '/qac_ugc/Proposal_sections/uploads/1747393878_1739894675_council.pdf', 'No'),
('wsws', 'ws', 'ws', 'ws', 'sw', 'ws', 'ws', 'ws', 'EDED', ' EDEDED ', '', 'EDED', 50, 'Bachelor Honours Degree', '4', 5, 5, 120, 'Sinhala', 13, 19, NULL, 'Level 6 (Bachelors Honours - 4 year programme)', 'DEDEDEDE', '', '', 'Yes'),
('A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', ' A ', 'UGC Z score based selection', '', 50, 'Bachelor Honours Degree', '4', 5, 5, 120, 'English', 14, 49, '/qac_ugc/Proposal_sections/uploads/1751917509_1748196112_1739894675_council.pdf', 'Level 6 (Bachelors Honours - 4 year programme)', 'W', '/qac_ugc/Proposal_sections/uploads/1751917509_1749405580_1748196112_1739894675_council.pdf', '/qac_ugc/Proposal_sections/uploads/1751917509_1742064039_1739720192_benchmark.pdf', 'Yes'),
('dassd', 'eded', 'edw', 'dew', 'dew', 'dwed', 'wed', 'wed', 'wefwe', ' fewf ', 'UGC Z score based selection', '', 50, 'Bachelor Honours Degree', '4', 5, 5, 120, 'English', 15, 53, '/qac_ugc/Proposal_sections/uploads/1752092370_1748196112_1739894675_council.pdf', 'Level 6 (Bachelors Honours - 4 year programme)', 'ewdfwef', '/qac_ugc/Proposal_sections/uploads/1752092370_1749405618_1748196031_1739720192_benchmark.pdf', '/qac_ugc/Proposal_sections/uploads/1752092370_1749405580_1748196112_1739894675_council.pdf', 'Yes'),
('A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', ' A', 'UGC Z score based selection', '', 50, 'Bachelor Honours Degree', '4', 5, 5, 120, 'English', 16, 69, '/qac_ugc/Proposal_sections/uploads/1752323094_1748196112_1739894675_council.pdf', 'Level 6 (Bachelors Honours - 4 year programme)', 'A', '/qac_ugc/Proposal_sections/uploads/1752323094_1749405618_1748196031_1739720192_benchmark.pdf', '/qac_ugc/Proposal_sections/uploads/1752323094_1748196112_1739894675_council.pdf', 'Yes');

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
(20, 'Recurrent Expenditure', 'A', 'A', 'A', 'A', 14, 10),
(21, 'Capital Expenditure', 'FV', 'VFD', 'VFD', 'VFD', 19, 11),
(22, 'Recurrent Expenditure', 'FDV', 'FDVFD', 'VDF', 'VFD', 19, 11),
(23, 'Capital Expenditure', 'a', 'a', 'aa', '', 49, 12),
(24, 'Recurrent Expenditure', 'a', 'a', 'aa', 'a', 49, 12),
(25, 'Capital Expenditure', 'sdc', 'dscd', 'scsdc', 'c', 53, 13),
(26, 'Recurrent Expenditure', 'cdsc', 'sdc', 'sdcsd', 'csd', 53, 13),
(27, 'Capital Expenditure', 'A', 'A', 'A', 'A', 69, 14),
(28, 'Recurrent Expenditure', 'A', 'A', 'A', 'A', 69, 14),
(29, 'Capital Expenditure', 'A', 'A', 'A', 'A', 23, 15),
(30, 'Recurrent Expenditure', 'A', 'A', 'A', 'A', 23, 15);

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
  `qualification_name_english` varchar(1000) NOT NULL,
  `qualification_name_sinhala` varchar(1000) NOT NULL,
  `qualification_name_tamil` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `proposal_general_info`
--

INSERT INTO `proposal_general_info` (`proposal_id`, `degree_name_english`, `degree_name_sinhala`, `degree_name_tamil`, `abbreviated_qualification`, `general_info_id`, `qualification_name_english`, `qualification_name_sinhala`, `qualification_name_tamil`) VALUES
(1, 'B', 'A', 'A', 'BSc', 1, '', '', ''),
(2, 'xssx', 'sxas', 'xsax', 'sax', 2, '', '', ''),
(3, 'Bsc (Hons) Software Engineering', 'Bsc (Hons) Software Engineering', 'Bsc (Hons) Software Engineering', 'BSc', 3, '', '', ''),
(6, 'fre', 'erferf', 'erfer', 'ff', 4, 'dcs', 'dsc', 'sdc'),
(7, 'rtg', 'trgrt', 'gtrg', 'trg', 5, '', '', ''),
(13, 'Bsc (Hons) Software Engineering', 'මෘදුකාංග ඉංජිනේරු විද්‍යාව පිළිබඳ විද්‍යාවේදී ගෞරව උපාධිය', 'பிஎஸ்சி ஹானர்ஸ் மென்பொருள் பொறியியல்', 'BSc', 6, 'Bsc (Hons) Software Engineering', 'මෘදුකාංග ඉංජිනේරු විද්‍යාව පිළිබඳ විද්‍යාවේදී ගෞරව උපාධිය', 'பிஎஸ்சி ஹானர்ஸ் மென்பொருள் பொறியியல்'),
(14, 'Bsc (Hons) Computer Science', 'පරිගණක විද්‍යාව පිළිබඳ විද්‍යාවේදී ගෞරව උපාධිය', 'பிஎஸ்சி ஹானர்ஸ் கணினி அறிவியல்', 'BSc', 7, 'S', 'S', 'S'),
(16, 'Bsc (Hons) Computer Science', 'පරිගණක විද්‍යාව පිළිබඳ විද්‍යාවේදී ගෞරව උපාධිය', 'பிஎஸ்சி ஹானர்ஸ் கணினி அறிவியல்', 'BSc', 8, 'A', 'A', 'A'),
(18, 'Bsc (Hons) Computer Science', 'පරිගණක විද්‍යාව පිළිබඳ විද්‍යාවේදී ගෞරව උපාධිය', 'பிஎஸ்சி ஹானர்ஸ் கணினி அறிவியல்', 'BSc', 10, '', '', ''),
(19, 'Bsc (Hons) Computer Science', 'පරිගණක විද්‍යාව පිළිබඳ විද්‍යාවේදී ගෞරව උපාධිය', 'பிஎஸ்சி ஹானர்ஸ் கணினி அறிவியல்', 'BSc', 11, 'A', 'B', 'C'),
(23, 'a', 'a', 'a', 'a', 12, 'a', 'a', 'aav'),
(49, 'Bsc (Hons) Computer Sciencee', 'පරිගණක විද්‍යාව පිළිබඳ විද්‍යාවේදී ගෞරව උපාධිය', 'பிஎஸ்சி ஹானர்ஸ் கணினி அறிவியல்', 'BSc', 13, 'A', 'B', 'C'),
(53, 'Bsc (Hons) Computer Science', 'පරිගණක විද්‍යාව පිළිබඳ විද්‍යාවේදී ගෞරව උපාධිය', 'பிஎஸ்சி ஹானர்ஸ் கணினி அறிவியல்', 'BSc', 14, 'Bsc (Hons) Computer Science', 'පරිගණක විද්‍යාව පිළිබඳ විද්‍යාවේදී ගෞරව උපාධිය', 'பிஎஸ்சி ஹானர்ஸ் கணினி அறிவியல்'),
(69, 'A', 'A', 'A', 'BSc', 15, 'A', 'A', 'A'),
(72, 'A', 'A', 'A', 'A', 16, 'A', 'A', 'A'),
(75, 'A', 'A', 'A', 'A', 17, 'A', 'A', 'A');

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
(8, 64, 'ewf', 'ewf', 'ewf', 18),
(13, 129, 's', 's', 's', 19),
(13, 130, '2', '2', '2', 19),
(14, 152, 'A', 'A', 'A', 49),
(14, 153, 'B', 'B', 'B', 49),
(9, 160, 'A', 'A', 'A', 16),
(6, 188, 'd', 'sad', 'sad', 13),
(15, 197, 'A', 'A', 'A', 53),
(15, 198, 'B', 'B', 'B', 53),
(2, 200, 'sax', 'sxa', 'sxa', 2),
(16, 207, 'A', 'A', 'A', 69),
(16, 208, 'A', 'A', 'A', 69),
(5, 209, 'ew', 'ewe', 'wefew', 6),
(3, 214, 'exw', 'xw', 'xw', 3),
(11, 215, 's', 's', 's', 23),
(10, 220, 'ABC', '2025', 'A', 14);

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
(14, 50, 'Minor Staff', 'A', 'A', 'A', 'A', 10),
(19, 51, 'Lecturers', 'FDV', 'VF', 'VFV', 'F', 11),
(19, 52, 'Instructors/Demonstrators', 'FDV', 'FV', 'FVFV', 'FV', 11),
(19, 53, 'Technical Grades', 'FDV', 'FV', 'F', 'FV', 11),
(19, 54, 'Management Assistants', 'FDV', 'VFDV', 'FV', 'VFV', 11),
(19, 55, 'Minor Staff', 'VFD', 'V', 'FV', 'FVF', 11),
(49, 56, 'Lecturers', 'a', 'a', 'a', 'a', 12),
(49, 57, 'Instructors/Demonstrators', 'a', 'a', 'aa', 'a', 12),
(49, 58, 'Technical Grades', 'a', 'a', 'a', 'a', 12),
(49, 59, 'Management Assistants', 'a', 'a', 'a', 'a', 12),
(49, 60, 'Minor Staff', 'a', 'a', 'a', 'a', 12),
(53, 61, 'Lecturers', 'dssdc', 'sdcsd', 'csdc', 'sdc', 13),
(53, 62, 'Instructors/Demonstrators', 'csdc', 'sdc', 'sdc', 'csdc', 13),
(53, 63, 'Technical Grades', 'sdc', 'dsdscc', 'sd', 'csd', 13),
(53, 64, 'Management Assistants', 'sd', 'sdc', 'cdsc', 'dscds', 13),
(53, 65, 'Minor Staff', 'dsc', 'sdc', 'sdc', 'dscdsc', 13),
(69, 66, 'Lecturers', 'A', 'A', 'A', 'A', 14),
(69, 67, 'Instructors/Demonstrators', 'A', 'A', 'A', 'A', 14),
(69, 68, 'Technical Grades', 'A', 'A', 'A', 'A', 14),
(69, 69, 'Management Assistants', 'A', 'A', 'A', 'A', 14),
(69, 70, 'Minor Staff', 'A', 'A', 'A', 'A', 14),
(23, 71, 'Lecturers', 'A', 'A', 'A', 'A', 15),
(23, 72, 'Instructors/Demonstrators', 'A', 'A', 'A', 'A', 15),
(23, 73, 'Technical Grades', 'A', 'A', 'A', 'A', 15),
(23, 74, 'Management Assistants', 'A', 'A', 'A', 'A', 15),
(23, 75, 'Minor Staff', 'A', 'A', 'A', 'A', 15);

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
('Corporate / Strategic Plan of the University', 'saxsx', '2025-03-04', '/qac_ugc/Proposal_sections/uploads/1751137033_1750187766_1739720192_benchmark.pdf', 5, 2, 2),
('Action Plan of the Faculty/Institute/Center/Unit', 'a', '2025-03-25', '/qac_ugc/Proposal_sections/uploads/1751137033_1750187766_1739720192_benchmark.pdf', 6, 2, 2),
('Senate Approval', 'sxa', '2025-04-02', '/qac_ugc/Proposal_sections/uploads/1751137033_1750187766_1739720192_benchmark.pdf', 7, 2, 2),
('Council Approval', 'sx', '2025-03-27', '/qac_ugc/Proposal_sections/uploads/1751137033_1750187766_1739720192_benchmark.pdf', 8, 2, 2),
('Corporate / Strategic Plan of the University', 'dcdc', '2025-03-10', '/qac_ugc/Proposal_sections/uploads/1750879201_1748196031_1739894675_cooperate.pdf', 9, 3, 3),
('Action Plan of the Faculty/Institute/Center/Unit', 'dc', '2025-03-25', '/qac_ugc/Proposal_sections/uploads/1750879201_1750187766_1739720192_benchmark.pdf', 10, 3, 3),
('Senate Approval', 'cd', '2025-03-25', '/qac_ugc/Proposal_sections/uploads/1750879201_1748196031_1739720192_benchmark.pdf', 11, 3, 3),
('Council Approval', 'cd', '2025-03-26', '/qac_ugc/Proposal_sections/uploads/1750879201_1749405618_1748196031_1739720192_benchmark.pdf', 12, 3, 3),
('Corporate / Strategic Plan of the University', 'tgr', '2025-02-25', '/qac_ugc/Proposal_sections/uploads/1741506202_Application_Summary - 2025-03-09T130611.020.pdf', 13, 7, 4),
('Action Plan of the Faculty/Institute/Center/Unit', 'trg', '2025-03-25', '/qac_ugc/Proposal_sections/uploads/1741506202_Application_Summary - 2025-03-09T130611.020.pdf', 14, 7, 4),
('Senate Approval', 'tgr', '2025-03-25', '/qac_ugc/Proposal_sections/uploads/1741506202_Application_Summary - 2025-03-09T130611.020.pdf', 15, 7, 4),
('Council Approval', 'tgr', '2025-03-27', '/qac_ugc/Proposal_sections/uploads/1741506202_Application_Summary - 2025-03-09T130611.020.pdf', 16, 7, 4),
('Corporate / Strategic Plan of the University', 'reg', '0000-00-00', '/qac_ugc/Proposal_sections/uploads/1748196031_1739720192_benchmark.pdf', 17, 6, 5),
('Action Plan of the Faculty/Institute/Center/Unit', 'reg', '2025-03-20', '/qac_ugc/Proposal_sections/uploads/1748196031_1739720192_benchmark.pdf', 18, 6, 5),
('Senate Approval', 'rferf', '2025-03-19', '/qac_ugc/Proposal_sections/uploads/1748196031_1739720192_benchmark.pdf', 19, 6, 5),
('Council Approval', 'erferf', '2025-03-19', '/qac_ugc/Proposal_sections/uploads/1748196031_1739720192_benchmark.pdf', 20, 6, 5),
('Corporate / Strategic Plan of the University', '1', '2025-03-12', '/qac_ugc/Proposal_sections/uploads/1750189627_1739720192_benchmark.pdf', 21, 16, 6),
('Action Plan of the Faculty/Institute/Center/Unit', '2', '2025-03-19', '/qac_ugc/Proposal_sections/uploads/1750189627_1739718375_fallback.pdf', 22, 16, 6),
('Senate Approval', '3', '2025-03-20', '/qac_ugc/Proposal_sections/uploads/1750189627_1739718211_action.pdf', 23, 16, 6),
('Council Approval', '4', '2025-03-13', '/qac_ugc/Proposal_sections/uploads/1750189627_1739718211_action.pdf', 24, 16, 6),
('Corporate / Strategic Plan of the University', 'sad', '2025-03-12', '/qac_ugc/Proposal_sections/uploads/1742064039_1739894675_action.pdf', 25, 13, 7),
('Action Plan of the Faculty/Institute/Center/Unit', 'sada', '2025-03-26', '/qac_ugc/Proposal_sections/uploads/1742064039_1739894675_council.pdf', 26, 13, 7),
('Senate Approval', 'sdsa', '2025-03-20', '/qac_ugc/Proposal_sections/uploads/1742064039_1739720192_benchmark.pdf', 27, 13, 7),
('Council Approval', 'd', '2025-03-13', '/qac_ugc/Proposal_sections/uploads/1751836078_1748196112_1739894675_council.pdf', 28, 13, 7),
('Corporate / Strategic Plan of the University', '1', '2025-03-04', '/qac_ugc/Proposal_sections/uploads/1742067168_1739894675_senate.pdf', 33, 18, 9),
('Action Plan of the Faculty/Institute/Center/Unit', '2', '2025-03-18', '/qac_ugc/Proposal_sections/uploads/1742067168_1739720192_benchmark.pdf', 34, 18, 9),
('Senate Approval', '3', '2025-03-19', '/qac_ugc/Proposal_sections/uploads/1742067168_1739720192_benchmark.pdf', 35, 18, 9),
('Council Approval', '4', '2025-03-19', '/qac_ugc/Proposal_sections/uploads/1742067168_1739720192_benchmark.pdf', 36, 18, 9),
('Corporate / Strategic Plan of the University', '1', '2025-03-05', '/qac_ugc/qac_ugc/Proposal_sections/uploads/1751825883_1750187766_1739720192_benchmark.pdf', 37, 19, 10),
('Action Plan of the Faculty/Institute/Center/Unit', '2', '2025-03-12', '/qac_ugc/qac_ugc/Proposal_sections/uploads/1751825883_1750187766_1739720192_benchmark.pdf', 38, 19, 10),
('Senate Approval', '3', '2025-03-26', '/qac_ugc/qac_ugc/Proposal_sections/uploads/1751825883_1750187766_1739720192_benchmark.pdf', 39, 19, 10),
('Council Approval', '4', '2025-03-12', '/qac_ugc/qac_ugc/Proposal_sections/uploads/1751825883_1750187766_1739720192_benchmark.pdf', 40, 19, 10),
('Corporate / Strategic Plan of the University', '1', '2025-05-21', '/qac_ugc/qac_ugc/Proposal_sections/uploads/1747387880_1739894675_senate.pdf', 45, 23, 11),
('Action Plan of the Faculty/Institute/Center/Unit', '2', '2025-05-21', '/qac_ugc/qac_ugc/Proposal_sections/uploads/1747387880_1739720192_benchmark.pdf', 46, 23, 11),
('Senate Approval', '4', '2025-05-21', '/qac_ugc/qac_ugc/Proposal_sections/uploads/1747387880_1739718375_fallback.pdf', 47, 23, 11),
('Council Approval', '5', '2025-05-21', '/qac_ugc/qac_ugc/Proposal_sections/uploads/1747387880_1739718375_fallback.pdf', 48, 23, 11),
('Faculty Approval', '3', '2025-05-25', '/qac_ugc/qac_ugc/Proposal_sections/uploads/1747387880_1739720192_benchmark.pdf', 49, 23, 11),
('Faculty Approval', 'dc', '2025-05-21', '/qac_ugc/Proposal_sections/uploads/1748196031_1739894675_cooperate.pdf', 50, 6, 5),
('Faculty Approval', '5', '2025-06-17', '/qac_ugc/Proposal_sections/uploads/1750189627_1739718375_fallback.pdf', 51, 16, 6),
('Faculty Approval', 'df', '2025-06-09', '/qac_ugc/Proposal_sections/uploads/1750879201_1748196031_1739720192_benchmark.pdf', 52, 3, 3),
('Faculty Approval', '1', '2025-06-24', '/qac_ugc/Proposal_sections/uploads/1751137033_1750187766_1739720192_benchmark.pdf', 53, 2, 2),
('Faculty Approval', '3', '2025-07-16', '/qac_ugc/qac_ugc/Proposal_sections/uploads/1751825883_1750187766_1739720192_benchmark.pdf', 54, 19, 10),
('Faculty Approval', '3', '2025-07-16', '/qac_ugc/Proposal_sections/uploads/1751836078_1748196112_1739894675_council.pdf', 55, 13, 7),
('Corporate / Strategic Plan of the University', '1', '2025-07-08', '/qac_ugc/Proposal_sections/uploads/1751917466_1742064039_1739720192_benchmark.pdf', 56, 49, 12),
('Action Plan of the Faculty/Institute/Center/Unit', '2', '2025-07-08', '/qac_ugc/Proposal_sections/uploads/1751917466_1742064039_1739720192_benchmark.pdf', 57, 49, 12),
('Faculty Approval', '3', '2025-07-08', '/qac_ugc/Proposal_sections/uploads/1751917466_1748196112_1739894675_council.pdf', 58, 49, 12),
('Senate Approval', '4', '2025-07-01', '/qac_ugc/Proposal_sections/uploads/1751917466_1748196112_1739894675_council.pdf', 59, 49, 12),
('Council Approval', '5', '2025-07-01', '/qac_ugc/Proposal_sections/uploads/1751917466_1748196112_1739894675_council.pdf', 60, 49, 12),
('Corporate / Strategic Plan of the University', '1', '2025-07-15', '/qac_ugc/Proposal_sections/uploads/1752092312_1742064039_1739720192_benchmark.pdf', 61, 53, 13),
('Action Plan of the Faculty/Institute/Center/Unit', '2', '2025-08-05', '/qac_ugc/Proposal_sections/uploads/1752092312_1742064039_1739894675_council.pdf', 62, 53, 13),
('Faculty Approval', '3', '2025-07-21', '/qac_ugc/Proposal_sections/uploads/1752092312_1748196031_1739720192_benchmark.pdf', 63, 53, 13),
('Senate Approval', '4', '2025-07-22', '/qac_ugc/Proposal_sections/uploads/1752092312_1748196031_1739894675_cooperate.pdf', 64, 53, 13),
('Council Approval', '5', '2025-07-15', '/qac_ugc/Proposal_sections/uploads/1752092312_1748196065_1739720192_benchmark.pdf', 65, 53, 13),
('Corporate / Strategic Plan of the University', '1', '2025-07-16', '/qac_ugc/Proposal_sections/uploads/1752323053_1742064039_1739720192_benchmark.pdf', 66, 69, 14),
('Action Plan of the Faculty/Institute/Center/Unit', '2', '2025-07-22', '/qac_ugc/Proposal_sections/uploads/1752323053_1748196112_1739894675_council.pdf', 67, 69, 14),
('Faculty Approval', '3', '2025-07-15', '/qac_ugc/Proposal_sections/uploads/1752323053_1748196112_1739894675_council.pdf', 68, 69, 14),
('Senate Approval', '4', '2025-07-08', '/qac_ugc/Proposal_sections/uploads/1752323053_1748196112_1739894675_council.pdf', 69, 69, 14),
('Council Approval', '5', '2025-07-02', '/qac_ugc/Proposal_sections/uploads/1752323053_1748196112_1739894675_council.pdf', 70, 69, 14),
('Corporate / Strategic Plan of the University', '1', '2025-07-08', '/qac_ugc/Proposal_sections/uploads/1752411573_1749405580_1748196112_1739894675_council.pdf', 71, 14, 15),
('Action Plan of the Faculty/Institute/Center/Unit', '2', '2025-07-30', '/qac_ugc/Proposal_sections/uploads/1752411573_1749405580_1748196112_1739894675_council.pdf', 72, 14, 15),
('Faculty Approval', '3', '2025-07-23', '/qac_ugc/Proposal_sections/uploads/1752411573_1749405580_1748196112_1739894675_council.pdf', 73, 14, 15),
('Senate Approval', '4', '2025-07-23', '/qac_ugc/Proposal_sections/uploads/1752411573_1749405580_1748196112_1739894675_council.pdf', 74, 14, 15),
('Council Approval', '5', '2025-07-23', '/qac_ugc/Proposal_sections/uploads/1752411573_1749405580_1748196112_1739894675_council.pdf', 75, 14, 15);

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
(241, 18, 'dfs', 'sdf', 3, 2, 2, 2, 3, 12),
(330, 49, 'A', 'aaa', 4, 3, 3, 3, 5, 18),
(331, 49, 'B', 'bbbb', 1, 2, 5, 4, 3, 15),
(341, 16, 'B', 'Lecturer', 1, 1, 1, 1, 1, 5),
(342, 16, 'D', 'aaa', 2, 2, 2, 2, 2, 10),
(428, 13, 'A_13', 'B', 3, 3, 3, 3, 3, 15),
(429, 13, 'B-13', 'sx', 2, 2, 2, 2, 2, 10),
(430, 13, 'C-13', 'dc', 2, 2, 2, 2, 2, 10),
(440, 53, 'A', 'dc', 2, 2, 2, 2, 2, 10),
(441, 53, 'b', 'wdf', 2, 2, 2, 3, 2, 11),
(443, 2, 'A_TEST', 'A', 2, 2, 2, 2, 2, 10),
(448, 69, 'A', 'A', 2, 2, 2, 2, 2, 10),
(449, 6, 'xc', 'dc', 3, 2, 2, 2, 2, 11),
(456, 3, '4', '4', 2, 1, 1, 1, 1, 6),
(457, 3, '4', '4', 2, 1, 1, 1, 1, 6),
(459, 23, 'P', 'Lecturer', 1, 3, 2, 2, 2, 10),
(460, 23, 'P', 'Lecturer', 1, 3, 2, 2, 2, 10),
(469, 14, 'P', 'Lecturer', 1, 3, 2, 2, 2, 10),
(470, 14, 'P', 'Lecturer', 1, 3, 2, 2, 2, 10);

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
(13, 3, 2, 'PROP_3_1747365861', 1000.00, 'pending', '2025-05-16 03:24:21', '2025-05-16 03:24:21'),
(14, 16, 2, 'PROP_16_1750189672', 1000.00, 'completed_used', '2025-06-17 19:47:52', '2025-06-17 19:50:24'),
(15, 3, 2, 'PROP_3_1750959287', 1000.00, 'pending', '2025-06-26 17:34:47', '2025-06-26 17:34:47'),
(16, 3, 2, 'PROP_3_1750959369', 1000.00, 'completed_used', '2025-06-26 17:36:09', '2025-06-26 17:38:28'),
(17, 3, 2, 'PROP_3_1750963892', 1000.00, 'completed_used', '2025-06-26 18:51:32', '2025-06-26 18:52:11'),
(18, 3, 2, 'PROP_3_1751832315', 1000.00, 'pending', '2025-07-06 20:05:15', '2025-07-06 20:05:15'),
(19, 16, 2, 'PROP_16_1751922211', 1000.00, 'pending', '2025-07-07 21:03:31', '2025-07-07 21:03:31'),
(20, 16, 2, 'PROP_16_1751922275', 1000.00, 'completed_used', '2025-07-07 21:04:35', '2025-07-07 21:13:12'),
(21, 3, 2, 'PROP_3_1752184339', 1000.00, 'pending', '2025-07-10 21:52:19', '2025-07-10 21:52:19'),
(22, 2, 2, 'PROP_2_1752184627', 1000.00, 'completed_used', '2025-07-10 21:57:07', '2025-07-10 21:58:00');

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
(14, 'Other', 'A', 'A', 'AA', 'A', 'A', 10, 90),
(19, 'Land extent (Acre/Hectare)', 'DV', 'FV', 'FDV', 'DFV', 'FVDFV', 11, 91),
(19, 'Office Space', 'FDV', 'V', 'VDFDF', 'DFV', 'DFDV', 11, 92),
(19, 'No. of Lecture Theatres', 'VDF', 'FDV', 'FV', 'FD', 'VDFV', 11, 93),
(19, 'No. of Laboratories', 'DFV', 'DV', 'VF', 'VFD', 'FD', 11, 94),
(19, 'No. of Computers with Internet Facilities', 'V', 'FDV', 'DFV', 'FV', 'DFV', 11, 95),
(19, 'Reading Rooms/Halls', 'FD', 'FDV', 'FDV', 'FV', 'DFV', 11, 96),
(19, 'Staff Common Rooms/Amenities', 'FVFDV', 'VDF', 'FVD', 'FV', 'FV', 11, 97),
(19, 'Student Common Rooms/Amenities', 'VDF', 'VFD', 'VF', 'VVF', 'FV', 11, 98),
(19, 'Other', 'VFD', 'VFD', 'VFD', 'FDV', 'FV', 11, 99),
(49, 'Land extent (Acre/Hectare)', 'A', 'A', 'A', 'a', 'a', 12, 100),
(49, 'Office Space', 'a', 'aa', 'a', 'a', 'a', 12, 101),
(49, 'No. of Lecture Theatres', 'a', 'a', 'a', 'a', 'a', 12, 102),
(49, 'No. of Laboratories', 'a', 'a', 'aa', 'a', 'a', 12, 103),
(49, 'No. of Computers with Internet Facilities', 'a', 'a', 'a', 'a', 'a', 12, 104),
(49, 'Reading Rooms/Halls', 'a', 'a', 'a', 'a', 'a', 12, 105),
(49, 'Staff Common Rooms/Amenities', 'a', 'a', 'a', 'aa', 'a', 12, 106),
(49, 'Student Common Rooms/Amenities', 'a', 'a', 'a', 'a', 'a', 12, 107),
(49, 'Other', 'a', 'a', 'a', 'a', 'a', 12, 108),
(53, 'Land extent (Acre/Hectare)', 'sdc', 'sdc', 'sdc', 'sdc', 'sdc', 13, 109),
(53, 'Office Space', 'c', 'cdsd', 'sdcs', 'scd', 'sdc', 13, 110),
(53, 'No. of Lecture Theatres', 'cds', 'sdc', 'cs', 'dc', 'sdc', 13, 111),
(53, 'No. of Laboratories', 'dsc', 'sdc', 'sdc', 'sdc', 'sdc', 13, 112),
(53, 'No. of Computers with Internet Facilities', 'dc', 'scd', 'scd', 'scd', 'scd', 13, 113),
(53, 'Reading Rooms/Halls', 'sdc', 'csd', 'csd', 'scd', 'dsc', 13, 114),
(53, 'Staff Common Rooms/Amenities', 'sdc', 'sd', 'sdc', 'csd', 'csd', 13, 115),
(53, 'Student Common Rooms/Amenities', 'sdc', 'dcsc', 'dcs', 'scd', 'csd', 13, 116),
(53, 'Other', 'scd', 'scd', 'csd', 'csd', 'dsc', 13, 117),
(69, 'Land extent (Acre/Hectare)', 'A', 'A', 'A', 'AA', 'A', 14, 118),
(69, 'Office Space', 'A', 'A', 'A', 'A', 'A', 14, 119),
(69, 'No. of Lecture Theatres', 'A', 'A', 'A', 'Aa', 'A', 14, 120),
(69, 'No. of Laboratories', 'A', 'A', 'A', 'A', 'A', 14, 121),
(69, 'No. of Computers with Internet Facilities', 'A', 'A', 'A', 'A', 'A', 14, 122),
(69, 'Reading Rooms/Halls', 'A', 'A', 'A', 'A', 'A', 14, 123),
(69, 'Staff Common Rooms/Amenities', 'A', 'A', 'A', 'A', 'A', 14, 124),
(69, 'Student Common Rooms/Amenities', 'A', 'A', 'A', 'A', 'A', 14, 125),
(69, 'Other', 'A', 'A', 'A', 'A', 'A', 14, 126),
(23, 'Land extent (Acre/Hectare)', 'A', 'A', 'A', 'A', 'A', 15, 127),
(23, 'Office Space', 'A', 'A', 'A', 'A', 'A', 15, 128),
(23, 'No. of Lecture Theatres', 'A', 'A', 'A', 'A', 'A', 15, 129),
(23, 'No. of Laboratories', 'AA', 'A', 'A', 'A', 'A', 15, 130),
(23, 'No. of Computers with Internet Facilities', 'A', 'A', 'AA', 'A', 'A', 15, 131),
(23, 'Reading Rooms/Halls', 'A', 'A', 'A', 'A', 'A', 15, 132),
(23, 'Staff Common Rooms/Amenities', 'A', 'A', 'A', 'A', 'A', 15, 133),
(23, 'Student Common Rooms/Amenities', 'A', 'A', 'A', 'A', 'A', 15, 134),
(23, 'Other', 'A', 'A', 'AA', 'A', 'A', 15, 135);

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
(20, 14, 1, 'A', 'xsx', 120, 'Optional', 3, 3, 3, 'A', 'A', 'A', 2, 3, 'A'),
(22, 19, 3, 'WED', 'EDW', 120, 'Optional', 2, 2, 2, 'ED', 'WED', 'WED', 2, 2, 'EWDWED'),
(24, 49, 1, 'A', 'A', 2, 'Optional', 2, 2, 2, 'A', 'A', 'A', 2, 2, 'A'),
(25, 49, 2, 'B', 'B', 118, 'Core', 4, 3, 3, 'B', 'B', 'B', 3, 4, 'B'),
(27, 53, 1, '12', '12', 120, 'Optional', 2, 2, 2, 'sc', 'dc', 'dc', 3, 2, 'dscsdc'),
(29, 69, 1, 'A', 'A', 120, 'Optional', 2, 2, 2, 'A', 'A', 'A', 2, 2, 'A'),
(31, 23, 1, 'A', 'xsx', 120, 'Optional', 3, 3, 3, 'A', 'A', 'A', 2, 3, 'A');

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
(14, 'A', 10),
(19, 'FVDFV', 11),
(49, 'A', 12),
(53, 'dscdsc', 13),
(69, 'A', 14),
(23, 'A', 15);

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
(23, 'School of computing', 'School of computing', 11, 'University of Colombo'),
(49, 'Faculty of Computing', 'Computing', 12, 'University of Colombo'),
(53, 'School of Computing', 'Computing', 13, 'University of Colombo'),
(69, 'School of Computing', 'Computer Science', 14, 'University of Colombo'),
(14, 'School of computing', 'School of computing', 15, 'University of Colombo');

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
(13, 13, 1, 'ef', 'ewf', 120, 'Compulsory', 'No', 'Yes', 'New'),
(17, 18, 4, 'fdv', 'fdv', 120, '', 'Yes', 'No', 'Existing'),
(19, 16, 1, 's', 'sx', 90, 'Optional', 'Yes', 'No', 'Existing'),
(21, 14, 2, 'A', 'A', 1, 'Compulsory', 'Yes', 'No', 'Existing'),
(22, 14, 2, 'B', 'B', 49, 'Compulsory', 'No', 'Yes', 'New'),
(23, 14, 4, 'C', 'C', 70, 'Compulsory', 'Yes', 'No', 'Existing'),
(25, 19, 1, '1', '1', 120, '', 'Yes', 'No', 'New'),
(27, 49, 1, 'A', 'A', 2, 'Compulsory', 'Yes', 'No', 'New'),
(28, 49, 2, 'B', 'B', 118, 'Optional', 'No', 'Yes', 'Existing'),
(31, 16, 2, 'd', 'd', 2, 'Compulsory', 'No', 'Yes', 'New'),
(32, 16, 3, '3', '3', 2, 'Optional', 'Yes', 'No', 'New'),
(33, 13, 2, 'sx', 'sd', 3, 'Optional', 'Yes', 'No', 'Existing'),
(34, 13, 3, 'scd', 'dc', 4, 'Compulsory', 'Yes', 'Yes', 'Existing'),
(35, 13, 4, 'dfc', 'dcdcvf', 2, 'Optional', 'Yes', 'No', 'New'),
(36, 13, 5, 'rf', 'vcr', 2, 'Optional', 'No', 'Yes', 'New'),
(37, 13, 6, 'cds', 'dcx', 2, 'Compulsory', 'Yes', 'No', 'Existing'),
(38, 13, 7, 'dcs', 'ccx', 2, 'Optional', 'Yes', 'Yes', 'New'),
(40, 53, 0, '12', 'A', 120, 'Optional', 'Yes', 'No', 'New'),
(42, 69, 1, 'A', 'A', 120, 'Compulsory', 'Yes', 'No', 'Existing'),
(44, 23, 2, 'A', 'A', 1, 'Compulsory', 'Yes', 'No', 'Existing'),
(45, 23, 2, 'B', 'B', 49, 'Compulsory', 'No', 'Yes', 'New'),
(46, 23, 4, 'C', 'C', 70, 'Compulsory', 'Yes', 'No', 'Existing');

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
(18, 9),
(19, 11),
(23, 15),
(49, 12),
(53, 13),
(69, 14);

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
(120, 14, 'Recommendation (a, b, or c)', 'A', 'A'),
(121, 19, '', '', ''),
(122, 19, 'Acceptability of the Background and the Justification', 'FDV', 'DFV'),
(123, 19, 'Relevance of proposed degree program to Society', 'FD', 'VDF'),
(124, 19, 'Entry Qualification and Admission Process', 'V', 'F'),
(125, 19, 'Program Structure', 'VD', 'VF'),
(126, 19, 'Program Content', 'DV', 'FDVFD'),
(127, 19, 'Teaching Learning Methods', 'VFD', 'FDV'),
(128, 19, 'Assessment Strategy/Procedure', 'VDF', 'V'),
(129, 19, 'Resource Availability - Physical', 'DF', 'VFD'),
(130, 19, 'Qualifications of Panel of Teachers (Internal & External)', 'FDV', 'V'),
(131, 19, 'Recommended Reading', 'DF', 'VFD'),
(132, 19, 'Recommendation (a, b, or c)', 'VFD', 'VDFV'),
(133, 49, '', '', ''),
(134, 49, 'Acceptability of the Background and the Justification', 'A', 'A'),
(135, 49, 'Relevance of proposed degree program to Society', 'A', 'A'),
(136, 49, 'Entry Qualification and Admission Process', 'A', 'A'),
(137, 49, 'Program Structure', 'A', 'A'),
(138, 49, 'Program Content', 'A', 'a'),
(139, 49, 'Teaching Learning Methods', 'A', 'A'),
(140, 49, 'Assessment Strategy/Procedure', 'a', 'a'),
(141, 49, 'Resource Availability - Physical', 'A', 'A'),
(142, 49, 'Qualifications of Panel of Teachers (Internal & External)', 'AA', 'A'),
(143, 49, 'Recommended Reading', 'A', 'A'),
(144, 49, 'Recommendation (a, b, or c)', 'A', 'A'),
(145, 53, '', '', ''),
(146, 53, 'Acceptability of the Background and the Justification', 'dsf', 'dsf'),
(147, 53, 'Relevance of proposed degree program to Society', 'sdf', 'sdf'),
(148, 53, 'Entry Qualification and Admission Process', 'sd', 'fs'),
(149, 53, 'Program Structure', 'df', 'sdf'),
(150, 53, 'Program Content', 'dsf', 'dsf'),
(151, 53, 'Teaching Learning Methods', 'sdf', 'sdf'),
(152, 53, 'Assessment Strategy/Procedure', 'sdf', 'e'),
(153, 53, 'Resource Availability - Physical', 'sdf', 'dsf'),
(154, 53, 'Qualifications of Panel of Teachers (Internal & External)', 'dsf', 'sdf'),
(155, 53, 'Recommended Reading', 'dsf', 'dsf'),
(156, 53, 'Recommendation (a, b, or c)', 'sdf', 'sdf'),
(157, 69, '', '', ''),
(158, 69, 'Acceptability of the Background and the Justification', 'A', 'A'),
(159, 69, 'Relevance of proposed degree program to Society', 'A', 'a'),
(160, 69, 'Entry Qualification and Admission Process', 'sad', 'de'),
(161, 69, 'Program Structure', 'wd', 'ewd'),
(162, 69, 'Program Content', 'd', 'ewd'),
(163, 69, 'Teaching Learning Methods', 'de', 'wed'),
(164, 69, 'Assessment Strategy/Procedure', 'wed', 'wed'),
(165, 69, 'Resource Availability - Physical', 'ewd', 'ew'),
(166, 69, 'Qualifications of Panel of Teachers (Internal & External)', 'ewd', 'we'),
(167, 69, 'Recommended Reading', 'wed', 'wed'),
(168, 69, 'Recommendation (a, b, or c)', 'wed', 'wed'),
(169, 23, '', '', ''),
(170, 23, 'Acceptability of the Background and the Justification', 'A', 'A'),
(171, 23, 'Relevance of proposed degree program to Society', 'A', 'A'),
(172, 23, 'Entry Qualification and Admission Process', 'A', 'A'),
(173, 23, 'Program Structure', 'A', 'A'),
(174, 23, 'Program Content', 'A', 'A'),
(175, 23, 'Teaching Learning Methods', 'A', 'A'),
(176, 23, 'Assessment Strategy/Procedure', 'A', 'A'),
(177, 23, 'Resource Availability - Physical', 'A', 'A'),
(178, 23, 'Qualifications of Panel of Teachers (Internal & External)', 'A', 'A'),
(179, 23, 'Recommended Reading', 'A', 'A'),
(180, 23, 'Recommendation (a, b, or c)', 'A', 'A');

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
(120, 14, 24, 'B', 'B', 'B', 'B', '2025-05-16'),
(132, 19, 25, 'VFVF', 'VFD', 'V', 'DFV', '2025-07-24'),
(132, 19, 26, 'FD', 'FDV', 'DVF', 'FDV', '2025-07-22'),
(144, 49, 27, 'A', 'A', 'a', 'a', '2025-07-24'),
(144, 49, 28, 'B', 'V', 'V', 'V', '2025-07-31'),
(156, 53, 29, 'dfs', 'sdf', 'sdf', 'dfs', '2025-07-30'),
(156, 53, 30, 'dsf', 'df', 'sdf', 'df', '2025-07-30'),
(168, 69, 31, 'wde', 'wed', 'ewd', 'ewd', '2025-07-25'),
(168, 69, 32, 'ed', 'wedw', 'ewd', 'ewdwed', '2025-07-30'),
(180, 23, 33, 'A', 'A', 'A', 'A', '2025-05-16'),
(180, 23, 34, 'B', 'B', 'B', 'B', '2025-05-16');

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
(7, 1, 7, 'approvedbycqa', 'approvedbyqachead', '2025-03-08 14:30:37'),
(9, 1, 9, 'approvedbyugcfinance', 'approvedbyugchr', '2025-03-08 14:33:16'),
(10, 1, 10, 'approvedbyugchr', 'approvedbyugcidd', '2025-03-08 14:33:44'),
(11, 1, 11, 'approvedbyugcidd', 'approvedbyugclegal', '2025-03-08 14:34:15'),
(12, 1, 13, 'approvedbyugclegal', 'approvedbyugcadmission', '2025-03-08 14:35:15'),
(13, 1, 12, 'approvedbyugcadmission', 'approvedbyugcacademic', '2025-03-08 14:35:44'),
(36, 6, 3, 'submitted', 'approvedbydean', '2025-03-09 10:01:02'),
(53, 7, 3, 'submitted', 'approvedbydean', '2025-03-15 08:41:41'),
(54, 7, 5, 'approvedbydean', 'approvedbyvc', '2025-03-15 08:43:39'),
(62, 6, 6, 'approvedbydean', 'approvedbycqa', '2025-03-15 15:05:38'),
(80, 2, 7, 'approvedbyvc', '', '2025-03-15 16:10:06'),
(81, 2, 7, '', 'rejectedbyqachead', '2025-03-15 16:10:15'),
(89, 6, 5, 'approvedbycqa', 'rejectedbyvc', '2025-03-15 16:24:58'),
(96, 13, 3, 'submitted', 'approvedbydean', '2025-03-15 18:58:27'),
(97, 13, 6, 'approvedbydean', 'approvedbycqa', '2025-03-15 18:58:58'),
(98, 13, 5, 'approvedbycqa', 'approvedbyvc', '2025-03-15 18:59:37'),
(99, 13, 7, 'approvedbyvc', 'rejectedbyqachead', '2025-03-15 19:01:03'),
(100, 16, 3, 'submitted', '', '2025-03-16 06:26:39'),
(101, 16, 3, '', 'approvedbydean', '2025-03-16 06:26:46'),
(102, 16, 6, 'approvedbydean', 'approvedbycqa', '2025-03-16 06:28:08'),
(103, 16, 5, 'approvedbycqa', 'rejectedbyvc', '2025-03-16 06:29:23'),
(104, 7, 7, 'approvedbyvc', 'approvedbyqachead', '2025-03-16 06:32:16'),
(107, 13, 3, 'submitted', 'rejectedbydean', '2025-05-16 03:37:42'),
(108, 13, 3, 'submitted', '', '2025-05-16 03:38:40'),
(109, 13, 3, '', 'approvedbydean', '2025-05-16 03:38:58'),
(110, 13, 6, 'approvedbydean', 'rejectedbycqa', '2025-05-16 07:09:58'),
(111, 6, 3, 'submitted', 'approvedbydean', '2025-06-08 17:59:40'),
(112, 6, 6, 'approvedbydean', 'approvedbycqa', '2025-06-08 18:00:18'),
(113, 6, 5, 'approvedbycqa', 'approvedbyvc', '2025-06-08 18:00:37'),
(115, 16, 3, '', 'approvedbydean', '2025-06-17 19:06:43'),
(116, 16, 3, 'approvedbydean', 'approvedbydean', '2025-06-17 19:09:06'),
(117, 16, 6, 'approvedbydean', 'approvedbycqa', '2025-06-17 19:09:53'),
(118, 16, 5, 'approvedbycqa', 'approvedbyvc', '2025-06-17 19:11:37'),
(119, 16, 5, 'approvedbyvc', 'rejectedbyvc', '2025-06-17 19:11:52'),
(120, 16, 3, 'submitted', 'rejectedbydean', '2025-06-17 19:16:52'),
(121, 16, 3, 'submitted', 'rejectedbydean', '2025-06-17 19:23:37'),
(122, 16, 3, 'submitted', 'approvedbydean', '2025-06-17 19:25:21'),
(123, 16, 6, 'approvedbydean', 'approvedbycqa', '2025-06-17 19:31:39'),
(124, 16, 6, 'approvedbycqa', 'approvedbycqa', '2025-06-17 19:32:07'),
(125, 16, 6, 'approvedbycqa', 'approvedbycqa', '2025-06-17 19:34:15'),
(126, 16, 5, 'approvedbycqa', 'approvedbyvc', '2025-06-17 19:34:39'),
(127, 16, 5, 'approvedbyvc', 'approvedbyvc', '2025-06-17 19:34:51'),
(128, 16, 7, 'approvedbyvc', 'rejectedbyqachead', '2025-06-17 19:37:37'),
(129, 16, 7, 'approvedbyvc', 'rejectedbyqachead', '2025-06-17 19:37:47'),
(130, 16, 7, 'approvedbyvc', 'rejectedbyqachead', '2025-06-17 19:37:57'),
(131, 16, 7, 'approvedbyvc', 'rejectedbyqachead', '2025-06-17 19:44:43'),
(132, 16, 3, 'submitted', '', '2025-06-26 17:05:57'),
(133, 16, 3, '', '', '2025-06-26 17:06:02'),
(138, 16, 3, 'submitted', 'approvedbydean', '2025-06-26 18:47:08'),
(139, 16, 6, 'approvedbydean', 'approvedbycqa', '2025-06-26 18:47:41'),
(140, 16, 5, 'approvedbycqa', 'rejectedbyvc', '2025-06-26 18:48:38'),
(152, 2, 6, 'approvedbydean', 'approvedbycqa', '2025-06-28 18:22:36'),
(153, 2, 6, 'approvedbycqa', 'approvedbycqa', '2025-06-28 18:22:47'),
(154, 2, 6, 'approvedbycqa', 'approvedbycqa', '2025-06-28 18:22:56'),
(155, 2, 6, 'approvedbycqa', 'approvedbycqa', '2025-06-28 18:23:00'),
(156, 2, 3, 'submitted', 'approvedbydean', '2025-06-28 18:27:54'),
(157, 2, 3, 'approvedbydean', 'approvedbydean', '2025-06-28 18:31:52'),
(158, 2, 3, 'approvedbydean', 'approvedbydean', '2025-06-28 18:33:45'),
(159, 2, 3, 'approvedbydean', 'approvedbydean', '2025-06-28 18:34:18'),
(160, 2, 3, 'approvedbydean', 'approvedbydean', '2025-06-28 18:40:57'),
(161, 2, 6, 'approvedbydean', 'rejectedbycqa', '2025-06-28 18:48:17'),
(162, 2, 3, 'submitted', 'rejectedbydean', '2025-06-28 18:56:31'),
(163, 2, 3, 'submitted', 'approvedbydean', '2025-06-28 18:59:02'),
(164, 2, 6, 'approvedbydean', 'approvedbycqa', '2025-06-28 19:01:07'),
(165, 2, 5, 'approvedbycqa', 'rejectedbyvc', '2025-06-28 19:02:30'),
(166, 2, 3, 'submitted', 'approvedbydean', '2025-06-28 19:03:34'),
(167, 2, 6, 'approvedbydean', 'approvedbycqa', '2025-06-28 19:04:37'),
(168, 2, 5, 'approvedbycqa', 'approvedbyvc', '2025-06-28 19:05:02'),
(169, 2, 3, 'submitted', 'rejectedbydean', '2025-06-28 19:58:29'),
(170, 2, 3, 'submitted', 'approvedbydean', '2025-06-28 19:59:10'),
(171, 2, 6, 'approvedbydean', 'approvedbycqa', '2025-06-28 20:08:32'),
(172, 2, 5, 'approvedbycqa', 'approvedbyvc', '2025-06-28 20:18:19'),
(173, 6, 7, 'approvedbyvc', 'rejectedbyqachead', '2025-06-29 18:40:38'),
(175, 2, 3, 'submitted', 'rejectedbydean', '2025-06-29 21:19:59'),
(182, 19, 3, 'submitted', 'rejectedbydean', '2025-07-06 18:05:20'),
(183, 19, 3, 'submitted', 'approvedbydean', '2025-07-06 18:11:14'),
(184, 19, 6, 'approvedbydean', 'approvedbycqa', '2025-07-06 18:11:48'),
(185, 19, 5, 'approvedbycqa', 'approvedbyvc', '2025-07-06 18:13:01'),
(186, 19, 26, 'approvedbyvc', 'rejectedbyTA', '2025-07-06 18:15:48'),
(187, 19, 3, 'submitted', 'approvedbydean', '2025-07-06 18:18:48'),
(188, 19, 6, 'approvedbydean', 'approvedbycqa', '2025-07-06 18:19:12'),
(189, 19, 5, 'approvedbycqa', 'approvedbyvc', '2025-07-06 18:19:33'),
(190, 19, 26, 'approvedbyvc', 'rejectedbyTA', '2025-07-06 18:29:48'),
(191, 19, 7, 'approvedbysecretary', 'rejectedbyqachead', '2025-07-06 18:32:14'),
(192, 19, 3, 'submitted', 'approvedbydean', '2025-07-06 18:33:38'),
(193, 19, 6, 'approvedbydean', 'approvedbycqa', '2025-07-06 18:34:31'),
(194, 19, 5, 'approvedbycqa', 'approvedbyvc', '2025-07-06 18:34:46'),
(195, 19, 26, 'approvedbyvc', 'rejectedbyTA', '2025-07-06 18:35:00'),
(196, 19, 7, 'approvedbysecretary', 'approvedbyqachead', '2025-07-06 18:51:33'),
(197, 13, 3, 'submitted', 'rejectedbydean', '2025-07-06 21:07:03'),
(198, 2, 30, 'approvedbyvc', 'approvedbyTA', '2025-07-07 17:33:17'),
(199, 2, 30, 'approvedbyvc', 'approvedbyTA', '2025-07-07 17:39:09'),
(200, 2, 28, 'approvedbyTA', 'approvedbysecretary', '2025-07-07 17:44:43'),
(214, 2, 7, 'approvedbysecretary', 'rejectedbyqachead', '2025-07-07 19:24:25'),
(215, 2, 7, 'approvedbysecretary', 'approvedbyqachead', '2025-07-07 19:30:03'),
(216, 2, 7, 'approvedbysecretary', 'rejectedbyqachead', '2025-07-07 19:31:01'),
(217, 2, 7, 'approvedbysecretary', 'rejectedbyqachead', '2025-07-07 19:40:09'),
(218, 49, 3, 'submitted', 'rejectedbydean', '2025-07-07 19:52:31'),
(219, 49, 3, 'submitted', 'approvedbydean', '2025-07-07 19:57:41'),
(220, 49, 6, 'approvedbydean', 'approvedbycqa', '2025-07-07 19:58:09'),
(221, 49, 5, 'approvedbycqa', 'approvedbyvc', '2025-07-07 19:58:27'),
(222, 49, 26, 'approvedbyvc', 'approvedbyTA', '2025-07-07 19:59:43'),
(223, 49, 28, 'approvedbyTA', 'approvedbysecretary', '2025-07-07 20:00:14'),
(224, 49, 7, 'approvedbysecretary', 'rejectedbyqachead', '2025-07-07 20:00:52'),
(225, 49, 3, 'submitted', 'approvedbydean', '2025-07-07 20:29:38'),
(226, 49, 6, 'approvedbydean', 'approvedbycqa', '2025-07-07 20:30:32'),
(227, 49, 5, 'approvedbycqa', 'approvedbyvc', '2025-07-07 20:30:44'),
(228, 49, 26, 'approvedbyvc', 'approvedbyTA', '2025-07-07 20:31:02'),
(229, 49, 28, 'approvedbyTA', 'approvedbysecretary', '2025-07-07 20:31:21'),
(230, 49, 7, 'approvedbysecretary', 'rejectedbyqachead', '2025-07-07 20:31:30'),
(231, 49, 3, 'submitted', 'approvedbydean', '2025-07-07 20:35:24'),
(232, 49, 6, 'approvedbydean', 'approvedbycqa', '2025-07-07 20:35:37'),
(233, 49, 5, 'approvedbycqa', 'approvedbyvc', '2025-07-07 20:35:50'),
(234, 49, 26, 'approvedbyvc', 'approvedbyTA', '2025-07-07 20:36:02'),
(235, 49, 28, 'approvedbyTA', 'approvedbysecretary', '2025-07-07 20:36:19'),
(236, 49, 7, 'approvedbysecretary', 'approvedbyqachead_revised', '2025-07-07 20:37:32'),
(237, 13, 3, 'submitted', 'rejectedbydean', '2025-07-08 17:11:40'),
(238, 13, 3, 'submitted', 'rejectedbydean', '2025-07-08 19:42:05'),
(239, 13, 3, 'submitted', 'rejectedbydean', '2025-07-08 20:03:23'),
(240, 13, 3, 'submitted', 'rejectedbydean', '2025-07-08 20:27:44'),
(241, 13, 3, 'submitted', 'approvedbydean', '2025-07-08 21:55:40'),
(242, 13, 6, 'approvedbydean', 'approvedbycqa', '2025-07-08 21:56:08'),
(243, 13, 26, 'approvedbycqa', 'approvedbyTA', '2025-07-08 22:18:35'),
(244, 13, 28, 'approvedbyTA', 'approvedbysecretary', '2025-07-08 22:18:57'),
(245, 13, 7, 'approvedbysecretary', 'approvedbyqachead', '2025-07-08 22:43:06'),
(246, 13, 7, 'approvedbysecretary', 'resignature_request_from_university', '2025-07-09 18:28:43'),
(247, 13, 3, 'resignature_request_from_university', 'approvedbydean', '2025-07-09 18:30:55'),
(248, 13, 6, 'approvedbydean', 'approvedbycqa', '2025-07-09 18:31:17'),
(249, 13, 7, 'approvedbysecretary', 'resignature_request_from_university', '2025-07-09 19:32:42'),
(250, 13, 3, 'resignature_request_from_university', 're-signed_dean', '2025-07-09 19:33:11'),
(251, 13, 6, 're-signed_dean', 're-signed_cqa', '2025-07-09 19:37:33'),
(252, 13, 6, 're-signed_dean', 're-signed_cqa', '2025-07-09 19:39:21'),
(253, 13, 5, 're-signed_cqa', 're-signed_vc', '2025-07-09 19:46:30'),
(254, 49, 8, 'approvedbyqachead_revised', 'approvedbyugcfinance', '2025-07-09 20:11:48'),
(255, 53, 3, 'submitted', 'approvedbydean', '2025-07-09 21:25:44'),
(256, 53, 6, 'approvedbydean', 'approvedbycqa', '2025-07-09 21:26:10'),
(257, 53, 5, 'approvedbycqa', 'approvedbyvc', '2025-07-09 21:26:20'),
(258, 53, 26, 'approvedbyvc', 'approvedbyTA', '2025-07-09 21:26:33'),
(259, 53, 28, 'approvedbyTA', 'approvedbysecretary', '2025-07-09 21:26:50'),
(260, 53, 7, 'approvedbysecretary', 'rejectedbyqachead', '2025-07-09 21:27:50'),
(261, 53, 3, 'submitted', 'approvedbydean', '2025-07-09 21:28:34'),
(262, 53, 6, 'approvedbydean', 'approvedbycqa', '2025-07-09 21:28:52'),
(263, 53, 26, 'approvedbycqa', 'approvedbyTA', '2025-07-09 21:39:15'),
(264, 53, 28, 'approvedbyTA', 'approvedbysecretary', '2025-07-09 21:39:43'),
(265, 53, 7, 'approvedbysecretary', 'approvedbyqachead_revised', '2025-07-09 21:40:04'),
(266, 53, 7, 'approvedbysecretary', 'resignature_request_from_university', '2025-07-09 21:41:23'),
(267, 53, 3, 'resignature_request_from_university', 're-signed_dean', '2025-07-09 21:41:41'),
(268, 53, 6, 're-signed_dean', 're-signed_cqa', '2025-07-09 21:42:16'),
(269, 53, 5, 're-signed_cqa', 're-signed_vc', '2025-07-09 21:42:27'),
(270, 13, 8, 're-signed_vc', 'approvedbyugcfinance', '2025-07-10 17:56:52'),
(271, 13, 9, 'approvedbyugcfinance', 'approvedbyugchr', '2025-07-10 20:25:19'),
(272, 13, 10, 'approvedbyugchr', 'approvedbyugcidd', '2025-07-10 20:51:57'),
(273, 2, 26, 'approvedbycqa', 'approvedbyTA', '2025-07-10 22:54:02'),
(274, 2, 26, 'approvedbycqa', 'approvedbyTA', '2025-07-10 22:56:05'),
(275, 2, 28, 'approvedbyTA', 'approvedbysecretary', '2025-07-10 22:57:13'),
(276, 2, 7, 'approvedbysecretary', 'approvedbyqachead_revised', '2025-07-10 22:57:39'),
(282, 2, 12, 'approvedbyqachead_revised', 'under_department_review', '2025-07-10 23:19:15'),
(283, 2, 8, 'approvedbyqachead_revised', 'under_department_review', '2025-07-10 23:21:08'),
(284, 2, 9, 'approvedbyqachead_revised', 'under_department_review', '2025-07-10 23:21:19'),
(285, 2, 10, 'approvedbyqachead_revised', 'under_department_review', '2025-07-10 23:21:43'),
(286, 2, 13, 'approvedbyqachead_revised', 'under_department_review', '2025-07-10 23:21:58'),
(287, 53, 8, 're-signed_vc', 'approvedbyugcfinance', '2025-07-10 23:25:32'),
(288, 53, 9, 're-signed_vc', 'approvedbyugchr', '2025-07-10 23:26:19'),
(289, 53, 10, 're-signed_vc', 'approvedbyugcidd', '2025-07-10 23:28:03'),
(290, 53, 12, 're-signed_vc', 'approvedbyugcacademic', '2025-07-10 23:28:20'),
(291, 53, 13, 're-signed_vc', 'approvedbyugcadmission', '2025-07-10 23:28:46'),
(292, 7, 3, 'submitted', 'approvedbydean', '2025-07-11 21:31:54'),
(293, 7, 6, 'approvedbydean', 'approvedbycqa', '2025-07-11 21:32:25'),
(294, 7, 5, 'approvedbycqa', 'approvedbyvc', '2025-07-11 21:32:36'),
(295, 7, 26, 'approvedbyvc', 'approvedbyTA', '2025-07-11 21:32:50'),
(296, 7, 28, 'approvedbyTA', 'approvedbysecretary', '2025-07-11 21:33:21'),
(297, 7, 7, 'approvedbysecretary', 'approvedbyqachead', '2025-07-11 21:34:00'),
(298, 7, 8, 'approvedbyqachead', 'approvedbyugcfinance', '2025-07-11 21:34:30'),
(299, 7, 9, 'approvedbyqachead', 'approvedbyugchr', '2025-07-11 21:35:30'),
(300, 7, 10, 'approvedbyqachead', 'approvedbyugcidd', '2025-07-11 21:35:44'),
(301, 7, 12, 'approvedbyqachead', 'approvedbyugcacademic', '2025-07-11 21:35:54'),
(302, 7, 13, 'approvedbyqachead', 'approvedbyugcadmission', '2025-07-11 21:36:11'),
(303, 16, 3, 'submitted', 'approvedbydean', '2025-07-11 21:49:07'),
(304, 16, 6, 'approvedbydean', 'approvedbycqa', '2025-07-11 21:49:28'),
(305, 16, 26, 'approvedbycqa', 'approvedbyTA', '2025-07-11 21:50:14'),
(306, 16, 28, 'approvedbyTA', 'approvedbysecretary', '2025-07-11 21:53:49'),
(307, 16, 7, 'approvedbysecretary', 'approvedbyqachead_revised', '2025-07-11 21:54:33'),
(308, 16, 8, 'approvedbyqachead_revised', 'approvedbyugcfinance', '2025-07-11 21:54:57'),
(309, 16, 9, 'approvedbyqachead_revised', 'approvedbyugchr', '2025-07-11 21:55:16'),
(310, 16, 10, 'approvedbyqachead_revised', 'approvedbyugcidd', '2025-07-11 21:55:27'),
(311, 16, 13, 'approvedbyqachead_revised', 'approvedbyugcadmission', '2025-07-11 21:55:37'),
(312, 16, 12, 'approvedbyqachead_revised', 'approvedbyugcacademic', '2025-07-11 21:55:54'),
(313, 6, 3, 'submitted', 'approvedbydean', '2025-07-11 21:58:41'),
(314, 6, 6, 'approvedbydean', 'approvedbycqa', '2025-07-11 21:58:56'),
(315, 6, 30, 'approvedbycqa', 'approvedbyTA', '2025-07-11 21:59:16'),
(316, 6, 28, 'approvedbyTA', 'approvedbysecretary', '2025-07-11 21:59:30'),
(317, 6, 7, 'approvedbysecretary', 'approvedbyqachead_revised', '2025-07-11 22:07:02'),
(318, 6, 8, 'approvedbyqachead_revised', 'approvedbyugcfinance', '2025-07-11 22:07:21'),
(319, 6, 9, 'approvedbyqachead_revised', 'approvedbyugchr', '2025-07-11 22:07:35'),
(320, 6, 12, 'approvedbyqachead_revised', 'approvedbyugcacademic', '2025-07-11 22:07:47'),
(321, 6, 10, 'approvedbyqachead_revised', 'approvedbyugcidd', '2025-07-11 22:08:05'),
(322, 6, 13, 'approvedbyqachead_revised', 'approvedbyugcadmission', '2025-07-11 22:08:19'),
(323, 7, 3, 'resignature_request_from_university', 're-signed_dean', '2025-07-11 22:15:00'),
(324, 7, 6, 're-signed_dean', 're-signed_cqa', '2025-07-11 22:15:20'),
(325, 7, 5, 're-signed_cqa', 're-signed_vc', '2025-07-11 22:15:30'),
(326, 13, 3, 'resignature_request_from_university', 're-signed_dean', '2025-07-11 23:21:46'),
(327, 69, 3, 'submitted', 'approvedbydean', '2025-07-12 13:30:04'),
(328, 13, 6, 're-signed_dean', 're-signed_cqa', '2025-07-12 18:22:02'),
(329, 13, 5, 're-signed_cqa', 're-signed_vc', '2025-07-12 18:22:16'),
(330, 69, 6, 'approvedbydean', 'approvedbycqa', '2025-07-12 18:23:39'),
(331, 69, 5, 'approvedbycqa', 'approvedbyvc', '2025-07-12 18:23:53'),
(332, 69, 30, 'under_review_by_BTechAssistant', 'approvedbyTA', '2025-07-12 20:04:41'),
(333, 69, 28, 'approvedbyTA', 'approvedbysecretary', '2025-07-12 20:50:56'),
(334, 69, 7, 'approvedbysecretary', 'rejectedbyqachead', '2025-07-12 20:51:25'),
(335, 69, 3, 'submitted', 'approvedbydean', '2025-07-12 20:51:54'),
(336, 69, 6, 'approvedbydean', 'approvedbycqa', '2025-07-12 20:52:06'),
(337, 69, 26, 'under_review_by_ATechAssistant', 'approvedbyTA', '2025-07-12 20:52:26'),
(338, 69, 28, 'approvedbyTA', 'approvedbysecretary', '2025-07-12 20:52:50'),
(339, 69, 7, 'approvedbysecretary', 'resignature_request_from_university', '2025-07-12 20:53:21'),
(340, 69, 3, 'resignature_request_from_university', 're-signed_dean', '2025-07-12 20:53:39'),
(341, 69, 6, 're-signed_dean', 're-signed_cqa', '2025-07-12 20:53:49'),
(342, 69, 5, 're-signed_cqa', 're-signed_vc', '2025-07-12 20:54:02'),
(343, 69, 8, 're-signed_vc', 'approvedbyugcfinance', '2025-07-12 20:57:53'),
(344, 69, 9, 're-signed_vc', 'approvedbyugchr', '2025-07-12 20:58:15'),
(345, 69, 10, 're-signed_vc', 'approvedbyugcidd', '2025-07-12 20:58:28'),
(346, 69, 13, 're-signed_vc', 'approvedbyugcadmission', '2025-07-12 20:58:54'),
(347, 69, 12, 're-signed_vc', 'approvedbyugcacademic', '2025-07-12 20:59:07'),
(348, 2, 29, 'approvedbyalldepartments', 'approvedbyStandardCommittee', '2025-07-12 22:13:32'),
(349, 6, 29, 'approvedbyalldepartments', 'rejectedbyStandardCommittee', '2025-07-12 22:13:50'),
(350, 13, 10, 're-signed_vc', 'rejectedbyugcidd', '2025-07-13 16:12:29'),
(351, 6, 3, 'submitted', 'approvedbydean', '2025-07-13 16:58:54'),
(352, 3, 3, 'submitted', 'approvedbydean', '2025-07-13 17:00:26'),
(353, 3, 6, 'approvedbydean', 'approvedbycqa', '2025-07-13 18:17:52'),
(354, 3, 5, 'approvedbycqa', 'approvedbyvc', '2025-07-13 18:18:09'),
(355, 3, 26, 'under_review_by_ATechAssistant', 'approvedbyTA', '2025-07-13 19:31:12'),
(356, 14, 3, 'submitted', 'approvedbydean', '2025-07-18 13:50:40'),
(357, 14, 6, 'approvedbydean', 'approvedbycqa', '2025-07-18 13:51:01'),
(358, 14, 5, 'approvedbycqa', 'approvedbyvc', '2025-07-18 13:51:15'),
(359, 14, 26, 'under_review_by_ATechAssistant', 'approvedbyTA', '2025-07-18 13:54:41'),
(360, 14, 26, 'under_review_by_ATechAssistant', 'approvedbyTA', '2025-07-18 14:08:26'),
(361, 14, 26, 'under_review_by_ATechAssistant', 'approvedbyTA', '2025-07-18 14:12:33'),
(362, 14, 26, 'approvedbyvc', 'approvedbyTA', '2025-07-18 14:13:37'),
(363, 14, 26, 'approvedbyvc', 'approvedbyTA', '2025-07-18 14:16:46'),
(364, 14, 26, 'under_review_by_ATechAssistant', 'approvedbyTA', '2025-07-18 14:24:16'),
(365, 14, 26, 'under_review_by_ATechAssistant', 'approvedbyTA', '2025-07-18 14:30:49'),
(366, 14, 26, 'approvedbyvc', 'approvedbyTA', '2025-07-18 14:35:02'),
(367, 14, 26, 'approvedbyvc', 'approvedbyTA', '2025-07-18 14:36:15'),
(368, 14, 26, 'approvedbyvc', 'approvedbyTA', '2025-07-18 14:38:45'),
(369, 14, 26, 'under_review_by_ATechAssistant', 'approvedbyTA', '2025-07-18 14:41:56'),
(370, 14, 26, 'under_review_by_ATechAssistant', 'approvedbyTA', '2025-07-18 14:44:18'),
(371, 14, 26, 'under_review_by_ATechAssistant', 'approvedbyTA', '2025-07-18 14:56:57'),
(372, 14, 26, 'under_review_by_ATechAssistant', 'approvedbyTA', '2025-07-18 15:02:11'),
(373, 14, 26, 'under_review_by_ATechAssistant', 'approvedbyTA', '2025-07-18 15:07:07'),
(374, 14, 26, 'under_review_by_ATechAssistant', 'approvedbyTA', '2025-07-18 15:07:40'),
(375, 14, 30, 'under_review_by_ATechAssistant', 'approvedbyTA', '2025-07-19 06:33:38'),
(376, 14, 28, 'approvedbyTA', 'approvedbysecretary', '2025-07-19 06:34:50'),
(377, 14, 7, 'approvedbysecretary', 'rejectedbyqachead', '2025-07-19 06:36:32'),
(378, 14, 3, 'submitted', 'approvedbydean', '2025-07-22 20:03:33'),
(379, 14, 6, 'approvedbydean', 'approvedbycqa', '2025-07-22 20:04:10'),
(380, 14, 26, 'under_review_by_ATechAssistant', 'approvedbyTA', '2025-07-22 21:07:58'),
(381, 14, 28, 'approvedbyTA', 'approvedbysecretary', '2025-07-22 21:09:35'),
(382, 14, 7, 'approvedbysecretary', 'resignature_request_from_university', '2025-07-22 21:10:10'),
(383, 14, 3, 'resignature_request_from_university', 're-signed_dean', '2025-07-22 21:17:58'),
(384, 14, 6, 're-signed_dean', 're-signed_cqa', '2025-07-22 21:18:21'),
(385, 14, 5, 're-signed_cqa', 're-signed_vc', '2025-07-22 21:41:53'),
(386, 14, 8, 're-signed_vc', 'approvedbyugcfinance', '2025-07-22 21:43:07'),
(387, 14, 9, 're-signed_vc', 'approvedbyugchr', '2025-07-22 21:43:24'),
(388, 14, 10, 're-signed_vc', 'approvedbyugcidd', '2025-07-22 21:43:37'),
(389, 14, 12, 're-signed_vc', 'approvedbyugcacademic', '2025-07-22 21:44:15'),
(390, 14, 13, 're-signed_vc', 'approvedbyugcadmission', '2025-07-22 21:45:24'),
(391, 14, 29, 'approvedbyalldepartments', 'rejectedbyStandardCommittee', '2025-07-22 21:53:40'),
(392, 14, 3, 'submitted', 'approvedbydean', '2025-07-25 19:16:07'),
(393, 14, 6, 'approvedbydean', 'approvedbycqa', '2025-07-25 19:16:24'),
(394, 14, 30, 'under_review_by_BTechAssistant', 'approvedbyTA', '2025-07-25 19:17:09');

-- --------------------------------------------------------

--
-- Table structure for table `proposal_summary_sheet`
--

CREATE TABLE `proposal_summary_sheet` (
  `id` int(11) NOT NULL,
  `proposal_id` int(11) NOT NULL,
  `section_identifier` varchar(255) NOT NULL,
  `compliance_status` enum('compliance','non_compliance','not_reviewed') NOT NULL DEFAULT 'not_reviewed',
  `comment` text DEFAULT NULL,
  `last_updated_by` int(11) DEFAULT NULL,
  `last_updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `proposal_summary_sheet`
--

INSERT INTO `proposal_summary_sheet` (`id`, `proposal_id`, `section_identifier`, `compliance_status`, `comment`, `last_updated_by`, `last_updated_at`) VALUES
(456, 14, 'general_information.degree_name_english', 'compliance', '', 30, '2025-07-25 19:17:09'),
(457, 14, 'general_information.degree_name_sinhala', 'compliance', 'REVISION NEED ', 30, '2025-07-25 19:17:09'),
(458, 14, 'general_information.degree_name_tamil', 'compliance', '', 30, '2025-07-25 19:17:09'),
(459, 14, 'general_information.qualification_name_english', 'compliance', '', 30, '2025-07-25 19:17:09'),
(460, 14, 'general_information.qualification_name_sinhala', 'compliance', '', 30, '2025-07-25 19:17:09'),
(461, 14, 'general_information.qualification_name_tamil', 'compliance', 'REVISION', 30, '2025-07-25 19:17:09'),
(462, 14, 'general_information.abbreviated_qualification', 'compliance', '', 30, '2025-07-25 19:17:09'),
(463, 14, 'program_entity.faculty', 'compliance', '', 30, '2025-07-25 19:17:09'),
(464, 14, 'program_entity.department', 'compliance', '', 30, '2025-07-25 19:17:09'),
(465, 14, 'program_entity.university', 'compliance', '', 30, '2025-07-25 19:17:09'),
(466, 14, 'table.mandate_availability', 'compliance', '', 30, '2025-07-25 19:17:09'),
(467, 14, 'degree_details.background_to_program', 'compliance', '', 30, '2025-07-25 19:17:09'),
(468, 14, 'degree_details.mandate_faculty', 'compliance', '', 30, '2025-07-25 19:17:09'),
(469, 14, 'degree_details.faculty_status', 'compliance', '', 30, '2025-07-25 19:17:09'),
(470, 14, 'degree_details.student_intake', 'compliance', '', 30, '2025-07-25 19:17:09'),
(471, 14, 'degree_details.staff_cadres', 'compliance', '', 30, '2025-07-25 19:17:09'),
(472, 14, 'degree_details.educational_facilities', 'compliance', '', 30, '2025-07-25 19:17:09'),
(473, 14, 'degree_details.common_facilities', 'compliance', '', 30, '2025-07-25 19:17:09'),
(474, 14, 'degree_details.program_benefits', 'compliance', '', 30, '2025-07-25 19:17:09'),
(475, 14, 'degree_details.eligibility_req', 'compliance', '', 30, '2025-07-25 19:17:09'),
(476, 14, 'degree_details.indicate_program', 'compliance', '', 30, '2025-07-25 19:17:09'),
(477, 14, 'degree_details.admission_process', 'compliance', '', 30, '2025-07-25 19:17:09'),
(478, 14, 'degree_details.other_criteria', 'compliance', '', 30, '2025-07-25 19:17:09'),
(479, 14, 'degree_details.intake', 'compliance', '', 30, '2025-07-25 19:17:09'),
(480, 14, 'degree_details.degree_type', 'compliance', '', 30, '2025-07-25 19:17:09'),
(481, 14, 'degree_details.duration', 'compliance', '', 30, '2025-07-25 19:17:09'),
(482, 14, 'degree_details.coursework_credits', 'compliance', '', 30, '2025-07-25 19:17:09'),
(483, 14, 'degree_details.thesis_credits', 'compliance', '', 30, '2025-07-25 19:17:09'),
(484, 14, 'degree_details.total_credits', 'compliance', '', 30, '2025-07-25 19:17:09'),
(485, 14, 'degree_details.medium_of_instruction', 'compliance', '', 30, '2025-07-25 19:17:09'),
(486, 14, 'degree_details.subject_benchmark', 'compliance', '', 30, '2025-07-25 19:17:09'),
(487, 14, 'degree_details.slqf_level', 'compliance', '', 30, '2025-07-25 19:17:09'),
(488, 14, 'degree_details.slqf_filled', 'compliance', '', 30, '2025-07-25 19:17:09'),
(489, 14, 'degree_details.rec_in_review_report', 'compliance', '', 30, '2025-07-25 19:17:09'),
(490, 14, 'degree_details.degree_details_objective', 'compliance', '', 30, '2025-07-25 19:17:09'),
(491, 14, 'degree_details.degree_details_justification', 'compliance', '', 30, '2025-07-25 19:17:09'),
(492, 14, 'table.program_grades', 'compliance', '', 30, '2025-07-25 19:17:09'),
(493, 14, 'table.program_structure', 'compliance', '', 30, '2025-07-25 19:17:09'),
(494, 14, 'table.program_content', 'compliance', '', 30, '2025-07-25 19:17:09'),
(495, 14, 'program_delivery_and_learner_support_system.program_delivery_description', 'compliance', '', 30, '2025-07-25 19:17:09'),
(496, 14, 'program_assessment_rules_and_precodures.formative_summative', 'compliance', '', 30, '2025-07-25 19:17:09'),
(497, 14, 'program_assessment_rules_and_precodures.grading_scheme', 'compliance', '', 30, '2025-07-25 19:17:09'),
(498, 14, 'program_assessment_rules_and_precodures.gpa_calculation', 'compliance', '', 30, '2025-07-25 19:17:09'),
(499, 14, 'program_assessment_rules_and_precodures.semester_contribution', 'compliance', '', 30, '2025-07-25 19:17:09'),
(500, 14, 'program_assessment_rules_and_precodures.inplant_training', 'compliance', '', 30, '2025-07-25 19:17:09'),
(501, 14, 'program_assessment_rules_and_precodures.repeat_exams', 'compliance', '', 30, '2025-07-25 19:17:09'),
(502, 14, 'program_assessment_rules_and_precodures.degree_requirements', 'compliance', '', 30, '2025-07-25 19:17:09'),
(503, 14, 'program_assessment_rules_and_precodures.class_requirements', 'compliance', '', 30, '2025-07-25 19:17:09'),
(504, 14, 'table.human_resources', 'compliance', '', 30, '2025-07-25 19:17:09'),
(505, 14, 'table.physical_resources', 'compliance', '', 30, '2025-07-25 19:17:09'),
(506, 14, 'table.financial_resources', 'compliance', '', 30, '2025-07-25 19:17:09'),
(507, 14, 'table.panel_of_teachers', 'compliance', '', 30, '2025-07-25 19:17:09'),
(508, 14, 'table.reviewers_report', 'compliance', '', 30, '2025-07-25 19:17:09'),
(509, 14, 'table.reviewer_details', 'compliance', '', 30, '2025-07-25 19:17:09'),
(510, 14, 'compliance_check.resources_commence', 'compliance', '', 30, '2025-07-25 19:17:09'),
(511, 14, 'compliance_check.fallback_options', 'compliance', '', 30, '2025-07-25 19:17:09'),
(512, 14, 'compliance_check.fallback_qualification', 'compliance', '', 30, '2025-07-25 19:17:09'),
(513, 14, 'compliance_check.collaboration', 'compliance', '', 30, '2025-07-25 19:17:09'),
(514, 14, 'compliance_check.collaboration_details', 'compliance', '', 30, '2025-07-25 19:17:09'),
(515, 14, 'compliance_check.access_facilities', 'compliance', '', 30, '2025-07-25 19:17:09'),
(516, 14, 'compliance_check.professional_membership', 'compliance', '', 30, '2025-07-25 19:17:09'),
(517, 14, 'compliance_check.fallback_attachment', 'compliance', '', 30, '2025-07-25 19:17:09'),
(518, 14, 'compliance_check.collaboration_attachment', 'compliance', '', 30, '2025-07-25 19:17:09'),
(519, 14, 'compliance_check.access_facilities_attachment', 'compliance', '', 30, '2025-07-25 19:17:09'),
(520, 14, 'compliance_check.membership_attachment', 'compliance', '', 30, '2025-07-25 19:17:09');

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
  `faculty_of` varchar(100) NOT NULL,
  `university` varchar(100) NOT NULL,
  `role` varchar(100) NOT NULL,
  `username` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `university_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `faculty_of`, `university`, `role`, `username`, `password`, `university_id`) VALUES
(2, 'Pro.', 'Coordinator UCSC', 'a@gmail.com', 'school of computing', 'University of Colombo', 'Program Coordinator of the university', 'pccol', '$2y$10$AZypU4KIY87Uxif4Y8e6Zu5XJPaq9NxlLMqqFCq1z/353q6Rw4mWK', 1),
(3, 'Dr.AX', 'BC', 'axbc@ucsc.ac.lk', 'school of computing', 'University of Colombo', 'Dean/Rector/Director of the university', 'deancol', '$2y$10$/OSJ8xo3mpSkepwcfPQxVumekfyo.8a1OyDPkSpJjz1MRtHG9.Er6', 1),
(5, 'Prof.A', 'S', 'weerasinghe@ucsc.ac.lk', '', 'University of Colombo', 'Vice Chancellor of the university', 'vccol', '$2y$10$AZypU4KIY87Uxif4Y8e6Zu5XJPaq9NxlLMqqFCq1z/353q6Rw4mWK', 1),
(6, 'B', 'B', 'b@ucsc.ac.lk', '', 'University of Colombo', 'CQA Director of the university', 'cqacol', '$2y$10$AZypU4KIY87Uxif4Y8e6Zu5XJPaq9NxlLMqqFCq1z/353q6Rw4mWK', 1),
(7, 'C', 'C', 'cc@qac.ugc.ac.lk', '', 'QAC-UGC', 'Head of the QAC-UGC Department', 'ugchead', '$2y$10$AZypU4KIY87Uxif4Y8e6Zu5XJPaq9NxlLMqqFCq1z/353q6Rw4mWK', 16),
(8, 'd', 'd', 'dd@qac.ugc.ac.lk', '', 'QAC-UGC', 'UGC - Finance Department', 'finance', '$2y$10$AZypU4KIY87Uxif4Y8e6Zu5XJPaq9NxlLMqqFCq1z/353q6Rw4mWK', 16),
(9, 'e', 'e', 'hr@qac.ugc.ac.lk', '', 'QAC-UGC', 'UGC - HR Department', 'hr', '$2y$10$AZypU4KIY87Uxif4Y8e6Zu5XJPaq9NxlLMqqFCq1z/353q6Rw4mWK', 16),
(10, 'i', 'dd', 'idd@qac.ugc.ac.lk', '', 'QAC-UGC', 'UGC - IDD Department', 'idd', '$2y$10$AZypU4KIY87Uxif4Y8e6Zu5XJPaq9NxlLMqqFCq1z/353q6Rw4mWK', 16),
(11, 'D', 'E', 'legal@ugc.qac.ac.lk', '', 'QAC-UGC', 'UGC - Legal Department', 'legal', '$2y$10$AZypU4KIY87Uxif4Y8e6Zu5XJPaq9NxlLMqqFCq1z/353q6Rw4mWK', 16),
(12, 'ac', 'ac', 'academic@ugc.ac.lk', '', 'QAC-UGC', 'UGC - Academic Department', 'ac', '$2y$10$AZypU4KIY87Uxif4Y8e6Zu5XJPaq9NxlLMqqFCq1z/353q6Rw4mWK', 16),
(13, 'admission', 'admission', 'admission@qac.ugc.ac.lk', '', 'QAC-UGC', 'UGC - Admission Department', 'ad', '$2y$10$AZypU4KIY87Uxif4Y8e6Zu5XJPaq9NxlLMqqFCq1z/353q6Rw4mWK', 16),
(20, 'A', 'B', 'pc@peradeniya.ac.lk', '', 'University of Peradeniya', 'Program Coordinator of the university', 'pcpera', '$2y$10$AZypU4KIY87Uxif4Y8e6Zu5XJPaq9NxlLMqqFCq1z/353q6Rw4mWK', 3),
(21, 'Dean', 'D', 'dean@peradeniya.ac.lk', 'faculty of computing', 'University of Peradeniya', 'Dean/Rector/Director of the university', 'deanpera', '$2y$10$AZypU4KIY87Uxif4Y8e6Zu5XJPaq9NxlLMqqFCq1z/353q6Rw4mWK', 3),
(22, 'CQA', 'Director', 'cqa@pera.ac.lk', '', 'University of Peradeniya', 'CQA Director of the university', 'cqapera', '$2y$10$AZypU4KIY87Uxif4Y8e6Zu5XJPaq9NxlLMqqFCq1z/353q6Rw4mWK', 3),
(23, 'VC', 'Peradeniya', 'vc@pera.ac.lk', '', 'University of Peradeniya', 'Vice Chancellor of the university', 'vcpera', '$2y$10$AZypU4KIY87Uxif4Y8e6Zu5XJPaq9NxlLMqqFCq1z/353q6Rw4mWK', 3),
(25, 'A', 'B', 'pceastern@ac.lk', '', 'Eastern University of SriLanka', 'Program Coordinator of the university', 'pceastern', '$2y$10$AZypU4KIY87Uxif4Y8e6Zu5XJPaq9NxlLMqqFCq1z/353q6Rw4mWK', 8),
(26, 'ATechAssistant', '1', 'ta1@ugc.lk', '', 'QAC-UGC', 'UGC - Technical Assistant', 'ta1', '$2y$10$5AKFEhkK26fkGDSWz5uUI.t8vXanb0Sh2ikkClPASTxNeYZrfG7Vm', 16),
(28, 'S', 'UGC', 'sugc@ugc.lk', '', 'QAC-UGC', 'UGC - Secretary', 'sec', '$2y$10$2puOnuHkyopH.p4H2wlwyuPmYCMdBKc/v4ATWxt/Qa/STCJH5N6lK', 16),
(29, 's', 'c', 'sc@ugc.lk', '', 'QAC-UGC', 'Standard Committee', 'sc', '$2y$10$MTDYoRHv9CrNardw5z.vIeynyBYh8SqRqynu0ZNCDFcEWqTGhhxPW', 16),
(30, 'BTechAssistant', '2', 'ta2@ugc.lk', '', 'QAC-UGC', 'UGC - Technical Assistant', 'ta2', '$2y$10$/gk2C3MpNdwn1joRQlvyaeh/MAEvDLhGSzofm6nE9kO78z2zL5KC.', 16),
(33, 'Dean', 'D', 'mg@uoc.lk', 'faculty of management', 'University of Colombo', 'Dean/Rector/Director of the university', 'deanmg', '$2y$10$iK7vwlLbewRv2jeurmOFG.ycVGKpzd0k1um38myJxqMYTI0fJYmR.', 1),
(34, 'dec', 'ec', 'ec@uoc.lk', 'faculty of law', 'University of Colombo', 'Dean/Rector/Director of the university', 'ec', '$2y$10$CeFOMrHl/B5ESHPZ9vm3gOcOVh0oiQ63M8wQhIZaPFLtAYCzqbtvO', 1),
(35, 'Senali', 'senu', 'senu@gmailu.com', 'faculty of management', 'University of Colombo', 'Program Coordinator of the university', 'senu', '$2y$10$/lyB6aNA1eEzPw4VsTkOmOvue5UhVrcWx63iCi6O1E1FocogoZ4FW', 1),
(36, 'rr', 'rr', 'rr@pera.lk', 'faculty of management', 'University of Peradeniya', 'Dean/Rector/Director of the university', 'rr', '$2y$10$FjdbIp2jNA8.QKjvEa3xh.wuBgCytULYaqXdncS4N77z/9AfejEky', 3);

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
-- Indexes for table `proposal_status_history`
--
ALTER TABLE `proposal_status_history`
  ADD PRIMARY KEY (`history_id`),
  ADD KEY `proposal_id` (`proposal_id`),
  ADD KEY `updated_by` (`updated_by`);

--
-- Indexes for table `proposal_summary_sheet`
--
ALTER TABLE `proposal_summary_sheet`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_review_item` (`proposal_id`,`section_identifier`),
  ADD KEY `last_updated_by` (`last_updated_by`);

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
  MODIFY `proposal_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=78;

--
-- AUTO_INCREMENT for table `proposal_assessment_rules`
--
ALTER TABLE `proposal_assessment_rules`
  MODIFY `assessment_rule_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `proposal_comments`
--
ALTER TABLE `proposal_comments`
  MODIFY `comment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=387;

--
-- AUTO_INCREMENT for table `proposal_compliance_check`
--
ALTER TABLE `proposal_compliance_check`
  MODIFY `compliance_check_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `proposal_degree_details`
--
ALTER TABLE `proposal_degree_details`
  MODIFY `degree_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `proposal_financial_resource`
--
ALTER TABLE `proposal_financial_resource`
  MODIFY `financial_resource_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `proposal_general_info`
--
ALTER TABLE `proposal_general_info`
  MODIFY `general_info_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `proposal_grades_received`
--
ALTER TABLE `proposal_grades_received`
  MODIFY `program_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=221;

--
-- AUTO_INCREMENT for table `proposal_human_resource`
--
ALTER TABLE `proposal_human_resource`
  MODIFY `human_resource_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=76;

--
-- AUTO_INCREMENT for table `proposal_mandate_availability`
--
ALTER TABLE `proposal_mandate_availability`
  MODIFY `mandate_availability_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=76;

--
-- AUTO_INCREMENT for table `proposal_panel_of_teachers`
--
ALTER TABLE `proposal_panel_of_teachers`
  MODIFY `teacher_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=471;

--
-- AUTO_INCREMENT for table `proposal_payments`
--
ALTER TABLE `proposal_payments`
  MODIFY `payment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `proposal_physical_resource`
--
ALTER TABLE `proposal_physical_resource`
  MODIFY `physical_resource_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=136;

--
-- AUTO_INCREMENT for table `proposal_program_content`
--
ALTER TABLE `proposal_program_content`
  MODIFY `content_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `proposal_program_delivery`
--
ALTER TABLE `proposal_program_delivery`
  MODIFY `program_delivery_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `proposal_program_entity`
--
ALTER TABLE `proposal_program_entity`
  MODIFY `program_entity_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `proposal_program_structure`
--
ALTER TABLE `proposal_program_structure`
  MODIFY `program_structure_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT for table `proposal_resource_requirements`
--
ALTER TABLE `proposal_resource_requirements`
  MODIFY `resource_requirement_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `proposal_reviewers_report`
--
ALTER TABLE `proposal_reviewers_report`
  MODIFY `report_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=181;

--
-- AUTO_INCREMENT for table `proposal_reviewer_details`
--
ALTER TABLE `proposal_reviewer_details`
  MODIFY `reviewer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `proposal_status_history`
--
ALTER TABLE `proposal_status_history`
  MODIFY `history_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=395;

--
-- AUTO_INCREMENT for table `proposal_summary_sheet`
--
ALTER TABLE `proposal_summary_sheet`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=521;

--
-- AUTO_INCREMENT for table `universities`
--
ALTER TABLE `universities`
  MODIFY `university_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

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
-- Constraints for table `proposal_summary_sheet`
--
ALTER TABLE `proposal_summary_sheet`
  ADD CONSTRAINT `proposal_summary_sheet_ibfk_1` FOREIGN KEY (`proposal_id`) REFERENCES `proposals` (`proposal_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `proposal_summary_sheet_ibfk_2` FOREIGN KEY (`last_updated_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `fk_uid` FOREIGN KEY (`university_id`) REFERENCES `universities` (`university_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
