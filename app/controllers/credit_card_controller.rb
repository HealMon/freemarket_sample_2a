class CreditCardController < ApplicationController
  def edit
    @credit_card = CreditCard.new
  end
end
