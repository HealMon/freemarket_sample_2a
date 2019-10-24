require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe 'HomeControllerについて' do
    describe 'GETメソッドのindexアクションについて' do
      it 'レスポンスが正常に返っている' do
        get :index
        expect(response).to be_success
      end       
    end
  end
end