-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 02, 2025 at 12:23 AM
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
(3, 1, 2, 'approvedbyalldepartments', 're-signed_vc', '2025-03-08 17:02:06', '2025-08-01 21:03:43', '2025-08-01 21:03:43', NULL, 'UG3', 'initial_proposal', NULL),
(4, 1, 2, 'fresh', 'fresh', '2025-03-08 17:44:13', '2025-07-11 19:32:42', '2025-07-11 19:32:42', NULL, 'UG4', '', NULL),
(5, 1, 2, 'fresh', 'fresh', '2025-03-08 17:44:34', '2025-07-11 19:32:42', '2025-07-11 19:32:42', NULL, 'UG5', '', NULL),
(6, 1, 2, 'approvedbydean', 'approvedbydean', '2025-03-08 17:46:41', '2025-07-13 16:58:54', '2025-07-13 16:58:54', NULL, 'UG6', 'revised_ST', NULL),
(7, 1, 2, 'approvedbyalldepartments', 're-signed_vc', '2025-03-08 18:38:45', '2025-08-01 22:09:10', '2025-08-01 22:09:10', NULL, 'UG7', 'revised_1', NULL),
(8, 1, 2, 'fresh', 'fresh', '2025-03-09 07:25:48', '2025-07-11 19:32:42', '2025-07-11 19:32:42', NULL, 'UG8', '', NULL),
(9, 1, 2, 'fresh', 'fresh', '2025-03-09 09:06:12', '2025-07-11 19:32:42', '2025-07-11 19:32:42', NULL, 'UG9', '', NULL),
(10, 1, 2, 'fresh', 'fresh', '2025-03-09 13:51:22', '2025-07-11 19:32:42', '2025-07-11 19:32:42', NULL, 'UG10', '', NULL),
(11, 1, 2, 'fresh', 'fresh', '2025-03-09 14:11:23', '2025-07-11 19:32:42', '2025-07-11 19:32:42', NULL, 'UG11', '', NULL),
(12, 1, 2, 'fresh', 'fresh', '2025-03-09 14:29:36', '2025-07-11 19:32:42', '2025-07-11 19:32:42', NULL, 'UG12', '', NULL),
(13, 1, 2, 'approvedbyalldepartments', 're-signed_vc', '2025-03-14 18:32:17', '2025-08-01 21:12:22', '2025-08-01 21:12:22', NULL, 'UG13', 'revised_1', NULL),
(14, 1, 2, 'approvedbyTA', 'approvedbyTA', '2025-03-15 07:08:06', '2025-07-25 19:17:09', '2025-07-25 19:17:09', NULL, 'UG14', 'revised_ST', NULL),
(15, 1, 2, 'fresh', 'fresh', '2025-03-15 08:39:59', '2025-07-11 19:32:42', '2025-07-11 19:32:42', NULL, 'UG15', '', NULL),
(16, 1, 2, 'approvedbyalldepartments', 'approvedbyqachead_revised', '2025-03-15 18:32:21', '2025-07-11 23:11:12', '2025-07-11 23:11:12', NULL, 'UG16', 'revised_3', NULL),
(18, 3, 20, 'approvedbyalldepartments', 're-signed_vc', '2025-03-15 19:32:13', '2025-08-01 20:04:20', '2025-08-01 20:04:20', NULL, 'UG18', 'revised_ST', NULL),
(19, 1, 2, 'approvedbyalldepartments', 'approvedbyqachead', '2025-03-16 06:15:43', '2025-07-11 20:42:26', '2025-07-11 20:42:26', NULL, 'UG19', 'revised_3', NULL),
(20, 1, 2, 'fresh', 'fresh', '2025-05-15 17:29:27', '2025-07-11 19:32:42', '2025-07-11 19:32:42', NULL, 'UG20', '', NULL),
(21, 1, 2, 'fresh', 'fresh', '2025-05-16 03:24:58', '2025-07-11 19:32:42', '2025-07-11 19:32:42', NULL, 'UG21', '', NULL),
(23, 1, 2, 'approvedbyTA', 'approvedbyTA', '2025-05-16 09:07:13', '2025-08-01 06:45:56', '2025-08-01 06:45:56', NULL, 'UG23', 'revised_1', NULL),
(49, 1, 2, 'approvedbyugcfinance', 'approvedbyqachead_revised', '2025-06-08 16:29:01', '2025-07-11 20:42:26', '2025-07-11 20:42:26', NULL, 'UG49', 'revised_2', NULL),
(50, 1, 2, 'fresh', 'fresh', '2025-06-25 18:04:47', '2025-07-11 19:32:42', '2025-07-11 19:32:42', NULL, 'UG50', '', NULL),
(51, 1, 2, 'fresh', 'fresh', '2025-06-27 06:15:23', '2025-07-11 19:32:42', '2025-07-11 19:32:42', NULL, 'UG51', '', NULL),
(52, 1, 2, 'fresh', 'fresh', '2025-06-27 06:39:13', '2025-07-11 19:32:42', '2025-07-11 19:32:42', NULL, 'UG52', '', NULL),
(53, 1, 2, 'approvedbyalldepartments', 're-signed_vc', '2025-07-09 20:17:09', '2025-07-11 20:42:26', '2025-07-11 20:42:26', NULL, 'UG53', 'revised_1', NULL),
(69, 1, 2, 'approvedbyalldepartments', 're-signed_vc', '2025-07-12 12:23:04', '2025-07-12 20:59:07', '2025-07-12 20:59:07', NULL, 'UG69', 'revised_1', 26),
(70, 1, 2, 'fresh', '', '2025-07-12 12:30:21', '2025-07-12 12:30:21', '2025-07-12 12:30:21', NULL, 'UG70', '', NULL),
(71, 1, 2, 'fresh', 'fresh', '2025-07-19 20:15:40', '2025-07-19 20:15:40', '2025-07-19 20:15:40', NULL, 'UG71', '', NULL),
(72, 1, 2, 'approvedbyalldepartments', 'approvedbyqachead', '2025-07-19 20:16:29', '2025-08-01 21:56:29', '2025-08-01 21:56:29', NULL, 'UG72', 'initial_proposal', NULL),
(73, 1, 2, 'fresh', 'fresh', '2025-07-19 20:43:46', '2025-07-19 20:43:46', '2025-07-19 20:43:46', NULL, 'UG73', '', NULL),
(74, 1, 2, 'fresh', 'fresh', '2025-07-19 20:55:43', '2025-07-19 20:55:43', '2025-07-19 20:55:43', NULL, 'UG74', '', NULL),
(75, 1, 2, 'approvedbyalldepartments', 'approvedbyqachead_revised', '2025-07-19 20:57:01', '2025-08-01 20:13:58', '2025-08-01 20:13:58', NULL, 'UG75', 'revised_ST', NULL),
(76, 1, 2, 'fresh', 'fresh', '2025-07-19 22:26:37', '2025-07-19 22:26:37', '2025-07-19 22:26:37', NULL, 'UG76', '', NULL),
(77, 1, 2, 'fresh', 'fresh', '2025-07-19 23:40:43', '2025-07-19 23:40:43', '2025-07-19 23:40:43', NULL, 'UG77', '', NULL),
(78, 3, 20, 'approvedbyStandardCommittee', 'approvedbyStandardCommittee', '2025-07-30 15:13:52', '2025-07-30 15:32:49', '2025-07-30 15:32:49', NULL, 'UG78', 'initial_proposal', NULL),
(79, 1, 2, 'approvedbydean', 'approvedbydean', '2025-07-31 19:07:33', '2025-08-01 18:22:16', '2025-08-01 18:22:16', NULL, 'UG79', 'revised_4', NULL),
(80, 3, 20, 'submitted', 'submitted', '2025-08-01 21:44:53', '2025-08-01 21:48:11', '2025-08-01 18:18:11', NULL, 'UG80', 'initial_proposal', NULL);

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
(23, 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 15),
(78, 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 16),
(75, 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 17),
(79, 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 18),
(72, 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 19),
(80, 'ewdwe', 'dw', 'edw', 'wed', 'wed', 'wed', 'ewd', 'wed', 20);

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
  `Time` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `proposal_comments`
--

INSERT INTO `proposal_comments` (`comment_id`, `proposal_id`, `comment`, `seal_and_sign`, `proposal_status`, `id`, `Date`, `Time`) VALUES
(1, 1, 'Reviewer Details wrong.', NULL, 'rejectedbydean', 3, '2025-03-08', '2025-08-02 00:00:00'),
(2, 1, 'Lot of Reviewer Details.', NULL, 'rejectedbydean', 3, '2025-03-08', '2025-08-02 00:00:00'),
(3, 1, 'Cooperate evidence file type should be pdf.', NULL, 'rejectedbydean', 3, '2025-03-08', '2025-08-02 00:00:00'),
(4, 1, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1741444025_action.pdf', 'approvedbydean', 3, '2025-03-08', '2025-08-02 00:00:00'),
(5, 1, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1741444096_action.pdf', 'approvedbyvc', 5, '2025-03-08', '2025-08-02 00:00:00'),
(6, 1, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1741444162_action.pdf', 'approvedbycqa', 6, '2025-03-08', '2025-08-02 00:00:00'),
(7, 1, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1741444237_action.pdf', 'approvedbyqachead', 7, '2025-03-08', '2025-08-02 00:00:00'),
(8, 1, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1741444359_action.pdf', 'approvedbyugcfinance', 8, '2025-03-08', '2025-08-02 00:00:00'),
(9, 1, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1741444396_action.pdf', 'approvedbyugchr', 9, '2025-03-08', '2025-08-02 00:00:00'),
(10, 1, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1741444424_action.pdf', 'approvedbyugcidd', 10, '2025-03-08', '2025-08-02 00:00:00'),
(12, 1, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1741444515_action.pdf', 'approvedbyugcadmission', 13, '2025-03-08', '2025-08-02 00:00:00'),
(13, 1, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1741444544_action.pdf', 'approvedbyugcacademic', 12, '2025-03-08', '2025-08-02 00:00:00'),
(25, 3, 'Approved.', NULL, '', 3, '2025-03-09', '2025-08-02 00:00:00'),
(26, 3, '', NULL, '', 3, '2025-03-09', '2025-08-02 00:00:00'),
(27, 3, 'Approved.', NULL, '', 3, '2025-03-09', '2025-08-02 00:00:00'),
(28, 3, 'Approved.', NULL, '', 3, '2025-03-09', '2025-08-02 00:00:00'),
(29, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1741461607_action.pdf', 'approvedbydean', 3, '2025-03-09', '2025-08-02 00:00:00'),
(30, 3, 'Degree name wrong.', NULL, 'rejectedbyvc', 5, '2025-03-09', '2025-08-02 00:00:00'),
(31, 3, 'Rejected. Check Mandate availability file uploads.', NULL, 'rejectedbydean', 3, '2025-03-09', '2025-08-02 00:00:00'),
(32, 3, 'Rejected.', NULL, 'rejectedbydean', 3, '2025-03-09', '2025-08-02 00:00:00'),
(33, 6, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1741514462_action.pdf', 'approvedbydean', 3, '2025-03-09', '2025-08-02 00:00:00'),
(34, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742020550_1738158952_dummy.pdf', 'approvedbydean', 3, '2025-03-15', '2025-08-02 00:00:00'),
(35, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742020589_1739894675_action.pdf', 'approvedbyvc', 5, '2025-03-15', '2025-08-02 00:00:00'),
(36, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742020645_1739894675_action.pdf', 'approvedbycqa', 6, '2025-03-15', '2025-08-02 00:00:00'),
(37, 3, 'Rejected.', NULL, 'rejectedbyqachead', 7, '2025-03-15', '2025-08-02 00:00:00'),
(38, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742020774_1739894675_action.pdf', 'approvedbydean', 3, '2025-03-15', '2025-08-02 00:00:00'),
(39, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742020808_1739894675_action.pdf', 'approvedbyvc', 5, '2025-03-15', '2025-08-02 00:00:00'),
(40, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742020834_1739894675_action.pdf', 'approvedbycqa', 6, '2025-03-15', '2025-08-02 00:00:00'),
(41, 3, 'Rejected', NULL, 'rejectedbyqachead', 7, '2025-03-15', '2025-08-02 00:00:00'),
(42, 3, 'Approved', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742020911_1739894675_action.pdf', 'approvedbydean', 3, '2025-03-15', '2025-08-02 00:00:00'),
(43, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742020944_1739894675_action.pdf', 'approvedbyvc', 5, '2025-03-15', '2025-08-02 00:00:00'),
(44, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742020974_1739894675_action.pdf', 'approvedbycqa', 6, '2025-03-15', '2025-08-02 00:00:00'),
(45, 3, '', NULL, 'rejectedbyqachead', 7, '2025-03-15', '2025-08-02 00:00:00'),
(46, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742021076_1739894675_action.pdf', 'approvedbydean', 3, '2025-03-15', '2025-08-02 00:00:00'),
(47, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742021105_1739894675_action.pdf', 'approvedbyvc', 5, '2025-03-15', '2025-08-02 00:00:00'),
(48, 3, 'Approved', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742021131_1739894675_action.pdf', 'approvedbycqa', 6, '2025-03-15', '2025-08-02 00:00:00'),
(49, 3, 'Rejected', NULL, 'rejectedbyqachead', 7, '2025-03-15', '2025-08-02 00:00:00'),
(50, 7, 'Approved', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742028101_1739894675_action.pdf', 'approvedbydean', 3, '2025-03-15', '2025-08-02 00:00:00'),
(51, 7, 'Approved', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742028219_1739894675_action.pdf', 'approvedbyvc', 5, '2025-03-15', '2025-08-02 00:00:00'),
(52, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742050546_1739894675_action.pdf', 'approvedbydean', 3, '2025-03-15', '2025-08-02 00:00:00'),
(53, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742050715_1739894675_action.pdf', 'approvedbydean', 3, '2025-03-15', '2025-08-02 00:00:00'),
(54, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742050733_1739894675_action.pdf', 'approvedbydean', 3, '2025-03-15', '2025-08-02 00:00:00'),
(55, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742050746_1739894675_action.pdf', 'rejectedbydean', 3, '2025-03-15', '2025-08-02 00:00:00'),
(56, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742050984_1739894675_action.pdf', 'approvedbydean', 3, '2025-03-15', '2025-08-02 00:00:00'),
(57, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742051008_1739894675_action.pdf', 'approvedbycqa', 6, '2025-03-15', '2025-08-02 00:00:00'),
(58, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742051029_1739894675_action.pdf', 'approvedbyvc', 5, '2025-03-15', '2025-08-02 00:00:00'),
(59, 6, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742051138_1739894675_action.pdf', 'approvedbycqa', 6, '2025-03-15', '2025-08-02 00:00:00'),
(60, 3, '', NULL, 'rejectedbyqachead', 7, '2025-03-15', '2025-08-02 00:00:00'),
(61, 3, 'Rejected.', NULL, 'rejectedbyqachead', 7, '2025-03-15', '2025-08-02 00:00:00'),
(62, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742051507_1739894675_action.pdf', 'approvedbydean', 3, '2025-03-15', '2025-08-02 00:00:00'),
(63, 3, 'REJECTED', NULL, 'rejectedbycqa', 6, '2025-03-15', '2025-08-02 00:00:00'),
(64, 3, 'Approved.', NULL, '', 3, '2025-03-15', '2025-08-02 00:00:00'),
(65, 3, 'Approved.', NULL, '', 3, '2025-03-15', '2025-08-02 00:00:00'),
(66, 3, 'Approved.', NULL, '', 3, '2025-03-15', '2025-08-02 00:00:00'),
(67, 3, 'A', NULL, '', 3, '2025-03-15', '2025-08-02 00:00:00'),
(68, 3, 'A', NULL, '', 3, '2025-03-15', '2025-08-02 00:00:00'),
(69, 3, 'Rejected.', NULL, 'rejectedbydean', 3, '2025-03-15', '2025-08-02 00:00:00'),
(70, 3, 'Rejected.', NULL, 'rejectedbydean', 3, '2025-03-15', '2025-08-02 00:00:00'),
(71, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742052970_1739894675_action.pdf', 'approvedbydean', 3, '2025-03-15', '2025-08-02 00:00:00'),
(72, 3, 'Approved.', NULL, '', 6, '2025-03-15', '2025-08-02 00:00:00'),
(73, 3, 'Approved.', NULL, '', 6, '2025-03-15', '2025-08-02 00:00:00'),
(74, 3, 'Approved.', NULL, '', 6, '2025-03-15', '2025-08-02 00:00:00'),
(75, 3, 'Rejected.', NULL, 'rejectedbycqa', 6, '2025-03-15', '2025-08-02 00:00:00'),
(76, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742054852_1739894675_action.pdf', 'approvedbydean', 3, '2025-03-15', '2025-08-02 00:00:00'),
(77, 2, 'Approved.', NULL, '', 7, '2025-03-15', '2025-08-02 00:00:00'),
(78, 2, 'Rejected.', NULL, 'rejectedbyqachead', 7, '2025-03-15', '2025-08-02 00:00:00'),
(79, 3, 'Approved.', NULL, '', 7, '2025-03-15', '2025-08-02 00:00:00'),
(80, 3, 'Rejected.', NULL, 'rejectedbyqachead', 7, '2025-03-15', '2025-08-02 00:00:00'),
(81, 3, 'Approved.', NULL, '', 7, '2025-03-15', '2025-08-02 00:00:00'),
(82, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742055767_1739894675_action.pdf', 'approvedbyqachead', 7, '2025-03-15', '2025-08-02 00:00:00'),
(83, 3, 'Rejected.', NULL, 'rejectedbyqachead', 7, '2025-03-15', '2025-08-02 00:00:00'),
(84, 3, 'Approved.', NULL, '', 3, '2025-03-15', '2025-08-02 00:00:00'),
(85, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742055875_1739894675_action.pdf', 'approvedbydean', 3, '2025-03-15', '2025-08-02 00:00:00'),
(86, 6, 'Rejected.', NULL, 'rejectedbyvc', 5, '2025-03-15', '2025-08-02 00:00:00'),
(87, 3, 'Approved.', NULL, '', 6, '2025-03-15', '2025-08-02 00:00:00'),
(88, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742055963_1739894675_action.pdf', 'approvedbycqa', 6, '2025-03-15', '2025-08-02 00:00:00'),
(89, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742055990_1739894675_action.pdf', 'approvedbyvc', 5, '2025-03-15', '2025-08-02 00:00:00'),
(90, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742056008_1739894675_action.pdf', 'approvedbyqachead', 7, '2025-03-15', '2025-08-02 00:00:00'),
(91, 3, 'Approved.', NULL, '', 8, '2025-03-15', '2025-08-02 00:00:00'),
(92, 3, 'Rejected.', NULL, 'rejectedbyugcfinance', 8, '2025-03-15', '2025-08-02 00:00:00'),
(93, 13, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742065107_1739894675_action.pdf', 'approvedbydean', 3, '2025-03-16', '2025-08-02 00:00:00'),
(94, 13, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742065138_1739894675_action.pdf', 'approvedbycqa', 6, '2025-03-16', '2025-08-02 00:00:00'),
(95, 13, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742065177_1739894675_action.pdf', 'approvedbyvc', 5, '2025-03-16', '2025-08-02 00:00:00'),
(96, 13, 'Rejected', NULL, 'rejectedbyqachead', 7, '2025-03-16', '2025-08-02 00:00:00'),
(97, 16, '', NULL, 'rejectedbydean', 3, '2025-03-16', '2025-08-02 00:00:00'),
(98, 16, '', NULL, 'rejectedbydean', 3, '2025-03-16', '2025-08-02 00:00:00'),
(99, 16, '', NULL, 'rejectedbydean', 3, '2025-03-16', '2025-08-02 00:00:00'),
(100, 16, '', NULL, 'rejectedbydean', 3, '2025-03-16', '2025-08-02 00:00:00'),
(101, 7, 'Approved', 'http://localhost/qac_ugc/Proposal_sections/uploads/1742106736_Application_Summary - 2025-03-16T010522.989.pdf', 'approvedbyqachead', 7, '2025-03-16', '2025-08-02 00:00:00'),
(102, 3, 'Approved_M', 'http://localhost/qac_ugc/Proposal_sections/uploads/1743622196_Application_Summary - 2025-03-16T115318.196.pdf', 'approvedbydean', 3, '2025-04-03', '2025-08-02 00:00:00'),
(103, 3, 'A', NULL, 'rejectedbydean', 3, '2025-05-15', '2025-08-02 00:00:00'),
(104, 13, '', NULL, 'rejectedbydean', 3, '2025-05-16', '2025-08-02 00:00:00'),
(105, 13, 'Approved.', NULL, '', 3, '2025-05-16', '2025-08-02 00:00:00'),
(106, 13, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1747366738_1738158952_dummy.pdf', 'approvedbydean', 3, '2025-05-16', '2025-08-02 00:00:00'),
(107, 13, 'aa', NULL, 'rejectedbycqa', 6, '2025-05-16', '2025-08-02 00:00:00'),
(108, 6, 'Approved', 'http://localhost/qac_ugc/Proposal_sections/uploads/1749405580_1748196112_1739894675_council.pdf', 'approvedbydean', 3, '2025-06-08', '2025-08-02 00:00:00'),
(109, 6, 'Approved', 'http://localhost/qac_ugc/Proposal_sections/uploads/1749405618_1748196031_1739720192_benchmark.pdf', 'approvedbycqa', 6, '2025-06-08', '2025-08-02 00:00:00'),
(110, 6, 'Approved', 'http://localhost/qac_ugc/Proposal_sections/uploads/1749405637_1748196031_1739720192_benchmark.pdf', 'approvedbyvc', 5, '2025-06-08', '2025-08-02 00:00:00'),
(111, 16, '', NULL, 'rejectedbydean', 3, '2025-06-18', '2025-08-02 00:00:00'),
(112, 16, '', NULL, 'rejectedbydean', 3, '2025-06-18', '2025-08-02 00:00:00'),
(113, 16, '', NULL, 'rejectedbydean', 3, '2025-06-18', '2025-08-02 00:00:00'),
(114, 16, '', NULL, 'rejectedbydean', 3, '2025-06-18', '2025-08-02 00:00:00'),
(115, 16, '', NULL, 'rejectedbydean', 3, '2025-06-18', '2025-08-02 00:00:00'),
(116, 16, '', NULL, 'rejectedbydean', 3, '2025-06-18', '2025-08-02 00:00:00'),
(117, 16, '', NULL, 'rejectedbydean', 3, '2025-06-18', '2025-08-02 00:00:00'),
(118, 16, '', NULL, 'approvedbydean', 3, '2025-06-18', '2025-08-02 00:00:00'),
(119, 16, '', NULL, 'approvedbycqa', 6, '2025-06-18', '2025-08-02 00:00:00'),
(120, 16, '', NULL, 'approvedbycqa', 6, '2025-06-18', '2025-08-02 00:00:00'),
(121, 16, 'Approved.A', '', 'approvedbycqa', 6, '2025-06-18', '2025-08-02 00:00:00'),
(122, 16, 'Approved.', '', 'approvedbyvc', 5, '2025-06-18', '2025-08-02 00:00:00'),
(123, 16, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1750188891_1739894675_action.pdf', 'approvedbyvc', 5, '2025-06-18', '2025-08-02 00:00:00'),
(124, 16, 'Rejected.', NULL, 'rejectedbyqachead', 7, '2025-06-18', '2025-08-02 00:00:00'),
(125, 16, '', NULL, '', 3, '2025-06-26', '2025-08-02 00:00:00'),
(126, 16, '', NULL, '', 3, '2025-06-26', '2025-08-02 00:00:00'),
(127, 3, 'Approved.', NULL, '', 3, '2025-06-26', '2025-08-02 00:00:00'),
(128, 16, 'Approved.', NULL, 'approvedbydean', 3, '2025-06-27', '2025-08-02 00:00:00'),
(129, 16, 'Approved.', NULL, 'approvedbycqa', 6, '2025-06-27', '2025-08-02 00:00:00'),
(130, 16, 'REJECTED_TEST_DEAN_REJECT', NULL, 'rejectedbyvc', 5, '2025-06-27', '2025-08-02 00:00:00'),
(131, 3, 'Approved.', NULL, 'approvedbydean', 3, '2025-06-27', '2025-08-02 00:00:00'),
(132, 3, 'Approved.', NULL, 'approvedbycqa', 6, '2025-06-27', '2025-08-02 00:00:00'),
(133, 3, 'Approved.', NULL, 'approvedbyvc', 5, '2025-06-27', '2025-08-02 00:00:00'),
(134, 3, 'Approved.', NULL, 'rejectedbyvc', 5, '2025-06-27', '2025-08-02 00:00:00'),
(135, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1750964529_1748196031_1739720192_benchmark.pdf', 'approvedbyvc', 5, '2025-06-27', '2025-08-02 00:00:00'),
(136, 3, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/1750965013_1748196031_1739720192_benchmark.pdf', 'approvedbyvc', 5, '2025-06-27', '2025-08-02 00:00:00'),
(137, 3, 'App', 'http://localhost/qac_ugc/Proposal_sections/uploads/1750965150_1748196031_1739720192_benchmark.pdf', 'approvedbyvc', 5, '2025-06-27', '2025-08-02 00:00:00'),
(138, 3, 'Approved_New', 'http://localhost/qac_ugc/Proposal_sections/uploads/1750965205_1748196031_1739720192_benchmark.pdf', 'approvedbyqachead', 7, '2025-06-27', '2025-08-02 00:00:00'),
(139, 2, 'Approved.', NULL, '', 3, '2025-06-28', '2025-08-02 00:00:00'),
(140, 2, 'Approved.', NULL, '', 6, '2025-06-28', '2025-08-02 00:00:00'),
(141, 2, 'Recommended.', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751134143.png', 'approvedbydean', 3, '2025-06-28', '2025-08-02 00:00:00'),
(147, 2, 'Recommended.', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751135512.png', 'approvedbydean', 3, '2025-06-29', '2025-08-02 00:00:00'),
(148, 2, 'A', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751135625.png', 'approvedbydean', 3, '2025-06-29', '2025-08-02 00:00:00'),
(149, 2, 'A', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751135658.png', 'approvedbydean', 3, '2025-06-29', '2025-08-02 00:00:00'),
(150, 2, 'A_TEST_ALERT.', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751136057.png', 'approvedbydean', 3, '2025-06-29', '2025-08-02 00:00:00'),
(151, 2, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751136497.png', 'rejectedbycqa', 6, '2025-06-29', '2025-08-02 00:00:00'),
(152, 2, 'REJECT_CHECK_3', NULL, 'rejectedbydean', 3, '2025-06-29', '2025-08-02 00:00:00'),
(153, 2, 'A', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751137142.png', 'approvedbydean', 3, '2025-06-29', '2025-08-02 00:00:00'),
(154, 2, 'CQA_DIRECTOR', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751137267.png', 'approvedbycqa', 6, '2025-06-29', '2025-08-02 00:00:00'),
(155, 2, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751137350.png', 'rejectedbyvc', 5, '2025-06-29', '2025-08-02 00:00:00'),
(156, 2, 'DEAN_1_TEST', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751137414.png', 'approvedbydean', 3, '2025-06-29', '2025-08-02 00:00:00'),
(157, 2, 'E', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751137477.png', 'approvedbycqa', 6, '2025-06-29', '2025-08-02 00:00:00'),
(158, 2, 'VC_TEST_1', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751137502.png', 'approvedbyvc', 5, '2025-06-29', '2025-08-02 00:00:00'),
(159, 2, '', NULL, 'rejectedbydean', 3, '2025-06-29', '2025-08-02 00:00:00'),
(160, 2, 'AQ', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751140750.png', 'approvedbydean', 3, '2025-06-29', '2025-08-02 00:00:00'),
(161, 2, 'CHECK_NAME_DATE_WITH-SIGN', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751141312.png', 'approvedbycqa', 6, '2025-06-29', '2025-08-02 00:00:00'),
(162, 2, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751141899.png', 'approvedbyvc', 5, '2025-06-29', '2025-08-02 00:00:00'),
(163, 6, '', NULL, 'rejectedbyqachead', 7, '2025-06-30', '2025-08-02 00:00:00'),
(165, 3, '', NULL, 'rejectedbycqa', 6, '2025-06-30', '2025-08-02 00:00:00'),
(167, 2, 'TEST_REJECT_AFTER_TA', NULL, 'rejectedbydean', 3, '2025-06-30', '2025-08-02 00:00:00'),
(168, 3, '', NULL, 'rejectedbyTA', 26, '2025-06-30', '2025-08-02 00:00:00'),
(169, 3, '', NULL, 'rejectedbyTA', 26, '2025-06-30', '2025-08-02 00:00:00'),
(170, 3, '', NULL, 'rejectedbyTA', 26, '2025-06-30', '2025-08-02 00:00:00'),
(171, 3, '', NULL, 'rejectedbyTA', 26, '2025-06-30', '2025-08-02 00:00:00'),
(172, 3, '', NULL, 'rejectedbyTA', 26, '2025-06-30', '2025-08-02 00:00:00'),
(173, 3, '', NULL, 'rejectedbyTA', 30, '2025-06-30', '2025-08-02 00:00:00'),
(174, 19, '', NULL, 'rejectedbydean', 3, '2025-07-06', '2025-08-02 00:00:00'),
(175, 19, 'Approved. (A)', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751825474.png', 'approvedbydean', 3, '2025-07-06', '2025-08-02 00:00:00'),
(176, 19, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751825508.png', 'approvedbycqa', 6, '2025-07-06', '2025-08-02 00:00:00'),
(177, 19, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751825581.png', 'approvedbyvc', 5, '2025-07-06', '2025-08-02 00:00:00'),
(178, 19, 'REJECTED_TYPE_CHECK', NULL, 'rejectedbyTA', 26, '2025-07-06', '2025-08-02 00:00:00'),
(179, 19, 'A2', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751825928.png', 'approvedbydean', 3, '2025-07-06', '2025-08-02 00:00:00'),
(180, 19, 'A2', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751825952.png', 'approvedbycqa', 6, '2025-07-06', '2025-08-02 00:00:00'),
(181, 19, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751825973.png', 'approvedbyvc', 5, '2025-07-06', '2025-08-02 00:00:00'),
(182, 19, '', NULL, 'rejectedbyTA', 26, '2025-07-06', '2025-08-02 00:00:00'),
(183, 19, '', NULL, 'rejectedbyqachead', 7, '2025-07-07', '2025-08-02 00:00:00'),
(184, 19, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751826818.png', 'approvedbydean', 3, '2025-07-07', '2025-08-02 00:00:00'),
(185, 19, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751826871.png', 'approvedbycqa', 6, '2025-07-07', '2025-08-02 00:00:00'),
(186, 19, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751826886.png', 'approvedbyvc', 5, '2025-07-07', '2025-08-02 00:00:00'),
(187, 19, '', NULL, 'rejectedbyTA', 26, '2025-07-07', '2025-08-02 00:00:00'),
(188, 19, 'Ap', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751827893.png', 'approvedbyqachead', 7, '2025-07-07', '2025-08-02 00:00:00'),
(189, 13, '', NULL, 'rejectedbydean', 3, '2025-07-07', '2025-08-02 00:00:00'),
(190, 2, 'A', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751909597.png', 'approvedbyTA', 30, '2025-07-07', '2025-08-02 00:00:00'),
(191, 2, 'APPROVED_BY_TA2', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751909949.png', 'approvedbyTA', 30, '2025-07-07', '2025-08-02 00:00:00'),
(192, 2, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751910283.png', 'approvedbysecretary', 28, '2025-07-07', '2025-08-02 00:00:00'),
(193, 2, 'Approved.', NULL, '', 7, '2025-07-08', '2025-08-02 00:00:00'),
(194, 2, 'Approved.', NULL, '', 7, '2025-07-08', '2025-08-02 00:00:00'),
(195, 2, 'A', NULL, '', 7, '2025-07-08', '2025-08-02 00:00:00'),
(196, 2, 'A', NULL, '', 7, '2025-07-08', '2025-08-02 00:00:00'),
(197, 2, 'A', NULL, '', 7, '2025-07-08', '2025-08-02 00:00:00'),
(198, 2, 'R', NULL, '', 7, '2025-07-08', '2025-08-02 00:00:00'),
(199, 2, 'A', NULL, '', 7, '2025-07-08', '2025-08-02 00:00:00'),
(200, 2, 'A', NULL, '', 7, '2025-07-08', '2025-08-02 00:00:00'),
(201, 2, 'R', NULL, '', 7, '2025-07-08', '2025-08-02 00:00:00'),
(202, 2, 'R', NULL, '', 7, '2025-07-08', '2025-08-02 00:00:00'),
(203, 2, 'R', NULL, '', 7, '2025-07-08', '2025-08-02 00:00:00'),
(204, 2, 'R', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751915830.png', '', 7, '2025-07-08', '2025-08-02 00:00:00'),
(205, 2, 'R', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751915951.png', '', 7, '2025-07-08', '2025-08-02 00:00:00'),
(206, 2, 'RE_1', NULL, 'rejectedbyqachead', 7, '2025-07-08', '2025-08-02 00:00:00'),
(207, 2, 'Ap', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751916603.png', 'approvedbyqachead', 7, '2025-07-08', '2025-08-02 00:00:00'),
(208, 2, 'RE_2', NULL, 'rejectedbyqachead', 7, '2025-07-08', '2025-08-02 00:00:00'),
(209, 2, 'RE_TEST', NULL, 'rejectedbyqachead', 7, '2025-07-08', '2025-08-02 00:00:00'),
(210, 49, '', NULL, 'rejectedbydean', 3, '2025-07-08', '2025-08-02 00:00:00'),
(211, 49, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751918261.png', 'approvedbydean', 3, '2025-07-08', '2025-08-02 00:00:00'),
(212, 49, 'A', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751918289.png', 'approvedbycqa', 6, '2025-07-08', '2025-08-02 00:00:00'),
(213, 49, 'A', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751918307.png', 'approvedbyvc', 5, '2025-07-08', '2025-08-02 00:00:00'),
(214, 49, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751918383.png', 'approvedbyTA', 26, '2025-07-08', '2025-08-02 00:00:00'),
(215, 49, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751918414.png', 'approvedbysecretary', 28, '2025-07-08', '2025-08-02 00:00:00'),
(216, 49, 'Panel_of teachers duplicate....\r\n\r\nProgram_structure module_status missing.', NULL, 'rejectedbyqachead', 7, '2025-07-08', '2025-08-02 00:00:00'),
(217, 49, '2A', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751920178.png', 'approvedbydean', 3, '2025-07-08', '2025-08-02 00:00:00'),
(218, 49, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751920232.png', 'approvedbycqa', 6, '2025-07-08', '2025-08-02 00:00:00'),
(219, 49, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751920244.png', 'approvedbyvc', 5, '2025-07-08', '2025-08-02 00:00:00'),
(220, 49, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751920262.png', 'approvedbyTA', 26, '2025-07-08', '2025-08-02 00:00:00'),
(221, 49, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751920281.png', 'approvedbysecretary', 28, '2025-07-08', '2025-08-02 00:00:00'),
(222, 49, '', NULL, 'rejectedbyqachead', 7, '2025-07-08', '2025-08-02 00:00:00'),
(223, 49, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751920524.png', 'approvedbydean', 3, '2025-07-08', '2025-08-02 00:00:00'),
(224, 49, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751920537.png', 'approvedbycqa', 6, '2025-07-08', '2025-08-02 00:00:00'),
(225, 49, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751920550.png', 'approvedbyvc', 5, '2025-07-08', '2025-08-02 00:00:00'),
(226, 49, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751920562.png', 'approvedbyTA', 26, '2025-07-08', '2025-08-02 00:00:00'),
(227, 49, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751920579.png', 'approvedbysecretary', 28, '2025-07-08', '2025-08-02 00:00:00'),
(228, 49, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1751920652.png', 'approvedbyqachead_revised', 7, '2025-07-08', '2025-08-02 00:00:00'),
(229, 13, '', NULL, 'rejectedbydean', 3, '2025-07-08', '2025-08-02 00:00:00'),
(230, 13, '', NULL, 'rejectedbydean', 3, '2025-07-09', '2025-08-02 00:00:00'),
(231, 13, '', NULL, 'rejectedbydean', 3, '2025-07-09', '2025-08-02 00:00:00'),
(232, 13, '', NULL, 'rejectedbydean', 3, '2025-07-09', '2025-08-02 00:00:00'),
(233, 13, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1752011740.png', 'approvedbydean', 3, '2025-07-09', '2025-08-02 00:00:00'),
(234, 13, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1752011768.png', 'approvedbycqa', 6, '2025-07-09', '2025-08-02 00:00:00'),
(235, 13, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1752013115.png', 'approvedbyTA', 26, '2025-07-09', '2025-08-02 00:00:00'),
(236, 13, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1752013137.png', 'approvedbysecretary', 28, '2025-07-09', '2025-08-02 00:00:00'),
(237, 13, '', NULL, 'approvedbyqachead', 7, '2025-07-09', '2025-08-02 00:00:00'),
(238, 13, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1752085723.png', 'resignature_request_from_university', 7, '2025-07-09', '2025-08-02 00:00:00'),
(239, 13, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1752085855.png', 'approvedbydean', 3, '2025-07-10', '2025-08-02 00:00:00'),
(240, 13, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1752085877.png', 'approvedbycqa', 6, '2025-07-10', '2025-08-02 00:00:00'),
(241, 13, 'Approved.', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1752089562.png', 'resignature_request_from_university', 7, '2025-07-10', '2025-08-02 00:00:00'),
(242, 13, 'Signed.', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1752089591.png', 're-signed_dean', 3, '2025-07-10', '2025-08-02 00:00:00'),
(243, 13, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1752089853.png', 're-signed_cqa', 6, '2025-07-10', '2025-08-02 00:00:00'),
(244, 13, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1752089961.png', 're-signed_cqa', 6, '2025-07-10', '2025-08-02 00:00:00'),
(245, 13, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1752090390.png', 're-signed_vc', 5, '2025-07-10', '2025-08-02 00:00:00'),
(246, 49, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1752091908.png', 'approvedbyugcfinance', 8, '2025-07-10', '2025-08-02 00:00:00'),
(247, 53, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1752096344.png', 'approvedbydean', 3, '2025-07-10', '2025-08-02 00:00:00'),
(248, 53, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1752096370.png', 'approvedbycqa', 6, '2025-07-10', '2025-08-02 00:00:00'),
(249, 53, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1752096380.png', 'approvedbyvc', 5, '2025-07-10', '2025-08-02 00:00:00'),
(250, 53, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1752096393.png', 'approvedbyTA', 26, '2025-07-10', '2025-08-02 00:00:00'),
(251, 53, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1752096410.png', 'approvedbysecretary', 28, '2025-07-10', '2025-08-02 00:00:00'),
(252, 53, '', NULL, 'rejectedbyqachead', 7, '2025-07-10', '2025-08-02 00:00:00'),
(253, 53, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1752096514.png', 'approvedbydean', 3, '2025-07-10', '2025-08-02 00:00:00'),
(254, 53, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1752096532.png', 'approvedbycqa', 6, '2025-07-10', '2025-08-02 00:00:00'),
(255, 53, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1752097155.png', 'approvedbyTA', 26, '2025-07-10', '2025-08-02 00:00:00'),
(256, 53, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1752097183.png', 'approvedbysecretary', 28, '2025-07-10', '2025-08-02 00:00:00'),
(257, 53, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1752097204.png', 'approvedbyqachead_revised', 7, '2025-07-10', '2025-08-02 00:00:00'),
(258, 53, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1752097283.png', 'resignature_request_from_university', 7, '2025-07-10', '2025-08-02 00:00:00'),
(259, 53, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1752097301.png', 're-signed_dean', 3, '2025-07-10', '2025-08-02 00:00:00'),
(260, 53, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1752097336.png', 're-signed_cqa', 6, '2025-07-10', '2025-08-02 00:00:00'),
(261, 53, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1752097347.png', 're-signed_vc', 5, '2025-07-10', '2025-08-02 00:00:00'),
(262, 13, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1752170212.png', 'approvedbyugcfinance', 8, '2025-07-10', '2025-08-01 00:00:00'),
(263, 13, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1752179119.png', 'approvedbyugchr', 9, '2025-07-11', '2025-08-02 00:00:00'),
(264, 13, 'Approved', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_1752180717.png', '', 10, '2025-07-11', '2025-08-02 00:00:00'),
(265, 19, 'APPROVED-TEST', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_8_1752183921.png', 'approvedbyugcfinance', 8, '2025-07-11', '2025-08-02 00:00:00'),
(266, 19, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_9_1752183970.png', 'approvedbyugchr', 9, '2025-07-11', '2025-08-02 00:00:00'),
(267, 19, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_10_1752183995.png', 'approvedbyugcidd', 10, '2025-07-11', '2025-08-02 00:00:00'),
(268, 19, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_13_1752184013.png', 'approvedbyugcadmission', 13, '2025-07-11', '2025-08-02 00:00:00'),
(269, 19, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_12_1752184026.png', 'approvedbyugcacademic', 12, '2025-07-11', '2025-08-02 00:00:00'),
(270, 2, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_3_1752184824.png', 'approvedbydean', 3, '2025-07-11', '2025-08-02 00:00:00'),
(271, 2, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_6_1752184895.png', 'approvedbycqa', 6, '2025-07-11', '2025-08-02 00:00:00'),
(272, 2, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_26_1752188165.png', 'approvedbyTA', 26, '2025-07-11', '2025-08-02 00:00:00'),
(273, 2, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_28_1752188233.png', 'approvedbysecretary', 28, '2025-07-11', '2025-08-02 00:00:00'),
(274, 2, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_7_1752188259.png', 'approvedbyqachead_revised', 7, '2025-07-11', '2025-08-02 00:00:00'),
(275, 2, 'A', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_12_1752188988.png', 'approvedbyqachead_revised', 12, '2025-07-11', '2025-08-02 00:00:00'),
(276, 2, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_12_1752189555.png', 'approvedbyugcacademic', 12, '2025-07-11', '2025-08-02 00:00:00'),
(277, 2, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_8_1752189668.png', 'approvedbyugcfinance', 8, '2025-07-11', '2025-08-02 00:00:00'),
(278, 2, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_9_1752189679.png', 'approvedbyugchr', 9, '2025-07-11', '2025-08-02 00:00:00'),
(279, 2, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_10_1752189703.png', 'approvedbyugcidd', 10, '2025-07-11', '2025-08-02 00:00:00'),
(280, 2, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_13_1752189718.png', 'approvedbyugcadmission', 13, '2025-07-11', '2025-08-02 00:00:00'),
(281, 53, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_8_1752189932.png', 'approvedbyugcfinance', 8, '2025-07-11', '2025-08-02 00:00:00'),
(282, 53, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_9_1752189979.png', 'approvedbyugchr', 9, '2025-07-11', '2025-08-02 00:00:00'),
(283, 53, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_10_1752190083.png', 'approvedbyugcidd', 10, '2025-07-11', '2025-08-02 00:00:00'),
(284, 53, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_12_1752190100.png', 'approvedbyugcacademic', 12, '2025-07-11', '2025-08-02 00:00:00'),
(285, 53, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_13_1752190126.png', 'approvedbyugcadmission', 13, '2025-07-11', '2025-08-02 00:00:00'),
(286, 7, 'AP', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_3_1752269514.png', 'approvedbydean', 3, '2025-07-12', '2025-08-02 00:00:00'),
(287, 7, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_6_1752269545.png', 'approvedbycqa', 6, '2025-07-12', '2025-08-02 00:00:00'),
(288, 7, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_5_1752269556.png', 'approvedbyvc', 5, '2025-07-12', '2025-08-02 00:00:00'),
(289, 7, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_26_1752269570.png', 'approvedbyTA', 26, '2025-07-12', '2025-08-02 00:00:00'),
(290, 7, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_28_1752269601.png', 'approvedbysecretary', 28, '2025-07-12', '2025-08-02 00:00:00'),
(291, 7, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_7_1752269640.png', 'approvedbyqachead', 7, '2025-07-12', '2025-08-02 00:00:00'),
(292, 7, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_8_1752269670.png', 'approvedbyugcfinance', 8, '2025-07-12', '2025-08-02 00:00:00'),
(293, 7, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_9_1752269730.png', 'approvedbyugchr', 9, '2025-07-12', '2025-08-02 00:00:00'),
(294, 7, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_10_1752269744.png', 'approvedbyugcidd', 10, '2025-07-12', '2025-08-02 00:00:00'),
(296, 7, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_13_1752269771.png', 'approvedbyugcadmission', 13, '2025-07-12', '2025-08-02 00:00:00'),
(297, 16, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_3_1752270547.png', 'approvedbydean', 3, '2025-07-12', '2025-08-02 00:00:00'),
(298, 16, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_6_1752270568.png', 'approvedbycqa', 6, '2025-07-12', '2025-08-02 00:00:00'),
(299, 16, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_26_1752270614.png', 'approvedbyTA', 26, '2025-07-12', '2025-08-02 00:00:00'),
(300, 16, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_28_1752270829.png', 'approvedbysecretary', 28, '2025-07-12', '2025-08-02 00:00:00'),
(301, 16, 'APPROVED_REVISED', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_7_1752270873.png', 'approvedbyqachead_revised', 7, '2025-07-12', '2025-08-02 00:00:00'),
(302, 16, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_8_1752270897.png', 'approvedbyugcfinance', 8, '2025-07-12', '2025-08-02 00:00:00'),
(303, 16, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_9_1752270916.png', 'approvedbyugchr', 9, '2025-07-12', '2025-08-02 00:00:00'),
(304, 16, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_10_1752270927.png', 'approvedbyugcidd', 10, '2025-07-12', '2025-08-02 00:00:00'),
(305, 16, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_13_1752270937.png', 'approvedbyugcadmission', 13, '2025-07-12', '2025-08-02 00:00:00'),
(306, 16, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_12_1752270954.png', 'approvedbyugcacademic', 12, '2025-07-12', '2025-08-02 00:00:00'),
(307, 6, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_3_1752271121.png', 'approvedbydean', 3, '2025-07-12', '2025-08-02 00:00:00'),
(308, 6, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_6_1752271136.png', 'approvedbycqa', 6, '2025-07-12', '2025-08-02 00:00:00'),
(309, 6, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_30_1752271156.png', 'approvedbyTA', 30, '2025-07-12', '2025-08-02 00:00:00'),
(310, 6, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_28_1752271170.png', 'approvedbysecretary', 28, '2025-07-12', '2025-08-02 00:00:00'),
(311, 6, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_7_1752271622.png', 'approvedbyqachead_revised', 7, '2025-07-12', '2025-08-02 00:00:00'),
(312, 6, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_8_1752271641.png', 'approvedbyugcfinance', 8, '2025-07-12', '2025-08-02 00:00:00'),
(313, 6, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_9_1752271655.png', 'approvedbyugchr', 9, '2025-07-12', '2025-08-02 00:00:00'),
(314, 6, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_12_1752271667.png', 'approvedbyugcacademic', 12, '2025-07-12', '2025-08-02 00:00:00'),
(315, 6, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_10_1752271685.png', 'approvedbyugcidd', 10, '2025-07-12', '2025-08-02 00:00:00'),
(316, 6, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_13_1752271699.png', 'approvedbyugcadmission', 13, '2025-07-12', '2025-08-02 00:00:00'),
(321, 69, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_3_1752327004.png', 'approvedbydean', 3, '2025-07-12', '2025-08-02 02:05:00'),
(322, 13, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_6_1752344522.png', 're-signed_cqa', 6, '2025-07-12', '2025-08-02 00:00:00'),
(323, 13, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_5_1752344536.png', 're-signed_vc', 5, '2025-07-12', '2025-08-02 00:00:00'),
(324, 69, 'Approved', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_6_1752344619.png', 'approvedbycqa', 6, '2025-07-12', '2025-08-02 02:06:00'),
(325, 69, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_5_1752344633.png', 'approvedbyvc', 5, '2025-07-12', '2025-08-02 02:07:00'),
(326, 69, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_30_1752350681.png', 'approvedbyTA', 30, '2025-07-13', '2025-08-02 02:08:00'),
(327, 69, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_28_1752353456.png', 'approvedbysecretary', 28, '2025-07-13', '2025-08-02 02:10:00'),
(328, 69, 'REVISION', NULL, 'rejectedbyqachead', 7, '2025-07-13', '2025-08-02 02:11:00'),
(329, 69, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_3_1752353514.png', 'approvedbydean', 3, '2025-07-13', '2025-08-02 02:12:00'),
(330, 69, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_6_1752353526.png', 'approvedbycqa', 6, '2025-07-13', '2025-08-02 02:13:00'),
(331, 69, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_26_1752353546.png', 'approvedbyTA', 26, '2025-07-13', '2025-08-02 02:14:00'),
(332, 69, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_28_1752353570.png', 'approvedbysecretary', 28, '2025-07-13', '2025-08-02 02:15:00'),
(333, 69, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_7_1752353601.png', 'resignature_request_from_university', 7, '2025-07-13', '2025-08-02 02:16:00'),
(334, 69, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_3_1752353619.png', 're-signed_dean', 3, '2025-07-13', '2025-08-02 02:17:00'),
(335, 69, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_6_1752353629.png', 're-signed_cqa', 6, '2025-07-13', '2025-08-02 02:18:00'),
(336, 69, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_5_1752353642.png', 're-signed_vc', 5, '2025-07-13', '2025-08-02 02:19:00'),
(337, 69, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_8_1752353873.png', 'approvedbyugcfinance', 8, '2025-07-13', '2025-08-02 02:20:00'),
(338, 69, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_9_1752353895.png', 'approvedbyugchr', 9, '2025-07-13', '2025-08-02 02:21:00'),
(339, 69, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_10_1752353908.png', 'approvedbyugcidd', 10, '2025-07-13', '2025-08-02 02:22:00'),
(340, 69, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_13_1752353934.png', 'approvedbyugcadmission', 13, '2025-07-13', '2025-08-02 02:23:00'),
(341, 69, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_12_1752353947.png', 'approvedbyugcacademic', 12, '2025-07-13', '2025-08-02 02:24:00'),
(343, 2, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_29_1752358412.png', 'approvedbyStandardCommittee', 29, '2025-07-13', '2025-08-02 00:00:00'),
(344, 6, '', NULL, 'rejectedbyStandardCommittee', 29, '2025-07-13', '2025-08-02 00:00:00'),
(346, 6, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_3_1752425934.png', 'approvedbydean', 3, '2025-07-13', '2025-08-02 00:00:00'),
(347, 3, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_3_1752426026.png', 'approvedbydean', 3, '2025-07-13', '2025-08-02 00:00:00'),
(348, 3, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_6_1752430672.png', 'approvedbycqa', 6, '2025-07-13', '2025-08-02 00:00:00'),
(349, 3, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_5_1752430689.png', 'approvedbyvc', 5, '2025-07-13', '2025-08-02 00:00:00'),
(350, 3, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_26_1752435072.png', 'approvedbyTA', 26, '2025-07-14', '2025-08-02 00:00:00'),
(351, 14, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_3_1752846640.png', 'approvedbydean', 3, '2025-07-18', '2025-08-02 00:00:00'),
(352, 14, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_6_1752846661.png', 'approvedbycqa', 6, '2025-07-18', '2025-08-02 00:00:00'),
(353, 14, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_5_1752846675.png', 'approvedbyvc', 5, '2025-07-18', '2025-08-02 00:00:00'),
(354, 14, 'Approved with non-compliance fields to review secretary.', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_26_1752846881.png', 'approvedbyTA', 26, '2025-07-18', '2025-08-02 00:00:00'),
(355, 14, '', '/qac_ugc/Proposal_sections/uploads/signature_26_1752847485.png', 'approvedbyTA', 26, '2025-07-18', '2025-08-02 00:00:00'),
(356, 14, 'Non compliance field -1', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_26_1752847706.png', 'approvedbyTA', 26, '2025-07-18', '2025-08-02 00:00:00'),
(357, 14, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_26_1752847953.png', 'approvedbyTA', 26, '2025-07-18', '2025-08-02 00:00:00'),
(358, 14, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_26_1752848017.png', 'approvedbyTA', 26, '2025-07-18', '2025-08-02 00:00:00'),
(359, 14, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_26_1752848206.png', 'approvedbyTA', 26, '2025-07-18', '2025-08-02 00:00:00'),
(360, 14, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_26_1752848656.png', 'approvedbyTA', 26, '2025-07-18', '2025-08-02 00:00:00'),
(361, 14, 'TEST_DB_DATA', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_26_1752849049.png', 'approvedbyTA', 26, '2025-07-18', '2025-08-02 00:00:00'),
(362, 14, 'TEST_DB_DATA', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_26_1752849302.png', 'approvedbyTA', 26, '2025-07-18', '2025-08-02 00:00:00'),
(363, 14, 'TEST_DB_DATA', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_26_1752849375.png', 'approvedbyTA', 26, '2025-07-18', '2025-08-02 00:00:00'),
(364, 14, 'TEST_DB_DATA', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_26_1752849716.png', 'approvedbyTA', 26, '2025-07-18', '2025-08-02 00:00:00'),
(365, 14, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_26_1752850617.png', 'approvedbyTA', 26, '2025-07-18', '2025-08-02 00:00:00'),
(366, 14, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_26_1752851260.png', 'approvedbyTA', 26, '2025-07-18', '2025-08-02 00:00:00'),
(367, 14, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_30_1752906818.png', 'approvedbyTA', 30, '2025-07-19', '2025-08-02 00:00:00'),
(368, 14, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_28_1752906890.png', 'approvedbysecretary', 28, '2025-07-19', '2025-08-02 00:00:00'),
(369, 14, '', NULL, 'rejectedbyqachead', 7, '2025-07-19', '2025-08-02 00:00:00'),
(370, 14, 'APPROVED', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_3_1753214613.png', 'approvedbydean', 3, '2025-07-23', '2025-08-02 00:00:00'),
(371, 14, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_6_1753214650.png', 'approvedbycqa', 6, '2025-07-23', '2025-08-02 00:00:00'),
(372, 14, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_26_1753218478.png', 'approvedbyTA', 26, '2025-07-23', '2025-08-02 00:00:00'),
(373, 14, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_28_1753218575.png', 'approvedbysecretary', 28, '2025-07-23', '2025-08-02 00:00:00'),
(374, 14, 'APPROVED REVISED VERSION', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_7_1753218610.png', 'resignature_request_from_university', 7, '2025-07-23', '2025-08-02 00:00:00'),
(375, 14, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_3_1753219078.png', 're-signed_dean', 3, '2025-07-23', '2025-08-02 00:00:00'),
(376, 14, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_6_1753219101.png', 're-signed_cqa', 6, '2025-07-23', '2025-08-02 00:00:00'),
(377, 14, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_5_1753220513.png', 're-signed_vc', 5, '2025-07-23', '2025-08-02 00:00:00'),
(378, 14, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_8_1753220587.png', 'approvedbyugcfinance', 8, '2025-07-23', '2025-08-02 00:00:00'),
(379, 14, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_9_1753220604.png', 'approvedbyugchr', 9, '2025-07-23', '2025-08-02 00:00:00'),
(380, 14, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_10_1753220617.png', 'approvedbyugcidd', 10, '2025-07-23', '2025-08-02 00:00:00'),
(381, 14, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_12_1753220655.png', 'approvedbyugcacademic', 12, '2025-07-23', '2025-08-02 00:00:00'),
(382, 14, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_13_1753220724.png', 'approvedbyugcadmission', 13, '2025-07-23', '2025-08-02 00:00:00'),
(383, 14, 'REVISIONS', NULL, 'rejectedbyStandardCommittee', 29, '2025-07-23', '2025-08-02 00:00:00'),
(384, 14, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_3_1753470967.png', 'approvedbydean', 3, '2025-07-26', '2025-08-02 00:00:00'),
(385, 14, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_6_1753470984.png', 'approvedbycqa', 6, '2025-07-26', '2025-08-02 00:00:00'),
(386, 14, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_30_1753471029.png', 'approvedbyTA', 30, '2025-07-26', '2025-08-02 00:00:00'),
(387, 18, 'A', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_21_1753809578.png', 'approvedbydean', 21, '2025-07-29', '2025-08-02 00:00:00'),
(388, 18, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_22_1753809696.png', 'approvedbycqa', 22, '2025-07-29', '2025-08-02 00:00:00'),
(389, 18, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_23_1753809710.png', 'approvedbyvc', 23, '2025-07-29', '2025-08-02 00:00:00'),
(390, 18, 'Check Non-compliance fields', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_30_1753810975.png', 'approvedbyTA', 30, '2025-07-29', '2025-08-02 00:00:00'),
(391, 18, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_28_1753811012.png', 'approvedbysecretary', 28, '2025-07-29', '2025-08-02 00:00:00'),
(392, 18, '', NULL, 'rejectedbyqachead', 7, '2025-07-29', '2025-08-02 00:00:00'),
(393, 18, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_21_1753811152.png', 'approvedbydean', 21, '2025-07-29', '2025-08-02 00:00:00'),
(394, 18, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_22_1753811176.png', 'approvedbycqa', 22, '2025-07-29', '2025-08-02 00:00:00'),
(395, 18, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_26_1753811242.png', 'approvedbyTA', 26, '2025-07-29', '2025-08-02 00:00:00'),
(396, 18, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_28_1753811264.png', 'approvedbysecretary', 28, '2025-07-29', '2025-08-02 00:00:00'),
(397, 18, 'Recommend.', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_7_1753811308.png', 'resignature_request_from_university', 7, '2025-07-29', '2025-08-02 00:00:00'),
(398, 18, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_21_1753811337.png', 're-signed_dean', 21, '2025-07-29', '2025-08-02 00:00:00'),
(399, 18, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_22_1753811351.png', 're-signed_cqa', 22, '2025-07-29', '2025-08-02 00:00:00'),
(400, 18, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_5_1753811362.png', 're-signed_vc', 5, '2025-07-29', '2025-08-02 00:00:00'),
(401, 18, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_23_1753811477.png', 're-signed_vc', 23, '2025-07-29', '2025-08-02 00:00:00');
INSERT INTO `proposal_comments` (`comment_id`, `proposal_id`, `comment`, `seal_and_sign`, `proposal_status`, `id`, `Date`, `Time`) VALUES
(402, 18, 'Finance part Ok', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_8_1753811564.png', 'approvedbyugcfinance', 8, '2025-07-29', '2025-08-02 00:00:00'),
(403, 18, 'HR part OK', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_9_1753811582.png', 'approvedbyugchr', 9, '2025-07-29', '2025-08-02 00:00:00'),
(404, 18, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_10_1753811597.png', 'approvedbyugcidd', 10, '2025-07-29', '2025-08-02 00:00:00'),
(405, 18, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_13_1753811610.png', 'approvedbyugcadmission', 13, '2025-07-29', '2025-08-02 00:00:00'),
(406, 18, 'Academic part OK', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_12_1753811636.png', 'approvedbyugcacademic', 12, '2025-07-29', '2025-08-02 00:00:00'),
(407, 18, 'REJECT', NULL, 'rejectedbyStandardCommittee', 29, '2025-07-29', '2025-08-02 00:00:00'),
(408, 18, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_21_1753813101.png', 'approvedbydean', 21, '2025-07-29', '2025-08-02 00:00:00'),
(409, 18, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_22_1753813120.png', 'approvedbycqa', 22, '2025-07-29', '2025-08-02 00:00:00'),
(410, 18, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_26_1753813142.png', 'approvedbyTA', 26, '2025-07-29', '2025-08-02 00:00:00'),
(411, 18, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_28_1753813164.png', 'approvedbysecretary', 28, '2025-07-29', '2025-08-02 00:00:00'),
(412, 18, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_7_1753813184.png', 'resignature_request_from_university', 7, '2025-07-29', '2025-08-02 00:00:00'),
(413, 18, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_21_1753813271.png', 're-signed_dean', 21, '2025-07-29', '2025-08-02 00:00:00'),
(414, 18, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_22_1753813288.png', 're-signed_cqa', 22, '2025-07-29', '2025-08-02 00:00:00'),
(415, 18, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_23_1753813305.png', 're-signed_vc', 23, '2025-07-30', '2025-08-02 00:00:00'),
(416, 78, 'Recommended.', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_21_1753889152.png', 'approvedbydean', 21, '2025-07-30', '2025-08-02 00:00:00'),
(417, 78, 'Recommended.', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_22_1753889179.png', 'approvedbycqa', 22, '2025-07-30', '2025-08-02 00:00:00'),
(418, 78, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_23_1753889191.png', 'approvedbyvc', 23, '2025-07-30', '2025-08-02 00:00:00'),
(419, 78, 'Recommended.', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_26_1753889346.png', 'approvedbyTA', 26, '2025-07-30', '2025-08-02 00:00:00'),
(420, 78, 'Ok', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_28_1753889368.png', 'approvedbysecretary', 28, '2025-07-30', '2025-08-02 00:00:00'),
(421, 78, 'Ok', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_7_1753889386.png', 'approvedbyqachead', 7, '2025-07-30', '2025-08-02 00:00:00'),
(422, 78, 'Ok', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_8_1753889415.png', 'approvedbyugcfinance', 8, '2025-07-30', '2025-08-02 00:00:00'),
(423, 78, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_9_1753889426.png', 'approvedbyugchr', 9, '2025-07-30', '2025-08-02 00:00:00'),
(424, 78, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_10_1753889456.png', 'approvedbyugcidd', 10, '2025-07-30', '2025-08-02 00:00:00'),
(425, 78, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_12_1753889466.png', 'approvedbyugcacademic', 12, '2025-07-30', '2025-08-02 00:00:00'),
(426, 78, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_13_1753889484.png', 'approvedbyugcadmission', 13, '2025-07-30', '2025-08-02 00:00:00'),
(427, 78, 'Ok', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_29_1753889569.png', 'approvedbyStandardCommittee', 29, '2025-07-30', '2025-08-02 00:00:00'),
(428, 75, 'Recommended', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_3_1753985122.png', 'approvedbydean', 3, '2025-07-31', '2025-08-02 00:00:00'),
(429, 75, 'Recommended', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_6_1753985139.png', 'approvedbycqa', 6, '2025-07-31', '2025-08-02 00:00:00'),
(430, 75, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_5_1753985151.png', 'approvedbyvc', 5, '2025-07-31', '2025-08-02 00:00:00'),
(431, 75, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_30_1753985277.png', 'approvedbyTA', 30, '2025-07-31', '2025-08-02 00:00:00'),
(432, 75, 'Approved with Non-compliance fields.', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_28_1753985765.png', 'approvedbysecretary', 28, '2025-07-31', '2025-08-02 00:00:00'),
(433, 75, 'Correct non-compliance fields and resubmit.', NULL, 'rejectedbyqachead', 7, '2025-07-31', '2025-08-02 00:00:00'),
(434, 23, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_3_1753988231.png', 'approvedbydean', 3, '2025-08-01', '2025-08-02 00:00:00'),
(435, 23, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_6_1753988246.png', 'approvedbycqa', 6, '2025-08-01', '2025-08-02 00:00:00'),
(436, 23, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_5_1753988293.png', 'approvedbyvc', 5, '2025-08-01', '2025-08-02 00:00:00'),
(437, 23, '2 non-compliance fields. Need revisions.', NULL, 'rejectedbyTA', 26, '2025-08-01', '2025-08-02 00:00:00'),
(438, 23, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_3_1753988595.png', 'approvedbydean', 3, '2025-08-01', '2025-08-02 00:00:00'),
(439, 23, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_6_1753988609.png', 'approvedbycqa', 6, '2025-08-01', '2025-08-02 00:00:00'),
(440, 79, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_3_1753989111.png', 'approvedbydean', 3, '2025-08-01', '2025-08-02 00:00:00'),
(441, 79, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_6_1753989127.png', 'approvedbycqa', 6, '2025-08-01', '2025-08-02 00:00:00'),
(442, 79, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_5_1753989140.png', 'approvedbyvc', 5, '2025-08-01', '2025-08-02 00:00:00'),
(443, 79, 'check Non-Compliance', NULL, 'rejectedbyTA', 30, '2025-08-01', '2025-08-02 00:00:00'),
(444, 79, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_3_1753989303.png', 'approvedbydean', 3, '2025-08-01', '2025-08-02 00:00:00'),
(445, 79, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_6_1753989328.png', 'approvedbycqa', 6, '2025-08-01', '2025-08-02 00:00:00'),
(446, 79, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_5_1753989341.png', 'approvedbyvc', 5, '2025-08-01', '2025-08-02 00:00:00'),
(447, 79, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_26_1753989358.png', 'approvedbyTA', 26, '2025-08-01', '2025-08-02 00:00:00'),
(448, 79, '', NULL, 'rejectedbysecretary', 28, '2025-08-01', '2025-08-02 00:00:00'),
(449, 79, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_3_1753989395.png', 'approvedbydean', 3, '2025-08-01', '2025-08-02 00:00:00'),
(450, 79, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_6_1753989406.png', 'approvedbycqa', 6, '2025-08-01', '2025-08-02 00:00:00'),
(451, 79, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_5_1753989421.png', 'approvedbyvc', 5, '2025-08-01', '2025-08-02 00:00:00'),
(452, 79, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_30_1753989441.png', 'approvedbyTA', 30, '2025-08-01', '2025-08-02 00:00:00'),
(453, 79, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_28_1753989452.png', 'approvedbysecretary', 28, '2025-08-01', '2025-08-02 00:00:00'),
(454, 79, '', NULL, 'rejectedbyqachead', 7, '2025-08-01', '2025-08-02 00:00:00'),
(455, 79, '', NULL, 'rejectedbyTA', 26, '2025-08-01', '2025-08-02 00:00:00'),
(456, 23, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_26_1754030756.png', 'approvedbyTA', 26, '2025-08-01', '2025-08-02 00:00:00'),
(457, 75, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_3_1754070799.png', 'approvedbydean', 3, '2025-08-01', '2025-08-02 00:00:00'),
(458, 75, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_6_1754070813.png', 'approvedbycqa', 6, '2025-08-01', '2025-08-02 00:00:00'),
(459, 75, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_26_1754070839.png', 'approvedbyTA', 26, '2025-08-01', '2025-08-02 00:00:00'),
(460, 75, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_28_1754070852.png', 'approvedbysecretary', 28, '2025-08-01', '2025-08-02 00:00:00'),
(461, 75, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_7_1754070870.png', 'approvedbyqachead_revised', 7, '2025-08-01', '2025-08-02 00:00:00'),
(462, 75, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_8_1754070908.png', 'approvedbyugcfinance', 8, '2025-08-01', '2025-08-02 00:00:00'),
(463, 75, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_9_1754070926.png', 'approvedbyugchr', 9, '2025-08-01', '2025-08-02 00:00:00'),
(464, 75, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_10_1754070966.png', 'approvedbyugcidd', 10, '2025-08-01', '2025-08-02 00:00:00'),
(465, 75, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_12_1754070979.png', 'approvedbyugcacademic', 12, '2025-08-01', '2025-08-02 00:00:00'),
(466, 75, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_13_1754070991.png', 'approvedbyugcadmission', 13, '2025-08-01', '2025-08-02 00:00:00'),
(467, 75, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_3_1754071488.png', 're-signed_dean', 3, '2025-08-01', '2025-08-02 00:00:00'),
(468, 75, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_6_1754071501.png', 're-signed_cqa', 6, '2025-08-01', '2025-08-02 00:00:00'),
(469, 75, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_5_1754071522.png', 're-signed_vc', 5, '2025-08-01', '2025-08-02 00:00:00'),
(470, 75, '', NULL, 'rejectedbyStandardCommittee', 29, '2025-08-01', '2025-08-02 00:00:00'),
(471, 75, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_3_1754071879.png', 'approvedbydean', 3, '2025-08-01', '2025-08-02 00:00:00'),
(472, 75, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_6_1754071892.png', 'approvedbycqa', 6, '2025-08-01', '2025-08-02 00:00:00'),
(473, 75, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_26_1754071912.png', 'approvedbyTA', 26, '2025-08-01', '2025-08-02 00:00:00'),
(474, 75, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_28_1754071924.png', 'approvedbysecretary', 28, '2025-08-01', '2025-08-02 00:00:00'),
(475, 75, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_7_1754071940.png', 'approvedbyqachead_revised', 7, '2025-08-01', '2025-08-02 00:00:00'),
(476, 79, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_3_1754072536.png', 'approvedbydean', 3, '2025-08-01', '2025-08-02 00:00:00'),
(477, 3, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_28_1754074162.png', 'approvedbysecretary', 28, '2025-08-02', '2025-08-02 00:00:00'),
(478, 3, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_7_1754074172.png', 'approvedbyqachead', 7, '2025-08-02', '2025-08-02 00:00:00'),
(484, 18, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_8_1754074625.png', 'approvedbyugcfinance', 8, '2025-08-02', '2025-08-02 01:28:00'),
(485, 18, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_9_1754078373.png', 'approvedbyugchr', 9, '2025-08-02', '2025-08-02 01:29:33'),
(486, 18, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_10_1754078612.png', 'approvedbyugcidd', 10, '2025-08-02', '2025-08-02 01:33:32'),
(487, 18, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_12_1754078644.png', 'approvedbyugcacademic', 12, '2025-08-02', '2025-08-02 01:34:04'),
(488, 18, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_13_1754078660.png', 'approvedbyugcadmission', 13, '2025-08-02', '2025-08-02 01:34:20'),
(489, 75, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_9_1754078842.png', 'approvedbyugchr', 9, '2025-08-02', '2025-08-02 01:37:22'),
(490, 75, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_8_1754079050.png', 'approvedbyugcfinance', 8, '2025-08-02', '2025-08-02 01:40:50'),
(491, 75, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_9_1754079065.png', 'approvedbyugchr', 9, '2025-08-02', '2025-08-02 01:41:05'),
(492, 75, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_10_1754079075.png', 'approvedbyugcidd', 10, '2025-08-02', '2025-08-02 01:41:15'),
(493, 75, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_13_1754079220.png', 'approvedbyugcadmission', 13, '2025-08-02', '2025-08-02 01:43:40'),
(494, 75, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_12_1754079238.png', 'approvedbyugcacademic', 12, '2025-08-02', '2025-08-02 01:43:58'),
(495, 13, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_9_1754080803.png', 'approvedbyugchr', 9, '2025-08-02', '2025-08-02 02:10:03'),
(505, 3, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_8_1754081537.png', 'approvedbyugcfinance', 8, '2025-08-02', '2025-08-02 02:22:17'),
(506, 3, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_9_1754081561.png', 'approvedbyugchr', 9, '2025-08-02', '2025-08-02 02:22:41'),
(507, 3, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_10_1754082191.png', 'approvedbyugcidd', 10, '2025-08-02', '2025-08-02 02:33:11'),
(508, 3, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_12_1754082203.png', 'approvedbyugcacademic', 12, '2025-08-02', '2025-08-02 02:33:23'),
(509, 3, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_13_1754082223.png', 'approvedbyugcadmission', 13, '2025-08-02', '2025-08-02 02:33:43'),
(510, 13, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_10_1754082556.png', 'approvedbyugcidd', 10, '2025-08-02', '2025-08-02 02:39:16'),
(511, 13, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_12_1754082572.png', 'approvedbyugcacademic', 12, '2025-08-02', '2025-08-02 02:39:32'),
(512, 13, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_13_1754082588.png', 'approvedbyugcadmission', 13, '2025-08-02', '2025-08-02 02:39:48'),
(513, 13, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_8_1754082742.png', 'approvedbyugcfinance', 8, '2025-08-02', '2025-08-02 02:42:22'),
(517, 72, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_3_1754083670.png', 'approvedbydean', 3, '2025-08-02', '2025-08-02 02:57:50'),
(518, 72, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_6_1754083680.png', 'approvedbycqa', 6, '2025-08-02', '2025-08-02 02:58:00'),
(519, 72, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_5_1754083709.png', 'approvedbyvc', 5, '2025-08-02', '2025-08-02 02:58:29'),
(520, 72, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_26_1754083856.png', 'approvedbyTA', 26, '2025-08-02', '2025-08-02 03:00:56'),
(521, 72, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_28_1754083874.png', 'approvedbysecretary', 28, '2025-08-02', '2025-08-02 03:01:14'),
(522, 72, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_7_1754083888.png', 'approvedbyqachead', 7, '2025-08-02', '2025-08-02 03:01:28'),
(524, 72, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_9_1754083962.png', 'approvedbyugchr', 9, '2025-08-02', '2025-08-02 03:02:42'),
(525, 72, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_10_1754083975.png', 'approvedbyugcidd', 10, '2025-08-02', '2025-08-02 03:02:55'),
(526, 72, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_12_1754083986.png', 'approvedbyugcacademic', 12, '2025-08-02', '2025-08-02 03:03:06'),
(527, 72, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_13_1754083997.png', 'approvedbyugcadmission', 13, '2025-08-02', '2025-08-02 03:03:17'),
(528, 72, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_8_1754085389.png', 'approvedbyugcfinance', 8, '2025-08-02', '2025-08-02 03:26:29'),
(529, 7, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_12_1754085564.png', 'approvedbyugcacademic', 12, '2025-08-02', '2025-08-02 03:29:24'),
(530, 7, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_3_1754085777.png', 'approvedbydean', 3, '2025-08-02', '2025-08-02 03:32:57'),
(531, 7, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_6_1754085786.png', 'approvedbycqa', 6, '2025-08-02', '2025-08-02 03:33:06'),
(532, 7, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_30_1754085875.png', 'approvedbyTA', 30, '2025-08-02', '2025-08-02 03:34:35'),
(533, 7, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_28_1754085894.png', 'approvedbysecretary', 28, '2025-08-02', '2025-08-02 03:34:54'),
(534, 7, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_7_1754085925.png', 'approvedbyqachead_revised', 7, '2025-08-02', '2025-08-02 03:35:25'),
(535, 7, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_8_1754085938.png', 'approvedbyugcfinance', 8, '2025-08-02', '2025-08-02 03:35:38'),
(536, 7, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_9_1754085947.png', 'approvedbyugchr', 9, '2025-08-02', '2025-08-02 03:35:47'),
(537, 7, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_10_1754085964.png', 'approvedbyugcidd', 10, '2025-08-02', '2025-08-02 03:36:04'),
(538, 7, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_12_1754085978.png', 'approvedbyugcacademic', 12, '2025-08-02', '2025-08-02 03:36:18'),
(539, 7, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_13_1754085987.png', 'approvedbyugcadmission', 13, '2025-08-02', '2025-08-02 03:36:27'),
(540, 7, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_7_1754086056.png', 'resignature_request_from_university', 7, '2025-08-02', '2025-08-02 03:37:36'),
(541, 7, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_3_1754086067.png', 're-signed_dean', 3, '2025-08-02', '2025-08-02 03:37:47'),
(542, 7, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_6_1754086080.png', 're-signed_cqa', 6, '2025-08-02', '2025-08-02 03:38:00'),
(543, 7, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_5_1754086097.png', 're-signed_vc', 5, '2025-08-02', '2025-08-02 03:38:17'),
(544, 7, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_8_1754086108.png', 'approvedbyugcfinance', 8, '2025-08-02', '2025-08-02 03:38:28'),
(545, 7, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_9_1754086118.png', 'approvedbyugchr', 9, '2025-08-02', '2025-08-02 03:38:38'),
(546, 7, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_10_1754086129.png', 'approvedbyugcidd', 10, '2025-08-02', '2025-08-02 03:38:49'),
(547, 7, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_12_1754086139.png', 'approvedbyugcacademic', 12, '2025-08-02', '2025-08-02 03:38:59'),
(548, 7, '', 'http://localhost/qac_ugc/Proposal_sections/uploads/signature_13_1754086150.png', 'approvedbyugcadmission', 13, '2025-08-02', '2025-08-02 03:39:10');

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
(69, 'Yes', 'Yes', 'Higher Diploma (SLQF 4)', 'Yes', '', 'Yes', 'Yes', 15, '', '', '', ''),
(78, 'Yes', 'Yes', 'Higher Diploma (SLQF 4)', 'Yes', 'A', 'Yes', 'Yes', 16, '/qac_ugc/Proposal_sections/uploads/1753888831_1748196031_1739894675_cooperate.pdf', '/qac_ugc/Proposal_sections/uploads/1753888831_1748196112_1739894675_council.pdf', '/qac_ugc/Proposal_sections/uploads/1753888831_1749405580_1748196112_1739894675_council.pdf', '/qac_ugc/Proposal_sections/uploads/1753888831_1749405580_1748196112_1739894675_council.pdf'),
(75, 'Yes', 'Yes', 'Bachelors Degree (SLQF 5)', 'Yes', 'edewd', 'Yes', 'Yes', 17, '/qac_ugc/Proposal_sections/uploads/1753985082_1748196112_1739894675_council.pdf', '/qac_ugc/Proposal_sections/uploads/1753985082_1749405580_1748196112_1739894675_council.pdf', '/qac_ugc/Proposal_sections/uploads/1753985082_1749405580_1748196112_1739894675_council.pdf', '/qac_ugc/Proposal_sections/uploads/1753985082_1748196112_1739894675_council.pdf'),
(79, 'Yes', 'Yes', 'Bachelors Degree (SLQF 5)', 'Yes', '', 'Yes', 'Yes', 18, '', '', '', '/qac_ugc/Proposal_sections/uploads/1753989092_1748196112_1739894675_council.pdf'),
(72, 'Yes', 'Yes', 'Bachelors Degree (SLQF 5)', 'Yes', '', 'Yes', 'Yes', 19, '', '', '', ''),
(80, 'Yes', 'Yes', 'Bachelors Degree (SLQF 5)', 'Yes', 'qws', 'Yes', 'Yes', 20, '', '/qac_ugc/Proposal_sections/uploads/1754084889_1748196112_1739894675_council.pdf', '', '');

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
('A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', ' A', 'UGC Z score based selection', '', 50, 'Bachelor Honours Degree', '4', 5, 5, 120, 'English', 16, 69, '/qac_ugc/Proposal_sections/uploads/1752323094_1748196112_1739894675_council.pdf', 'Level 6 (Bachelors Honours - 4 year programme)', 'A', '/qac_ugc/Proposal_sections/uploads/1752323094_1749405618_1748196031_1739720192_benchmark.pdf', '/qac_ugc/Proposal_sections/uploads/1752323094_1748196112_1739894675_council.pdf', 'Yes'),
('A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'UGC Z score based selection', '', 50, 'Bachelor Honours Degree', '4', 5, 5, 120, 'English', 17, 78, '/qac_ugc/Proposal_sections/uploads/1753888559_1742064039_1739720192_benchmark.pdf', 'Level 6 (Bachelors Honours - 4 year programme)', 'A', '/qac_ugc/Proposal_sections/uploads/1753888559_1748196112_1739894675_council.pdf', '/qac_ugc/Proposal_sections/uploads/1753888559_1748196065_1739720192_benchmark.pdf', 'Yes'),
('A', 'A', 'A', 'A', 'ABC', 'A', 'A', 'A', 'A', 'A', '', '', 50, 'Bachelor Honours Degree', '4', 5, 5, 120, '', 18, 75, '/qac_ugc/Proposal_sections/uploads/1753984813_1748196031_1739720192_benchmark.pdf', '', 'A', '/qac_ugc/Proposal_sections/uploads/1753984813_1748196112_1739894675_council.pdf', '/qac_ugc/Proposal_sections/uploads/1753984813_1748196112_1739894675_council.pdf', ''),
('A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'UGC Z score based selection', '', 50, 'Bachelor Honours Degree', '4', 5, 5, 120, 'English', 19, 79, '/qac_ugc/Proposal_sections/uploads/1753988946_1748196031_1739720192_benchmark.pdf', 'Level 6 (Bachelors Honours - 4 year programme)', 'A', '/qac_ugc/Proposal_sections/uploads/1753988946_1749405580_1748196112_1739894675_council.pdf', '/qac_ugc/Proposal_sections/uploads/1753988946_1749405580_1748196112_1739894675_council.pdf', 'Yes'),
('A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'UGC Z score based selection', 'A', 50, 'Bachelor Honours Degree', '4', 5, 5, 120, 'English', 20, 72, '/qac_ugc/Proposal_sections/uploads/1754083440_1749405618_1748196031_1739720192_benchmark.pdf', 'Level 6 (Bachelors Honours - 4 year programme)', 'A', '/qac_ugc/Proposal_sections/uploads/1754083440_1748196031_1739894675_cooperate.pdf', '/qac_ugc/Proposal_sections/uploads/1754083440_1748196112_1739894675_council.pdf', 'Yes'),
('saz', 'wsqw', 'sqw', 'sq', 'qws', 'qws', 'qws', 'wqs', 'wsq', 'ws', 'UGC Z score based selection', '', 50, 'Bachelor Honours Degree', '4', 5, 5, 120, 'English', 21, 80, '/qac_ugc/Proposal_sections/uploads/1754084763_1749405580_1748196112_1739894675_council.pdf', 'Level 6 (Bachelors Honours - 4 year programme)', 'wsq', '/qac_ugc/Proposal_sections/uploads/1754084763_1748196065_1739720192_benchmark.pdf', '/qac_ugc/Proposal_sections/uploads/1754084763_1749405580_1748196112_1739894675_council.pdf', 'Yes');

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
(30, 'Recurrent Expenditure', 'A', 'A', 'A', 'A', 23, 15),
(31, 'Capital Expenditure', 'A', 'A', 'A', 'A', 78, 16),
(32, 'Recurrent Expenditure', 'A', 'A', 'A', 'A', 78, 16),
(33, 'Capital Expenditure', '1', '1', '1', '1', 75, 17),
(34, 'Recurrent Expenditure', '1', '1', '1', '1', 75, 17),
(35, 'Capital Expenditure', '2', '2', '2', '2', 79, 18),
(36, 'Recurrent Expenditure', '2', '2', '2', '2', 79, 18),
(37, 'Capital Expenditure', '1', '1', '1', '1', 72, 19),
(38, 'Recurrent Expenditure', '1', '1', '1', '1', 72, 19),
(39, 'Capital Expenditure', '1', '1', '1', '1', 80, 20),
(40, 'Recurrent Expenditure', '1', '1', '1', '11', 80, 20);

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
(18, 'Bsc (Hons) Computer Science', 'පරිගණක විද්‍යාව පිළිබඳ විද්‍යාවේදී ගෞරව උපාධිය', 'பிஎஸ்சி ஹானர்ஸ் கணினி அறிவியல்', 'BSc', 10, '', 'පරිගණක විද්‍යාව පිළිබඳ විද්‍යාවේදී ගෞරව උපාධිය', ''),
(19, 'Bsc (Hons) Computer Science', 'පරිගණක විද්‍යාව පිළිබඳ විද්‍යාවේදී ගෞරව උපාධිය', 'பிஎஸ்சி ஹானர்ஸ் கணினி அறிவியல்', 'BSc', 11, 'A', 'B', 'C'),
(23, 'a', 'a', 'a', 'a', 12, 'a', 'a', 'aav'),
(49, 'Bsc (Hons) Computer Sciencee', 'පරිගණක විද්‍යාව පිළිබඳ විද්‍යාවේදී ගෞරව උපාධිය', 'பிஎஸ்சி ஹானர்ஸ் கணினி அறிவியல்', 'BSc', 13, 'A', 'B', 'C'),
(53, 'Bsc (Hons) Computer Science', 'පරිගණක විද්‍යාව පිළිබඳ විද්‍යාවේදී ගෞරව උපාධිය', 'பிஎஸ்சி ஹானர்ஸ் கணினி அறிவியல்', 'BSc', 14, 'Bsc (Hons) Computer Science', 'පරිගණක විද්‍යාව පිළිබඳ විද්‍යාවේදී ගෞරව උපාධිය', 'பிஎஸ்சி ஹானர்ஸ் கணினி அறிவியல்'),
(69, 'A', 'A', 'A', 'BSc', 15, 'A', 'A', 'A'),
(72, 'A', 'A', 'A', 'A', 16, 'A', 'A', 'A'),
(75, 'Bsc (Hons) Computer Science', 'A', 'A', 'A', 17, 'A', 'A', 'A'),
(78, 'Bsc (Hons) Computer Science', 'Bsc (Hons) Computer Science', 'Bsc (Hons) Computer Science', 'BSc', 18, 'Bsc (Hons) Computer Science', 'Bsc (Hons) Computer Science', 'Bsc (Hons) Computer Science'),
(79, 'Bsc (Hons) Software Engineering', 'Bsc (Hons) Software Engineering', 'Bsc (Hons) Software Engineering', 'BSc', 19, 'Bsc (Hons) Software Engineering', 'Bsc (Hons) Software Engineering', 'Bsc (Hons) Software Engineering'),
(80, 'A', 'A', 'A', 'A', 20, 'A', 'A', 'A');

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
(10, 220, 'ABC', '2025', 'A', 14),
(17, 225, 'A', 'A', 'A', 78),
(17, 226, 'B', 'B', 'B', 78),
(11, 230, 's', 's', 's', 23),
(19, 235, 'A', 'A', 'A', 79),
(20, 236, 'A', 'A', 'A', 72),
(21, 237, 'qws', 'qws', 'qws', 80);

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
(23, 75, 'Minor Staff', 'A', 'A', 'A', 'A', 15),
(78, 76, 'Lecturers', 'A', 'A', 'A', 'A', 16),
(78, 77, 'Instructors/Demonstrators', 'A', 'A', 'A', 'A', 16),
(78, 78, 'Technical Grades', 'A', 'A', 'A', 'A', 16),
(78, 79, 'Management Assistants', 'A', 'A', 'A', 'A', 16),
(78, 80, 'Minor Staff', 'a', 'A', 'A', 'A', 16),
(75, 81, 'Lecturers', '1', '11', '1', '1', 17),
(75, 82, 'Instructors/Demonstrators', '1', '1', '1', '1', 17),
(75, 83, 'Technical Grades', '1', '1', '1', '1', 17),
(75, 84, 'Management Assistants', '1', '1', '1', '1', 17),
(75, 85, 'Minor Staff', '1', '1', '1', '1', 17),
(79, 86, 'Lecturers', '2', '2', '2', '2', 18),
(79, 87, 'Instructors/Demonstrators', '2', '2', '2', '2', 18),
(79, 88, 'Technical Grades', '2', '2', '2', '2', 18),
(79, 89, 'Management Assistants', '2', '2', '2', '2', 18),
(79, 90, 'Minor Staff', '2', '2', '2', '2', 18),
(72, 91, 'Lecturers', '1', '11', '1', '1', 19),
(72, 92, 'Instructors/Demonstrators', '1', '1', '1', '1', 19),
(72, 93, 'Technical Grades', '1', '1', '1', '1', 19),
(72, 94, 'Management Assistants', '1', '1', '1', '1', 19),
(72, 95, 'Minor Staff', '1', '1', '1', '1', 19),
(80, 96, 'Lecturers', '1', '1', '1', '1', 20),
(80, 97, 'Instructors/Demonstrators', '1', '1', '1', '1', 20),
(80, 98, 'Technical Grades', '1', '1', '1', '1', 20),
(80, 99, 'Management Assistants', '1', '1', '1', '1', 20),
(80, 100, 'Minor Staff', '1', '1', '1', '1', 20);

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
('Corporate / Strategic Plan of the University', '1', '2025-05-21', '/qac_ugc/Proposal_sections/uploads/1753988475_1748196031_1739720192_benchmark.pdf', 45, 23, 11),
('Action Plan of the Faculty/Institute/Center/Unit', '2', '2025-05-21', '/qac_ugc/Proposal_sections/uploads/1753988475_1748196031_1739894675_cooperate.pdf', 46, 23, 11),
('Senate Approval', '4', '2025-05-21', '/qac_ugc/Proposal_sections/uploads/1753988475_1749405580_1748196112_1739894675_council.pdf', 47, 23, 11),
('Council Approval', '5', '2025-05-21', '/qac_ugc/Proposal_sections/uploads/1753988475_1749405618_1748196031_1739720192_benchmark.pdf', 48, 23, 11),
('Faculty Approval', '3', '2025-05-25', '/qac_ugc/Proposal_sections/uploads/1753988475_1748196065_1739720192_benchmark.pdf', 49, 23, 11),
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
('Council Approval', '5', '2025-07-23', '/qac_ugc/Proposal_sections/uploads/1752411573_1749405580_1748196112_1739894675_council.pdf', 75, 14, 15),
('Corporate / Strategic Plan of the University', '1', '2025-07-15', '/qac_ugc/Proposal_sections/uploads/1753888507_1742064039_1739720192_benchmark.pdf', 76, 78, 16),
('Action Plan of the Faculty/Institute/Center/Unit', '2', '2025-07-22', '/qac_ugc/Proposal_sections/uploads/1753888507_1742064039_1739894675_council.pdf', 77, 78, 16),
('Faculty Approval', '3', '2025-07-22', '/qac_ugc/Proposal_sections/uploads/1753888507_1748196031_1739720192_benchmark.pdf', 78, 78, 16),
('Senate Approval', '4', '2025-07-16', '/qac_ugc/Proposal_sections/uploads/1753888507_1748196031_1739894675_cooperate.pdf', 79, 78, 16),
('Council Approval', '5', '2025-07-08', '/qac_ugc/Proposal_sections/uploads/1753888507_1748196065_1739720192_benchmark.pdf', 80, 78, 16),
('Corporate / Strategic Plan of the University', '1', '2025-07-31', '/qac_ugc/Proposal_sections/uploads/1753984763_1748196031_1739720192_benchmark.pdf', 81, 75, 17),
('Action Plan of the Faculty/Institute/Center/Unit', '2', '2025-07-23', '/qac_ugc/Proposal_sections/uploads/1753984763_1748196065_1739720192_benchmark.pdf', 82, 75, 17),
('Faculty Approval', '3', '2025-07-23', '/qac_ugc/Proposal_sections/uploads/1753984763_1748196112_1739894675_council.pdf', 83, 75, 17),
('Senate Approval', '4', '2025-07-10', '/qac_ugc/Proposal_sections/uploads/1753984763_1749405580_1748196112_1739894675_council.pdf', 84, 75, 17),
('Council Approval', '5', '2025-07-02', '/qac_ugc/Proposal_sections/uploads/1753984763_1749405618_1748196031_1739720192_benchmark.pdf', 85, 75, 17),
('Corporate / Strategic Plan of the University', '1', '2025-08-12', '/qac_ugc/Proposal_sections/uploads/1753988906_1748196112_1739894675_council.pdf', 86, 79, 18),
('Action Plan of the Faculty/Institute/Center/Unit', '23', '2025-08-20', '/qac_ugc/Proposal_sections/uploads/1753988906_1749405580_1748196112_1739894675_council.pdf', 87, 79, 18),
('Faculty Approval', '3', '2025-08-13', '/qac_ugc/Proposal_sections/uploads/1753988906_1749405580_1748196112_1739894675_council.pdf', 88, 79, 18),
('Senate Approval', '4', '2025-08-12', '/qac_ugc/Proposal_sections/uploads/1753988906_1748196112_1739894675_council.pdf', 89, 79, 18),
('Council Approval', '5', '2025-08-12', '/qac_ugc/Proposal_sections/uploads/1753988906_1749405580_1748196112_1739894675_council.pdf', 90, 79, 18),
('Corporate / Strategic Plan of the University', '1', '2025-08-14', '/qac_ugc/Proposal_sections/uploads/1754083399_1749405580_1748196112_1739894675_council.pdf', 91, 72, 19),
('Action Plan of the Faculty/Institute/Center/Unit', '2', '2025-08-27', '/qac_ugc/Proposal_sections/uploads/1754083399_1748196112_1739894675_council.pdf', 92, 72, 19),
('Faculty Approval', '3', '2025-08-19', '/qac_ugc/Proposal_sections/uploads/1754083399_1749405580_1748196112_1739894675_council.pdf', 93, 72, 19),
('Senate Approval', '4', '2025-08-12', '/qac_ugc/Proposal_sections/uploads/1754083399_1749405580_1748196112_1739894675_council.pdf', 94, 72, 19),
('Council Approval', '5', '2025-08-12', '/qac_ugc/Proposal_sections/uploads/1754083399_1749405618_1748196031_1739720192_benchmark.pdf', 95, 72, 19),
('Corporate / Strategic Plan of the University', '1', '2025-08-05', '/qac_ugc/Proposal_sections/uploads/1754084730_1749405580_1748196112_1739894675_council.pdf', 96, 80, 20),
('Action Plan of the Faculty/Institute/Center/Unit', '2', '2025-08-26', '/qac_ugc/Proposal_sections/uploads/1754084730_1748196112_1739894675_council.pdf', 97, 80, 20),
('Faculty Approval', '34', '2025-08-26', '/qac_ugc/Proposal_sections/uploads/1754084730_1748196112_1739894675_council.pdf', 98, 80, 20),
('Senate Approval', '4', '2025-08-11', '/qac_ugc/Proposal_sections/uploads/1754084731_1748196112_1739894675_council.pdf', 99, 80, 20),
('Council Approval', '5', '2025-08-05', '/qac_ugc/Proposal_sections/uploads/1754084731_1748196112_1739894675_council.pdf', 100, 80, 20);

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
(469, 14, 'P', 'Lecturer', 1, 3, 2, 2, 2, 10),
(470, 14, 'P', 'Lecturer', 1, 3, 2, 2, 2, 10),
(474, 78, 'A', 'A', 2, 3, 3, 2, 4, 14),
(482, 23, 'P', 'Lecturer', 1, 3, 2, 2, 2, 10),
(488, 79, 'A', 'ee', 2, 2, 2, 2, 3, 11),
(491, 75, 'A', 'A', 3, 3, 2, 2, 3, 13),
(492, 75, 'B', 'B', 2, 2, 2, 5, 3, 14),
(494, 72, 'A', 'A', 3, 2, 1, 3, 3, 12),
(496, 80, '1', '1', 3, 2, 3, 2, 2, 12);

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
(22, 2, 2, 'PROP_2_1752184627', 1000.00, 'completed_used', '2025-07-10 21:57:07', '2025-07-10 21:58:00'),
(23, 79, 2, 'PROP_79_1753989742', 1000.00, 'completed_used', '2025-07-31 19:22:22', '2025-07-31 19:24:20');

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
(23, 'Other', 'A', 'A', 'AA', 'A', 'A', 15, 135),
(78, 'Land extent (Acre/Hectare)', 'A', 'A', 'A', 'A', 'A', 16, 136),
(78, 'Office Space', 'A', 'A', 'A', 'A', 'A', 16, 137),
(78, 'No. of Lecture Theatres', 'A', 'A', 'A', 'A', 'A', 16, 138),
(78, 'No. of Laboratories', 'A', 'A', 'A', 'A', 'A', 16, 139),
(78, 'No. of Computers with Internet Facilities', 'A', 'A', 'A', 'A', 'A', 16, 140),
(78, 'Reading Rooms/Halls', 'A', 'A', 'A', 'A', 'A', 16, 141),
(78, 'Staff Common Rooms/Amenities', 'A', 'A', 'A', 'A', 'A', 16, 142),
(78, 'Student Common Rooms/Amenities', 'A', 'A', 'A', 'A', 'A', 16, 143),
(78, 'Other', 'A', 'A', 'A', 'A', 'A', 16, 144),
(75, 'Land extent (Acre/Hectare)', '1', '1', '11', '1', '1', 17, 145),
(75, 'Office Space', '1', '1', '1', '1', '1', 17, 146),
(75, 'No. of Lecture Theatres', '1', '1', '1', '1', '1', 17, 147),
(75, 'No. of Laboratories', '1', '1', '1', '11', '1', 17, 148),
(75, 'No. of Computers with Internet Facilities', '1', '1', '1', '1', '1', 17, 149),
(75, 'Reading Rooms/Halls', '1', '1', '1', '1', '1', 17, 150),
(75, 'Staff Common Rooms/Amenities', '1', '1', '1', '1', '1', 17, 151),
(75, 'Student Common Rooms/Amenities', '1', '1', '1', '1', '1', 17, 152),
(75, 'Other', '1', '1', '1', '1', '1', 17, 153),
(79, 'Land extent (Acre/Hectare)', '1', '2', '3', '4', '5', 18, 154),
(79, 'Office Space', '2', '2', '2', '2', '2', 18, 155),
(79, 'No. of Lecture Theatres', '2', '2', '2', '2', '2', 18, 156),
(79, 'No. of Laboratories', '2', '2', '22', '2', '2', 18, 157),
(79, 'No. of Computers with Internet Facilities', '2', '2', '2', '2', '2', 18, 158),
(79, 'Reading Rooms/Halls', '2', '2', '2', '2', '2', 18, 159),
(79, 'Staff Common Rooms/Amenities', '2', '2', '22', '2', '2', 18, 160),
(79, 'Student Common Rooms/Amenities', '2', '22', '2', '2', '2', 18, 161),
(79, 'Other', '2', '2', '2', '2', '2', 18, 162),
(72, 'Land extent (Acre/Hectare)', '1', '1', '11', '1', '1', 19, 163),
(72, 'Office Space', '1', '1', '11', '1', '1', 19, 164),
(72, 'No. of Lecture Theatres', '1', '1', '1', '1', '11', 19, 165),
(72, 'No. of Laboratories', '1', '1', '1', '1', '11', 19, 166),
(72, 'No. of Computers with Internet Facilities', '1', '1', '1', '1', '1', 19, 167),
(72, 'Reading Rooms/Halls', '1', '11', '11', '1', '1', 19, 168),
(72, 'Staff Common Rooms/Amenities', '1', '1', '1', '1', '11', 19, 169),
(72, 'Student Common Rooms/Amenities', '1', '11', '1', '1', '11', 19, 170),
(72, 'Other', '1', '1', '1', '1', '1', 19, 171),
(80, 'Land extent (Acre/Hectare)', '1', '1', '11', '1', '1', 20, 172),
(80, 'Office Space', '11', '1', '1', '1', '1', 20, 173),
(80, 'No. of Lecture Theatres', '1', '1', '1', '1', '1', 20, 174),
(80, 'No. of Laboratories', '1', '1', '1', '11', '1', 20, 175),
(80, 'No. of Computers with Internet Facilities', '1', '1', '1', '1', '1', 20, 176),
(80, 'Reading Rooms/Halls', '1', '1', '1', '1', '1', 20, 177),
(80, 'Staff Common Rooms/Amenities', '1', '1', '1', '1', '11', 20, 178),
(80, 'Student Common Rooms/Amenities', '11', '1', '11', '1', '1', 20, 179),
(80, 'Other', '1', '1', '1', '1', '1', 20, 180);

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
(31, 23, 1, 'A', 'xsx', 120, 'Optional', 3, 3, 3, 'A', 'A', 'A', 2, 3, 'A'),
(33, 78, 2, 'A', 'A', 120, 'Optional', 2, 2, 2, 'A', 'A', 'A', 2, 2, 'A'),
(34, 78, 1, 'B', 'B', 1, 'Core', 2, 2, 2, 'B', 'B', 'B', 2, 2, 'B'),
(36, 75, 1, 'A', 'aa', 120, 'Core', 3, 3, 2, 'a', 'a', 'a', 3, 2, 'a'),
(38, 79, 2, 'A', 'A', 120, 'Optional', 3, 2, 3, 'A', 'A', 'A', 2, 2, 'A'),
(40, 72, 3, 'A', 'A', 120, 'Optional', 4, 4, 4, 'd', 'd', 'd', 2, 2, 's'),
(42, 80, 3, 's', 's', 120, 'Optional', 2, 2, 2, 'ed', 'wde', 'ewd', 2, 2, 'ed');

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
(23, 'A', 15),
(78, 'A', 16),
(75, 'A', 17),
(79, 'A', 18),
(72, 'A', 19),
(80, 'ed', 20);

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
(14, 'School of computing', 'School of computing', 15, 'University of Colombo'),
(78, 'School of computing', 'Computing', 16, 'University of Peradeniya'),
(75, 'School of computing', 'School of computing', 17, 'University of Colombo'),
(79, 'School of computing', 'School of computing', 18, 'University of Colombo'),
(72, 'School of computing', 'School of computing', 19, 'University of Colombo'),
(80, 'School of computing', 'School of computing', 20, 'University of Peradeniya');

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
(46, 23, 4, 'C', 'C', 70, 'Compulsory', 'Yes', 'No', 'Existing'),
(48, 78, 1, 'A', 'A', 3, 'Compulsory', 'Yes', 'No', 'New'),
(49, 78, 2, 'B', 'B', 117, 'Compulsory', 'No', 'Yes', 'Existing'),
(51, 75, 1, 'ww', 'ww', 120, 'Compulsory', 'Yes', 'No', 'New'),
(53, 79, 1, 'A', 'A', 120, 'Optional', 'Yes', 'No', 'New'),
(55, 72, 3, 'SE', 'A', 120, 'Optional', 'Yes', 'No', 'New'),
(57, 80, 1, 's', 's', 120, 'Optional', 'Yes', 'No', 'Existing');

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
(69, 14),
(72, 19),
(75, 17),
(78, 16),
(79, 18),
(80, 20);

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
(180, 23, 'Recommendation (a, b, or c)', 'A', 'A'),
(181, 78, '', '', ''),
(182, 78, 'Acceptability of the Background and the Justification', 'A', 'A'),
(183, 78, 'Relevance of proposed degree program to Society', 'A', 'A'),
(184, 78, 'Entry Qualification and Admission Process', 'A', 'A'),
(185, 78, 'Program Structure', 'A', 'A'),
(186, 78, 'Program Content', 'A', 'A'),
(187, 78, 'Teaching Learning Methods', 'A', 'A'),
(188, 78, 'Assessment Strategy/Procedure', 'A', 'A'),
(189, 78, 'Resource Availability - Physical', 'A', 'A'),
(190, 78, 'Qualifications of Panel of Teachers (Internal & External)', 'A', 'A'),
(191, 78, 'Recommended Reading', 'A', 'A'),
(192, 78, 'Recommendation (a, b, or c)', 'A', 'A'),
(193, 75, '', '', ''),
(194, 75, 'Acceptability of the Background and the Justification', 'A', 'A'),
(195, 75, 'Relevance of proposed degree program to Society', 'A', 'A'),
(196, 75, 'Entry Qualification and Admission Process', 'A', 'A'),
(197, 75, 'Program Structure', 'A', 'A'),
(198, 75, 'Program Content', 'A', 'A'),
(199, 75, 'Teaching Learning Methods', 'A', 'a'),
(200, 75, 'Assessment Strategy/Procedure', 'a', 'a'),
(201, 75, 'Resource Availability - Physical', 'A', 'a'),
(202, 75, 'Qualifications of Panel of Teachers (Internal & External)', 'A', 'A'),
(203, 75, 'Recommended Reading', 'a', 'a'),
(204, 75, 'Recommendation (a, b, or c)', 'A', 'a'),
(205, 79, '', '', ''),
(206, 79, 'Acceptability of the Background and the Justification', 'wd', 'wd'),
(207, 79, 'Relevance of proposed degree program to Society', 'wd', 'wd'),
(208, 79, 'Entry Qualification and Admission Process', 'wd', 'wd'),
(209, 79, 'Program Structure', 'wd', 'wd'),
(210, 79, 'Program Content', 'dw', 'wd'),
(211, 79, 'Teaching Learning Methods', 'wd', 'wd'),
(212, 79, 'Assessment Strategy/Procedure', 'qw', 'dqwd'),
(213, 79, 'Resource Availability - Physical', 'qwd', 'qwd'),
(214, 79, 'Qualifications of Panel of Teachers (Internal & External)', 'dwq', 'wdqw'),
(215, 79, 'Recommended Reading', 'd', 'qwd'),
(216, 79, 'Recommendation (a, b, or c)', 'qwd', 'wqd'),
(217, 72, '', '', ''),
(218, 72, 'Acceptability of the Background and the Justification', 's', 's'),
(219, 72, 'Relevance of proposed degree program to Society', 's', 's'),
(220, 72, 'Entry Qualification and Admission Process', 's', 's'),
(221, 72, 'Program Structure', 's', 's'),
(222, 72, 'Program Content', 's', 's'),
(223, 72, 'Teaching Learning Methods', 's', 's'),
(224, 72, 'Assessment Strategy/Procedure', 's', 's'),
(225, 72, 'Resource Availability - Physical', 's', 's'),
(226, 72, 'Qualifications of Panel of Teachers (Internal & External)', 'ss', 's'),
(227, 72, 'Recommended Reading', 's', 's'),
(228, 72, 'Recommendation (a, b, or c)', 's', 's'),
(229, 80, '', '', ''),
(230, 80, 'Acceptability of the Background and the Justification', '1', '1'),
(231, 80, 'Relevance of proposed degree program to Society', '1', '1'),
(232, 80, 'Entry Qualification and Admission Process', '1', '1'),
(233, 80, 'Program Structure', '1', '1'),
(234, 80, 'Program Content', '1', '1'),
(235, 80, 'Teaching Learning Methods', '1', '1'),
(236, 80, 'Assessment Strategy/Procedure', '1', '1'),
(237, 80, 'Resource Availability - Physical', '1', '1'),
(238, 80, 'Qualifications of Panel of Teachers (Internal & External)', '1', '1'),
(239, 80, 'Recommended Reading', '1', '1'),
(240, 80, 'Recommendation (a, b, or c)', '1', '1');

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
(180, 23, 34, 'B', 'B', 'B', 'B', '2025-05-16'),
(192, 78, 35, 'A', 'A', 'S', 's', '2025-07-24'),
(192, 78, 36, 'AB', 'A', 'S', 's', '2025-07-23'),
(204, 75, 37, 'fgrg', 'rg', 'rwfwe', 'eqwe', '2025-07-31'),
(204, 75, 38, 'rgrg', 'rg', 'dqeww', 'qwew', '2025-07-31'),
(216, 79, 39, 'dw', 's', 's', 'd', '2025-08-16'),
(216, 79, 40, 'e', 'd', 'd', 'd', '2025-08-19'),
(228, 72, 41, 'sf', 's', 's', 's', '2025-08-08'),
(228, 72, 42, 'vrf', 's', 's', 's', '2025-08-19'),
(240, 80, 43, '1d', '1', '1', '1', '2025-08-16'),
(240, 80, 44, '2w2', '1', '1', '1', '2025-08-13');

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
(394, 14, 30, 'under_review_by_BTechAssistant', 'approvedbyTA', '2025-07-25 19:17:09'),
(395, 18, 21, 'submitted', 'approvedbydean', '2025-07-29 17:19:38'),
(396, 18, 22, 'approvedbydean', 'approvedbycqa', '2025-07-29 17:21:36'),
(397, 18, 23, 'approvedbycqa', 'approvedbyvc', '2025-07-29 17:21:50'),
(398, 18, 30, 'under_review_by_BTechAssistant', 'approvedbyTA', '2025-07-29 17:42:55'),
(399, 18, 28, 'approvedbyTA', 'approvedbysecretary', '2025-07-29 17:43:32'),
(400, 18, 7, 'approvedbysecretary', 'rejectedbyqachead', '2025-07-29 17:44:06'),
(401, 18, 21, 'submitted', 'approvedbydean', '2025-07-29 17:45:52'),
(402, 18, 22, 'approvedbydean', 'approvedbycqa', '2025-07-29 17:46:16'),
(403, 18, 26, 'under_review_by_ATechAssistant', 'approvedbyTA', '2025-07-29 17:47:22'),
(404, 18, 28, 'approvedbyTA', 'approvedbysecretary', '2025-07-29 17:47:44'),
(405, 18, 7, 'approvedbysecretary', 'resignature_request_from_university', '2025-07-29 17:48:28'),
(406, 18, 21, 'resignature_request_from_university', 're-signed_dean', '2025-07-29 17:48:57'),
(407, 18, 22, 're-signed_dean', 're-signed_cqa', '2025-07-29 17:49:11'),
(408, 18, 5, 're-signed_cqa', 're-signed_vc', '2025-07-29 17:49:22'),
(409, 18, 23, 're-signed_cqa', 're-signed_vc', '2025-07-29 17:51:17'),
(410, 18, 8, 're-signed_vc', 'approvedbyugcfinance', '2025-07-29 17:52:44'),
(411, 18, 9, 're-signed_vc', 'approvedbyugchr', '2025-07-29 17:53:02'),
(412, 18, 10, 're-signed_vc', 'approvedbyugcidd', '2025-07-29 17:53:17'),
(413, 18, 13, 're-signed_vc', 'approvedbyugcadmission', '2025-07-29 17:53:30'),
(414, 18, 12, 're-signed_vc', 'approvedbyugcacademic', '2025-07-29 17:53:56'),
(415, 18, 29, 'approvedbyalldepartments', 'rejectedbyStandardCommittee', '2025-07-29 18:14:32'),
(416, 18, 21, 'submitted', 'approvedbydean', '2025-07-29 18:18:21'),
(417, 18, 22, 'approvedbydean', 'approvedbycqa', '2025-07-29 18:18:40'),
(418, 18, 26, 'under_review_by_ATechAssistant', 'approvedbyTA', '2025-07-29 18:19:02'),
(419, 18, 28, 'approvedbyTA', 'approvedbysecretary', '2025-07-29 18:19:24'),
(420, 18, 7, 'approvedbysecretary', 'resignature_request_from_university', '2025-07-29 18:19:44'),
(421, 18, 21, 'resignature_request_from_university', 're-signed_dean', '2025-07-29 18:21:11'),
(422, 18, 22, 're-signed_dean', 're-signed_cqa', '2025-07-29 18:21:28'),
(423, 18, 23, 're-signed_cqa', 're-signed_vc', '2025-07-29 18:21:45'),
(424, 78, 21, 'submitted', 'approvedbydean', '2025-07-30 15:25:52'),
(425, 78, 22, 'approvedbydean', 'approvedbycqa', '2025-07-30 15:26:19'),
(426, 78, 23, 'approvedbycqa', 'approvedbyvc', '2025-07-30 15:26:31'),
(427, 78, 26, 'under_review_by_ATechAssistant', 'approvedbyTA', '2025-07-30 15:29:06'),
(428, 78, 28, 'approvedbyTA', 'approvedbysecretary', '2025-07-30 15:29:28'),
(429, 78, 7, 'approvedbysecretary', 'approvedbyqachead', '2025-07-30 15:29:46'),
(430, 78, 8, 'approvedbyqachead', 'approvedbyugcfinance', '2025-07-30 15:30:15'),
(431, 78, 9, 'approvedbyqachead', 'approvedbyugchr', '2025-07-30 15:30:26'),
(432, 78, 10, 'approvedbyqachead', 'approvedbyugcidd', '2025-07-30 15:30:56'),
(433, 78, 12, 'approvedbyqachead', 'approvedbyugcacademic', '2025-07-30 15:31:06'),
(434, 78, 13, 'approvedbyqachead', 'approvedbyugcadmission', '2025-07-30 15:31:24'),
(435, 78, 29, 'approvedbyalldepartments', 'approvedbyStandardCommittee', '2025-07-30 15:32:49'),
(436, 75, 3, 'submitted', 'approvedbydean', '2025-07-31 18:05:22'),
(437, 75, 6, 'approvedbydean', 'approvedbycqa', '2025-07-31 18:05:39'),
(438, 75, 5, 'approvedbycqa', 'approvedbyvc', '2025-07-31 18:05:51'),
(439, 75, 30, 'under_review_by_BTechAssistant', 'approvedbyTA', '2025-07-31 18:07:57'),
(440, 75, 28, 'approvedbyTA', 'approvedbysecretary', '2025-07-31 18:16:05'),
(441, 75, 7, 'approvedbysecretary', 'rejectedbyqachead', '2025-07-31 18:16:47'),
(442, 23, 3, 'submitted', 'approvedbydean', '2025-07-31 18:57:11'),
(443, 23, 6, 'approvedbydean', 'approvedbycqa', '2025-07-31 18:57:26'),
(444, 23, 5, 'approvedbycqa', 'approvedbyvc', '2025-07-31 18:58:13'),
(445, 23, 26, 'under_review_by_ATechAssistant', 'rejectedbyTA', '2025-07-31 19:00:44'),
(446, 23, 3, 'submitted', 'approvedbydean', '2025-07-31 19:03:15'),
(447, 23, 6, 'approvedbydean', 'approvedbycqa', '2025-07-31 19:03:29'),
(448, 79, 3, 'submitted', 'approvedbydean', '2025-07-31 19:11:51'),
(449, 79, 6, 'approvedbydean', 'approvedbycqa', '2025-07-31 19:12:07'),
(450, 79, 5, 'approvedbycqa', 'approvedbyvc', '2025-07-31 19:12:20'),
(451, 79, 30, 'under_review_by_BTechAssistant', 'rejectedbyTA', '2025-07-31 19:14:29'),
(452, 79, 3, 'submitted', 'approvedbydean', '2025-07-31 19:15:03'),
(453, 79, 6, 'approvedbydean', 'approvedbycqa', '2025-07-31 19:15:28'),
(454, 79, 5, 'approvedbycqa', 'approvedbyvc', '2025-07-31 19:15:41'),
(455, 79, 26, 'under_review_by_ATechAssistant', 'approvedbyTA', '2025-07-31 19:15:58'),
(456, 79, 28, 'approvedbyTA', 'rejectedbysecretary', '2025-07-31 19:16:07'),
(457, 79, 3, 'submitted', 'approvedbydean', '2025-07-31 19:16:35'),
(458, 79, 6, 'approvedbydean', 'approvedbycqa', '2025-07-31 19:16:46'),
(459, 79, 5, 'approvedbycqa', 'approvedbyvc', '2025-07-31 19:17:01'),
(460, 79, 30, 'under_review_by_BTechAssistant', 'approvedbyTA', '2025-07-31 19:17:21'),
(461, 79, 28, 'approvedbyTA', 'approvedbysecretary', '2025-07-31 19:17:31'),
(462, 79, 7, 'approvedbysecretary', 'rejectedbyqachead', '2025-07-31 19:17:42'),
(463, 79, 26, 'under_review_by_ATechAssistant', 'rejectedbyTA', '2025-07-31 19:22:14'),
(464, 23, 26, 'under_review_by_ATechAssistant', 'approvedbyTA', '2025-08-01 06:45:56'),
(465, 75, 3, 'submitted', 'approvedbydean', '2025-08-01 17:53:19'),
(466, 75, 6, 'approvedbydean', 'approvedbycqa', '2025-08-01 17:53:33'),
(467, 75, 26, 'under_review_by_ATechAssistant', 'approvedbyTA', '2025-08-01 17:53:59'),
(468, 75, 28, 'approvedbyTA', 'approvedbysecretary', '2025-08-01 17:54:12'),
(469, 75, 7, 'approvedbysecretary', 'approvedbyqachead_revised', '2025-08-01 17:54:30'),
(470, 75, 8, 'approvedbyqachead_revised', 'approvedbyugcfinance', '2025-08-01 17:55:08'),
(471, 75, 9, 'approvedbyqachead_revised', 'approvedbyugchr', '2025-08-01 17:55:26'),
(472, 75, 10, 'approvedbyqachead_revised', 'approvedbyugcidd', '2025-08-01 17:56:06'),
(473, 75, 12, 'approvedbyqachead_revised', 'approvedbyugcacademic', '2025-08-01 17:56:19'),
(474, 75, 13, 'approvedbyqachead_revised', 'approvedbyugcadmission', '2025-08-01 17:56:31'),
(475, 75, 3, 'resignature_request_from_university', 're-signed_dean', '2025-08-01 18:04:48'),
(476, 75, 6, 're-signed_dean', 're-signed_cqa', '2025-08-01 18:05:01'),
(477, 75, 5, 're-signed_cqa', 're-signed_vc', '2025-08-01 18:05:22'),
(478, 75, 29, 'approvedbyalldepartments', 'rejectedbyStandardCommittee', '2025-08-01 18:10:48'),
(479, 75, 3, 'submitted', 'approvedbydean', '2025-08-01 18:11:19'),
(480, 75, 6, 'approvedbydean', 'approvedbycqa', '2025-08-01 18:11:32'),
(481, 75, 26, 'under_review_by_ATechAssistant', 'approvedbyTA', '2025-08-01 18:11:52'),
(482, 75, 28, 'approvedbyTA', 'approvedbysecretary', '2025-08-01 18:12:04'),
(483, 75, 7, 'approvedbysecretary', 'approvedbyqachead_revised', '2025-08-01 18:12:20'),
(484, 79, 3, 'submitted', 'approvedbydean', '2025-08-01 18:22:16'),
(485, 3, 28, 'approvedbyTA', 'approvedbysecretary', '2025-08-01 18:49:22'),
(486, 3, 7, 'approvedbysecretary', 'approvedbyqachead', '2025-08-01 18:49:32'),
(487, 3, 8, 'approvedbyqachead', 'approvedbyugcfinance', '2025-08-01 18:51:33'),
(488, 3, 9, 'approvedbyqachead', 'approvedbyugchr', '2025-08-01 18:52:03'),
(489, 3, 10, 'approvedbyqachead', 'approvedbyugcidd', '2025-08-01 18:52:27'),
(490, 3, 12, 'approvedbyqachead', 'approvedbyugcacademic', '2025-08-01 18:52:41'),
(491, 3, 13, 'approvedbyqachead', 'approvedbyugcadmission', '2025-08-01 18:52:57'),
(492, 18, 8, 're-signed_vc', 'approvedbyugcfinance', '2025-08-01 18:57:05'),
(493, 18, 9, 're-signed_vc', 'approvedbyugchr', '2025-08-01 19:59:33'),
(494, 18, 10, 're-signed_vc', 'approvedbyugcidd', '2025-08-01 20:03:32'),
(495, 18, 12, 're-signed_vc', 'approvedbyugcacademic', '2025-08-01 20:04:04'),
(496, 18, 13, 're-signed_vc', 'approvedbyugcadmission', '2025-08-01 20:04:20'),
(497, 75, 9, 'approvedbyqachead_revised', 'approvedbyugchr', '2025-08-01 20:07:22'),
(498, 75, 8, 'approvedbyqachead_revised', 'approvedbyugcfinance', '2025-08-01 20:10:50'),
(499, 75, 9, 'approvedbyqachead_revised', 'approvedbyugchr', '2025-08-01 20:11:05'),
(500, 75, 10, 'approvedbyqachead_revised', 'approvedbyugcidd', '2025-08-01 20:11:15'),
(501, 75, 13, 'approvedbyqachead_revised', 'approvedbyugcadmission', '2025-08-01 20:13:40'),
(502, 75, 12, 'approvedbyqachead_revised', 'approvedbyugcacademic', '2025-08-01 20:13:58'),
(503, 13, 9, 're-signed_vc', 'approvedbyugchr', '2025-08-01 20:40:03'),
(504, 7, 8, 're-signed_vc', 'approvedbyugcfinance', '2025-08-01 20:48:45'),
(505, 7, 9, 're-signed_vc', 'approvedbyugchr', '2025-08-01 20:48:59'),
(506, 7, 10, 're-signed_vc', 'approvedbyugcidd', '2025-08-01 20:49:12'),
(507, 7, 12, 're-signed_vc', 'approvedbyugcacademic', '2025-08-01 20:49:28'),
(508, 7, 13, 're-signed_vc', 'approvedbyugcadmission', '2025-08-01 20:49:48'),
(509, 7, 12, 're-signed_vc', 'approvedbyugcacademic', '2025-08-01 20:50:04'),
(510, 7, 13, 're-signed_vc', 'approvedbyugcadmission', '2025-08-01 20:50:23'),
(511, 7, 12, 're-signed_vc', 'approvedbyugcacademic', '2025-08-01 20:50:48'),
(512, 7, 8, 're-signed_vc', 'approvedbyugcfinance', '2025-08-01 20:51:15'),
(513, 3, 8, 're-signed_vc', 'approvedbyugcfinance', '2025-08-01 20:52:17'),
(514, 3, 9, 're-signed_vc', 'approvedbyugchr', '2025-08-01 20:52:41'),
(515, 3, 10, 're-signed_vc', 'approvedbyugcidd', '2025-08-01 21:03:11'),
(516, 3, 12, 're-signed_vc', 'approvedbyugcacademic', '2025-08-01 21:03:23'),
(517, 3, 13, 're-signed_vc', 'approvedbyugcadmission', '2025-08-01 21:03:43'),
(518, 13, 10, 're-signed_vc', 'approvedbyugcidd', '2025-08-01 21:09:16'),
(519, 13, 12, 're-signed_vc', 'approvedbyugcacademic', '2025-08-01 21:09:32'),
(520, 13, 13, 're-signed_vc', 'approvedbyugcadmission', '2025-08-01 21:09:48'),
(521, 13, 8, 're-signed_vc', 'approvedbyugcfinance', '2025-08-01 21:12:22'),
(522, 7, 10, 're-signed_vc', 'approvedbyugcidd', '2025-08-01 21:13:55'),
(523, 7, 12, 're-signed_vc', 'approvedbyugcacademic', '2025-08-01 21:14:07'),
(524, 7, 13, 're-signed_vc', 'approvedbyugcadmission', '2025-08-01 21:14:25'),
(525, 72, 3, 'submitted', 'approvedbydean', '2025-08-01 21:27:50'),
(526, 72, 6, 'approvedbydean', 'approvedbycqa', '2025-08-01 21:28:00'),
(527, 72, 5, 'approvedbycqa', 'approvedbyvc', '2025-08-01 21:28:29'),
(528, 72, 26, 'under_review_by_ATechAssistant', 'approvedbyTA', '2025-08-01 21:30:56'),
(529, 72, 28, 'approvedbyTA', 'approvedbysecretary', '2025-08-01 21:31:14'),
(530, 72, 7, 'approvedbysecretary', 'approvedbyqachead', '2025-08-01 21:31:28'),
(531, 72, 8, 'approvedbyqachead', 'approvedbyugcfinance', '2025-08-01 21:32:30'),
(532, 72, 9, 'approvedbyqachead', 'approvedbyugchr', '2025-08-01 21:32:42'),
(533, 72, 10, 'approvedbyqachead', 'approvedbyugcidd', '2025-08-01 21:32:55'),
(534, 72, 12, 'approvedbyqachead', 'approvedbyugcacademic', '2025-08-01 21:33:06'),
(535, 72, 13, 'approvedbyqachead', 'approvedbyugcadmission', '2025-08-01 21:33:17'),
(536, 72, 8, 'approvedbyqachead', 'approvedbyugcfinance', '2025-08-01 21:56:29'),
(537, 7, 12, 're-signed_vc', 'approvedbyugcacademic', '2025-08-01 21:59:24'),
(538, 7, 3, 'submitted', 'approvedbydean', '2025-08-01 22:02:57'),
(539, 7, 6, 'approvedbydean', 'approvedbycqa', '2025-08-01 22:03:06'),
(540, 7, 30, 'under_review_by_BTechAssistant', 'approvedbyTA', '2025-08-01 22:04:35'),
(541, 7, 28, 'approvedbyTA', 'approvedbysecretary', '2025-08-01 22:04:54'),
(542, 7, 7, 'approvedbysecretary', 'approvedbyqachead_revised', '2025-08-01 22:05:25'),
(543, 7, 8, 'approvedbyqachead_revised', 'approvedbyugcfinance', '2025-08-01 22:05:38'),
(544, 7, 9, 'approvedbyqachead_revised', 'approvedbyugchr', '2025-08-01 22:05:47'),
(545, 7, 10, 'approvedbyqachead_revised', 'approvedbyugcidd', '2025-08-01 22:06:04'),
(546, 7, 12, 'approvedbyqachead_revised', 'approvedbyugcacademic', '2025-08-01 22:06:18'),
(547, 7, 13, 'approvedbyqachead_revised', 'approvedbyugcadmission', '2025-08-01 22:06:27'),
(548, 7, 7, 'approvedbysecretary', 'resignature_request_from_university', '2025-08-01 22:07:36'),
(549, 7, 3, 'resignature_request_from_university', 're-signed_dean', '2025-08-01 22:07:47'),
(550, 7, 6, 're-signed_dean', 're-signed_cqa', '2025-08-01 22:08:00'),
(551, 7, 5, 're-signed_cqa', 're-signed_vc', '2025-08-01 22:08:17'),
(552, 7, 8, 're-signed_vc', 'approvedbyugcfinance', '2025-08-01 22:08:28'),
(553, 7, 9, 're-signed_vc', 'approvedbyugchr', '2025-08-01 22:08:38'),
(554, 7, 10, 're-signed_vc', 'approvedbyugcidd', '2025-08-01 22:08:49'),
(555, 7, 12, 're-signed_vc', 'approvedbyugcacademic', '2025-08-01 22:08:59'),
(556, 7, 13, 're-signed_vc', 'approvedbyugcadmission', '2025-08-01 22:09:10');

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
(520, 14, 'compliance_check.membership_attachment', 'compliance', '', 30, '2025-07-25 19:17:09'),
(1106, 18, 'general_information.degree_name_english', 'compliance', '', 7, '2025-07-29 18:19:44'),
(1107, 18, 'general_information.degree_name_sinhala', 'compliance', '', 7, '2025-07-29 18:19:44'),
(1108, 18, 'general_information.degree_name_tamil', 'compliance', '', 7, '2025-07-29 18:19:44'),
(1109, 18, 'general_information.qualification_name_english', 'compliance', '', 7, '2025-07-29 18:19:44'),
(1110, 18, 'general_information.qualification_name_sinhala', 'compliance', 'Sinhala name correct.', 7, '2025-07-29 18:19:44'),
(1111, 18, 'general_information.qualification_name_tamil', 'compliance', '', 7, '2025-07-29 18:19:44'),
(1112, 18, 'general_information.abbreviated_qualification', 'compliance', '', 7, '2025-07-29 18:19:44'),
(1113, 18, 'program_entity.faculty', 'compliance', '', 7, '2025-07-29 18:19:44'),
(1114, 18, 'program_entity.department', 'compliance', '', 7, '2025-07-29 18:19:44'),
(1115, 18, 'program_entity.university', 'compliance', '', 7, '2025-07-29 18:19:44'),
(1116, 18, 'table.mandate_availability', 'compliance', '', 7, '2025-07-29 18:19:44'),
(1117, 18, 'degree_details.background_to_program', 'compliance', '', 7, '2025-07-29 18:19:44'),
(1118, 18, 'degree_details.mandate_faculty', 'compliance', '', 7, '2025-07-29 18:19:44'),
(1119, 18, 'degree_details.faculty_status', 'compliance', '', 7, '2025-07-29 18:19:44'),
(1120, 18, 'degree_details.student_intake', 'compliance', '', 7, '2025-07-29 18:19:44'),
(1121, 18, 'degree_details.staff_cadres', 'compliance', '', 7, '2025-07-29 18:19:44'),
(1122, 18, 'degree_details.educational_facilities', 'compliance', '', 7, '2025-07-29 18:19:44'),
(1123, 18, 'degree_details.common_facilities', 'compliance', '', 7, '2025-07-29 18:19:44'),
(1124, 18, 'degree_details.program_benefits', 'compliance', '', 7, '2025-07-29 18:19:44'),
(1125, 18, 'degree_details.eligibility_req', 'compliance', '', 7, '2025-07-29 18:19:44'),
(1126, 18, 'degree_details.indicate_program', 'compliance', '', 7, '2025-07-29 18:19:44'),
(1127, 18, 'degree_details.admission_process', 'compliance', '', 7, '2025-07-29 18:19:44'),
(1128, 18, 'degree_details.other_criteria', 'compliance', '', 7, '2025-07-29 18:19:44'),
(1129, 18, 'degree_details.intake', 'compliance', '', 7, '2025-07-29 18:19:44'),
(1130, 18, 'degree_details.degree_type', 'compliance', '', 7, '2025-07-29 18:19:44'),
(1131, 18, 'degree_details.duration', 'compliance', '', 7, '2025-07-29 18:19:44'),
(1132, 18, 'degree_details.coursework_credits', 'compliance', '', 7, '2025-07-29 18:19:44'),
(1133, 18, 'degree_details.thesis_credits', 'compliance', '', 7, '2025-07-29 18:19:44'),
(1134, 18, 'degree_details.total_credits', 'compliance', '', 7, '2025-07-29 18:19:44'),
(1135, 18, 'degree_details.medium_of_instruction', 'compliance', '', 7, '2025-07-29 18:19:44'),
(1136, 18, 'degree_details.subject_benchmark', 'compliance', '', 7, '2025-07-29 18:19:44'),
(1137, 18, 'degree_details.slqf_level', 'compliance', '', 7, '2025-07-29 18:19:44'),
(1138, 18, 'degree_details.slqf_filled', 'compliance', '', 7, '2025-07-29 18:19:44'),
(1139, 18, 'degree_details.rec_in_review_report', 'compliance', '', 7, '2025-07-29 18:19:44'),
(1140, 18, 'degree_details.degree_details_objective', 'compliance', '', 7, '2025-07-29 18:19:44'),
(1141, 18, 'degree_details.degree_details_justification', 'compliance', '', 7, '2025-07-29 18:19:44'),
(1142, 18, 'table.program_grades', 'compliance', '', 7, '2025-07-29 18:19:44'),
(1143, 18, 'table.program_structure', 'compliance', '', 7, '2025-07-29 18:19:44'),
(1144, 18, 'table.program_content', 'compliance', '', 7, '2025-07-29 18:19:44'),
(1145, 18, 'program_delivery_and_learner_support_system.program_delivery_description', 'compliance', '', 7, '2025-07-29 18:19:44'),
(1146, 18, 'program_assessment_rules_and_precodures.formative_summative', 'compliance', '', 7, '2025-07-29 18:19:44'),
(1147, 18, 'program_assessment_rules_and_precodures.grading_scheme', 'compliance', '', 7, '2025-07-29 18:19:44'),
(1148, 18, 'program_assessment_rules_and_precodures.gpa_calculation', 'compliance', '', 7, '2025-07-29 18:19:44'),
(1149, 18, 'program_assessment_rules_and_precodures.semester_contribution', 'compliance', '', 7, '2025-07-29 18:19:44'),
(1150, 18, 'program_assessment_rules_and_precodures.inplant_training', 'compliance', '', 7, '2025-07-29 18:19:44'),
(1151, 18, 'program_assessment_rules_and_precodures.repeat_exams', 'compliance', '', 7, '2025-07-29 18:19:44'),
(1152, 18, 'program_assessment_rules_and_precodures.degree_requirements', 'compliance', '', 7, '2025-07-29 18:19:44'),
(1153, 18, 'program_assessment_rules_and_precodures.class_requirements', 'compliance', '', 7, '2025-07-29 18:19:44'),
(1154, 18, 'table.human_resources', 'compliance', '', 7, '2025-07-29 18:19:44'),
(1155, 18, 'table.physical_resources', 'compliance', '', 7, '2025-07-29 18:19:44'),
(1156, 18, 'table.financial_resources', 'compliance', '', 7, '2025-07-29 18:19:44'),
(1157, 18, 'table.panel_of_teachers', 'compliance', '', 7, '2025-07-29 18:19:44'),
(1158, 18, 'table.reviewers_report', 'compliance', '', 7, '2025-07-29 18:19:44'),
(1159, 18, 'table.reviewer_details', 'compliance', '', 7, '2025-07-29 18:19:44'),
(1160, 18, 'compliance_check.resources_commence', 'compliance', '', 7, '2025-07-29 18:19:44'),
(1161, 18, 'compliance_check.fallback_options', 'compliance', '', 7, '2025-07-29 18:19:44'),
(1162, 18, 'compliance_check.fallback_qualification', 'compliance', '', 7, '2025-07-29 18:19:44'),
(1163, 18, 'compliance_check.collaboration', 'compliance', '', 7, '2025-07-29 18:19:44'),
(1164, 18, 'compliance_check.collaboration_details', 'compliance', '', 7, '2025-07-29 18:19:44'),
(1165, 18, 'compliance_check.access_facilities', 'compliance', '', 7, '2025-07-29 18:19:44'),
(1166, 18, 'compliance_check.professional_membership', 'compliance', '', 7, '2025-07-29 18:19:44'),
(1167, 18, 'compliance_check.fallback_attachment', 'compliance', '', 7, '2025-07-29 18:19:44'),
(1168, 18, 'compliance_check.collaboration_attachment', 'compliance', '', 7, '2025-07-29 18:19:44'),
(1169, 18, 'compliance_check.access_facilities_attachment', 'compliance', '', 7, '2025-07-29 18:19:44'),
(1170, 18, 'compliance_check.membership_attachment', 'compliance', '', 7, '2025-07-29 18:19:44'),
(1366, 78, 'general_information.degree_name_english', 'compliance', '', 29, '2025-07-30 15:32:49'),
(1367, 78, 'general_information.degree_name_sinhala', 'compliance', '', 29, '2025-07-30 15:32:49'),
(1368, 78, 'general_information.degree_name_tamil', 'compliance', '', 29, '2025-07-30 15:32:49'),
(1369, 78, 'general_information.qualification_name_english', 'compliance', '', 29, '2025-07-30 15:32:49'),
(1370, 78, 'general_information.qualification_name_sinhala', 'compliance', '', 29, '2025-07-30 15:32:49'),
(1371, 78, 'general_information.qualification_name_tamil', 'compliance', '', 29, '2025-07-31 18:38:09'),
(1372, 78, 'general_information.abbreviated_qualification', 'compliance', '', 29, '2025-07-30 15:32:49'),
(1373, 78, 'program_entity.faculty', 'compliance', '', 29, '2025-07-31 18:37:07'),
(1374, 78, 'program_entity.department', 'compliance', '', 29, '2025-07-30 15:32:49'),
(1375, 78, 'program_entity.university', 'compliance', '', 29, '2025-07-30 15:32:49'),
(1376, 78, 'table.mandate_availability', 'compliance', '', 29, '2025-07-30 15:32:49'),
(1377, 78, 'degree_details.background_to_program', 'compliance', '', 29, '2025-07-30 15:32:49'),
(1378, 78, 'degree_details.mandate_faculty', 'compliance', '', 29, '2025-07-30 15:32:49'),
(1379, 78, 'degree_details.faculty_status', 'compliance', '', 29, '2025-07-30 15:32:49'),
(1380, 78, 'degree_details.student_intake', 'compliance', 'Ok.', 29, '2025-07-30 15:32:49'),
(1381, 78, 'degree_details.staff_cadres', 'compliance', '', 29, '2025-07-30 15:32:49'),
(1382, 78, 'degree_details.educational_facilities', 'compliance', '', 29, '2025-07-30 15:32:49'),
(1383, 78, 'degree_details.common_facilities', 'compliance', '', 29, '2025-07-30 15:32:49'),
(1384, 78, 'degree_details.program_benefits', 'compliance', '', 29, '2025-07-30 15:32:49'),
(1385, 78, 'degree_details.eligibility_req', 'compliance', '', 29, '2025-07-30 15:32:49'),
(1386, 78, 'degree_details.indicate_program', 'compliance', '', 29, '2025-07-30 15:32:49'),
(1387, 78, 'degree_details.admission_process', 'compliance', '', 29, '2025-07-30 15:32:49'),
(1388, 78, 'degree_details.other_criteria', 'compliance', '', 29, '2025-07-30 15:32:49'),
(1389, 78, 'degree_details.intake', 'compliance', '', 29, '2025-07-30 15:32:49'),
(1390, 78, 'degree_details.degree_type', 'compliance', '', 29, '2025-07-30 15:32:49'),
(1391, 78, 'degree_details.duration', 'compliance', '', 29, '2025-07-30 15:32:49'),
(1392, 78, 'degree_details.coursework_credits', 'compliance', '', 29, '2025-07-30 15:32:49'),
(1393, 78, 'degree_details.thesis_credits', 'compliance', '', 29, '2025-07-30 15:32:49'),
(1394, 78, 'degree_details.total_credits', 'compliance', '', 29, '2025-07-30 15:32:49'),
(1395, 78, 'degree_details.medium_of_instruction', 'compliance', '', 29, '2025-07-30 15:32:49'),
(1396, 78, 'degree_details.subject_benchmark', 'compliance', '', 29, '2025-07-30 15:32:49'),
(1397, 78, 'degree_details.slqf_level', 'compliance', '', 29, '2025-07-30 15:32:49'),
(1398, 78, 'degree_details.slqf_filled', 'compliance', '', 29, '2025-07-30 15:32:49'),
(1399, 78, 'degree_details.rec_in_review_report', 'compliance', '', 29, '2025-07-30 15:32:49'),
(1400, 78, 'degree_details.degree_details_objective', 'compliance', '', 29, '2025-07-30 15:32:49'),
(1401, 78, 'degree_details.degree_details_justification', 'compliance', '', 29, '2025-07-30 15:32:49'),
(1402, 78, 'table.program_grades', 'compliance', '', 29, '2025-07-30 15:32:49'),
(1403, 78, 'table.program_structure', 'compliance', '', 29, '2025-07-30 15:32:49'),
(1404, 78, 'table.program_content', 'compliance', '', 29, '2025-07-30 15:32:49'),
(1405, 78, 'program_delivery_and_learner_support_system.program_delivery_description', 'compliance', '', 29, '2025-07-30 15:32:49'),
(1406, 78, 'program_assessment_rules_and_precodures.formative_summative', 'compliance', '', 29, '2025-07-30 15:32:49'),
(1407, 78, 'program_assessment_rules_and_precodures.grading_scheme', 'compliance', '', 29, '2025-07-30 15:32:49'),
(1408, 78, 'program_assessment_rules_and_precodures.gpa_calculation', 'compliance', '', 29, '2025-07-30 15:32:49'),
(1409, 78, 'program_assessment_rules_and_precodures.semester_contribution', 'compliance', '', 29, '2025-07-30 15:32:49'),
(1410, 78, 'program_assessment_rules_and_precodures.inplant_training', 'compliance', '', 29, '2025-07-30 15:32:49'),
(1411, 78, 'program_assessment_rules_and_precodures.repeat_exams', 'compliance', '', 29, '2025-07-30 15:32:49'),
(1412, 78, 'program_assessment_rules_and_precodures.degree_requirements', 'compliance', '', 29, '2025-07-30 15:32:49'),
(1413, 78, 'program_assessment_rules_and_precodures.class_requirements', 'compliance', '', 29, '2025-07-30 15:32:49'),
(1414, 78, 'table.human_resources', 'compliance', '', 29, '2025-07-30 15:32:49'),
(1415, 78, 'table.physical_resources', 'compliance', '', 29, '2025-07-30 15:32:49'),
(1416, 78, 'table.financial_resources', 'compliance', '', 29, '2025-07-30 15:32:49'),
(1417, 78, 'table.panel_of_teachers', 'compliance', '', 29, '2025-07-30 15:32:49'),
(1418, 78, 'table.reviewers_report', 'compliance', '', 29, '2025-07-30 15:32:49'),
(1419, 78, 'table.reviewer_details', 'compliance', '', 29, '2025-07-30 15:32:49'),
(1420, 78, 'compliance_check.resources_commence', 'compliance', '', 29, '2025-07-30 15:32:49'),
(1421, 78, 'compliance_check.fallback_options', 'compliance', '', 29, '2025-07-30 15:32:49'),
(1422, 78, 'compliance_check.fallback_qualification', 'compliance', '', 29, '2025-07-30 15:32:49'),
(1423, 78, 'compliance_check.collaboration', 'compliance', '', 29, '2025-07-30 15:32:49'),
(1424, 78, 'compliance_check.collaboration_details', 'compliance', '', 29, '2025-07-30 15:32:49'),
(1425, 78, 'compliance_check.access_facilities', 'compliance', '', 29, '2025-07-30 15:32:49'),
(1426, 78, 'compliance_check.professional_membership', 'compliance', '', 29, '2025-07-30 15:32:49'),
(1427, 78, 'compliance_check.fallback_attachment', 'compliance', '', 29, '2025-07-30 15:32:49'),
(1428, 78, 'compliance_check.collaboration_attachment', 'compliance', '', 29, '2025-07-30 15:32:49'),
(1429, 78, 'compliance_check.access_facilities_attachment', 'compliance', '', 29, '2025-07-30 15:32:49'),
(1430, 78, 'compliance_check.membership_attachment', 'compliance', '', 29, '2025-07-30 15:32:49'),
(2081, 79, 'general_information.degree_name_english', 'compliance', '', 26, '2025-07-31 19:22:14'),
(2082, 79, 'general_information.degree_name_sinhala', 'compliance', '', 26, '2025-07-31 19:22:14'),
(2083, 79, 'general_information.degree_name_tamil', 'compliance', '', 26, '2025-07-31 19:22:14'),
(2084, 79, 'general_information.qualification_name_english', 'compliance', '', 26, '2025-07-31 19:22:14'),
(2085, 79, 'general_information.qualification_name_sinhala', 'non_compliance', '', 26, '2025-07-31 19:22:14'),
(2086, 79, 'general_information.qualification_name_tamil', 'non_compliance', '', 26, '2025-07-31 19:22:14'),
(2087, 79, 'general_information.abbreviated_qualification', 'non_compliance', '', 26, '2025-07-31 19:22:14'),
(2088, 79, 'program_entity.faculty', 'non_compliance', '', 26, '2025-07-31 19:22:14'),
(2089, 79, 'program_entity.department', 'non_compliance', '', 26, '2025-07-31 19:22:14'),
(2090, 79, 'program_entity.university', 'non_compliance', '', 26, '2025-07-31 19:22:14'),
(2091, 79, 'table.mandate_availability', 'non_compliance', '', 26, '2025-07-31 19:22:14'),
(2092, 79, 'degree_details.background_to_program', 'non_compliance', '', 26, '2025-07-31 19:22:14'),
(2093, 79, 'degree_details.mandate_faculty', 'non_compliance', '', 26, '2025-07-31 19:22:14'),
(2094, 79, 'degree_details.faculty_status', 'non_compliance', '', 26, '2025-07-31 19:22:14'),
(2095, 79, 'degree_details.student_intake', 'non_compliance', '', 26, '2025-07-31 19:22:14'),
(2096, 79, 'degree_details.staff_cadres', 'non_compliance', '', 26, '2025-07-31 19:22:14'),
(2097, 79, 'degree_details.educational_facilities', 'non_compliance', '', 26, '2025-07-31 19:22:14'),
(2098, 79, 'degree_details.common_facilities', 'compliance', '', 26, '2025-07-31 19:22:14'),
(2099, 79, 'degree_details.program_benefits', 'compliance', '', 26, '2025-07-31 19:22:14'),
(2100, 79, 'degree_details.eligibility_req', 'compliance', '', 26, '2025-07-31 19:22:14'),
(2101, 79, 'degree_details.indicate_program', 'compliance', '', 26, '2025-07-31 19:22:14'),
(2102, 79, 'degree_details.admission_process', 'compliance', '', 26, '2025-07-31 19:22:14'),
(2103, 79, 'degree_details.other_criteria', 'compliance', '', 26, '2025-07-31 19:22:14'),
(2104, 79, 'degree_details.intake', 'compliance', '', 26, '2025-07-31 19:22:14'),
(2105, 79, 'degree_details.degree_type', 'compliance', '', 26, '2025-07-31 19:22:14'),
(2106, 79, 'degree_details.duration', 'compliance', '', 26, '2025-07-31 19:22:14'),
(2107, 79, 'degree_details.coursework_credits', 'compliance', '', 26, '2025-07-31 19:22:14'),
(2108, 79, 'degree_details.thesis_credits', 'compliance', '', 26, '2025-07-31 19:22:14'),
(2109, 79, 'degree_details.total_credits', 'compliance', '', 26, '2025-07-31 19:22:14'),
(2110, 79, 'degree_details.medium_of_instruction', 'compliance', '', 26, '2025-07-31 19:22:14'),
(2111, 79, 'degree_details.subject_benchmark', 'compliance', '', 26, '2025-07-31 19:22:14'),
(2112, 79, 'degree_details.slqf_level', 'compliance', '', 26, '2025-07-31 19:22:14'),
(2113, 79, 'degree_details.slqf_filled', 'compliance', '', 26, '2025-07-31 19:22:14'),
(2114, 79, 'degree_details.rec_in_review_report', 'compliance', '', 26, '2025-07-31 19:22:14'),
(2115, 79, 'degree_details.degree_details_objective', 'compliance', '', 26, '2025-07-31 19:22:14'),
(2116, 79, 'degree_details.degree_details_justification', 'compliance', '', 26, '2025-07-31 19:22:14'),
(2117, 79, 'table.program_grades', 'compliance', '', 26, '2025-07-31 19:22:14'),
(2118, 79, 'table.program_structure', 'compliance', '', 26, '2025-07-31 19:22:14'),
(2119, 79, 'table.program_content', 'compliance', '', 26, '2025-07-31 19:22:14'),
(2120, 79, 'program_delivery_and_learner_support_system.program_delivery_description', 'compliance', '', 26, '2025-07-31 19:22:14'),
(2121, 79, 'program_assessment_rules_and_precodures.formative_summative', 'compliance', '', 26, '2025-07-31 19:22:14'),
(2122, 79, 'program_assessment_rules_and_precodures.grading_scheme', 'compliance', '', 26, '2025-07-31 19:22:14'),
(2123, 79, 'program_assessment_rules_and_precodures.gpa_calculation', 'compliance', '', 26, '2025-07-31 19:22:14'),
(2124, 79, 'program_assessment_rules_and_precodures.semester_contribution', 'compliance', '', 26, '2025-07-31 19:22:14'),
(2125, 79, 'program_assessment_rules_and_precodures.inplant_training', 'compliance', '', 26, '2025-07-31 19:22:14'),
(2126, 79, 'program_assessment_rules_and_precodures.repeat_exams', 'compliance', '', 26, '2025-07-31 19:22:14'),
(2127, 79, 'program_assessment_rules_and_precodures.degree_requirements', 'compliance', '', 26, '2025-07-31 19:22:14'),
(2128, 79, 'program_assessment_rules_and_precodures.class_requirements', 'compliance', '', 26, '2025-07-31 19:22:14'),
(2129, 79, 'table.human_resources', 'compliance', '', 26, '2025-07-31 19:22:14'),
(2130, 79, 'table.physical_resources', 'compliance', '', 26, '2025-07-31 19:22:14'),
(2131, 79, 'table.financial_resources', 'compliance', '', 26, '2025-07-31 19:22:14'),
(2132, 79, 'table.panel_of_teachers', 'compliance', '', 26, '2025-07-31 19:22:14'),
(2133, 79, 'table.reviewers_report', 'compliance', '', 26, '2025-07-31 19:22:14'),
(2134, 79, 'table.reviewer_details', 'compliance', '', 26, '2025-07-31 19:22:14'),
(2135, 79, 'compliance_check.resources_commence', 'compliance', '', 26, '2025-07-31 19:22:14'),
(2136, 79, 'compliance_check.fallback_options', 'compliance', '', 26, '2025-07-31 19:22:14'),
(2137, 79, 'compliance_check.fallback_qualification', 'compliance', '', 26, '2025-07-31 19:22:14'),
(2138, 79, 'compliance_check.collaboration', 'compliance', '', 26, '2025-07-31 19:22:14'),
(2139, 79, 'compliance_check.collaboration_details', 'compliance', '', 26, '2025-07-31 19:22:14'),
(2140, 79, 'compliance_check.access_facilities', 'compliance', '', 26, '2025-07-31 19:22:14'),
(2141, 79, 'compliance_check.professional_membership', 'compliance', '', 26, '2025-07-31 19:22:14'),
(2142, 79, 'compliance_check.fallback_attachment', 'compliance', '', 26, '2025-07-31 19:22:14'),
(2143, 79, 'compliance_check.collaboration_attachment', 'compliance', '', 26, '2025-07-31 19:22:14'),
(2144, 79, 'compliance_check.access_facilities_attachment', 'compliance', '', 26, '2025-07-31 19:22:14'),
(2145, 79, 'compliance_check.membership_attachment', 'compliance', '', 26, '2025-07-31 19:22:14'),
(2146, 23, 'general_information.degree_name_english', 'compliance', '', 26, '2025-08-01 06:45:56'),
(2147, 23, 'general_information.degree_name_sinhala', 'compliance', '', 26, '2025-08-01 06:45:56'),
(2148, 23, 'general_information.degree_name_tamil', 'compliance', '', 26, '2025-08-01 06:45:56'),
(2149, 23, 'general_information.qualification_name_english', 'compliance', '', 26, '2025-08-01 06:45:56'),
(2150, 23, 'general_information.qualification_name_sinhala', 'compliance', '', 26, '2025-08-01 06:45:56'),
(2151, 23, 'general_information.qualification_name_tamil', 'compliance', '', 26, '2025-08-01 06:45:56'),
(2152, 23, 'general_information.abbreviated_qualification', 'compliance', '', 26, '2025-08-01 06:45:56'),
(2153, 23, 'program_entity.faculty', 'compliance', '', 26, '2025-08-01 06:45:56'),
(2154, 23, 'program_entity.department', 'compliance', '', 26, '2025-08-01 06:45:56'),
(2155, 23, 'program_entity.university', 'compliance', '', 26, '2025-08-01 06:45:56'),
(2156, 23, 'table.mandate_availability', 'non_compliance', 'Can\'t see evidence attachments. ', 26, '2025-08-01 06:45:56'),
(2157, 23, 'degree_details.background_to_program', 'compliance', '', 26, '2025-08-01 06:45:56'),
(2158, 23, 'degree_details.mandate_faculty', 'compliance', '', 26, '2025-08-01 06:45:56'),
(2159, 23, 'degree_details.faculty_status', 'compliance', '', 26, '2025-08-01 06:45:56'),
(2160, 23, 'degree_details.student_intake', 'compliance', '', 26, '2025-08-01 06:45:56'),
(2161, 23, 'degree_details.staff_cadres', 'compliance', '', 26, '2025-08-01 06:45:56'),
(2162, 23, 'degree_details.educational_facilities', 'compliance', '', 26, '2025-08-01 06:45:56'),
(2163, 23, 'degree_details.common_facilities', 'compliance', '', 26, '2025-08-01 06:45:56'),
(2164, 23, 'degree_details.program_benefits', 'compliance', '', 26, '2025-08-01 06:45:56'),
(2165, 23, 'degree_details.eligibility_req', 'compliance', '', 26, '2025-08-01 06:45:56'),
(2166, 23, 'degree_details.indicate_program', 'compliance', '', 26, '2025-08-01 06:45:56'),
(2167, 23, 'degree_details.admission_process', 'compliance', '', 26, '2025-08-01 06:45:56'),
(2168, 23, 'degree_details.other_criteria', 'compliance', '', 26, '2025-08-01 06:45:56'),
(2169, 23, 'degree_details.intake', 'compliance', '', 26, '2025-08-01 06:45:56'),
(2170, 23, 'degree_details.degree_type', 'compliance', '', 26, '2025-08-01 06:45:56'),
(2171, 23, 'degree_details.duration', 'compliance', '', 26, '2025-08-01 06:45:56'),
(2172, 23, 'degree_details.coursework_credits', 'compliance', '', 26, '2025-08-01 06:45:56'),
(2173, 23, 'degree_details.thesis_credits', 'compliance', '', 26, '2025-08-01 06:45:56'),
(2174, 23, 'degree_details.total_credits', 'compliance', '', 26, '2025-08-01 06:45:56'),
(2175, 23, 'degree_details.medium_of_instruction', 'compliance', '', 26, '2025-08-01 06:45:56'),
(2176, 23, 'degree_details.subject_benchmark', 'compliance', '', 26, '2025-08-01 06:45:56'),
(2177, 23, 'degree_details.slqf_level', 'compliance', '', 26, '2025-08-01 06:45:56'),
(2178, 23, 'degree_details.slqf_filled', 'compliance', '', 26, '2025-08-01 06:45:56'),
(2179, 23, 'degree_details.rec_in_review_report', 'compliance', '', 26, '2025-08-01 06:45:56'),
(2180, 23, 'degree_details.degree_details_objective', 'compliance', '', 26, '2025-08-01 06:45:56'),
(2181, 23, 'degree_details.degree_details_justification', 'compliance', '', 26, '2025-08-01 06:45:56'),
(2182, 23, 'table.program_grades', 'compliance', '', 26, '2025-08-01 06:45:56'),
(2183, 23, 'table.program_structure', 'compliance', '', 26, '2025-08-01 06:45:56'),
(2184, 23, 'table.program_content', 'compliance', '', 26, '2025-08-01 06:45:56'),
(2185, 23, 'program_delivery_and_learner_support_system.program_delivery_description', 'compliance', '', 26, '2025-08-01 06:45:56'),
(2186, 23, 'program_assessment_rules_and_precodures.formative_summative', 'compliance', '', 26, '2025-08-01 06:45:56'),
(2187, 23, 'program_assessment_rules_and_precodures.grading_scheme', 'compliance', '', 26, '2025-08-01 06:45:56'),
(2188, 23, 'program_assessment_rules_and_precodures.gpa_calculation', 'compliance', '', 26, '2025-08-01 06:45:56'),
(2189, 23, 'program_assessment_rules_and_precodures.semester_contribution', 'compliance', '', 26, '2025-08-01 06:45:56'),
(2190, 23, 'program_assessment_rules_and_precodures.inplant_training', 'compliance', '', 26, '2025-08-01 06:45:56'),
(2191, 23, 'program_assessment_rules_and_precodures.repeat_exams', 'compliance', '', 26, '2025-08-01 06:45:56'),
(2192, 23, 'program_assessment_rules_and_precodures.degree_requirements', 'compliance', '', 26, '2025-08-01 06:45:56'),
(2193, 23, 'program_assessment_rules_and_precodures.class_requirements', 'compliance', '', 26, '2025-08-01 06:45:56'),
(2194, 23, 'table.human_resources', 'compliance', '', 26, '2025-08-01 06:45:56'),
(2195, 23, 'table.physical_resources', 'compliance', '', 26, '2025-08-01 06:45:56'),
(2196, 23, 'table.financial_resources', 'compliance', '', 26, '2025-08-01 06:45:56'),
(2197, 23, 'table.panel_of_teachers', 'non_compliance', 'Data duplications.', 26, '2025-08-01 06:45:56'),
(2198, 23, 'table.reviewers_report', 'compliance', '', 26, '2025-08-01 06:45:56'),
(2199, 23, 'table.reviewer_details', 'compliance', '', 26, '2025-08-01 06:45:56'),
(2200, 23, 'compliance_check.resources_commence', 'compliance', '', 26, '2025-08-01 06:45:56'),
(2201, 23, 'compliance_check.fallback_options', 'compliance', '', 26, '2025-08-01 06:45:56'),
(2202, 23, 'compliance_check.fallback_qualification', 'compliance', '', 26, '2025-08-01 06:45:56'),
(2203, 23, 'compliance_check.collaboration', 'compliance', '', 26, '2025-08-01 06:45:56'),
(2204, 23, 'compliance_check.collaboration_details', 'compliance', '', 26, '2025-08-01 06:45:56'),
(2205, 23, 'compliance_check.access_facilities', 'compliance', '', 26, '2025-08-01 06:45:56'),
(2206, 23, 'compliance_check.professional_membership', 'compliance', '', 26, '2025-08-01 06:45:56'),
(2207, 23, 'compliance_check.fallback_attachment', 'compliance', '', 26, '2025-08-01 06:45:56'),
(2208, 23, 'compliance_check.collaboration_attachment', 'compliance', '', 26, '2025-08-01 06:45:56'),
(2209, 23, 'compliance_check.access_facilities_attachment', 'compliance', '', 26, '2025-08-01 06:45:56'),
(2210, 23, 'compliance_check.membership_attachment', 'compliance', '', 26, '2025-08-01 06:45:56'),
(2595, 75, 'general_information.degree_name_english', 'compliance', '', 7, '2025-08-01 18:12:20'),
(2596, 75, 'general_information.degree_name_sinhala', 'non_compliance', 'REVISE CHECK', 7, '2025-08-01 18:12:20'),
(2597, 75, 'general_information.degree_name_tamil', 'compliance', '', 7, '2025-08-01 18:12:20'),
(2598, 75, 'general_information.qualification_name_english', 'compliance', '', 7, '2025-08-01 18:12:20'),
(2599, 75, 'general_information.qualification_name_sinhala', 'compliance', '', 7, '2025-08-01 18:12:20'),
(2600, 75, 'general_information.qualification_name_tamil', 'compliance', '', 7, '2025-08-01 18:12:20'),
(2601, 75, 'general_information.abbreviated_qualification', 'compliance', '', 7, '2025-08-01 18:12:20'),
(2602, 75, 'program_entity.faculty', 'compliance', '', 7, '2025-08-01 18:12:20'),
(2603, 75, 'program_entity.department', 'compliance', '', 7, '2025-08-01 18:12:20'),
(2604, 75, 'program_entity.university', 'compliance', '', 7, '2025-08-01 18:12:20'),
(2605, 75, 'table.mandate_availability', 'compliance', '', 7, '2025-08-01 18:12:20'),
(2606, 75, 'degree_details.background_to_program', 'compliance', '', 7, '2025-08-01 18:12:20'),
(2607, 75, 'degree_details.mandate_faculty', 'compliance', '', 7, '2025-08-01 18:12:20'),
(2608, 75, 'degree_details.faculty_status', 'compliance', '', 7, '2025-08-01 18:12:20'),
(2609, 75, 'degree_details.student_intake', 'compliance', '', 7, '2025-08-01 18:12:20'),
(2610, 75, 'degree_details.staff_cadres', 'non_compliance', 'CHECK', 7, '2025-08-01 18:12:20'),
(2611, 75, 'degree_details.educational_facilities', 'compliance', '', 7, '2025-08-01 18:12:20'),
(2612, 75, 'degree_details.common_facilities', 'compliance', '', 7, '2025-08-01 18:12:20'),
(2613, 75, 'degree_details.program_benefits', 'compliance', '', 7, '2025-08-01 18:12:20'),
(2614, 75, 'degree_details.eligibility_req', 'compliance', '', 7, '2025-08-01 18:12:20'),
(2615, 75, 'degree_details.indicate_program', 'compliance', '', 7, '2025-08-01 18:12:20'),
(2616, 75, 'degree_details.admission_process', 'compliance', '', 7, '2025-08-01 18:12:20'),
(2617, 75, 'degree_details.other_criteria', 'compliance', '', 7, '2025-08-01 18:12:20'),
(2618, 75, 'degree_details.intake', 'compliance', '', 7, '2025-08-01 18:12:20'),
(2619, 75, 'degree_details.degree_type', 'compliance', '', 7, '2025-08-01 18:12:20'),
(2620, 75, 'degree_details.duration', 'compliance', '', 7, '2025-08-01 18:12:20'),
(2621, 75, 'degree_details.coursework_credits', 'compliance', '', 7, '2025-08-01 18:12:20'),
(2622, 75, 'degree_details.thesis_credits', 'compliance', '', 7, '2025-08-01 18:12:20'),
(2623, 75, 'degree_details.total_credits', 'compliance', '', 7, '2025-08-01 18:12:20'),
(2624, 75, 'degree_details.medium_of_instruction', 'compliance', '', 7, '2025-08-01 18:12:20'),
(2625, 75, 'degree_details.subject_benchmark', 'compliance', '', 7, '2025-08-01 18:12:20'),
(2626, 75, 'degree_details.slqf_level', 'compliance', '', 7, '2025-08-01 18:12:20'),
(2627, 75, 'degree_details.slqf_filled', 'compliance', '', 7, '2025-08-01 18:12:20'),
(2628, 75, 'degree_details.rec_in_review_report', 'compliance', '', 7, '2025-08-01 18:12:20'),
(2629, 75, 'degree_details.degree_details_objective', 'compliance', '', 7, '2025-08-01 18:12:20'),
(2630, 75, 'degree_details.degree_details_justification', 'compliance', '', 7, '2025-08-01 18:12:20'),
(2631, 75, 'table.program_structure', 'compliance', '', 7, '2025-08-01 18:12:20'),
(2632, 75, 'table.program_content', 'compliance', '', 7, '2025-08-01 18:12:20'),
(2633, 75, 'program_delivery_and_learner_support_system.program_delivery_description', 'compliance', '', 7, '2025-08-01 18:12:20'),
(2634, 75, 'program_assessment_rules_and_precodures.formative_summative', 'compliance', '', 7, '2025-08-01 18:12:20'),
(2635, 75, 'program_assessment_rules_and_precodures.grading_scheme', 'compliance', '', 7, '2025-08-01 18:12:20'),
(2636, 75, 'program_assessment_rules_and_precodures.gpa_calculation', 'compliance', '', 7, '2025-08-01 18:12:20'),
(2637, 75, 'program_assessment_rules_and_precodures.semester_contribution', 'compliance', '', 7, '2025-08-01 18:12:20'),
(2638, 75, 'program_assessment_rules_and_precodures.inplant_training', 'compliance', '', 7, '2025-08-01 18:12:20'),
(2639, 75, 'program_assessment_rules_and_precodures.repeat_exams', 'compliance', '', 7, '2025-08-01 18:12:20'),
(2640, 75, 'program_assessment_rules_and_precodures.degree_requirements', 'compliance', '', 7, '2025-08-01 18:12:20'),
(2641, 75, 'program_assessment_rules_and_precodures.class_requirements', 'compliance', '', 7, '2025-08-01 18:12:20'),
(2642, 75, 'table.human_resources', 'compliance', '', 7, '2025-08-01 18:12:20'),
(2643, 75, 'table.physical_resources', 'compliance', '', 7, '2025-08-01 18:12:20'),
(2644, 75, 'table.financial_resources', 'compliance', '', 7, '2025-08-01 18:12:20'),
(2645, 75, 'table.panel_of_teachers', 'compliance', '', 7, '2025-08-01 18:12:20'),
(2646, 75, 'table.reviewers_report', 'compliance', '', 7, '2025-08-01 18:12:20'),
(2647, 75, 'table.reviewer_details', 'compliance', '', 7, '2025-08-01 18:12:20'),
(2648, 75, 'compliance_check.resources_commence', 'compliance', '', 7, '2025-08-01 18:12:20'),
(2649, 75, 'compliance_check.fallback_options', 'compliance', '', 7, '2025-08-01 18:12:20'),
(2650, 75, 'compliance_check.fallback_qualification', 'compliance', '', 7, '2025-08-01 18:12:20'),
(2651, 75, 'compliance_check.collaboration', 'compliance', '', 7, '2025-08-01 18:12:20'),
(2652, 75, 'compliance_check.collaboration_details', 'compliance', '', 7, '2025-08-01 18:12:20'),
(2653, 75, 'compliance_check.access_facilities', 'compliance', '', 7, '2025-08-01 18:12:20'),
(2654, 75, 'compliance_check.professional_membership', 'compliance', '', 7, '2025-08-01 18:12:20'),
(2655, 75, 'compliance_check.fallback_attachment', 'compliance', '', 7, '2025-08-01 18:12:20'),
(2656, 75, 'compliance_check.collaboration_attachment', 'compliance', '', 7, '2025-08-01 18:12:20'),
(2657, 75, 'compliance_check.access_facilities_attachment', 'compliance', '', 7, '2025-08-01 18:12:20'),
(2658, 75, 'compliance_check.membership_attachment', 'compliance', '', 7, '2025-08-01 18:12:20'),
(2724, 3, 'general_information.degree_name_english', 'compliance', '', 7, '2025-08-01 18:49:32'),
(2725, 3, 'general_information.degree_name_sinhala', 'compliance', '', 7, '2025-08-01 18:49:32'),
(2726, 3, 'general_information.degree_name_tamil', 'compliance', '', 7, '2025-08-01 18:49:32'),
(2727, 3, 'general_information.qualification_name_english', 'compliance', '', 7, '2025-08-01 18:49:32'),
(2728, 3, 'general_information.qualification_name_sinhala', 'compliance', '', 7, '2025-08-01 18:49:32'),
(2729, 3, 'general_information.qualification_name_tamil', 'compliance', '', 7, '2025-08-01 18:49:32'),
(2730, 3, 'general_information.abbreviated_qualification', 'compliance', '', 7, '2025-08-01 18:49:32'),
(2731, 3, 'program_entity.faculty', 'compliance', '', 7, '2025-08-01 18:49:32'),
(2732, 3, 'program_entity.department', 'compliance', '', 7, '2025-08-01 18:49:32'),
(2733, 3, 'program_entity.university', 'compliance', '', 7, '2025-08-01 18:49:32'),
(2734, 3, 'table.mandate_availability', 'compliance', '', 7, '2025-08-01 18:49:32'),
(2735, 3, 'degree_details.background_to_program', 'compliance', '', 7, '2025-08-01 18:49:32'),
(2736, 3, 'degree_details.mandate_faculty', 'compliance', '', 7, '2025-08-01 18:49:32'),
(2737, 3, 'degree_details.faculty_status', 'compliance', '', 7, '2025-08-01 18:49:32'),
(2738, 3, 'degree_details.student_intake', 'compliance', '', 7, '2025-08-01 18:49:32'),
(2739, 3, 'degree_details.staff_cadres', 'compliance', '', 7, '2025-08-01 18:49:32'),
(2740, 3, 'degree_details.educational_facilities', 'compliance', '', 7, '2025-08-01 18:49:32'),
(2741, 3, 'degree_details.common_facilities', 'compliance', '', 7, '2025-08-01 18:49:32'),
(2742, 3, 'degree_details.program_benefits', 'compliance', '', 7, '2025-08-01 18:49:32'),
(2743, 3, 'degree_details.eligibility_req', 'compliance', '', 7, '2025-08-01 18:49:32'),
(2744, 3, 'degree_details.indicate_program', 'compliance', '', 7, '2025-08-01 18:49:32'),
(2745, 3, 'degree_details.admission_process', 'compliance', '', 7, '2025-08-01 18:49:32'),
(2746, 3, 'degree_details.other_criteria', 'compliance', '', 7, '2025-08-01 18:49:32'),
(2747, 3, 'degree_details.intake', 'compliance', '', 7, '2025-08-01 18:49:32'),
(2748, 3, 'degree_details.degree_type', 'compliance', '', 7, '2025-08-01 18:49:32'),
(2749, 3, 'degree_details.duration', 'compliance', '', 7, '2025-08-01 18:49:32'),
(2750, 3, 'degree_details.coursework_credits', 'compliance', '', 7, '2025-08-01 18:49:32'),
(2751, 3, 'degree_details.thesis_credits', 'compliance', '', 7, '2025-08-01 18:49:32'),
(2752, 3, 'degree_details.total_credits', 'compliance', '', 7, '2025-08-01 18:49:32'),
(2753, 3, 'degree_details.medium_of_instruction', 'compliance', '', 7, '2025-08-01 18:49:32'),
(2754, 3, 'degree_details.subject_benchmark', 'compliance', '', 7, '2025-08-01 18:49:32'),
(2755, 3, 'degree_details.slqf_level', 'compliance', '', 7, '2025-08-01 18:49:32'),
(2756, 3, 'degree_details.slqf_filled', 'compliance', '', 7, '2025-08-01 18:49:32'),
(2757, 3, 'degree_details.rec_in_review_report', 'compliance', '', 7, '2025-08-01 18:49:32'),
(2758, 3, 'degree_details.degree_details_objective', 'compliance', '', 7, '2025-08-01 18:49:32'),
(2759, 3, 'degree_details.degree_details_justification', 'compliance', '', 7, '2025-08-01 18:49:32'),
(2760, 3, 'table.program_grades', 'compliance', '', 7, '2025-08-01 18:49:32'),
(2761, 3, 'table.program_structure', 'compliance', '', 7, '2025-08-01 18:49:32'),
(2762, 3, 'table.program_content', 'compliance', '', 7, '2025-08-01 18:49:32'),
(2763, 3, 'program_delivery_and_learner_support_system.program_delivery_description', 'compliance', '', 7, '2025-08-01 18:49:32'),
(2764, 3, 'program_assessment_rules_and_precodures.formative_summative', 'compliance', '', 7, '2025-08-01 18:49:32'),
(2765, 3, 'program_assessment_rules_and_precodures.grading_scheme', 'compliance', '', 7, '2025-08-01 18:49:32'),
(2766, 3, 'program_assessment_rules_and_precodures.gpa_calculation', 'compliance', '', 7, '2025-08-01 18:49:32'),
(2767, 3, 'program_assessment_rules_and_precodures.semester_contribution', 'compliance', '', 7, '2025-08-01 18:49:32'),
(2768, 3, 'program_assessment_rules_and_precodures.inplant_training', 'compliance', '', 7, '2025-08-01 18:49:32'),
(2769, 3, 'program_assessment_rules_and_precodures.repeat_exams', 'compliance', '', 7, '2025-08-01 18:49:32'),
(2770, 3, 'program_assessment_rules_and_precodures.degree_requirements', 'compliance', '', 7, '2025-08-01 18:49:32'),
(2771, 3, 'program_assessment_rules_and_precodures.class_requirements', 'compliance', '', 7, '2025-08-01 18:49:32'),
(2772, 3, 'table.human_resources', 'compliance', '', 7, '2025-08-01 18:49:32'),
(2773, 3, 'table.physical_resources', 'compliance', '', 7, '2025-08-01 18:49:32'),
(2774, 3, 'table.financial_resources', 'compliance', '', 7, '2025-08-01 18:49:32'),
(2775, 3, 'table.panel_of_teachers', 'compliance', '', 7, '2025-08-01 18:49:32'),
(2776, 3, 'table.reviewers_report', 'compliance', '', 7, '2025-08-01 18:49:32'),
(2777, 3, 'table.reviewer_details', 'compliance', '', 7, '2025-08-01 18:49:32'),
(2778, 3, 'compliance_check.resources_commence', 'compliance', '', 7, '2025-08-01 18:49:32'),
(2779, 3, 'compliance_check.fallback_options', 'compliance', '', 7, '2025-08-01 18:49:32'),
(2780, 3, 'compliance_check.fallback_qualification', 'compliance', '', 7, '2025-08-01 18:49:32'),
(2781, 3, 'compliance_check.collaboration', 'compliance', '', 7, '2025-08-01 18:49:32'),
(2782, 3, 'compliance_check.collaboration_details', 'compliance', '', 7, '2025-08-01 18:49:32'),
(2783, 3, 'compliance_check.access_facilities', 'compliance', '', 7, '2025-08-01 18:49:32'),
(2784, 3, 'compliance_check.professional_membership', 'compliance', '', 7, '2025-08-01 18:49:32'),
(2785, 3, 'compliance_check.fallback_attachment', 'compliance', '', 7, '2025-08-01 18:49:32'),
(2786, 3, 'compliance_check.collaboration_attachment', 'compliance', '', 7, '2025-08-01 18:49:32'),
(2787, 3, 'compliance_check.access_facilities_attachment', 'compliance', '', 7, '2025-08-01 18:49:32'),
(2788, 3, 'compliance_check.membership_attachment', 'compliance', '', 7, '2025-08-01 18:49:32'),
(2919, 72, 'general_information.degree_name_english', 'compliance', '', 7, '2025-08-01 21:31:28'),
(2920, 72, 'general_information.degree_name_sinhala', 'compliance', '', 7, '2025-08-01 21:31:28'),
(2921, 72, 'general_information.degree_name_tamil', 'compliance', '', 7, '2025-08-01 21:31:28'),
(2922, 72, 'general_information.qualification_name_english', 'compliance', '', 7, '2025-08-01 21:31:28'),
(2923, 72, 'general_information.qualification_name_sinhala', 'non_compliance', '', 7, '2025-08-01 21:31:28'),
(2924, 72, 'general_information.qualification_name_tamil', 'non_compliance', '', 7, '2025-08-01 21:31:28'),
(2925, 72, 'general_information.abbreviated_qualification', 'compliance', '', 7, '2025-08-01 21:31:28'),
(2926, 72, 'program_entity.faculty', 'compliance', '', 7, '2025-08-01 21:31:28'),
(2927, 72, 'program_entity.department', 'compliance', '', 7, '2025-08-01 21:31:28'),
(2928, 72, 'program_entity.university', 'compliance', '', 7, '2025-08-01 21:31:28'),
(2929, 72, 'table.mandate_availability', 'compliance', '', 7, '2025-08-01 21:31:28'),
(2930, 72, 'degree_details.background_to_program', 'compliance', '', 7, '2025-08-01 21:31:28'),
(2931, 72, 'degree_details.mandate_faculty', 'compliance', '', 7, '2025-08-01 21:31:28'),
(2932, 72, 'degree_details.faculty_status', 'compliance', '', 7, '2025-08-01 21:31:28'),
(2933, 72, 'degree_details.student_intake', 'compliance', '', 7, '2025-08-01 21:31:28'),
(2934, 72, 'degree_details.staff_cadres', 'compliance', '', 7, '2025-08-01 21:31:28'),
(2935, 72, 'degree_details.educational_facilities', 'compliance', '', 7, '2025-08-01 21:31:28'),
(2936, 72, 'degree_details.common_facilities', 'compliance', '', 7, '2025-08-01 21:31:28'),
(2937, 72, 'degree_details.program_benefits', 'compliance', '', 7, '2025-08-01 21:31:28'),
(2938, 72, 'degree_details.eligibility_req', 'compliance', '', 7, '2025-08-01 21:31:28'),
(2939, 72, 'degree_details.indicate_program', 'compliance', '', 7, '2025-08-01 21:31:28'),
(2940, 72, 'degree_details.admission_process', 'compliance', '', 7, '2025-08-01 21:31:28'),
(2941, 72, 'degree_details.other_criteria', 'compliance', '', 7, '2025-08-01 21:31:28'),
(2942, 72, 'degree_details.intake', 'compliance', '', 7, '2025-08-01 21:31:28'),
(2943, 72, 'degree_details.degree_type', 'compliance', '', 7, '2025-08-01 21:31:28'),
(2944, 72, 'degree_details.duration', 'compliance', '', 7, '2025-08-01 21:31:28'),
(2945, 72, 'degree_details.coursework_credits', 'compliance', '', 7, '2025-08-01 21:31:28'),
(2946, 72, 'degree_details.thesis_credits', 'compliance', '', 7, '2025-08-01 21:31:28'),
(2947, 72, 'degree_details.total_credits', 'compliance', '', 7, '2025-08-01 21:31:28'),
(2948, 72, 'degree_details.medium_of_instruction', 'compliance', '', 7, '2025-08-01 21:31:28'),
(2949, 72, 'degree_details.subject_benchmark', 'compliance', '', 7, '2025-08-01 21:31:28'),
(2950, 72, 'degree_details.slqf_level', 'compliance', '', 7, '2025-08-01 21:31:28'),
(2951, 72, 'degree_details.slqf_filled', 'compliance', '', 7, '2025-08-01 21:31:28'),
(2952, 72, 'degree_details.rec_in_review_report', 'compliance', '', 7, '2025-08-01 21:31:28'),
(2953, 72, 'degree_details.degree_details_objective', 'compliance', '', 7, '2025-08-01 21:31:28'),
(2954, 72, 'degree_details.degree_details_justification', 'compliance', '', 7, '2025-08-01 21:31:28'),
(2955, 72, 'table.program_grades', 'compliance', '', 7, '2025-08-01 21:31:28'),
(2956, 72, 'table.program_structure', 'compliance', '', 7, '2025-08-01 21:31:28'),
(2957, 72, 'table.program_content', 'compliance', '', 7, '2025-08-01 21:31:28'),
(2958, 72, 'program_delivery_and_learner_support_system.program_delivery_description', 'compliance', '', 7, '2025-08-01 21:31:28'),
(2959, 72, 'program_assessment_rules_and_precodures.formative_summative', 'compliance', '', 7, '2025-08-01 21:31:28'),
(2960, 72, 'program_assessment_rules_and_precodures.grading_scheme', 'compliance', '', 7, '2025-08-01 21:31:28'),
(2961, 72, 'program_assessment_rules_and_precodures.gpa_calculation', 'compliance', '', 7, '2025-08-01 21:31:28'),
(2962, 72, 'program_assessment_rules_and_precodures.semester_contribution', 'compliance', '', 7, '2025-08-01 21:31:28'),
(2963, 72, 'program_assessment_rules_and_precodures.inplant_training', 'compliance', '', 7, '2025-08-01 21:31:28'),
(2964, 72, 'program_assessment_rules_and_precodures.repeat_exams', 'compliance', '', 7, '2025-08-01 21:31:28'),
(2965, 72, 'program_assessment_rules_and_precodures.degree_requirements', 'compliance', '', 7, '2025-08-01 21:31:28'),
(2966, 72, 'program_assessment_rules_and_precodures.class_requirements', 'compliance', '', 7, '2025-08-01 21:31:28'),
(2967, 72, 'table.human_resources', 'compliance', '', 7, '2025-08-01 21:31:28'),
(2968, 72, 'table.physical_resources', 'compliance', '', 7, '2025-08-01 21:31:28'),
(2969, 72, 'table.financial_resources', 'compliance', '', 7, '2025-08-01 21:31:28'),
(2970, 72, 'table.panel_of_teachers', 'compliance', '', 7, '2025-08-01 21:31:28'),
(2971, 72, 'table.reviewers_report', 'compliance', '', 7, '2025-08-01 21:31:28'),
(2972, 72, 'table.reviewer_details', 'compliance', '', 7, '2025-08-01 21:31:28'),
(2973, 72, 'compliance_check.resources_commence', 'compliance', '', 7, '2025-08-01 21:31:28'),
(2974, 72, 'compliance_check.fallback_options', 'compliance', '', 7, '2025-08-01 21:31:28'),
(2975, 72, 'compliance_check.fallback_qualification', 'compliance', '', 7, '2025-08-01 21:31:28'),
(2976, 72, 'compliance_check.collaboration', 'compliance', '', 7, '2025-08-01 21:31:28'),
(2977, 72, 'compliance_check.collaboration_details', 'compliance', '', 7, '2025-08-01 21:31:28'),
(2978, 72, 'compliance_check.access_facilities', 'compliance', '', 7, '2025-08-01 21:31:28'),
(2979, 72, 'compliance_check.professional_membership', 'compliance', '', 7, '2025-08-01 21:31:28'),
(2980, 72, 'compliance_check.fallback_attachment', 'compliance', '', 7, '2025-08-01 21:31:28'),
(2981, 72, 'compliance_check.collaboration_attachment', 'compliance', '', 7, '2025-08-01 21:31:28'),
(2982, 72, 'compliance_check.access_facilities_attachment', 'compliance', '', 7, '2025-08-01 21:31:28'),
(2983, 72, 'compliance_check.membership_attachment', 'compliance', '', 7, '2025-08-01 21:31:28'),
(3179, 7, 'general_information.degree_name_english', 'compliance', '', 7, '2025-08-01 22:07:36'),
(3180, 7, 'general_information.degree_name_sinhala', 'compliance', '', 7, '2025-08-01 22:07:36'),
(3181, 7, 'general_information.degree_name_tamil', 'compliance', '', 7, '2025-08-01 22:07:36'),
(3182, 7, 'general_information.qualification_name_english', 'compliance', '', 7, '2025-08-01 22:07:36'),
(3183, 7, 'general_information.qualification_name_sinhala', 'compliance', '', 7, '2025-08-01 22:07:36'),
(3184, 7, 'general_information.qualification_name_tamil', 'compliance', '', 7, '2025-08-01 22:07:36'),
(3185, 7, 'general_information.abbreviated_qualification', 'compliance', '', 7, '2025-08-01 22:07:36'),
(3186, 7, 'program_entity.faculty', 'non_compliance', '', 7, '2025-08-01 22:07:36'),
(3187, 7, 'program_entity.department', 'non_compliance', '', 7, '2025-08-01 22:07:36'),
(3188, 7, 'program_entity.university', 'non_compliance', '', 7, '2025-08-01 22:07:36'),
(3189, 7, 'table.mandate_availability', 'non_compliance', '', 7, '2025-08-01 22:07:36');
INSERT INTO `proposal_summary_sheet` (`id`, `proposal_id`, `section_identifier`, `compliance_status`, `comment`, `last_updated_by`, `last_updated_at`) VALUES
(3190, 7, 'degree_details.background_to_program', 'non_compliance', '', 7, '2025-08-01 22:07:36'),
(3191, 7, 'degree_details.mandate_faculty', 'non_compliance', '', 7, '2025-08-01 22:07:36'),
(3192, 7, 'degree_details.faculty_status', 'compliance', '', 7, '2025-08-01 22:07:36'),
(3193, 7, 'degree_details.student_intake', 'compliance', '', 7, '2025-08-01 22:07:36'),
(3194, 7, 'degree_details.staff_cadres', 'compliance', '', 7, '2025-08-01 22:07:36'),
(3195, 7, 'degree_details.educational_facilities', 'compliance', '', 7, '2025-08-01 22:07:36'),
(3196, 7, 'degree_details.common_facilities', 'compliance', '', 7, '2025-08-01 22:07:36'),
(3197, 7, 'degree_details.program_benefits', 'compliance', '', 7, '2025-08-01 22:07:36'),
(3198, 7, 'degree_details.eligibility_req', 'compliance', '', 7, '2025-08-01 22:07:36'),
(3199, 7, 'degree_details.indicate_program', 'compliance', '', 7, '2025-08-01 22:07:36'),
(3200, 7, 'degree_details.admission_process', 'compliance', '', 7, '2025-08-01 22:07:36'),
(3201, 7, 'degree_details.other_criteria', 'compliance', '', 7, '2025-08-01 22:07:36'),
(3202, 7, 'degree_details.intake', 'compliance', '', 7, '2025-08-01 22:07:36'),
(3203, 7, 'degree_details.degree_type', 'compliance', '', 7, '2025-08-01 22:07:36'),
(3204, 7, 'degree_details.duration', 'compliance', '', 7, '2025-08-01 22:07:36'),
(3205, 7, 'degree_details.coursework_credits', 'compliance', '', 7, '2025-08-01 22:07:36'),
(3206, 7, 'degree_details.thesis_credits', 'compliance', '', 7, '2025-08-01 22:07:36'),
(3207, 7, 'degree_details.total_credits', 'compliance', '', 7, '2025-08-01 22:07:36'),
(3208, 7, 'degree_details.medium_of_instruction', 'compliance', '', 7, '2025-08-01 22:07:36'),
(3209, 7, 'degree_details.subject_benchmark', 'compliance', '', 7, '2025-08-01 22:07:36'),
(3210, 7, 'degree_details.slqf_level', 'compliance', '', 7, '2025-08-01 22:07:36'),
(3211, 7, 'degree_details.slqf_filled', 'compliance', '', 7, '2025-08-01 22:07:36'),
(3212, 7, 'degree_details.rec_in_review_report', 'compliance', '', 7, '2025-08-01 22:07:36'),
(3213, 7, 'degree_details.degree_details_objective', 'compliance', '', 7, '2025-08-01 22:07:36'),
(3214, 7, 'degree_details.degree_details_justification', 'compliance', '', 7, '2025-08-01 22:07:36'),
(3215, 7, 'table.program_grades', 'compliance', '', 7, '2025-08-01 22:07:36'),
(3216, 7, 'table.program_structure', 'compliance', '', 7, '2025-08-01 22:07:36'),
(3217, 7, 'table.program_content', 'compliance', '', 7, '2025-08-01 22:07:36'),
(3218, 7, 'program_delivery_and_learner_support_system.program_delivery_description', 'compliance', '', 7, '2025-08-01 22:07:36'),
(3219, 7, 'program_assessment_rules_and_precodures.formative_summative', 'compliance', '', 7, '2025-08-01 22:07:36'),
(3220, 7, 'program_assessment_rules_and_precodures.grading_scheme', 'compliance', '', 7, '2025-08-01 22:07:36'),
(3221, 7, 'program_assessment_rules_and_precodures.gpa_calculation', 'compliance', '', 7, '2025-08-01 22:07:36'),
(3222, 7, 'program_assessment_rules_and_precodures.semester_contribution', 'compliance', '', 7, '2025-08-01 22:07:36'),
(3223, 7, 'program_assessment_rules_and_precodures.inplant_training', 'compliance', '', 7, '2025-08-01 22:07:36'),
(3224, 7, 'program_assessment_rules_and_precodures.repeat_exams', 'compliance', '', 7, '2025-08-01 22:07:36'),
(3225, 7, 'program_assessment_rules_and_precodures.degree_requirements', 'compliance', '', 7, '2025-08-01 22:07:36'),
(3226, 7, 'program_assessment_rules_and_precodures.class_requirements', 'compliance', '', 7, '2025-08-01 22:07:36'),
(3227, 7, 'table.human_resources', 'compliance', '', 7, '2025-08-01 22:07:36'),
(3228, 7, 'table.physical_resources', 'compliance', '', 7, '2025-08-01 22:07:36'),
(3229, 7, 'table.financial_resources', 'compliance', '', 7, '2025-08-01 22:07:36'),
(3230, 7, 'table.panel_of_teachers', 'compliance', '', 7, '2025-08-01 22:07:36'),
(3231, 7, 'table.reviewers_report', 'compliance', '', 7, '2025-08-01 22:07:36'),
(3232, 7, 'table.reviewer_details', 'compliance', '', 7, '2025-08-01 22:07:36'),
(3233, 7, 'compliance_check.resources_commence', 'compliance', '', 7, '2025-08-01 22:07:36'),
(3234, 7, 'compliance_check.fallback_options', 'compliance', '', 7, '2025-08-01 22:07:36'),
(3235, 7, 'compliance_check.fallback_qualification', 'compliance', '', 7, '2025-08-01 22:07:36'),
(3236, 7, 'compliance_check.collaboration', 'compliance', '', 7, '2025-08-01 22:07:36'),
(3237, 7, 'compliance_check.collaboration_details', 'compliance', '', 7, '2025-08-01 22:07:36'),
(3238, 7, 'compliance_check.access_facilities', 'compliance', '', 7, '2025-08-01 22:07:36'),
(3239, 7, 'compliance_check.professional_membership', 'compliance', '', 7, '2025-08-01 22:07:36'),
(3240, 7, 'compliance_check.fallback_attachment', 'compliance', '', 7, '2025-08-01 22:07:36'),
(3241, 7, 'compliance_check.collaboration_attachment', 'compliance', '', 7, '2025-08-01 22:07:36'),
(3242, 7, 'compliance_check.access_facilities_attachment', 'compliance', '', 7, '2025-08-01 22:07:36'),
(3243, 7, 'compliance_check.membership_attachment', 'compliance', '', 7, '2025-08-01 22:07:36');

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
(20, 'A', 'B', 'pc@peradeniya.ac.lk', 'school of computing', 'University of Peradeniya', 'Program Coordinator of the university', 'pcpera', '$2y$10$AZypU4KIY87Uxif4Y8e6Zu5XJPaq9NxlLMqqFCq1z/353q6Rw4mWK', 3),
(21, 'Dean', 'D', 'dean@peradeniya.ac.lk', 'school of computing', 'University of Peradeniya', 'Dean/Rector/Director of the university', 'deanpera', '$2y$10$AZypU4KIY87Uxif4Y8e6Zu5XJPaq9NxlLMqqFCq1z/353q6Rw4mWK', 3),
(22, 'CQA', 'Director', 'cqa@pera.ac.lk', '', 'University of Peradeniya', 'CQA Director of the university', 'cqapera', '$2y$10$AZypU4KIY87Uxif4Y8e6Zu5XJPaq9NxlLMqqFCq1z/353q6Rw4mWK', 3),
(23, 'VC', 'Peradeniya', 'vc@pera.ac.lk', '', 'University of Peradeniya', 'Vice Chancellor of the university', 'vcpera', '$2y$10$AZypU4KIY87Uxif4Y8e6Zu5XJPaq9NxlLMqqFCq1z/353q6Rw4mWK', 3),
(25, 'A', 'B', 'pceastern@ac.lk', '', 'Eastern University of SriLanka', 'Program Coordinator of the university', 'pceastern', '$2y$10$AZypU4KIY87Uxif4Y8e6Zu5XJPaq9NxlLMqqFCq1z/353q6Rw4mWK', 8),
(26, 'ATechAssistant', '1', 'ta1@ugc.lk', '', 'QAC-UGC', 'UGC - Technical Assistant', 'ta1', '$2y$10$5AKFEhkK26fkGDSWz5uUI.t8vXanb0Sh2ikkClPASTxNeYZrfG7Vm', 16),
(28, 'S', 'UGC', 'sugc@ugc.lk', '', 'QAC-UGC', 'UGC - Secretary', 'sec', '$2y$10$2puOnuHkyopH.p4H2wlwyuPmYCMdBKc/v4ATWxt/Qa/STCJH5N6lK', 16),
(29, 's', 'c', 'sc@ugc.lk', '', 'QAC-UGC', 'Standing Committee', 'sc', '$2y$10$MTDYoRHv9CrNardw5z.vIeynyBYh8SqRqynu0ZNCDFcEWqTGhhxPW', 16),
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
  MODIFY `proposal_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=81;

--
-- AUTO_INCREMENT for table `proposal_assessment_rules`
--
ALTER TABLE `proposal_assessment_rules`
  MODIFY `assessment_rule_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `proposal_comments`
--
ALTER TABLE `proposal_comments`
  MODIFY `comment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=549;

--
-- AUTO_INCREMENT for table `proposal_compliance_check`
--
ALTER TABLE `proposal_compliance_check`
  MODIFY `compliance_check_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `proposal_degree_details`
--
ALTER TABLE `proposal_degree_details`
  MODIFY `degree_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `proposal_financial_resource`
--
ALTER TABLE `proposal_financial_resource`
  MODIFY `financial_resource_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `proposal_general_info`
--
ALTER TABLE `proposal_general_info`
  MODIFY `general_info_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `proposal_grades_received`
--
ALTER TABLE `proposal_grades_received`
  MODIFY `program_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=238;

--
-- AUTO_INCREMENT for table `proposal_human_resource`
--
ALTER TABLE `proposal_human_resource`
  MODIFY `human_resource_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

--
-- AUTO_INCREMENT for table `proposal_mandate_availability`
--
ALTER TABLE `proposal_mandate_availability`
  MODIFY `mandate_availability_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

--
-- AUTO_INCREMENT for table `proposal_panel_of_teachers`
--
ALTER TABLE `proposal_panel_of_teachers`
  MODIFY `teacher_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=497;

--
-- AUTO_INCREMENT for table `proposal_payments`
--
ALTER TABLE `proposal_payments`
  MODIFY `payment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `proposal_physical_resource`
--
ALTER TABLE `proposal_physical_resource`
  MODIFY `physical_resource_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=181;

--
-- AUTO_INCREMENT for table `proposal_program_content`
--
ALTER TABLE `proposal_program_content`
  MODIFY `content_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT for table `proposal_program_delivery`
--
ALTER TABLE `proposal_program_delivery`
  MODIFY `program_delivery_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `proposal_program_entity`
--
ALTER TABLE `proposal_program_entity`
  MODIFY `program_entity_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `proposal_program_structure`
--
ALTER TABLE `proposal_program_structure`
  MODIFY `program_structure_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT for table `proposal_resource_requirements`
--
ALTER TABLE `proposal_resource_requirements`
  MODIFY `resource_requirement_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `proposal_reviewers_report`
--
ALTER TABLE `proposal_reviewers_report`
  MODIFY `report_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=241;

--
-- AUTO_INCREMENT for table `proposal_reviewer_details`
--
ALTER TABLE `proposal_reviewer_details`
  MODIFY `reviewer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT for table `proposal_status_history`
--
ALTER TABLE `proposal_status_history`
  MODIFY `history_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=557;

--
-- AUTO_INCREMENT for table `proposal_summary_sheet`
--
ALTER TABLE `proposal_summary_sheet`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3244;

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
