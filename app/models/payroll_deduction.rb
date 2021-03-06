class PayrollDeduction
  include Mongoid::Document
  include Mongoid::Timestamps

  field :deduction_type, type: String
  field :code, type: String
  field :concept, type: String
  field :amount, type: Money
  
  belongs_to :bill
end
