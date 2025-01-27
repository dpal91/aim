const applyPayConfiguration = '''{
  "provider": "apple_pay",
  "data": {
    "merchantIdentifier": "merchant.com.dev.aimpariksha",
    "displayName": "Aim Pariksha",
    "merchantCapabilities": ["3DS", "debit", "credit"],
    "supportedNetworks": ["amex", "visa", "discover", "masterCard"],
    "countryCode": "IN",
    "currencyCode": "INR",
    "requiredBillingContactFields": ["divineinstitutechd007@gmail.com", "Divine", "7986500427", "Delhi, India"],
    "shippingMethods": [
        {
          "amount": "0.00",
          "detail": "Available within an hour",
          "identifier": "in_store_pickup",
          "label": "In-Store Pickup"
        },
        {
          "amount": "4.99",
          "detail": "5-8 Business Days",
          "identifier": "flat_rate_shipping_id_2",
          "label": "UPS Ground"
        },
        {
          "amount": "29.99",
          "detail": "1-3 Business Days",
          "identifier": "flat_rate_shipping_id_1",
          "label": "FedEx Priority Mail"
        }
      ]
  }
}
''';
