class CreatePayrollOtherPayments < ActiveRecord::Migration[6.0]
  def change
    create_table :payroll_other_payments do |t|
      t.string :other_type_payment
      t.string :code
      t.string :concept
      t.decimal :amount, precision: 10, scale: 2
      t.references :bill, null: false, foreign_key: true

      t.timestamps
    end
  end
end
