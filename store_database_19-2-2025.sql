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
CREATE TABLE `customers` (
  `customer_id` int(11) PRIMARY KEY NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `customer_uid` VARCHAR(255) UNIQUE NOT NULL COMMENT 'Unique id that must be used externally when representing the object',
  `first_name` varchar(255) DEFAULT null COMMENT 'First Name',
  `last_name` varchar(255) DEFAULT null COMMENT 'Last Name',
  `address` varchar(255) DEFAULT null COMMENT 'Address',
  `postal_code` varchar(10) DEFAULT null COMMENT 'Postal Code',
  `city` varchar(255) DEFAULT null COMMENT 'City',
  `email` varchar(255) UNIQUE NOT NULL COMMENT 'Email Address',
  `phone_number` varchar(20) DEFAULT null COMMENT 'Phone Number',
  `birth_date` date DEFAULT null COMMENT 'Date of Birth. (Is this sufficient for alcohol sale, or should asking if they are of age be enough?)',
  `language` ENUM ('en', 'fr', 'de', 'fi', 'sv') NOT NULL DEFAULT 'fi' COMMENT 'Preferred Language',
  `encrypted_password` VARCHAR(255) NOT NULL COMMENT 'Encrypted Password',
  `is_active` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Indicates if account is active (eg. Confirmed/Closed because of violation)',
  `terms_accepted` tinyint(1) NOT NULL,
  `created_at` DATETIME DEFAULT (CURRENT_TIMESTAMP) COMMENT 'Timestamp when the customer was created',
  `updated_at` DATETIME DEFAULT (CURRENT_TIMESTAMP) COMMENT 'Timestamp when the customer was last updated'
);

CREATE TABLE `account_tokens` (
  `account_token_id` int(11) PRIMARY KEY AUTO_INCREMENT,
  `customer_id` int(11) COMMENT 'Intentionally left without default',
  `service_provider_id` int(11) COMMENT 'Intentionally left without default',
  `token_target` ENUM ('service_provider', 'customer') NOT NULL COMMENT 'Select Reset token target',
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` DATETIME DEFAULT (CURRENT_TIMESTAMP) COMMENT 'Timestamp when the token was created',
  `expires_at` DATETIME NOT NULL
);

CREATE TABLE `orders` (
  `order_id` int(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `order_uid` VARCHAR(255) UNIQUE NOT NULL COMMENT 'Unique id that must be used externally when representing the object',
  `customer_id` int(11) NOT NULL COMMENT 'This orders customer id',
  `payment_id` int(11) NOT NULL COMMENT 'This orders payments id',
  `status` TINYINT(6) NOT NULL DEFAULT 0 COMMENT 'Indicates status of the order',
  `details` TEXT DEFAULT null COMMENT 'Additional details',
  `order_price_excl_vat` DECIMAL(6,2) NOT NULL COMMENT 'Price per orders excluding VAT',
  `order_price_incl_vat` DECIMAL(6,2) COMMENT 'Price per orders including VAT',
  `created_at` DATETIME DEFAULT (CURRENT_TIMESTAMP) COMMENT 'Timestamp when the product was added',
  `updated_at` DATETIME DEFAULT (CURRENT_TIMESTAMP) COMMENT 'Timestamp when the product was last updated'
);

CREATE TABLE `order_products` (
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `amount` int(11) NOT NULL DEFAULT 1,
  `is_redeemed` TINYINT(1) NOT NULL DEFAULT 0,
  `redeem_token` VARCHAR(255) DEFAULT null COMMENT 'Hash',
  `unit_price_excl_vat` DECIMAL(6,2) NOT NULL COMMENT 'Price per unit excluding VAT',
  `vat_percentage` DECIMAL(4,2) NOT NULL COMMENT 'VAT percentage',
  `unit_price_incl_vat` DECIMAL(6,2) NOT NULL COMMENT 'Price per unit including VAT',
  `total_price` DECIMAL(6,2) NOT NULL COMMENT 'Total price',
  `details` TEXT DEFAULT null COMMENT 'Additional details',
  PRIMARY KEY (`order_id`, `product_id`)
);

CREATE TABLE `payments` (
  `payment_id` int(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `filing_identifier` varchar(255) UNIQUE NOT NULL COMMENT 'Filing identifier that can compare with the payment service provider',
  `payment_status` TINYINT(1) NOT NULL DEFAULT 0 COMMENT 'Example: 0 = Process started | 1 = Process Ongoing | 2 = Process completed',
  `payment_provider` ENUM ('epassi', 'vismapay') NOT NULL,
  `psp_transaction_id` varchar(255) DEFAULT null COMMENT 'Payment service providers ID for the transaction',
  `psp_token` varchar(255) DEFAULT null COMMENT 'Payment service providers Token. (Only use if necessary)',
  `created_at` DATETIME DEFAULT (CURRENT_TIMESTAMP) COMMENT 'Timestamp when the payment was added',
  `updated_at` DATETIME DEFAULT (CURRENT_TIMESTAMP) COMMENT 'Timestamp when the payment was last updated'
);

CREATE TABLE `persons` (
  `person_id` int(11) PRIMARY KEY NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `first_name` varchar(255) DEFAULT null COMMENT 'First Name',
  `last_name` varchar(255) DEFAULT null COMMENT 'Last Name',
  `address` varchar(255) DEFAULT null COMMENT 'Address',
  `postal_code` varchar(10) DEFAULT null COMMENT 'Postal Code',
  `city` varchar(255) DEFAULT null COMMENT 'City',
  `email` varchar(255) UNIQUE NOT NULL COMMENT 'Email Address',
  `phone_number` varchar(20) DEFAULT null COMMENT 'Phone Number'
);

CREATE TABLE `organizations` (
  `organization_id` int(11) PRIMARY KEY NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `company_name` TEXT DEFAULT null,
  `register_number` varchar(9) DEFAULT null COMMENT 'Unique company registry number. (Y-tunnus)',
  `address` varchar(255) DEFAULT null COMMENT 'Address',
  `postal_code` varchar(10) DEFAULT null COMMENT 'Postal Code',
  `city` varchar(255) DEFAULT null COMMENT 'City',
  `country` varchar(255) DEFAULT null COMMENT 'Country',
  `contact_first_name` varchar(255) NOT NULL COMMENT 'First Name',
  `contact_last_name` varchar(255) NOT NULL COMMENT 'Last Name',
  `contact_phone_number` varchar(20) NOT NULL COMMENT 'Phone Number',
  `contact_email` varchar(255) UNIQUE NOT NULL COMMENT 'Email Address'
);

CREATE TABLE `service_providers` (
  `service_provider_id` int(11) PRIMARY KEY NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `service_provider_uid` VARCHAR(255) UNIQUE NOT NULL COMMENT 'Unique id that must be used externally when representing the object',
  `person_id` int(11) DEFAULT null COMMENT 'One of these two IDs must not be NULL',
  `organization_id` int(11) DEFAULT null COMMENT 'One of these two IDs must not be NULL',
  `bank_account` varchar(34) DEFAULT null COMMENT 'Bank Account IBAN number',
  `description` TEXT DEFAULT null COMMENT 'Public description of the shop owner',
  `language` ENUM ('en', 'fr', 'de', 'fi', 'sv') NOT NULL DEFAULT 'fi' COMMENT 'Preferred Language',
  `terms_accepted` tinyint(1) NOT NULL,
  `encrypted_password` VARCHAR(255) NOT NULL COMMENT 'Encrypted Password',
  `is_active` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Indicates if account is active (eg. Confirmed/Closed because of violation)',
  `created_at` DATETIME DEFAULT (CURRENT_TIMESTAMP) COMMENT 'Timestamp when the mechant was created',
  `updated_at` DATETIME DEFAULT (CURRENT_TIMESTAMP) COMMENT 'Timestamp when the mechant was last updated'
);

CREATE TABLE `shop_owners` (
  `shop_owner_id` int(11) PRIMARY KEY NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `service_provider_id` int(11) NOT NULL COMMENT 'Reference to merchant ID',
  `description` TEXT DEFAULT null COMMENT 'Public description of the shop owner'
);

CREATE TABLE `shops` (
  `shop_id` int(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `shop_uid` VARCHAR(255) UNIQUE NOT NULL COMMENT 'Unique id that must be used externally when representing the object',
  `shop_owner_id` int(11) NOT NULL,
  `event_id` int(11) DEFAULT null COMMENT 'Foreign Key to event table',
  `parent_id` int(11) DEFAULT null COMMENT 'Refence to parent that has been used as a template',
  `space_id` int(11),
  `internal_name` VARCHAR(255) NOT NULL COMMENT 'Shop Name',
  `internal_description` TEXT DEFAULT null COMMENT 'Shop Description',
  `description_img` VARCHAR(512) DEFAULT null COMMENT 'Image to be used in description. (Intended to be hash of the image filename.)',
  `location_map` TEXT DEFAULT null COMMENT 'Map information. (eg. url to img)',
  `opening_time` TIME DEFAULT null COMMENT 'Opening time',
  `closing_time` TIME DEFAULT null COMMENT 'Closing time',
  `preoreder_start` TIME DEFAULT null COMMENT 'Preorder limits',
  `preoreder_closes` TIME DEFAULT null COMMENT 'Preorder limits',
  `alcohol_service_start` TIME DEFAULT null COMMENT 'Alcohol service limits',
  `alcohol_service_end` TIME DEFAULT null COMMENT 'Alcohol service limits',
  `is_confirmed` TINYINT(1) NOT NULL DEFAULT 1 COMMENT 'confirmed by event organizer',
  `is_public` TINYINT(1) NOT NULL DEFAULT 0,
  `created_at` DATETIME DEFAULT (CURRENT_TIMESTAMP) COMMENT 'Timestamp when the shop was created',
  `updated_at` DATETIME DEFAULT (CURRENT_TIMESTAMP) COMMENT 'Timestamp when the shop was last updated'
);

CREATE TABLE `products` (
  `product_id` int(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `product_uid` VARCHAR(255) UNIQUE NOT NULL COMMENT 'Unique id that must be used externally when representing the object',
  `shop_owner_id` int(11) NOT NULL,
  `parent_id` int(11) DEFAULT null COMMENT 'Refence to parent that has been used as a template',
  `category` ENUM ('fan_merch', 'food', 'beverages', 'lunch', 'other') NOT NULL COMMENT 'Product category',
  `internal_name` VARCHAR(255) NOT NULL COMMENT 'Product name',
  `internal_description` VARCHAR(255) DEFAULT null COMMENT 'Description for internal use',
  `description_img` VARCHAR(255) DEFAULT null COMMENT 'Image to be used in description. (Intended to be hash of the image filename.)',
  `is_available` TINYINT(1) NOT NULL DEFAULT 1 COMMENT '1 if product is available, 0 if unavailable',
  `is_visible` TINYINT(1) NOT NULL DEFAULT 1,
  `discount_code` VARCHAR(255) DEFAULT null,
  `data` TEXT DEFAULT null COMMENT 'For storing data structures',
  `price_excl_vat` DECIMAL(6,2) NOT NULL COMMENT 'Price excluding VAT',
  `vat_percentage` DECIMAL(4,2) NOT NULL COMMENT 'VAT percentage',
  `price_incl_vat` DECIMAL(6,2) COMMENT 'Price including VAT',
  `shop_information` TEXT DEFAULT null COMMENT 'Used to store the additional information about the associated shop. (eg. in case of shop deletion)',
  `created_at` DATETIME DEFAULT (CURRENT_TIMESTAMP) COMMENT 'Timestamp when the product was added',
  `updated_at` DATETIME DEFAULT (CURRENT_TIMESTAMP) COMMENT 'Timestamp when the product was last updated'
);

CREATE TABLE `shop_products` (
  `product_id` int(11) NOT NULL AUTO_INCREMENT,
  `shop_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`product_id`, `shop_id`)
);

CREATE TABLE `event_organizers` (
  `event_organizer_id` int(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `merchant_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Reference to merchant ID',
  `description` TEXT DEFAULT null COMMENT 'Public description of the event organizer'
);

CREATE TABLE `events` (
  `event_id` int(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `event_uid` VARCHAR(255) UNIQUE NOT NULL COMMENT 'Unique id that must be used externally when representing the object',
  `venue_id` int(11),
  `space_id` int(11),
  `parent_id` int(11) DEFAULT null COMMENT 'Refence to parent that has been used as a template',
  `event_organizer_id` int(11) NOT NULL,
  `internal_name` VARCHAR(255) NOT NULL COMMENT 'Event name',
  `internal_description` VARCHAR(255) DEFAULT null COMMENT 'Description for internal use',
  `description` TEXT DEFAULT null COMMENT 'Detailed description of the event',
  `description_img` VARCHAR(512) DEFAULT null COMMENT 'Image to be used in description. (Intended to be hash of the image filename.)',
  `is_available` TINYINT(1) NOT NULL DEFAULT 1 COMMENT '1 if event is available, 0 if unavailable',
  `is_public` TINYINT(1) NOT NULL DEFAULT 0,
  `created_at` DATETIME DEFAULT (CURRENT_TIMESTAMP) COMMENT 'Timestamp when the event was added',
  `updated_at` DATETIME DEFAULT (CURRENT_TIMESTAMP) COMMENT 'Timestamp when the event was last updated'
);

CREATE TABLE `venues` (
  `venue_id` int(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `address_id` int(11) NOT NULL,
  `data1` TEXT DEFAULT null COMMENT 'For storing data structures',
  `data2` TEXT DEFAULT null COMMENT 'For storing data structures'
);

CREATE TABLE `spaces` (
  `space_id` int(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `venue_id` int(11),
  `address_id` int(11),
  `data1` TEXT DEFAULT null COMMENT 'For storing data structures',
  `data2` TEXT DEFAULT null COMMENT 'For storing data structures'
);

CREATE TABLE `addresses` (
  `address_id` int(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `address` varchar(255) DEFAULT null COMMENT 'Address',
  `postal_code` varchar(10) DEFAULT null COMMENT 'Postal Code',
  `city` varchar(255) DEFAULT null COMMENT 'City',
  `additional_info` TEXT DEFAULT null COMMENT 'Additional information',
  `additional_info2` TEXT DEFAULT null COMMENT 'Additional information'
);

CREATE TABLE `ticket_groups` (
  `ticket_group_id` int(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `ticket_group_uid` VARCHAR(255) UNIQUE NOT NULL COMMENT 'Unique id that must be used externally when representing the object',
  `event_id` int(11) NOT NULL AUTO_INCREMENT,
  `venue_id` int(11),
  `space_id` int(11),
  `parent_id` int(11) DEFAULT null COMMENT 'Refence to parent that has been used as a template',
  `is_visible` TINYINT(1) NOT NULL DEFAULT 1,
  `discount_code` VARCHAR(255) DEFAULT null,
  `price_excl_vat` DECIMAL(6,2) NOT NULL COMMENT 'Price excluding VAT',
  `vat_percentage` DECIMAL(4,2) NOT NULL COMMENT 'VAT percentage',
  `price_incl_vat` DECIMAL(6,2) COMMENT 'Price including VAT',
  `valid_from` DATETIME DEFAULT null COMMENT 'Timestamp on which point onwards the ticket is valid',
  `valid_to` DATETIME DEFAULT null COMMENT 'Till on which point the thicket is valid (Should we change a time how long the ticket is valid instead)',
  `event_information` TEXT DEFAULT null COMMENT 'Used to store the additional information about the associated event. (eg. in case of event deletion)',
  `data1` TEXT DEFAULT null COMMENT 'For storing data structures',
  `data2` TEXT DEFAULT null COMMENT 'For storing data structures',
  `created_at` DATETIME DEFAULT (CURRENT_TIMESTAMP) COMMENT 'Timestamp when the ticket was added',
  `updated_at` DATETIME DEFAULT (CURRENT_TIMESTAMP) COMMENT 'Timestamp when the ticket was last updated'
);

CREATE TABLE `tickets` (
  `ticket_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `ticket_group_id` int(11) NOT NULL,
  `is_redeemed` TINYINT(1) NOT NULL DEFAULT 0,
  `redeem_token` VARCHAR(255) DEFAULT null COMMENT 'Hash',
  `price_excl_vat` DECIMAL(6,2) NOT NULL COMMENT 'Price excluding VAT',
  `vat_percentage` DECIMAL(4,2) NOT NULL COMMENT 'VAT percentage',
  `price_incl_vat` DECIMAL(6,2) COMMENT 'Price including VAT',
  `info1` TEXT DEFAULT null COMMENT 'Information fields',
  `info2` TEXT DEFAULT null COMMENT 'Information fields',
  `data1` TEXT DEFAULT null COMMENT 'For storing data structures',
  `data2` TEXT DEFAULT null COMMENT 'For storing data structures',
  `created_at` DATETIME DEFAULT (CURRENT_TIMESTAMP) COMMENT 'Timestamp when the ticket was added',
  `updated_at` DATETIME DEFAULT (CURRENT_TIMESTAMP) COMMENT 'Timestamp when the ticket was last updated',
  PRIMARY KEY (`ticket_id`, `order_id`, `ticket_group_id`)
);

CREATE TABLE `translations` (
  `translation_id` int(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `language` ENUM ('en', 'fr', 'de', 'fi', 'sv') NOT NULL COMMENT 'Language',
  `name` VARCHAR(255) NOT NULL COMMENT 'Product name',
  `description` TEXT DEFAULT null COMMENT 'Detailed description of the product',
  `info1` TEXT DEFAULT null COMMENT 'Information fields',
  `info2` TEXT DEFAULT null COMMENT 'Information fields'
);

CREATE TABLE `product_translations` (
  `product_id` int(11),
  `translation_id` int(11),
  PRIMARY KEY (`product_id`, `translation_id`)
);

CREATE TABLE `ticket_group_translations` (
  `ticket_id` int(11),
  `translation_id` int(11),
  PRIMARY KEY (`ticket_id`, `translation_id`)
);

CREATE TABLE `event_translations` (
  `event_id` int(11),
  `translation_id` int(11),
  PRIMARY KEY (`event_id`, `translation_id`)
);

CREATE TABLE `venue_translations` (
  `venue_id` int(11),
  `translation_id` int(11),
  PRIMARY KEY (`venue_id`, `translation_id`)
);

CREATE TABLE `space_translations` (
  `space_id` int(11),
  `translation_id` int(11),
  PRIMARY KEY (`space_id`, `translation_id`)
);

CREATE TABLE `shop_translations` (
  `shop_id` int(11),
  `translation_id` int(11),
  PRIMARY KEY (`shop_id`, `translation_id`)
);

ALTER TABLE `ticket_group_translations` ADD FOREIGN KEY (`translation_id`) REFERENCES `translations` (`translation_id`);

ALTER TABLE `space_translations` ADD FOREIGN KEY (`translation_id`) REFERENCES `translations` (`translation_id`);

ALTER TABLE `venue_translations` ADD FOREIGN KEY (`translation_id`) REFERENCES `translations` (`translation_id`);

ALTER TABLE `shop_translations` ADD FOREIGN KEY (`translation_id`) REFERENCES `translations` (`translation_id`);

ALTER TABLE `product_translations` ADD FOREIGN KEY (`translation_id`) REFERENCES `translations` (`translation_id`);

ALTER TABLE `event_translations` ADD FOREIGN KEY (`translation_id`) REFERENCES `translations` (`translation_id`);

ALTER TABLE `event_translations` ADD FOREIGN KEY (`event_id`) REFERENCES `events` (`event_id`);

ALTER TABLE `ticket_group_translations` ADD FOREIGN KEY (`ticket_id`) REFERENCES `ticket_groups` (`ticket_group_id`);

ALTER TABLE `shop_translations` ADD FOREIGN KEY (`shop_id`) REFERENCES `shops` (`shop_id`);

ALTER TABLE `product_translations` ADD FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);

ALTER TABLE `venue_translations` ADD FOREIGN KEY (`venue_id`) REFERENCES `venues` (`venue_id`);

ALTER TABLE `space_translations` ADD FOREIGN KEY (`space_id`) REFERENCES `spaces` (`space_id`);

ALTER TABLE `account_tokens` ADD FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`);

ALTER TABLE `account_tokens` ADD FOREIGN KEY (`service_provider_id`) REFERENCES `service_providers` (`service_provider_id`);

ALTER TABLE `tickets` ADD FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`);

ALTER TABLE `order_products` ADD FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`);

ALTER TABLE `payments` ADD FOREIGN KEY (`payment_id`) REFERENCES `orders` (`payment_id`);

ALTER TABLE `products` ADD FOREIGN KEY (`shop_owner_id`) REFERENCES `shop_owners` (`shop_owner_id`);

ALTER TABLE `events` ADD FOREIGN KEY (`event_organizer_id`) REFERENCES `event_organizers` (`event_organizer_id`);

ALTER TABLE `shops` ADD FOREIGN KEY (`shop_owner_id`) REFERENCES `shop_owners` (`shop_owner_id`);

ALTER TABLE `shops` ADD FOREIGN KEY (`event_id`) REFERENCES `events` (`event_id`);

ALTER TABLE `shop_products` ADD FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);

ALTER TABLE `shop_products` ADD FOREIGN KEY (`shop_id`) REFERENCES `shops` (`shop_id`);

ALTER TABLE `events` ADD FOREIGN KEY (`parent_id`) REFERENCES `events` (`event_id`);

ALTER TABLE `ticket_groups` ADD FOREIGN KEY (`parent_id`) REFERENCES `ticket_groups` (`ticket_group_id`);

ALTER TABLE `event_organizers` ADD FOREIGN KEY (`merchant_id`) REFERENCES `service_providers` (`service_provider_id`);

ALTER TABLE `shop_owners` ADD FOREIGN KEY (`service_provider_id`) REFERENCES `service_providers` (`service_provider_id`);

ALTER TABLE `events` ADD FOREIGN KEY (`venue_id`) REFERENCES `venues` (`venue_id`);

ALTER TABLE `events` ADD FOREIGN KEY (`space_id`) REFERENCES `spaces` (`space_id`);

ALTER TABLE `ticket_groups` ADD FOREIGN KEY (`event_id`) REFERENCES `events` (`event_id`);

ALTER TABLE `ticket_groups` ADD FOREIGN KEY (`venue_id`) REFERENCES `venues` (`venue_id`);

ALTER TABLE `ticket_groups` ADD FOREIGN KEY (`space_id`) REFERENCES `spaces` (`space_id`);

ALTER TABLE `addresses` ADD FOREIGN KEY (`address_id`) REFERENCES `venues` (`address_id`);

ALTER TABLE `addresses` ADD FOREIGN KEY (`address_id`) REFERENCES `spaces` (`address_id`);

ALTER TABLE `spaces` ADD FOREIGN KEY (`venue_id`) REFERENCES `venues` (`venue_id`);

ALTER TABLE `spaces` ADD FOREIGN KEY (`space_id`) REFERENCES `shops` (`space_id`);

ALTER TABLE `products` ADD FOREIGN KEY (`parent_id`) REFERENCES `products` (`product_id`);

ALTER TABLE `shops` ADD FOREIGN KEY (`parent_id`) REFERENCES `shops` (`shop_id`);

ALTER TABLE `service_providers` ADD FOREIGN KEY (`person_id`) REFERENCES `persons` (`person_id`);

ALTER TABLE `service_providers` ADD FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`organization_id`);











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
INSERT INTO `tickets` (`ticket_id`, `order_id`, `ticket_group_id`, `is_redeemed`, `price_excl_vat`, `vat_percentage`, `price_incl_vat`, `created_at`, `updated_at`) 
VALUES
(1, 1, 1, 0, 10.00, 24.00, 12.40, NOW(), NOW()),
(2, 2, 2, 0, 5.00, 14.00, 5.70, NOW(), NOW()),
(3, 3, 3, 0, 2.00, 14.00, 2.28, NOW(), NOW());
