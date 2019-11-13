class UserController < ApplicationController
  def edit
  end

  def update
  end

  def profile
  end

  def tosaben
    session[:tosaben] = params[:tosaben]
  end
end
