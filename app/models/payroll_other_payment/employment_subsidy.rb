class PayrollOtherPayment::EmploymentSubsidy
  include Mongoid::Document
  include Mongoid::Timestamps

  field :subsidy_caused, type: Money
  field :subsidy_paid, type: Money

  belongs_to :payroll_other_payment
end
