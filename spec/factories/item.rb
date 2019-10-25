FactoryBot.define do
  factory :category do
    name {"レディース"}
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