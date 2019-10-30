class CardsController < ApplicationController
    def new
      @card = Card.new
    end

    def create 
      secret_key = Rails.application.credentials[:secret_payjp_key]
      Payjp.api_key = secret_key
      if params['payjpToken'].blank?
        # paramsの中にjsで作った'payjpTokenが存在するか確かめる
        redirect_to action: "new"
      else
        customer = Payjp::Customer.create(
        card: params['payjpToken'],
        metadata: {user_id: current_user.id}
        )
        # ↑ここでpay.jpに保存
        @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
        # ここでdbに保存
        if @card.save
          redirect_to action: "show"
        else
          redirect_to action: "new"
        end
      end
    end

    def show
      
    end

    def mypage_card
    end
end
