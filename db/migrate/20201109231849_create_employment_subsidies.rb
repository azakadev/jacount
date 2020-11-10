class CreateEmploymentSubsidies < ActiveRecord::Migration[6.0]
  def change
    create_table :employment_subsidies do |t|
      t.decimal :subsidy_caused, precision: 10, scale: 2
      t.decimal :subsidy_paid, precision: 10, scale: 2
      t.references :payroll_other_payment, null: false, foreign_key: true

      t.timestamps
    end
  end
end
