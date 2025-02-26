-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: 27.01.2025 klo 11:54
-- Palvelimen versio: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `store_database_test`
--

-- --------------------------------------------------------

--
-- Table structure for table `account_tokens`
--

CREATE TABLE `account_tokens` (
  `account_token_id` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT NULL COMMENT 'Intentionally left without default',
  `service_provider_id` int(11) DEFAULT NULL COMMENT 'Intentionally left without default',
  `token_target` enum('service_provider','customer') NOT NULL COMMENT 'Select Reset token target',
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp() COMMENT 'Timestamp when the token was created',
  `expires_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `addresses`
--

CREATE TABLE `addresses` (
  `address_id` int(11) NOT NULL,
  `address` varchar(255) DEFAULT NULL COMMENT 'Address',
  `postal_code` varchar(10) DEFAULT NULL COMMENT 'Postal Code',
  `city` varchar(255) DEFAULT NULL COMMENT 'City',
  `additional_info` text DEFAULT NULL COMMENT 'Additional information',
  `additional_info2` text DEFAULT NULL COMMENT 'Additional information'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `customer_id` int(11) NOT NULL COMMENT 'Primary Key',
  `customer_uid` varchar(255) NOT NULL COMMENT 'Unique id that must be used externally when representing the object',
  `first_name` varchar(255) DEFAULT NULL COMMENT 'First Name',
  `last_name` varchar(255) DEFAULT NULL COMMENT 'Last Name',
  `address` varchar(255) DEFAULT NULL COMMENT 'Address',
  `postal_code` varchar(10) DEFAULT NULL COMMENT 'Postal Code',
  `city` varchar(255) DEFAULT NULL COMMENT 'City',
  `email` varchar(255) NOT NULL COMMENT 'Email Address',
  `phone_number` varchar(20) DEFAULT NULL COMMENT 'Phone Number',
  `birth_date` date DEFAULT NULL COMMENT 'Date of Birth. (Is this sufficient for alcohol sale, or should asking if they are of age be enough?)',
  `language` enum('en','fr','de','fi','sv') NOT NULL DEFAULT 'fi' COMMENT 'Preferred Language',
  `encrypted_password` varchar(255) NOT NULL COMMENT 'Encrypted Password',
  `is_active` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Indicates if account is active (eg. Confirmed/Closed because of violation)',
  `terms_accepted` tinyint(1) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp() COMMENT 'Timestamp when the customer was created',
  `updated_at` datetime DEFAULT current_timestamp() COMMENT 'Timestamp when the customer was last updated'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`customer_id`, `customer_uid`, `first_name`, `last_name`, `address`, `postal_code`, `city`, `email`, `phone_number`, `birth_date`, `language`, `encrypted_password`, `is_active`, `terms_accepted`, `created_at`, `updated_at`) VALUES
(1, '12345', 'John', 'Doe', '123 Main St', '12345', 'Helsinki', 'john.doe@example.com', '1234567890', '1980-01-01', 'fi', 'encrypted_password_1', 1, 1, '2025-02-24 16:12:16', '2025-02-24 16:12:16'),
(2, '12346', 'Jane', 'Smith', '456 Elm St', '67890', 'Espoo', 'jane.smith@example.com', '0987654321', '1990-02-02', 'fi', 'encrypted_password_2', 1, 1, '2025-02-24 16:12:16', '2025-02-24 16:12:16'),
(3, '12347', 'Alice', 'Johnson', '789 Oak St', '54321', 'Vantaa', 'alice.johnson@example.com', '1122334455', '2000-03-03', 'fi', 'encrypted_password_3', 1, 1, '2025-02-24 16:12:16', '2025-02-24 16:12:16');

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

CREATE TABLE `events` (
  `event_id` int(11) NOT NULL,
  `event_uid` varchar(255) NOT NULL COMMENT 'Unique id that must be used externally when representing the object',
  `venue_id` int(11) DEFAULT NULL,
  `space_id` int(11) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL COMMENT 'Refence to parent that has been used as a template',
  `event_organizer_id` int(11) NOT NULL,
  `internal_name` varchar(255) NOT NULL COMMENT 'Event name',
  `internal_description` varchar(255) DEFAULT NULL COMMENT 'Description for internal use',
  `description` text DEFAULT NULL COMMENT 'Detailed description of the event',
  `description_img` varchar(512) DEFAULT NULL COMMENT 'Image to be used in description. (Intended to be hash of the image filename.)',
  `is_available` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1 if event is available, 0 if unavailable',
  `is_public` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` datetime DEFAULT current_timestamp() COMMENT 'Timestamp when the event was added',
  `updated_at` datetime DEFAULT current_timestamp() COMMENT 'Timestamp when the event was last updated'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `event_organizers`
--

CREATE TABLE `event_organizers` (
  `event_organizer_id` int(11) NOT NULL,
  `merchant_id` int(11) NOT NULL COMMENT 'Reference to merchant ID',
  `description` text DEFAULT NULL COMMENT 'Public description of the event organizer'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `event_translations`
--

CREATE TABLE `event_translations` (
  `event_id` int(11) NOT NULL,
  `translation_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `order_uid` varchar(255) NOT NULL COMMENT 'Unique id that must be used externally when representing the object',
  `customer_id` int(11) NOT NULL COMMENT 'This orders customer id',
  `payment_id` int(11) DEFAULT NULL COMMENT 'This orders payments id',
  `status` tinyint(6) NOT NULL DEFAULT 0 COMMENT 'Indicates status of the order',
  `details` text DEFAULT NULL COMMENT 'Additional details',
  `order_price_excl_vat` decimal(6,2) NOT NULL COMMENT 'Price per orders excluding VAT',
  `order_price_incl_vat` decimal(6,2) DEFAULT NULL COMMENT 'Price per orders including VAT',
  `created_at` datetime DEFAULT current_timestamp() COMMENT 'Timestamp when the product was added',
  `updated_at` datetime DEFAULT current_timestamp() COMMENT 'Timestamp when the product was last updated'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`order_id`, `order_uid`, `customer_id`, `payment_id`, `status`, `details`, `order_price_excl_vat`, `order_price_incl_vat`, `created_at`, `updated_at`) VALUES
(1, 'O12345', 1, 24, 1, NULL, 17.00, 20.38, '2025-02-24 16:13:50', '2025-02-24 16:13:50'),
(2, 'O12346', 2, NULL, 2, NULL, 5.00, 5.70, '2025-02-24 16:13:50', '2025-02-24 16:13:50'),
(3, 'O12347', 3, NULL, 3, NULL, 2.00, 2.28, '2025-02-24 16:13:50', '2025-02-24 16:13:50');

-- --------------------------------------------------------

--
-- Table structure for table `order_products`
--

CREATE TABLE `order_products` (
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `amount` int(11) NOT NULL DEFAULT 1,
  `is_redeemed` tinyint(1) NOT NULL DEFAULT 0,
  `redeem_token` varchar(255) DEFAULT NULL COMMENT 'Hash',
  `unit_price_excl_vat` decimal(6,2) NOT NULL COMMENT 'Price per unit excluding VAT',
  `vat_percentage` decimal(4,2) NOT NULL COMMENT 'VAT percentage',
  `unit_price_incl_vat` decimal(6,2) NOT NULL COMMENT 'Price per unit including VAT',
  `total_price` decimal(6,2) NOT NULL COMMENT 'Total price',
  `details` text DEFAULT NULL COMMENT 'Additional details'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_products`
--

INSERT INTO `order_products` (`order_id`, `product_id`, `amount`, `is_redeemed`, `redeem_token`, `unit_price_excl_vat`, `vat_percentage`, `unit_price_incl_vat`, `total_price`, `details`) VALUES
(1, 10, 1, 0, NULL, 10.00, 24.00, 12.40, 12.40, NULL),
(1, 11, 1, 0, NULL, 5.00, 14.00, 5.70, 5.70, NULL),
(2, 11, 1, 0, NULL, 5.00, 14.00, 5.70, 5.70, NULL),
(3, 12, 1, 0, NULL, 2.00, 14.00, 2.28, 2.28, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `organizations`
--

CREATE TABLE `organizations` (
  `organization_id` int(11) NOT NULL COMMENT 'Primary Key',
  `company_name` text DEFAULT NULL,
  `register_number` varchar(9) DEFAULT NULL COMMENT 'Unique company registry number. (Y-tunnus)',
  `address` varchar(255) DEFAULT NULL COMMENT 'Address',
  `postal_code` varchar(10) DEFAULT NULL COMMENT 'Postal Code',
  `city` varchar(255) DEFAULT NULL COMMENT 'City',
  `country` varchar(255) DEFAULT NULL COMMENT 'Country',
  `contact_first_name` varchar(255) NOT NULL COMMENT 'First Name',
  `contact_last_name` varchar(255) NOT NULL COMMENT 'Last Name',
  `contact_phone_number` varchar(20) NOT NULL COMMENT 'Phone Number',
  `contact_email` varchar(255) NOT NULL COMMENT 'Email Address'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `payment_id` int(11) NOT NULL,
  `filing_identifier` varchar(255) NOT NULL COMMENT 'Filing identifier that can compare with the payment service provider',
  `payment_status` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Example: 0 = Process started | 1 = Process Ongoing | 2 = Process completed',
  `payment_provider` enum('epassi','vismapay') NOT NULL,
  `psp_transaction_id` varchar(255) DEFAULT NULL COMMENT 'Payment service providers ID for the transaction',
  `psp_token` varchar(255) DEFAULT NULL COMMENT 'Payment service providers Token. (Only use if necessary)',
  `created_at` datetime DEFAULT current_timestamp() COMMENT 'Timestamp when the payment was added',
  `updated_at` datetime DEFAULT current_timestamp() COMMENT 'Timestamp when the payment was last updated'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`payment_id`, `filing_identifier`, `payment_status`, `payment_provider`, `psp_transaction_id`, `psp_token`, `created_at`, `updated_at`) VALUES
(24, '9f4191e9bcad3769a30f2a70b73974b4830ed6ccdb98b930736d9a942c2765ef1c994c917dfbe76eab95bc03786c44a826ec2325ba24dd64d37bcbaafe4d3103', 1, 'epassi', NULL, NULL, '2025-02-24 16:02:50', '2025-02-24 17:02:50');

-- --------------------------------------------------------

--
-- Table structure for table `persons`
--

CREATE TABLE `persons` (
  `person_id` int(11) NOT NULL COMMENT 'Primary Key',
  `first_name` varchar(255) DEFAULT NULL COMMENT 'First Name',
  `last_name` varchar(255) DEFAULT NULL COMMENT 'Last Name',
  `address` varchar(255) DEFAULT NULL COMMENT 'Address',
  `postal_code` varchar(10) DEFAULT NULL COMMENT 'Postal Code',
  `city` varchar(255) DEFAULT NULL COMMENT 'City',
  `email` varchar(255) NOT NULL COMMENT 'Email Address',
  `phone_number` varchar(20) DEFAULT NULL COMMENT 'Phone Number'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `product_id` int(11) NOT NULL,
  `product_uid` varchar(255) NOT NULL COMMENT 'Unique id that must be used externally when representing the object',
  `shop_owner_id` int(11) NOT NULL,
  `parent_id` int(11) DEFAULT NULL COMMENT 'Refence to parent that has been used as a template',
  `category` enum('fan_merch','food','beverages','lunch','other') NOT NULL COMMENT 'Product category',
  `internal_name` varchar(255) NOT NULL COMMENT 'Product name',
  `internal_description` varchar(255) DEFAULT NULL COMMENT 'Description for internal use',
  `description_img` varchar(255) DEFAULT NULL COMMENT 'Image to be used in description. (Intended to be hash of the image filename.)',
  `is_available` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1 if product is available, 0 if unavailable',
  `is_visible` tinyint(1) NOT NULL DEFAULT 1,
  `discount_code` varchar(255) DEFAULT NULL,
  `data` text DEFAULT NULL COMMENT 'For storing data structures',
  `price_excl_vat` decimal(6,2) NOT NULL COMMENT 'Price excluding VAT',
  `vat_percentage` decimal(4,2) NOT NULL COMMENT 'VAT percentage',
  `price_incl_vat` decimal(6,2) DEFAULT NULL COMMENT 'Price including VAT',
  `shop_information` text DEFAULT NULL COMMENT 'Used to store the additional information about the associated shop. (eg. in case of shop deletion)',
  `created_at` datetime DEFAULT current_timestamp() COMMENT 'Timestamp when the product was added',
  `updated_at` datetime DEFAULT current_timestamp() COMMENT 'Timestamp when the product was last updated'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`product_id`, `product_uid`, `shop_owner_id`, `parent_id`, `category`, `internal_name`, `internal_description`, `description_img`, `is_available`, `is_visible`, `discount_code`, `data`, `price_excl_vat`, `vat_percentage`, `price_incl_vat`, `shop_information`, `created_at`, `updated_at`) VALUES
(10, 'P12345', 1, NULL, 'fan_merch', 'T-Shirt', NULL, NULL, 1, 1, NULL, NULL, 10.00, 24.00, 12.40, NULL, '2025-02-24 16:18:57', '2025-02-24 16:18:57'),
(11, 'P12346', 1, NULL, 'food', 'Burger', NULL, NULL, 1, 1, NULL, NULL, 5.00, 14.00, 5.70, NULL, '2025-02-24 16:18:57', '2025-02-24 16:18:57'),
(12, 'P12347', 1, NULL, 'beverages', 'Soda', NULL, NULL, 1, 1, NULL, NULL, 2.00, 14.00, 2.28, NULL, '2025-02-24 16:18:57', '2025-02-24 16:18:57');

-- --------------------------------------------------------

--
-- Table structure for table `product_translations`
--

CREATE TABLE `product_translations` (
  `product_id` int(11) NOT NULL,
  `translation_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `service_providers`
--

CREATE TABLE `service_providers` (
  `service_provider_id` int(11) NOT NULL COMMENT 'Primary Key',
  `service_provider_uid` varchar(255) NOT NULL COMMENT 'Unique id that must be used externally when representing the object',
  `person_id` int(11) DEFAULT NULL COMMENT 'One of these two IDs must not be NULL',
  `organization_id` int(11) DEFAULT NULL COMMENT 'One of these two IDs must not be NULL',
  `bank_account` varchar(34) DEFAULT NULL COMMENT 'Bank Account IBAN number',
  `description` text DEFAULT NULL COMMENT 'Public description of the shop owner',
  `language` enum('en','fr','de','fi','sv') NOT NULL DEFAULT 'fi' COMMENT 'Preferred Language',
  `terms_accepted` tinyint(1) NOT NULL,
  `encrypted_password` varchar(255) NOT NULL COMMENT 'Encrypted Password',
  `is_active` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Indicates if account is active (eg. Confirmed/Closed because of violation)',
  `created_at` datetime DEFAULT current_timestamp() COMMENT 'Timestamp when the mechant was created',
  `updated_at` datetime DEFAULT current_timestamp() COMMENT 'Timestamp when the mechant was last updated'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `shops`
--

CREATE TABLE `shops` (
  `shop_id` int(11) NOT NULL,
  `shop_uid` varchar(255) NOT NULL COMMENT 'Unique id that must be used externally when representing the object',
  `shop_owner_id` int(11) NOT NULL,
  `event_id` int(11) DEFAULT NULL COMMENT 'Foreign Key to event table',
  `parent_id` int(11) DEFAULT NULL COMMENT 'Refence to parent that has been used as a template',
  `space_id` int(11) DEFAULT NULL,
  `internal_name` varchar(255) NOT NULL COMMENT 'Shop Name',
  `internal_description` text DEFAULT NULL COMMENT 'Shop Description',
  `description_img` varchar(512) DEFAULT NULL COMMENT 'Image to be used in description. (Intended to be hash of the image filename.)',
  `location_map` text DEFAULT NULL COMMENT 'Map information. (eg. url to img)',
  `opening_time` time DEFAULT NULL COMMENT 'Opening time',
  `closing_time` time DEFAULT NULL COMMENT 'Closing time',
  `preoreder_start` time DEFAULT NULL COMMENT 'Preorder limits',
  `preoreder_closes` time DEFAULT NULL COMMENT 'Preorder limits',
  `alcohol_service_start` time DEFAULT NULL COMMENT 'Alcohol service limits',
  `alcohol_service_end` time DEFAULT NULL COMMENT 'Alcohol service limits',
  `is_confirmed` tinyint(1) NOT NULL DEFAULT 1 COMMENT 'confirmed by event organizer',
  `is_public` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` datetime DEFAULT current_timestamp() COMMENT 'Timestamp when the shop was created',
  `updated_at` datetime DEFAULT current_timestamp() COMMENT 'Timestamp when the shop was last updated'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `shop_owners`
--

CREATE TABLE `shop_owners` (
  `shop_owner_id` int(11) NOT NULL COMMENT 'Primary Key',
  `service_provider_id` int(11) NOT NULL COMMENT 'Reference to merchant ID',
  `description` text DEFAULT NULL COMMENT 'Public description of the shop owner'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `shop_products`
--

CREATE TABLE `shop_products` (
  `product_id` int(11) NOT NULL,
  `shop_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `shop_translations`
--

CREATE TABLE `shop_translations` (
  `shop_id` int(11) NOT NULL,
  `translation_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `spaces`
--

CREATE TABLE `spaces` (
  `space_id` int(11) NOT NULL,
  `venue_id` int(11) DEFAULT NULL,
  `address_id` int(11) DEFAULT NULL,
  `data1` text DEFAULT NULL COMMENT 'For storing data structures',
  `data2` text DEFAULT NULL COMMENT 'For storing data structures'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `space_translations`
--

CREATE TABLE `space_translations` (
  `space_id` int(11) NOT NULL,
  `translation_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tickets`
--

CREATE TABLE `tickets` (
  `ticket_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `ticket_group_id` int(11) NOT NULL,
  `is_redeemed` tinyint(1) NOT NULL DEFAULT 0,
  `redeem_token` varchar(255) DEFAULT NULL COMMENT 'Hash',
  `price_excl_vat` decimal(6,2) NOT NULL COMMENT 'Price excluding VAT',
  `vat_percentage` decimal(4,2) NOT NULL COMMENT 'VAT percentage',
  `price_incl_vat` decimal(6,2) DEFAULT NULL COMMENT 'Price including VAT',
  `info1` text DEFAULT NULL COMMENT 'Information fields',
  `info2` text DEFAULT NULL COMMENT 'Information fields',
  `data1` text DEFAULT NULL COMMENT 'For storing data structures',
  `data2` text DEFAULT NULL COMMENT 'For storing data structures',
  `created_at` datetime DEFAULT current_timestamp() COMMENT 'Timestamp when the ticket was added',
  `updated_at` datetime DEFAULT current_timestamp() COMMENT 'Timestamp when the ticket was last updated'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tickets`
--

INSERT INTO `tickets` (`ticket_id`, `order_id`, `ticket_group_id`, `is_redeemed`, `redeem_token`, `price_excl_vat`, `vat_percentage`, `price_incl_vat`, `info1`, `info2`, `data1`, `data2`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 0, NULL, 10.00, 24.00, 12.40, NULL, NULL, NULL, NULL, '2025-02-24 16:24:08', '2025-02-24 16:24:08'),
(2, 2, 2, 0, NULL, 5.00, 14.00, 5.70, NULL, NULL, NULL, NULL, '2025-02-24 16:24:08', '2025-02-24 16:24:08'),
(3, 3, 3, 0, NULL, 2.00, 14.00, 2.28, NULL, NULL, NULL, NULL, '2025-02-24 16:24:08', '2025-02-24 16:24:08');

-- --------------------------------------------------------

--
-- Table structure for table `ticket_groups`
--

CREATE TABLE `ticket_groups` (
  `ticket_group_id` int(11) NOT NULL,
  `ticket_group_uid` varchar(255) NOT NULL COMMENT 'Unique id that must be used externally when representing the object',
  `event_id` int(11) NOT NULL,
  `venue_id` int(11) DEFAULT NULL,
  `space_id` int(11) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL COMMENT 'Refence to parent that has been used as a template',
  `is_visible` tinyint(1) NOT NULL DEFAULT 1,
  `discount_code` varchar(255) DEFAULT NULL,
  `price_excl_vat` decimal(6,2) NOT NULL COMMENT 'Price excluding VAT',
  `vat_percentage` decimal(4,2) NOT NULL COMMENT 'VAT percentage',
  `price_incl_vat` decimal(6,2) DEFAULT NULL COMMENT 'Price including VAT',
  `valid_from` datetime DEFAULT NULL COMMENT 'Timestamp on which point onwards the ticket is valid',
  `valid_to` datetime DEFAULT NULL COMMENT 'Till on which point the thicket is valid (Should we change a time how long the ticket is valid instead)',
  `event_information` text DEFAULT NULL COMMENT 'Used to store the additional information about the associated event. (eg. in case of event deletion)',
  `data1` text DEFAULT NULL COMMENT 'For storing data structures',
  `data2` text DEFAULT NULL COMMENT 'For storing data structures',
  `created_at` datetime DEFAULT current_timestamp() COMMENT 'Timestamp when the ticket was added',
  `updated_at` datetime DEFAULT current_timestamp() COMMENT 'Timestamp when the ticket was last updated'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ticket_group_translations`
--

CREATE TABLE `ticket_group_translations` (
  `ticket_id` int(11) NOT NULL,
  `translation_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `translations`
--

CREATE TABLE `translations` (
  `translation_id` int(11) NOT NULL,
  `language` enum('en','fr','de','fi','sv') NOT NULL COMMENT 'Language',
  `name` varchar(255) NOT NULL COMMENT 'Product name',
  `description` text DEFAULT NULL COMMENT 'Detailed description of the product',
  `info1` text DEFAULT NULL COMMENT 'Information fields',
  `info2` text DEFAULT NULL COMMENT 'Information fields'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `venues`
--

CREATE TABLE `venues` (
  `venue_id` int(11) NOT NULL,
  `address_id` int(11) NOT NULL,
  `data1` text DEFAULT NULL COMMENT 'For storing data structures',
  `data2` text DEFAULT NULL COMMENT 'For storing data structures'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `venue_translations`
--

CREATE TABLE `venue_translations` (
  `venue_id` int(11) NOT NULL,
  `translation_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `account_tokens`
--
ALTER TABLE `account_tokens`
  ADD PRIMARY KEY (`account_token_id`),
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `service_provider_id` (`service_provider_id`);

--
-- Indexes for table `addresses`
--
ALTER TABLE `addresses`
  ADD PRIMARY KEY (`address_id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`customer_id`),
  ADD UNIQUE KEY `customer_uid` (`customer_uid`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`event_id`),
  ADD UNIQUE KEY `event_uid` (`event_uid`),
  ADD KEY `event_organizer_id` (`event_organizer_id`),
  ADD KEY `parent_id` (`parent_id`),
  ADD KEY `venue_id` (`venue_id`),
  ADD KEY `space_id` (`space_id`);

--
-- Indexes for table `event_organizers`
--
ALTER TABLE `event_organizers`
  ADD PRIMARY KEY (`event_organizer_id`),
  ADD KEY `merchant_id` (`merchant_id`);

--
-- Indexes for table `event_translations`
--
ALTER TABLE `event_translations`
  ADD PRIMARY KEY (`event_id`,`translation_id`),
  ADD KEY `translation_id` (`translation_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD UNIQUE KEY `order_uid` (`order_uid`),
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `payment_id` (`payment_id`);

--
-- Indexes for table `order_products`
--
ALTER TABLE `order_products`
  ADD PRIMARY KEY (`order_id`,`product_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `organizations`
--
ALTER TABLE `organizations`
  ADD PRIMARY KEY (`organization_id`),
  ADD UNIQUE KEY `contact_email` (`contact_email`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`payment_id`),
  ADD UNIQUE KEY `filing_identifier` (`filing_identifier`);

--
-- Indexes for table `persons`
--
ALTER TABLE `persons`
  ADD PRIMARY KEY (`person_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`),
  ADD UNIQUE KEY `product_uid` (`product_uid`),
  ADD KEY `parent_id` (`parent_id`);

--
-- Indexes for table `product_translations`
--
ALTER TABLE `product_translations`
  ADD PRIMARY KEY (`product_id`,`translation_id`),
  ADD KEY `translation_id` (`translation_id`);

--
-- Indexes for table `service_providers`
--
ALTER TABLE `service_providers`
  ADD PRIMARY KEY (`service_provider_id`),
  ADD UNIQUE KEY `service_provider_uid` (`service_provider_uid`),
  ADD KEY `person_id` (`person_id`),
  ADD KEY `organization_id` (`organization_id`);

--
-- Indexes for table `shops`
--
ALTER TABLE `shops`
  ADD PRIMARY KEY (`shop_id`),
  ADD UNIQUE KEY `shop_uid` (`shop_uid`),
  ADD KEY `shop_owner_id` (`shop_owner_id`),
  ADD KEY `event_id` (`event_id`),
  ADD KEY `space_id` (`space_id`),
  ADD KEY `parent_id` (`parent_id`);

--
-- Indexes for table `shop_owners`
--
ALTER TABLE `shop_owners`
  ADD PRIMARY KEY (`shop_owner_id`),
  ADD KEY `service_provider_id` (`service_provider_id`);

--
-- Indexes for table `shop_products`
--
ALTER TABLE `shop_products`
  ADD PRIMARY KEY (`product_id`,`shop_id`),
  ADD KEY `shop_id` (`shop_id`);

--
-- Indexes for table `shop_translations`
--
ALTER TABLE `shop_translations`
  ADD PRIMARY KEY (`shop_id`,`translation_id`),
  ADD KEY `translation_id` (`translation_id`);

--
-- Indexes for table `spaces`
--
ALTER TABLE `spaces`
  ADD PRIMARY KEY (`space_id`),
  ADD KEY `address_id` (`address_id`),
  ADD KEY `venue_id` (`venue_id`);

--
-- Indexes for table `space_translations`
--
ALTER TABLE `space_translations`
  ADD PRIMARY KEY (`space_id`,`translation_id`),
  ADD KEY `translation_id` (`translation_id`);

--
-- Indexes for table `tickets`
--
ALTER TABLE `tickets`
  ADD PRIMARY KEY (`ticket_id`,`order_id`) USING BTREE,
  ADD KEY `order_id` (`order_id`);

--
-- Indexes for table `ticket_groups`
--
ALTER TABLE `ticket_groups`
  ADD PRIMARY KEY (`ticket_group_id`),
  ADD UNIQUE KEY `ticket_group_uid` (`ticket_group_uid`),
  ADD KEY `parent_id` (`parent_id`),
  ADD KEY `event_id` (`event_id`),
  ADD KEY `venue_id` (`venue_id`),
  ADD KEY `space_id` (`space_id`);

--
-- Indexes for table `ticket_group_translations`
--
ALTER TABLE `ticket_group_translations`
  ADD PRIMARY KEY (`ticket_id`,`translation_id`),
  ADD KEY `translation_id` (`translation_id`);

--
-- Indexes for table `translations`
--
ALTER TABLE `translations`
  ADD PRIMARY KEY (`translation_id`);

--
-- Indexes for table `venues`
--
ALTER TABLE `venues`
  ADD PRIMARY KEY (`venue_id`),
  ADD KEY `address_id` (`address_id`);

--
-- Indexes for table `venue_translations`
--
ALTER TABLE `venue_translations`
  ADD PRIMARY KEY (`venue_id`,`translation_id`),
  ADD KEY `translation_id` (`translation_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `account_tokens`
--
ALTER TABLE `account_tokens`
  MODIFY `account_token_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `addresses`
--
ALTER TABLE `addresses`
  MODIFY `address_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key', AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `events`
--
ALTER TABLE `events`
  MODIFY `event_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `event_organizers`
--
ALTER TABLE `event_organizers`
  MODIFY `event_organizer_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `organizations`
--
ALTER TABLE `organizations`
  MODIFY `organization_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key';

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `payment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=103;

--
-- AUTO_INCREMENT for table `persons`
--
ALTER TABLE `persons`
  MODIFY `person_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key';

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `service_providers`
--
ALTER TABLE `service_providers`
  MODIFY `service_provider_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key';

--
-- AUTO_INCREMENT for table `shops`
--
ALTER TABLE `shops`
  MODIFY `shop_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `shop_owners`
--
ALTER TABLE `shop_owners`
  MODIFY `shop_owner_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key';

--
-- AUTO_INCREMENT for table `spaces`
--
ALTER TABLE `spaces`
  MODIFY `space_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tickets`
--
ALTER TABLE `tickets`
  MODIFY `ticket_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `ticket_groups`
--
ALTER TABLE `ticket_groups`
  MODIFY `ticket_group_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `translations`
--
ALTER TABLE `translations`
  MODIFY `translation_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `venues`
--
ALTER TABLE `venues`
  MODIFY `venue_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `account_tokens`
--
ALTER TABLE `account_tokens`
  ADD CONSTRAINT `account_tokens_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
  ADD CONSTRAINT `account_tokens_ibfk_10` FOREIGN KEY (`service_provider_id`) REFERENCES `service_providers` (`service_provider_id`),
  ADD CONSTRAINT `account_tokens_ibfk_11` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
  ADD CONSTRAINT `account_tokens_ibfk_12` FOREIGN KEY (`service_provider_id`) REFERENCES `service_providers` (`service_provider_id`),
  ADD CONSTRAINT `account_tokens_ibfk_2` FOREIGN KEY (`service_provider_id`) REFERENCES `service_providers` (`service_provider_id`),
  ADD CONSTRAINT `account_tokens_ibfk_3` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
  ADD CONSTRAINT `account_tokens_ibfk_4` FOREIGN KEY (`service_provider_id`) REFERENCES `service_providers` (`service_provider_id`),
  ADD CONSTRAINT `account_tokens_ibfk_5` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
  ADD CONSTRAINT `account_tokens_ibfk_6` FOREIGN KEY (`service_provider_id`) REFERENCES `service_providers` (`service_provider_id`),
  ADD CONSTRAINT `account_tokens_ibfk_7` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
  ADD CONSTRAINT `account_tokens_ibfk_8` FOREIGN KEY (`service_provider_id`) REFERENCES `service_providers` (`service_provider_id`),
  ADD CONSTRAINT `account_tokens_ibfk_9` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`);

--
-- Constraints for table `events`
--
ALTER TABLE `events`
  ADD CONSTRAINT `events_ibfk_1` FOREIGN KEY (`event_organizer_id`) REFERENCES `event_organizers` (`event_organizer_id`),
  ADD CONSTRAINT `events_ibfk_10` FOREIGN KEY (`parent_id`) REFERENCES `events` (`event_id`),
  ADD CONSTRAINT `events_ibfk_11` FOREIGN KEY (`venue_id`) REFERENCES `venues` (`venue_id`),
  ADD CONSTRAINT `events_ibfk_12` FOREIGN KEY (`space_id`) REFERENCES `spaces` (`space_id`),
  ADD CONSTRAINT `events_ibfk_13` FOREIGN KEY (`event_organizer_id`) REFERENCES `event_organizers` (`event_organizer_id`),
  ADD CONSTRAINT `events_ibfk_14` FOREIGN KEY (`parent_id`) REFERENCES `events` (`event_id`),
  ADD CONSTRAINT `events_ibfk_15` FOREIGN KEY (`venue_id`) REFERENCES `venues` (`venue_id`),
  ADD CONSTRAINT `events_ibfk_16` FOREIGN KEY (`space_id`) REFERENCES `spaces` (`space_id`),
  ADD CONSTRAINT `events_ibfk_2` FOREIGN KEY (`parent_id`) REFERENCES `events` (`event_id`),
  ADD CONSTRAINT `events_ibfk_3` FOREIGN KEY (`venue_id`) REFERENCES `venues` (`venue_id`),
  ADD CONSTRAINT `events_ibfk_4` FOREIGN KEY (`space_id`) REFERENCES `spaces` (`space_id`),
  ADD CONSTRAINT `events_ibfk_5` FOREIGN KEY (`event_organizer_id`) REFERENCES `event_organizers` (`event_organizer_id`),
  ADD CONSTRAINT `events_ibfk_6` FOREIGN KEY (`parent_id`) REFERENCES `events` (`event_id`),
  ADD CONSTRAINT `events_ibfk_7` FOREIGN KEY (`venue_id`) REFERENCES `venues` (`venue_id`),
  ADD CONSTRAINT `events_ibfk_8` FOREIGN KEY (`space_id`) REFERENCES `spaces` (`space_id`),
  ADD CONSTRAINT `events_ibfk_9` FOREIGN KEY (`event_organizer_id`) REFERENCES `event_organizers` (`event_organizer_id`);

--
-- Constraints for table `event_organizers`
--
ALTER TABLE `event_organizers`
  ADD CONSTRAINT `event_organizers_ibfk_1` FOREIGN KEY (`merchant_id`) REFERENCES `service_providers` (`service_provider_id`),
  ADD CONSTRAINT `event_organizers_ibfk_2` FOREIGN KEY (`merchant_id`) REFERENCES `service_providers` (`service_provider_id`),
  ADD CONSTRAINT `event_organizers_ibfk_3` FOREIGN KEY (`merchant_id`) REFERENCES `service_providers` (`service_provider_id`),
  ADD CONSTRAINT `event_organizers_ibfk_4` FOREIGN KEY (`merchant_id`) REFERENCES `service_providers` (`service_provider_id`);

--
-- Constraints for table `event_translations`
--
ALTER TABLE `event_translations`
  ADD CONSTRAINT `event_translations_ibfk_1` FOREIGN KEY (`translation_id`) REFERENCES `translations` (`translation_id`),
  ADD CONSTRAINT `event_translations_ibfk_10` FOREIGN KEY (`event_id`) REFERENCES `events` (`event_id`),
  ADD CONSTRAINT `event_translations_ibfk_11` FOREIGN KEY (`translation_id`) REFERENCES `translations` (`translation_id`),
  ADD CONSTRAINT `event_translations_ibfk_12` FOREIGN KEY (`event_id`) REFERENCES `events` (`event_id`),
  ADD CONSTRAINT `event_translations_ibfk_2` FOREIGN KEY (`event_id`) REFERENCES `events` (`event_id`),
  ADD CONSTRAINT `event_translations_ibfk_3` FOREIGN KEY (`translation_id`) REFERENCES `translations` (`translation_id`),
  ADD CONSTRAINT `event_translations_ibfk_4` FOREIGN KEY (`event_id`) REFERENCES `events` (`event_id`),
  ADD CONSTRAINT `event_translations_ibfk_5` FOREIGN KEY (`translation_id`) REFERENCES `translations` (`translation_id`),
  ADD CONSTRAINT `event_translations_ibfk_6` FOREIGN KEY (`event_id`) REFERENCES `events` (`event_id`),
  ADD CONSTRAINT `event_translations_ibfk_7` FOREIGN KEY (`translation_id`) REFERENCES `translations` (`translation_id`),
  ADD CONSTRAINT `event_translations_ibfk_8` FOREIGN KEY (`event_id`) REFERENCES `events` (`event_id`),
  ADD CONSTRAINT `event_translations_ibfk_9` FOREIGN KEY (`translation_id`) REFERENCES `translations` (`translation_id`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`payment_id`) REFERENCES `payments` (`payment_id`),
  ADD CONSTRAINT `orders_ibfk_3` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
  ADD CONSTRAINT `orders_ibfk_4` FOREIGN KEY (`payment_id`) REFERENCES `payments` (`payment_id`),
  ADD CONSTRAINT `orders_ibfk_5` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
  ADD CONSTRAINT `orders_ibfk_6` FOREIGN KEY (`payment_id`) REFERENCES `payments` (`payment_id`),
  ADD CONSTRAINT `orders_ibfk_7` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
  ADD CONSTRAINT `orders_ibfk_8` FOREIGN KEY (`payment_id`) REFERENCES `payments` (`payment_id`);

--
-- Constraints for table `order_products`
--
ALTER TABLE `order_products`
  ADD CONSTRAINT `order_products_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  ADD CONSTRAINT `order_products_ibfk_2` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  ADD CONSTRAINT `order_products_ibfk_3` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`),
  ADD CONSTRAINT `order_products_ibfk_4` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  ADD CONSTRAINT `order_products_ibfk_5` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`),
  ADD CONSTRAINT `order_products_ibfk_6` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  ADD CONSTRAINT `order_products_ibfk_7` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`),
  ADD CONSTRAINT `order_products_ibfk_8` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  ADD CONSTRAINT `order_products_ibfk_9` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_4` FOREIGN KEY (`parent_id`) REFERENCES `products` (`product_id`),
  ADD CONSTRAINT `products_ibfk_6` FOREIGN KEY (`parent_id`) REFERENCES `products` (`product_id`);

--
-- Constraints for table `product_translations`
--
ALTER TABLE `product_translations`
  ADD CONSTRAINT `product_translations_ibfk_1` FOREIGN KEY (`translation_id`) REFERENCES `translations` (`translation_id`),
  ADD CONSTRAINT `product_translations_ibfk_10` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`),
  ADD CONSTRAINT `product_translations_ibfk_11` FOREIGN KEY (`translation_id`) REFERENCES `translations` (`translation_id`),
  ADD CONSTRAINT `product_translations_ibfk_12` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`),
  ADD CONSTRAINT `product_translations_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`),
  ADD CONSTRAINT `product_translations_ibfk_3` FOREIGN KEY (`translation_id`) REFERENCES `translations` (`translation_id`),
  ADD CONSTRAINT `product_translations_ibfk_4` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`),
  ADD CONSTRAINT `product_translations_ibfk_5` FOREIGN KEY (`translation_id`) REFERENCES `translations` (`translation_id`),
  ADD CONSTRAINT `product_translations_ibfk_6` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`),
  ADD CONSTRAINT `product_translations_ibfk_7` FOREIGN KEY (`translation_id`) REFERENCES `translations` (`translation_id`),
  ADD CONSTRAINT `product_translations_ibfk_8` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`),
  ADD CONSTRAINT `product_translations_ibfk_9` FOREIGN KEY (`translation_id`) REFERENCES `translations` (`translation_id`);

--
-- Constraints for table `service_providers`
--
ALTER TABLE `service_providers`
  ADD CONSTRAINT `service_providers_ibfk_1` FOREIGN KEY (`person_id`) REFERENCES `persons` (`person_id`),
  ADD CONSTRAINT `service_providers_ibfk_2` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`organization_id`),
  ADD CONSTRAINT `service_providers_ibfk_3` FOREIGN KEY (`person_id`) REFERENCES `persons` (`person_id`),
  ADD CONSTRAINT `service_providers_ibfk_4` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`organization_id`);

--
-- Constraints for table `shops`
--
ALTER TABLE `shops`
  ADD CONSTRAINT `shops_ibfk_1` FOREIGN KEY (`shop_owner_id`) REFERENCES `shop_owners` (`shop_owner_id`),
  ADD CONSTRAINT `shops_ibfk_10` FOREIGN KEY (`event_id`) REFERENCES `events` (`event_id`),
  ADD CONSTRAINT `shops_ibfk_11` FOREIGN KEY (`space_id`) REFERENCES `spaces` (`space_id`),
  ADD CONSTRAINT `shops_ibfk_12` FOREIGN KEY (`parent_id`) REFERENCES `shops` (`shop_id`),
  ADD CONSTRAINT `shops_ibfk_2` FOREIGN KEY (`event_id`) REFERENCES `events` (`event_id`),
  ADD CONSTRAINT `shops_ibfk_3` FOREIGN KEY (`shop_owner_id`) REFERENCES `shop_owners` (`shop_owner_id`),
  ADD CONSTRAINT `shops_ibfk_4` FOREIGN KEY (`event_id`) REFERENCES `events` (`event_id`),
  ADD CONSTRAINT `shops_ibfk_5` FOREIGN KEY (`shop_owner_id`) REFERENCES `shop_owners` (`shop_owner_id`),
  ADD CONSTRAINT `shops_ibfk_6` FOREIGN KEY (`event_id`) REFERENCES `events` (`event_id`),
  ADD CONSTRAINT `shops_ibfk_7` FOREIGN KEY (`space_id`) REFERENCES `spaces` (`space_id`),
  ADD CONSTRAINT `shops_ibfk_8` FOREIGN KEY (`parent_id`) REFERENCES `shops` (`shop_id`),
  ADD CONSTRAINT `shops_ibfk_9` FOREIGN KEY (`shop_owner_id`) REFERENCES `shop_owners` (`shop_owner_id`);

--
-- Constraints for table `shop_owners`
--
ALTER TABLE `shop_owners`
  ADD CONSTRAINT `shop_owners_ibfk_1` FOREIGN KEY (`service_provider_id`) REFERENCES `service_providers` (`service_provider_id`),
  ADD CONSTRAINT `shop_owners_ibfk_2` FOREIGN KEY (`service_provider_id`) REFERENCES `service_providers` (`service_provider_id`),
  ADD CONSTRAINT `shop_owners_ibfk_3` FOREIGN KEY (`service_provider_id`) REFERENCES `service_providers` (`service_provider_id`),
  ADD CONSTRAINT `shop_owners_ibfk_4` FOREIGN KEY (`service_provider_id`) REFERENCES `service_providers` (`service_provider_id`);

--
-- Constraints for table `shop_products`
--
ALTER TABLE `shop_products`
  ADD CONSTRAINT `shop_products_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`),
  ADD CONSTRAINT `shop_products_ibfk_2` FOREIGN KEY (`shop_id`) REFERENCES `shops` (`shop_id`),
  ADD CONSTRAINT `shop_products_ibfk_3` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`),
  ADD CONSTRAINT `shop_products_ibfk_4` FOREIGN KEY (`shop_id`) REFERENCES `shops` (`shop_id`),
  ADD CONSTRAINT `shop_products_ibfk_5` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`),
  ADD CONSTRAINT `shop_products_ibfk_6` FOREIGN KEY (`shop_id`) REFERENCES `shops` (`shop_id`),
  ADD CONSTRAINT `shop_products_ibfk_7` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`),
  ADD CONSTRAINT `shop_products_ibfk_8` FOREIGN KEY (`shop_id`) REFERENCES `shops` (`shop_id`);

--
-- Constraints for table `shop_translations`
--
ALTER TABLE `shop_translations`
  ADD CONSTRAINT `shop_translations_ibfk_1` FOREIGN KEY (`translation_id`) REFERENCES `translations` (`translation_id`),
  ADD CONSTRAINT `shop_translations_ibfk_10` FOREIGN KEY (`shop_id`) REFERENCES `shops` (`shop_id`),
  ADD CONSTRAINT `shop_translations_ibfk_11` FOREIGN KEY (`translation_id`) REFERENCES `translations` (`translation_id`),
  ADD CONSTRAINT `shop_translations_ibfk_12` FOREIGN KEY (`shop_id`) REFERENCES `shops` (`shop_id`),
  ADD CONSTRAINT `shop_translations_ibfk_2` FOREIGN KEY (`shop_id`) REFERENCES `shops` (`shop_id`),
  ADD CONSTRAINT `shop_translations_ibfk_3` FOREIGN KEY (`translation_id`) REFERENCES `translations` (`translation_id`),
  ADD CONSTRAINT `shop_translations_ibfk_4` FOREIGN KEY (`shop_id`) REFERENCES `shops` (`shop_id`),
  ADD CONSTRAINT `shop_translations_ibfk_5` FOREIGN KEY (`translation_id`) REFERENCES `translations` (`translation_id`),
  ADD CONSTRAINT `shop_translations_ibfk_6` FOREIGN KEY (`shop_id`) REFERENCES `shops` (`shop_id`),
  ADD CONSTRAINT `shop_translations_ibfk_7` FOREIGN KEY (`translation_id`) REFERENCES `translations` (`translation_id`),
  ADD CONSTRAINT `shop_translations_ibfk_8` FOREIGN KEY (`shop_id`) REFERENCES `shops` (`shop_id`),
  ADD CONSTRAINT `shop_translations_ibfk_9` FOREIGN KEY (`translation_id`) REFERENCES `translations` (`translation_id`);

--
-- Constraints for table `spaces`
--
ALTER TABLE `spaces`
  ADD CONSTRAINT `spaces_ibfk_1` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`address_id`),
  ADD CONSTRAINT `spaces_ibfk_2` FOREIGN KEY (`venue_id`) REFERENCES `venues` (`venue_id`),
  ADD CONSTRAINT `spaces_ibfk_3` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`address_id`),
  ADD CONSTRAINT `spaces_ibfk_4` FOREIGN KEY (`venue_id`) REFERENCES `venues` (`venue_id`),
  ADD CONSTRAINT `spaces_ibfk_5` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`address_id`),
  ADD CONSTRAINT `spaces_ibfk_6` FOREIGN KEY (`venue_id`) REFERENCES `venues` (`venue_id`);

--
-- Constraints for table `space_translations`
--
ALTER TABLE `space_translations`
  ADD CONSTRAINT `space_translations_ibfk_1` FOREIGN KEY (`translation_id`) REFERENCES `translations` (`translation_id`),
  ADD CONSTRAINT `space_translations_ibfk_10` FOREIGN KEY (`space_id`) REFERENCES `spaces` (`space_id`),
  ADD CONSTRAINT `space_translations_ibfk_11` FOREIGN KEY (`translation_id`) REFERENCES `translations` (`translation_id`),
  ADD CONSTRAINT `space_translations_ibfk_12` FOREIGN KEY (`space_id`) REFERENCES `spaces` (`space_id`),
  ADD CONSTRAINT `space_translations_ibfk_2` FOREIGN KEY (`space_id`) REFERENCES `spaces` (`space_id`),
  ADD CONSTRAINT `space_translations_ibfk_3` FOREIGN KEY (`translation_id`) REFERENCES `translations` (`translation_id`),
  ADD CONSTRAINT `space_translations_ibfk_4` FOREIGN KEY (`space_id`) REFERENCES `spaces` (`space_id`),
  ADD CONSTRAINT `space_translations_ibfk_5` FOREIGN KEY (`translation_id`) REFERENCES `translations` (`translation_id`),
  ADD CONSTRAINT `space_translations_ibfk_6` FOREIGN KEY (`space_id`) REFERENCES `spaces` (`space_id`),
  ADD CONSTRAINT `space_translations_ibfk_7` FOREIGN KEY (`translation_id`) REFERENCES `translations` (`translation_id`),
  ADD CONSTRAINT `space_translations_ibfk_8` FOREIGN KEY (`space_id`) REFERENCES `spaces` (`space_id`),
  ADD CONSTRAINT `space_translations_ibfk_9` FOREIGN KEY (`translation_id`) REFERENCES `translations` (`translation_id`);

--
-- Constraints for table `tickets`
--
ALTER TABLE `tickets`
  ADD CONSTRAINT `tickets_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  ADD CONSTRAINT `tickets_ibfk_3` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  ADD CONSTRAINT `tickets_ibfk_5` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  ADD CONSTRAINT `tickets_ibfk_7` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  ADD CONSTRAINT `tickets_ibfk_9` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`);

--
-- Constraints for table `ticket_groups`
--
ALTER TABLE `ticket_groups`
  ADD CONSTRAINT `ticket_groups_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `ticket_groups` (`ticket_group_id`),
  ADD CONSTRAINT `ticket_groups_ibfk_10` FOREIGN KEY (`event_id`) REFERENCES `events` (`event_id`),
  ADD CONSTRAINT `ticket_groups_ibfk_11` FOREIGN KEY (`venue_id`) REFERENCES `venues` (`venue_id`),
  ADD CONSTRAINT `ticket_groups_ibfk_12` FOREIGN KEY (`space_id`) REFERENCES `spaces` (`space_id`),
  ADD CONSTRAINT `ticket_groups_ibfk_13` FOREIGN KEY (`parent_id`) REFERENCES `ticket_groups` (`ticket_group_id`),
  ADD CONSTRAINT `ticket_groups_ibfk_14` FOREIGN KEY (`event_id`) REFERENCES `events` (`event_id`),
  ADD CONSTRAINT `ticket_groups_ibfk_15` FOREIGN KEY (`venue_id`) REFERENCES `venues` (`venue_id`),
  ADD CONSTRAINT `ticket_groups_ibfk_16` FOREIGN KEY (`space_id`) REFERENCES `spaces` (`space_id`),
  ADD CONSTRAINT `ticket_groups_ibfk_2` FOREIGN KEY (`event_id`) REFERENCES `events` (`event_id`),
  ADD CONSTRAINT `ticket_groups_ibfk_3` FOREIGN KEY (`venue_id`) REFERENCES `venues` (`venue_id`),
  ADD CONSTRAINT `ticket_groups_ibfk_4` FOREIGN KEY (`space_id`) REFERENCES `spaces` (`space_id`),
  ADD CONSTRAINT `ticket_groups_ibfk_5` FOREIGN KEY (`parent_id`) REFERENCES `ticket_groups` (`ticket_group_id`),
  ADD CONSTRAINT `ticket_groups_ibfk_6` FOREIGN KEY (`event_id`) REFERENCES `events` (`event_id`),
  ADD CONSTRAINT `ticket_groups_ibfk_7` FOREIGN KEY (`venue_id`) REFERENCES `venues` (`venue_id`),
  ADD CONSTRAINT `ticket_groups_ibfk_8` FOREIGN KEY (`space_id`) REFERENCES `spaces` (`space_id`),
  ADD CONSTRAINT `ticket_groups_ibfk_9` FOREIGN KEY (`parent_id`) REFERENCES `ticket_groups` (`ticket_group_id`);

--
-- Constraints for table `ticket_group_translations`
--
ALTER TABLE `ticket_group_translations`
  ADD CONSTRAINT `ticket_group_translations_ibfk_1` FOREIGN KEY (`translation_id`) REFERENCES `translations` (`translation_id`),
  ADD CONSTRAINT `ticket_group_translations_ibfk_10` FOREIGN KEY (`ticket_id`) REFERENCES `ticket_groups` (`ticket_group_id`),
  ADD CONSTRAINT `ticket_group_translations_ibfk_11` FOREIGN KEY (`translation_id`) REFERENCES `translations` (`translation_id`),
  ADD CONSTRAINT `ticket_group_translations_ibfk_12` FOREIGN KEY (`ticket_id`) REFERENCES `ticket_groups` (`ticket_group_id`),
  ADD CONSTRAINT `ticket_group_translations_ibfk_2` FOREIGN KEY (`ticket_id`) REFERENCES `ticket_groups` (`ticket_group_id`),
  ADD CONSTRAINT `ticket_group_translations_ibfk_3` FOREIGN KEY (`translation_id`) REFERENCES `translations` (`translation_id`),
  ADD CONSTRAINT `ticket_group_translations_ibfk_4` FOREIGN KEY (`ticket_id`) REFERENCES `ticket_groups` (`ticket_group_id`),
  ADD CONSTRAINT `ticket_group_translations_ibfk_5` FOREIGN KEY (`translation_id`) REFERENCES `translations` (`translation_id`),
  ADD CONSTRAINT `ticket_group_translations_ibfk_6` FOREIGN KEY (`ticket_id`) REFERENCES `ticket_groups` (`ticket_group_id`),
  ADD CONSTRAINT `ticket_group_translations_ibfk_7` FOREIGN KEY (`translation_id`) REFERENCES `translations` (`translation_id`),
  ADD CONSTRAINT `ticket_group_translations_ibfk_8` FOREIGN KEY (`ticket_id`) REFERENCES `ticket_groups` (`ticket_group_id`),
  ADD CONSTRAINT `ticket_group_translations_ibfk_9` FOREIGN KEY (`translation_id`) REFERENCES `translations` (`translation_id`);

--
-- Constraints for table `venues`
--
ALTER TABLE `venues`
  ADD CONSTRAINT `venues_ibfk_1` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`address_id`),
  ADD CONSTRAINT `venues_ibfk_2` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`address_id`),
  ADD CONSTRAINT `venues_ibfk_3` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`address_id`);

--
-- Constraints for table `venue_translations`
--
ALTER TABLE `venue_translations`
  ADD CONSTRAINT `venue_translations_ibfk_1` FOREIGN KEY (`translation_id`) REFERENCES `translations` (`translation_id`),
  ADD CONSTRAINT `venue_translations_ibfk_10` FOREIGN KEY (`venue_id`) REFERENCES `venues` (`venue_id`),
  ADD CONSTRAINT `venue_translations_ibfk_11` FOREIGN KEY (`translation_id`) REFERENCES `translations` (`translation_id`),
  ADD CONSTRAINT `venue_translations_ibfk_12` FOREIGN KEY (`venue_id`) REFERENCES `venues` (`venue_id`),
  ADD CONSTRAINT `venue_translations_ibfk_2` FOREIGN KEY (`venue_id`) REFERENCES `venues` (`venue_id`),
  ADD CONSTRAINT `venue_translations_ibfk_3` FOREIGN KEY (`translation_id`) REFERENCES `translations` (`translation_id`),
  ADD CONSTRAINT `venue_translations_ibfk_4` FOREIGN KEY (`venue_id`) REFERENCES `venues` (`venue_id`),
  ADD CONSTRAINT `venue_translations_ibfk_5` FOREIGN KEY (`translation_id`) REFERENCES `translations` (`translation_id`),
  ADD CONSTRAINT `venue_translations_ibfk_6` FOREIGN KEY (`venue_id`) REFERENCES `venues` (`venue_id`),
  ADD CONSTRAINT `venue_translations_ibfk_7` FOREIGN KEY (`translation_id`) REFERENCES `translations` (`translation_id`),
  ADD CONSTRAINT `venue_translations_ibfk_8` FOREIGN KEY (`venue_id`) REFERENCES `venues` (`venue_id`),
  ADD CONSTRAINT `venue_translations_ibfk_9` FOREIGN KEY (`translation_id`) REFERENCES `translations` (`translation_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;






-- Dummy data for testing
INSERT INTO `customers` (`customer_uid`, `first_name`, `last_name`, `address`, `postal_code`, `city`, `email`, `phone_number`, `birth_date`, `language`, `encrypted_password`, `is_active`, `terms_accepted`, `created_at`, `updated_at`) 
VALUES
('12345', 'John', 'Doe', '123 Main St', '12345', 'Helsinki', 'john.doe@example.com', '1234567890', '1980-01-01', 'fi', 'encrypted_password_1', 1, 1, NOW(), NOW()),
('12346', 'Jane', 'Smith', '456 Elm St', '67890', 'Espoo', 'jane.smith@example.com', '0987654321', '1990-02-02', 'fi', 'encrypted_password_2', 1, 1, NOW(), NOW()),
('12347', 'Alice', 'Johnson', '789 Oak St', '54321', 'Vantaa', 'alice.johnson@example.com', '1122334455', '2000-03-03', 'fi', 'encrypted_password_3', 1, 1, NOW(), NOW());

-- Dummy data for shop_owners
INSERT INTO `shop_owners` (`shop_owner_id`, `service_provider_id`, `description`) 
VALUES
(1, 1, 'Shop Owner 1'),
(2, 2, 'Shop Owner 2'),
(3, 3, 'Shop Owner 3');

-- Dummy data for shops
INSERT INTO `shops` (`shop_uid`, `shop_owner_id`, `internal_name`, `internal_description`, `is_public`, `created_at`, `updated_at`) 
VALUES
('S12345', 1, 'Shop 1', 'Description for Shop 1', 1, NOW(), NOW()),
('S12346', 2, 'Shop 2', 'Description for Shop 2', 1, NOW(), NOW()),
('S12347', 3, 'Shop 3', 'Description for Shop 3', 1, NOW(), NOW());

-- Dummy data for products
INSERT INTO `products` (`product_uid`, `shop_owner_id`, `category`, `internal_name`, `price_excl_vat`, `vat_percentage`, `price_incl_vat`, `created_at`, `updated_at`) 
VALUES
('P12345', 1, 'fan_merch', 'T-Shirt', 10.00, 24.00, 12.40, NOW(), NOW()),
('P12346', 1, 'food', 'Burger', 5.00, 14.00, 5.70, NOW(), NOW()),
('P12347', 1, 'beverages', 'Soda', 2.00, 14.00, 2.28, NOW(), NOW());

-- Dummy data for orders
INSERT INTO `orders` (`order_uid`, `customer_id`, `payment_id`, `status`, `order_price_excl_vat`, `order_price_incl_vat`, `created_at`, `updated_at`) 
VALUES
('O12345', 1, 1, 1, 17.00, 20.38, NOW(), NOW()),
('O12346', 2, 2, 1, 5.00, 5.70, NOW(), NOW()),
('O12347', 3, 3, 1, 2.00, 2.28, NOW(), NOW());

-- Dummy data for order_products
INSERT INTO `order_products` (`order_id`, `product_id`, `amount`, `unit_price_excl_vat`, `vat_percentage`, `unit_price_incl_vat`, `total_price`) 
VALUES
(1, 1, 1, 10.00, 24.00, 12.40, 12.40),
(1, 2, 1, 5.00, 14.00, 5.70, 5.70),
(2, 2, 1, 5.00, 14.00, 5.70, 5.70),
(3, 3, 1, 2.00, 14.00, 2.28, 2.28);

-- Dummy data for payments
INSERT INTO `payments` (`filing_identifier`, `payment_status`, `payment_provider`, `created_at`, `updated_at`) 
VALUES
('F12345', 2, 'epassi', NOW(), NOW()),
('F12346', 2, 'vismapay', NOW(), NOW()),
('F12347', 2, 'epassi', NOW(), NOW());

-- Dummy data for tickets
INSERT INTO `ticket_groups` (`ticket_group_id`, `ticket_group_uid`) 
VALUES
(1, 1),
(2, 2),
(3, 3);

-- Dummy data for tickets
INSERT INTO `tickets` (`ticket_id`, `order_id`, `ticket_group_id`, `is_redeemed`, `price_excl_vat`, `vat_percentage`, `price_incl_vat`, `created_at`, `updated_at`) 
VALUES
(1, 1, 1, 0, 10.00, 24.00, 12.40, NOW(), NOW()),
(2, 2, 2, 0, 5.00, 14.00, 5.70, NOW(), NOW()),
(3, 3, 3, 0, 2.00, 14.00, 2.28, NOW(), NOW());
