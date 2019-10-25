FactoryBot.define do
  factory :category do
    name {"レディース"}
  end

  factory :user do
      birth_year               {1900}
      birth_month              {1}
      birth_day                {1}
      nickname                 {"test"}
      email                    {"test@gmail.com"}
      password                 {"testtest123"}
      password_confirmation    {"testtest123"}
      last_name                {"A"}
      first_name               {"チーム"}
      last_name_kana           {"エー"}
      first_name_kana          {"チーム"}
      phone_number             {"09099999999"}
      delivery_last_name       {"仮登録"}
      delivery_first_name      {"仮登録"}
      delivery_last_name_kana  {"カリトウロク"}
      delivery_first_name_kana {"カリトウロク"}
      prefecture_id            {"1"}
      zipcode                  {"781-0001"}
      city                     {"高知市"}
      address                  {"1-1"}
      building                 {"仮ハイツ１"}  
      delivery_phone_number    {"09099999999"}  
  end

  factory :item do
    name                   {"test"}      
    description            {"test description"}   
    price                  {10000}   
    condition              {1}
    shipping_charge_id     {1}
    shipping_method_id     {1}
    prefecture_id          {1}
    estimated_delivery_id  {1}
    trade_status           {1}
    category_id            {1}

    after(:build) do |image|
      image.attached = fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'test.jpg'), 'image/jpg')
    end
  end
end