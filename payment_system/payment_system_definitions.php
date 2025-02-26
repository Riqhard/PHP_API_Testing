<?php

  // Payment providers
  // EPASSI
  define('PAYMENT_PROVIDER_EPASSI', 'epassi');
  define('EPASSI_API_URL', 'https://prodstaging.Epassi.fi/e_payments/v2');
  define('EPASSI_TESTING', true);
  
  // Vismapay
  define('PAYMENT_PROVIDER_VISMA', 'vismapay');

  // Internal transactions
  define('PAYMENT_PROVIDER_INTERNAL', 'internal');
  
  define('PAYMENT_PROVIDERS', array(PAYMENT_PROVIDER_EPASSI, PAYMENT_PROVIDER_VISMA, PAYMENT_PROVIDER_INTERNAL));

  // Error states
  define('ERROR_INVALID_PROVIDER', 'Invalid payment provider');
  define('ERROR_INVALID_PROVIDER_TYPE', 'Invalid payment provider type for transaction');
  define('ERROR_INVALID_TRANSACTION', 'Invalid transaction');
  define('ERROR_TRANSACTION_NOT_FOUND', 'Transaction not found');
  define('ERROR_DUPLICATE_PAYMENT', 'Duplicate payment');
  define('ERROR_DATABASE_REFERENCE', 'Database reference error');
  define('ERROR_DATABASE_INSERT', 'Database insert error');
  define('ERROR_PROVIDER_ERROR', 'Payment provider error');

  // Payment status
  define('PAYMENT_STATUS_ONGOING', 1);
  define('PAYMENT_STATUS_SUCCESS', 2);
?>