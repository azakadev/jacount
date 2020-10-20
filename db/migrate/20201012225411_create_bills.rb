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
      t.decimal :subtotal, precision: 10, scale: 2
      t.string :discount
      t.string :currency
      t.string :exchange_rate
      t.decimal :total, precision: 10, scale: 2
      t.string :type_of_vaucher
      t.string :payment_method
      t.string :expedition_place
      t.string :confirmation

      t.string :transmiter_rfc
      t.string :transmiter_name
      t.string :transmiter_fiscal_regime

      t.string :receiver_rfc
      t.string :receiver_name
      t.string :receiver_cfdi_use

      t.string :initial_payment_date
      t.string :final_payment_date
      t.string :payment_date

      t.timestamps
    end
  end
end
