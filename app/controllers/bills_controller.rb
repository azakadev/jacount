class BillsController < ApplicationController
  def index
    @bills = Bill.all
  end

  def create
    unformated_json = params['_json'].first

    params['_json'].each do |item|
      bill = Bill.from_json(unformated_json)
      bill.save
    end
    redirect_to bills_url
  end
end
