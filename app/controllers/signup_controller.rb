class SignupController < ApplicationController
  before_action :redirect_to_index_from_registration, only: [:phone2, :address, :payment, :congrats, :create]

  def new
    @user = User.new
  end

  def phone1

    session[:birthday] = params[:birthday]["birthday(1i)"] + "/" + params[:birthday]["birthday(2i)"] + "/" + params[:birthday]["birthday(3i)"]

    session[:nickname]              = user_params[:nickname]
    session[:email]                 = user_params[:email]
    session[:password]              = user_params[:password]
    session[:password_confirmation] = user_params[:password_confirmation]
    session[:last_name]             = user_params[:last_name]
    session[:first_name]            = user_params[:first_name]
    session[:last_name_kana]        = user_params[:last_name_kana]
    session[:first_name_kana]       = user_params[:first_name_kana]

    # ダミー
    @user = User.new(
      birthday:                 session[:birthday],
      nickname:                 session[:nickname],
      email:                    session[:email],
      password:                 session[:password],
      password_confirmation:    session[:password_confirmation],
      last_name:                session[:last_name],
      first_name:               session[:first_name],
      last_name_kana:           session[:last_name_kana],
      first_name_kana:          session[:first_name_kana],

      phone_number:             session[:phone_number] || "09099999999",

      delivery_last_name:       session[:delivery_last_name] || "仮登録",
      delivery_first_name:      session[:delivery_first_name] || "仮登録",
      delivery_last_name_kana:  session[:delivery_last_name_kana] || "カリトウロク",
      delivery_first_name_kana: session[:delivery_first_name_kana] || "カリトウロク",
      zipcode:                  session[:zipcode] || "781-0001",
      city:                     session[:city] || "高知県高知市",
      address:                  session[:address] || "1-1",
      building:                 session[:building] || "仮ハイツ１"  ,
      delivery_phone_number:    session[:delivery_phone_number] || "09099999999",
    )
      # @credit_card = CreditCard.new(
      #   card_number: session[:card_number] || "",
      #   exporation_date: session[:exporation_date] || "",
      #   cvc: session[:cvc] || ""
      # )

      # byebugログ
      # @user
#<User id: nil, nickname: "", email: "", phone_number: "222-2222", zipcode: "k", prefecture: nil, city: "k", address: "1-1", building: "仮ハイツ１", birthday: 0, last_name: "", first_name: "", last_name_kana: "", first_name_kana: "", avatar: nil, profile: nil, delivery_last_name: "kk", delivery_first_name: "kk", delivery_last_name_kana: "kk", delivery_first_name_kana: "kk", delivery_phone_number: "", created_at: nil, updated_at: nil>


    check_user_valid = @user.valid?

    unless check_user_valid
      render 'signup/registration' 
    else
      session[:through_first_valid] = "through_first_valid"
    end
  end

  def phone2
    session[:phone_number] = user_params[:phone_number] # キーnumberは仮
    @user = User.new
  end

  def address
    @user = User.new
  end

  def payment
    session[:delivery_last_name]        = user_params[:delivery_last_name]
    session[:delivery_first_name]       = user_params[:delivery_first_name]
    session[:delivery_last_name_kana]   = user_params[:delivery_last_name_kana]
    session[:delivery_first_name_kana]  = user_params[:delivery_first_name_kana]
    session[:zipcode]                   = user_params[:zipcode]
    session[:city]                      = user_params[:city]
    session[:address]                   = user_params[:addrss]
    session[:building]                  = user_params[:building]
    session[:delivery_phone_number]     = user_params[:delivery_phone_number]
    @credit_card = CreditCard.new
  end

  def congrats   
  end

  def create
    @user = User.new(
      nickname:                 session[:nickname],
      email:                    session[:email],
      password:                 session[:password],
      password_confirmation:    session[:password_confirmation],
      last_name:                session[:last_name],
      first_name:               session[:first_name],
      last_name_kana:           session[:last_name_kana],
      first_name_kana:          session[:first_name_kana],
      phone_number:             session[:phone_number],
      zipcode:                  session[:zipcode],
      prefecture:               session[:prefecture],
      city:                     session[:city],
      address:                  session[:address],
      birthday:                 session[:birthday],
      delivery_last_name:       session[:delivery_last_name],
      delivery_first_name:      session[:delivery_first_name],
      delivery_last_name_kana:  session[:delivery_last_name_kana],
      delivery_first_name_kana: session[:delivery_first_name_kana],
      delivery_phone_number:    session[:delivery_phone_number]
    )
    credit_card_params = {
      card_number:      params[:credit_card][:card_number],
      exporation_date:  params[:credit_card]["exporation_date(2i)"] + "/" + params[:credit_card]["exporation_date(1i)"], # exporation_date :integer
      cvc:              params[:credit_card][:cvc]
    }


    if @user.save # userがvalid: trueで
      if @user.credit_cards.build(credit_card_params).valid? # credit_cardもvalid: trueなら
        credit_card = @user.credit_cards.build(credit_card_params)
        credit_card.save
        session[:id] = @user.id
        redirect_to congrats_signup_index_path
      else
        User.last.delete # userをsaveしてしまっているので,delete
        render 'signup/payment'
      end
    else
      render 'signup/payment'
    end
    
  end


  private

  def user_params
    params.require(:user).permit(
      :nickname, 
      :email, 
      :password, 
      :password_confirmation, 
      :last_name, 
      :first_name, 
      :last_name_kana, 
      :first_name_kana, 
      :phone_number,
      :zipcode,
      :prefecture,
      :city,
      :address,
      :birthday,
      :delivery_last_name,
      :delivery_first_name,
      :delivery_last_name_kana,
      :delivery_first_name_kana,
      :delivery_phone_number
    )
  end

  def credit_card_params
    params.require(:credit_card).permit(:card_number, :exporation_date, :cvc)
  end

  def redirect_to_index_from_registration
    redirect_to registration_signup_index_path unless session[:through_first_valid].present? && session[:through_first_valid] == "through_first_valid"
  end
end