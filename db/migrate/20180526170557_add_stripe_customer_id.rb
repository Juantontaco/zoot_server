class AddStripeCustomerId < ActiveRecord::Migration
  def change
    add_column :users, :stripe_customer_id, :string, default: ''
  end
end
