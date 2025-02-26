INSERT INTO `customers` (`customer_uid`, `first_name`, `last_name`, `address`, `postal_code`, `city`, `email`, `phone_number`, `birth_date`, `language`, `encrypted_password`, `is_active`, `terms_accepted`)
VALUES 
('UID12345', 'John', 'Doe', '123 Street Name', '00100', 'Helsinki', 'john.doe@example.com', '358401234567', '1985-06-15', 'fi', 'encryptedpass1', 1, 1),
('UID67890', 'Jane', 'Smith', '456 Avenue', '00200', 'Espoo', 'jane.smith@example.com', '358409876543', '1990-08-25', 'en', 'encryptedpass2', 1, 1);

INSERT INTO `service_providers` (`service_provider_uid`, `person_id`, `organization_id`, `bank_account`, `description`, `language`, `terms_accepted`, `encrypted_password`, `is_active`)
VALUES 
('SP123', 1, NULL, 'FI1234567890123456', 'Catering service', 'fi', 1, 'encryptedpass3', 1),
('SP456', NULL, 2, 'FI6543210987654321', 'Retail store', 'en', 1, 'encryptedpass4', 1);

INSERT INTO `account_tokens` (`customer_id`, `service_provider_id`, `token_target`, `email`, `token`, `expires_at`)
VALUES 
(1, 1, 'customer', 'john.doe@example.com', 'token123', '2025-01-01 12:00:00'),
(2, 2, 'service_provider', 'jane.smith@example.com', 'token456', '2025-02-01 12:00:00');

INSERT INTO `orders` (`order_uid`, `customer_id`, `payment_id`, `status`, `details`, `order_price_excl_vat`, `order_price_incl_vat`)
VALUES 
('ORDER123', 1, 1, 1, 'Order details 1', 100.00, 124.00),
('ORDER456', 2, 2, 0, 'Order details 2', 50.00, 62.00);

INSERT INTO `payments` (`filing_identifier`, `payment_status`, `payment_provider`, `psp_transaction_id`, `psp_token`)
VALUES 
('FILING123', 2, 'epassi', 'TRANSACTION123', 'TOKEN123'),
('FILING456', 1, 'vismapay', 'TRANSACTION456', 'TOKEN456');

INSERT INTO `events` (`event_uid`, `venue_id`, `space_id`, `event_organizer_id`, `internal_name`, `internal_description`, `is_available`, `is_public`)
VALUES 
('EVENT123', 1, 1, 1, 'Music Festival', 'An amazing outdoor music festival', 1, 1),
('EVENT456', 2, 2, 2, 'Tech Conference', 'Latest trends in technology', 1, 1);

INSERT INTO `venues` (`address_id`, `data1`, `data2`)
VALUES 
(1, 'Venue data 1', 'Venue data 2'),
(2, 'Venue data 3', 'Venue data 4');

INSERT INTO `spaces` (`venue_id`, `address_id`, `data1`, `data2`)
VALUES 
(1, 1, 'Space data 1', 'Space data 2'),
(2, 2, 'Space data 3', 'Space data 4');

INSERT INTO `shops` (`shop_uid`, `shop_owner_id`, `event_id`, `space_id`, `internal_name`, `is_confirmed`, `is_public`)
VALUES 
('SHOP123', 1, 1, 1, 'Café Delight', 1, 1),
('SHOP456', 2, 2, 2, 'Tech Hub', 1, 1);

INSERT INTO `products` (`product_uid`, `shop_owner_id`, `category`, `internal_name`, `is_available`, `is_visible`, `price_excl_vat`, `vat_percentage`, `price_incl_vat`)
VALUES 
('PROD123', 1, 'beverages', 'Cappuccino', 1, 1, 4.00, 24.00, 4.96),
('PROD456', 2, 'fan_merch', 'T-shirt', 1, 1, 20.00, 24.00, 24.80);

INSERT INTO `tickets` (`order_id`, `ticket_group_id`, `is_redeemed`, `redeem_token`, `price_excl_vat`, `vat_percentage`, `price_incl_vat`)
VALUES 
(1, 1, 0, 'TICKET123', 50.00, 24.00, 62.00),
(2, 2, 0, 'TICKET456', 100.00, 24.00, 124.00);

INSERT INTO `event_organizers` (`merchant_id`, `description`)
VALUES 
(1, 'Organizer of Music Festival'),
(2, 'Organizer of Tech Conference');

INSERT INTO `shop_owners` (`service_provider_id`, `description`)
VALUES 
(1, 'Owner of Café Delight'),
(2, 'Owner of Tech Hub');

INSERT INTO `shop_products` (`product_id`, `shop_id`)
VALUES 
(1, 1),
(2, 2);

INSERT INTO `ticket_groups` (`ticket_group_uid`, `event_id`, `venue_id`, `space_id`, `price_excl_vat`, `vat_percentage`, `price_incl_vat`)
VALUES 
('TICKETGROUP1', 1, 1, 1, 50.00, 24.00, 62.00),
('TICKETGROUP2', 2, 2, 2, 100.00, 24.00, 124.00);