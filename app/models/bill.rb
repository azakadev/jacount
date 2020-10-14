class Bill < ApplicationRecord

  def self.from_json(string)
    string
    json = JSON.parse string
    json = json['elements'].first
    json['attributes']
    byebug
    self.new(
      version:          json['attributes']['Version'],
      serie:            json['attributes']['Serie'],
      folio:            json['attributes']['Folio'],
      date:             json['attributes']['Fecha'],
      stamp:            json['attributes']['Sello'],
      way_to_pay:       json['attributes']['FormaPago'],
      certificate_number: json['attributes']['NoCertificado'],
      certificate:      json['attributes']['Certificado'],
      payment_conditions: json['attributes']['CondicionesDePago'],
      subtotal:         json['attributes']['SubTotal'],
      discount:         json['attributes']['Descuento'],
      currency:         json['attributes']['Moneda'],
      exchange_rate:    json['attributes']['TipoCambio'],
      total:            json['attributes']['Total'],
      type_of_vaucher:  json['attributes']['TipoDeComprobante'],
      payment_method:   json['attributes']['MetodoPago'],
      expedition_place: json['attributes']['LugarExpedicion'],
      confirmation:     json['attributes']['Confirmacion'],
      )
  end
end
