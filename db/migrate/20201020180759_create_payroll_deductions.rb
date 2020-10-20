class CreatePayrollDeductions < ActiveRecord::Migration[6.0]
  def change
    create_table :payroll_deductions do |t|
      t.string :deduction_type
      t.string :code
      t.string :concept
      t.string :amount
      t.references :bill, null: false, foreign_key: true

      t.timestamps
    end
  end
end
