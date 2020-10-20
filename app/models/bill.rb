class Bill < ApplicationRecord
  has_many :payroll_perceptions

  accepts_nested_attributes_for :payroll_perceptions


  def self.from_json(string)
    json = JSON.parse string, symbolize_names: true
    json = json.dig(:elements).first
    # Get PayrollBill Perceptions
    perceptions = 
      ( json.dig(:elements, 3, :elements, 0, :elements, 2, :elements) || [] ).map do |perception|
        {
          perception_type:  perception.dig(:attributes, :TipoPercepcion),
          code:             perception.dig(:attributes, :Clave),
          concept:          perception.dig(:attributes, :Concepto),
          taxed_amount:     perception.dig(:attributes, :ImporteGravado),
          exempt_amount:    perception.dig(:attributes, :ImporteExento),
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

      payroll_perceptions_attributes: perceptions
    )
    byebug
    payroll_bill
  end
end
