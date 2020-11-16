class PayrollOtherPayment
  include Mongoid::Document
  include Mongoid::Timestamps

  field :other_payment_type, type: String
  field :code, type: String
  field :concept, type: String
  field :amount, type: Money

  belongs_to :bill
  has_many :employment_subsidy
end
