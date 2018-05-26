require 'stripe'
Stripe.api_key = 'sk_test_XAtp71IjbXUVrAVXtnkMe8GP'

class ChargesController < ApplicationController
  before_action :authenticate_user!

  def add_source
    begin
      if current_user.stripe_customer_id == ''
        customer = Stripe::Customer.create(
          :email => current_user.email
        )

        current_user.update_attributes(stripe_customer_id: customer.id)
      end

      customer = Stripe::Customer.retrieve(current_user.stripe_customer_id)
      customer.sources.create(source: params[:source_token])
    rescue Stripe::StripeError => e
      raise "An Error Occured"
    end

    render json: {success: true}
  end

  def sources
    customer = Stripe::Customer.retrieve(current_user.stripe_customer_id)
    render json: {sources: customer.sources}
  end

  # def make_charge
  #
  # end

end
