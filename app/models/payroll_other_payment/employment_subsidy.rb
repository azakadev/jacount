class PayrollOtherPayment::EmploymentSubsidy < ApplicationRecord
  self.table_name = 'employment_subsidies'

  belongs_to :payroll_other_payment
end
