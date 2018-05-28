require 'stripe'
Stripe.api_key = 'sk_test_XAtp71IjbXUVrAVXtnkMe8GP'

class Charge
  def make_charge(amount_in_cents, source_id, customer_id)
    begin
      Stripe::Charge.create(
        :customer => customer_id,
        :amount => amount_in_cents,
        :currency => "usd",
        :source => source_id,
        :description => "Charge for RideZoot"
      )
    rescue Stripe::StripeError => e
      puts e
      raise "An Error Occured with Stripe"
    end

    return true
  end
end
