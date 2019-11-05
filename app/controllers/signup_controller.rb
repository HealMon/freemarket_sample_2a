class SignupController < ApplicationController
  before_action :validates_step1, only: :phone1
  before_action :validates_step2, only: :payment
  before_action :validates_step3, only: :create

  def new
    @user = User.new
  end

  def phone1
    @user = User.new
  end

  def phone2
    session[:phone_number] = user_params[:phone_number]
    @user = User.new
  end

  def address
    @user = User.new
  end

  def payment
  end

  def congrats 
  end

  def create
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
      :prefecture_id,
      :city,
      :address,
      :birth_year,
      :birth_month,
      :birth_day,
      :delivery_last_name,
      :delivery_first_name,
      :delivery_last_name_kana,
      :delivery_first_name_kana,
      :delivery_phone_number
    )
  end

  def validates_step1
    session[:birth_year]            = user_params[:birth_year]
    session[:birth_month]           = user_params[:birth_month]
    session[:birth_day]             = user_params[:birth_day]
    session[:nickname]              = user_params[:nickname]
    session[:email]                 = user_params[:email]
    session[:password]              = user_params[:password]
    session[:password_confirmation] = user_params[:password_confirmation]
    session[:last_name]             = user_params[:last_name]
    session[:first_name]            = user_params[:first_name]
    session[:last_name_kana]        = user_params[:last_name_kana]
    session[:first_name_kana]       = user_params[:first_name_kana]
    
    @user = User.new(
      birth_year:               session[:birth_year],
      birth_month:              session[:birth_month],
      birth_day:                session[:birth_day],
      nickname:                 session[:nickname],
      email:                    session[:email],
      password:                 session[:password] ,
      password_confirmation:    session[:password_confirmation] ,
      last_name:                session[:last_name] ,
      first_name:               session[:first_name],
      last_name_kana:           session[:last_name_kana],
      first_name_kana:          session[:first_name_kana],
      phone_number:             "09099999999",
      delivery_last_name:       "仮登録",
      delivery_first_name:      "仮登録",
      delivery_last_name_kana:  "カリトウロク",
      delivery_first_name_kana: "カリトウロク",
      prefecture_id:            "1",
      zipcode:                  "781-0001",
      city:                     "高知市",
      address:                  "1-1",
      building:                 "仮ハイツ１"  ,
      delivery_phone_number:    "09099999999",
    )
    render action: :new unless @user.valid?
  end

  def validates_step2

    session[:delivery_last_name]        = user_params[:delivery_last_name]
    session[:delivery_first_name]       = user_params[:delivery_first_name]
    session[:delivery_last_name_kana]   = user_params[:delivery_last_name_kana]
    session[:delivery_first_name_kana]  = user_params[:delivery_first_name_kana]
    session[:prefecture_id]             = user_params[:prefecture_id]
    session[:zipcode]                   = user_params[:zipcode]
    session[:city]                      = user_params[:city]
    session[:address]                   = user_params[:address]
    session[:building]                  = user_params[:building]
    session[:delivery_phone_number]     = user_params[:delivery_phone_number]

    @user = User.new(
      birth_year:               session[:birth_year],
      birth_month:              session[:birth_month],
      birth_day:                session[:birth_day],
      nickname:                 session[:nickname],
      email:                    session[:email],
      password:                 session[:password] ,
      password_confirmation:    session[:password_confirmation] ,
      last_name:                session[:last_name] ,
      first_name:               session[:first_name],
      last_name_kana:           session[:last_name_kana],
      first_name_kana:          session[:first_name_kana],
      phone_number:             session[:phone_number],
      delivery_last_name:       session[:delivery_last_name],
      delivery_first_name:      session[:delivery_first_name],
      delivery_last_name_kana:  session[:delivery_last_name_kana],
      delivery_first_name_kana: session[:delivery_first_name_kana],
      zipcode:                  session[:zipcode],
      prefecture_id:            session[:prefecture_id],
      city:                     session[:city] ,
      address:                  session[:address],
      building:                 session[:building],
      delivery_phone_number:    session[:delivery_phone_number],
    )

    render action: :address unless @user.valid?
  end

  def validates_step3
    @user = User.create(
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
      prefecture_id:            session[:prefecture_id],
      city:                     session[:city],
      address:                  session[:address],
      birth_year:               session[:birth_year],
      birth_month:              session[:birth_month],
      birth_day:                session[:birth_day],
      delivery_last_name:       session[:delivery_last_name],
      delivery_first_name:      session[:delivery_first_name],
      delivery_last_name_kana:  session[:delivery_last_name_kana],
      delivery_first_name_kana: session[:delivery_first_name_kana],
      delivery_phone_number:    session[:delivery_phone_number]
    )

    get_user_id = User.last.id # 先程登録したユーザーのid
    secret_key = Rails.application.credentials[:secret_payjp_key]
    Payjp.api_key = secret_key
    if params['payjpToken'].blank?
      # paramsの中にjsで作った'payjpTokenが存在するか確かめる
      render action: :payment
    else
      customer = Payjp::Customer.create(
      card: params['payjpToken'],
      metadata: {user_id: get_user_id}
      )
      # ↑ここでpay.jpに保存
      @card = Card.new(user_id: get_user_id, customer_id: customer.id, card_id: customer.default_card)
      # ここでdbに保存
      if @card.save
        session[:id] = @user.id # TODO: ユーザーのログイン処理を入れる
        
        redirect_to congrats_signup_index_path
      else
        User.last.delete
        render action: :payment
      end
    end
  end
end