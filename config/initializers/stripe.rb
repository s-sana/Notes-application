Rails.configuration.stripe = {
  publishable_key: 'pk_test_j8eiLyRhCvonA48BaAMJe1YV',
  secret_key: 'sk_test_03WL0w8AXxhoDzSBOLNXY8C3'
}
# charge = Stripe::Charge.retrieve("")refunded = Stripe::Refund.create({ charge: refund.user_chargeid,})
# charge.refund

Stripe.api_key = Rails.configuration.stripe[:secret_key]
