class BillsController < ApplicationController
  def index
    @bills = Bill.all.limit(10)
  end

  def create
    unformated_json = params['_json'].first

    Bill.delete_all

    # Bill.with_session do |session|
    #   session.start_transaction

      params['_json'].each do |item|
        bill = Bill.from_json(item)
        bill.save
      end

      # session.commit_transaction
    # end

    respond_to do |format|
      format.html
      format.json { render json: Bill.all.last }
    end
  end
end
