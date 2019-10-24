FactoryBot.define do
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
    image                  {"https://tech-master.s3.amazonaws.com/uploads/curriculums/images/Rails1-4/sample.jpg"}
  end
end