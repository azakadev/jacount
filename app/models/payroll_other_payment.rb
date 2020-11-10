class PayrollOtherPayment < ApplicationRecord
  belongs_to :bill
  has_many :employment_subsidies, 
            class_name: 'PayrollOtherPayment::EmploymentSubsidy',
             dependent: :delete_all

  accepts_nested_attributes_for :employment_subsidies
end