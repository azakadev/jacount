class CreateBills < ActiveRecord::Migration[6.0]
  def change
    create_table :bills do |t|
      t.string :voucher_node
      t.string :version
      t.string :serie
      t.string :folio
      t.string :date
      t.string :stamp
      t.string :way_to_pay
      t.string :certificate_number
      t.string :certificate
      t.string :payment_conditions
      t.string :subtotal
      t.string :discount
      t.string :currency
      t.string :exchange_rate
      t.string :total
      t.string :type_of_vaucher
      t.string :payment_method
      t.string :expedition_place
      t.string :confirmation

      t.timestamps
    end
  end
end
