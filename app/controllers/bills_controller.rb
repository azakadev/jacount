class BillsController < ApplicationController
  def index
    @bills = Bill.all
  end

  def create
    unformated_json = params['_json'].first

    Bill.delete_all

    params['_json'].each do |item|
      bill = Bill.from_json(item)
      bill.save
    end
    # redirect_to bills_url
    byebug
    render json: JSON.parse( unformated_json )
  end
end
