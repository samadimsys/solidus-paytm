class CreateSpreePaytmCheckouts < ActiveRecord::Migration[5.2]
  def change
    create_table :spree_paytm_checkouts do |t|
      t.string :checksum
      t.string :txn_id
      t.string :order_id
    end
  end
end
