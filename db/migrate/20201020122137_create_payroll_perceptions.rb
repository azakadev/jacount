class CreatePayrollPerceptions < ActiveRecord::Migration[6.0]
  def change
    create_table :payroll_perceptions do |t|
      t.string :perception_type
      t.string :code
      t.string :concept
      t.string :taxed_amount
      t.string :exempt_amount
      t.references :bill, null: false, foreign_key: true

      t.timestamps
    end
  end
end
