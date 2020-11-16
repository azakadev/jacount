class Bill
  include Mongoid::Document
  include Mongoid::Timestamps

  field :voucher_node, type: String 
  field :version, type: String 
  field :serie, type: String
  field :folio, type: String 
  field :date, type: String 
  field :stamp, type: String 
  field :way_to_pay, type: String 
  field :certificate_number, type: String 
  field :certificate, type: String 
  field :payment_conditions, type: String 
  field :subtotal, type: Money
  field :discount, type: String 
  field :currency, type: String 
  field :exchange_rate, type: String 
  field :total, type: Money
  field :type_of_vaucher, type: String 
  field :payment_method, type: String 
  field :expedition_place, type: String 
  field :confirmation, type: String 

  field :transmiter_rfc, type: String 
  field :transmiter_name, type: String 
  field :transmiter_fiscal_regime, type: String 

  field :receiver_rfc, type: String 
  field :receiver_name, type: String 
  field :receiver_cfdi_use, type: String 

  field :initial_payment_date, type: String 
  field :final_payment_date, type: String 
  field :payment_date, type: String 

  has_many :payroll_perceptions, dependent: :delete_all
  has_many :payroll_deductions, dependent: :delete_all
  has_many :payroll_other_payments, dependent: :delete_all

  accepts_nested_attributes_for :payroll_perceptions
  accepts_nested_attributes_for :payroll_deductions
  accepts_nested_attributes_for :payroll_other_payments

  def self.from_json(string)
    json = JSON.parse string, symbolize_names: true
    json = json.dig(:elements).first
    # Get PayrollBill Perceptions
    perceptions = 
      ( get_perceptions(json).dig(0, :elements) || [] ).map do |perception|
        {
          perception_type:  perception.dig(:attributes, :TipoPercepcion),
          code:             perception.dig(:attributes, :Clave),
          concept:          perception.dig(:attributes, :Concepto),
          taxed_amount:     perception.dig(:attributes, :ImporteGravado),
          exempt_amount:    perception.dig(:attributes, :ImporteExento),
        }
      end
    deductions = 
      ( get_deductions(json).dig(0, :elements) || [] ).map do |deduction|
        {
          deduction_type:   deduction.dig(:attributes, :TipoDeduccion),
          code:             deduction.dig(:attributes, :Clave),
          concept:          deduction.dig(:attributes, :Concepto),
          amount:           deduction.dig(:attributes, :Importe),
        }
      end


    other_payments =
      ( get_other_payments(json).dig(0, :elements) || [] ).map do |other_payment|
          {
            other_payment_type: other_payment.dig(:attributes, :TipoOtroPago),
            code:               other_payment.dig(:attributes, :Clave),
            concept:            other_payment.dig(:attributes, :Concepto),
            amount:             other_payment.dig(:attributes, :Importe),
          }
      end

    payroll_bill = self.new(
      version:              json.dig(:attributes, :Version),
      serie:                json.dig(:attributes, :Serie),
      folio:                json.dig(:attributes, :Folio),
      date:                 json.dig(:attributes, :Fecha),
      stamp:                json.dig(:attributes, :Sello),
      way_to_pay:           json.dig(:attributes, :FormaPago),
      certificate_number:   json.dig(:attributes, :NoCertificado),
      certificate:          json.dig(:attributes, :Certificado),
      payment_conditions:   json.dig(:attributes, :CondicionesDePago),
      subtotal:             json.dig(:attributes, :SubTotal),
      discount:             json.dig(:attributes, :Descuento),
      currency:             json.dig(:attributes, :Moneda),
      exchange_rate:        json.dig(:attributes, :TipoCambio),
      total:                json.dig(:attributes, :Total),
      type_of_vaucher:      json.dig(:attributes, :TipoDeComprobante),
      payment_method:       json.dig(:attributes, :MetodoPago),
      expedition_place:     json.dig(:attributes, :LugarExpedicion),
      confirmation:         json.dig(:attributes, :Confirmacion),

      transmiter_rfc:       json.dig(:elements, 0, :attributes, :Rfc),
      transmiter_name:      json.dig(:elements, 0, :attributes, :Nombre),
      transmiter_fiscal_regime: json.dig(:elements, 0, :attributes, :RegimenFiscal),

      receiver_rfc:         json.dig(:elements, 0, :attributes, :Rfc),
      receiver_name:        json.dig(:elements, 0, :attributes, :Nombre),
      receiver_cfdi_use:    json.dig(:elements, 0, :attributes, :UsoCFDI),

      initial_payment_date: json.dig(:elements, 3, :elements, 0, :attributes, :FechaInicialPago),
      final_payment_date:   json.dig(:elements, 3, :elements, 0, :attributes, :FechaFinalPago),
      payment_date:         json.dig(:elements, 3, :elements, 0, :attributes, :FechaPago),

      payroll_perceptions_attributes: perceptions,
      payroll_deductions_attributes: deductions,
      payroll_other_payments_attributes: other_payments,
    )
  end

  private
  def self.get_deductions(json)
    json.dig(:elements, 3, :elements, 0, :elements).select {|element| element[:name] == "nomina12:Deducciones"}
  end

  def self.get_perceptions(json)
    json.dig(:elements, 3, :elements, 0, :elements).select {|element| element[:name] == "nomina12:Percepciones"}
  end

  def self.get_other_payments(json)
    json.dig(:elements, 3, :elements, 0, :elements).select {|element| element[:name] == "nomina12:OtrosPagos"}
  end
end
