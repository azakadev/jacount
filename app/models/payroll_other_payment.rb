class PayrollOtherPayment < ApplicationRecord
  belongs_to :bill
  has_many :employment_subsidies, dependent: :delete_all

  accepts_nested_attributes_for :employment_subsidies
end