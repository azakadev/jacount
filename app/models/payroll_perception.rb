class PayrollPerception
  include Mongoid::Document
  include Mongoid::Timestamps

  field :perception_type, type: String 
  field :code, type: String 
  field :concept, type: String 
  field :taxed_amount, type: Money 
  field :exempt_amount, type: Money 

  belongs_to :bill
end
