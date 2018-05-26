class AddPaymentSourceToRide < ActiveRecord::Migration
  def change
    add_column :rides, :payment_source, :string, default: ''
  end
end
