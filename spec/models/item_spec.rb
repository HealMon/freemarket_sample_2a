describe "item#new (/items/sell)" do 

  it "きちんとしたデータが入力されるとバリデーションに通る" do
    category = Category.create(name: "レディース")
    category_id = Category.last.id
    user = create(:user)

    byebug

    # カテゴリーを元にitemインスタンスを作成
    item = user.items.build(
      trade_status: 1,
      shipping_method_id: 1,
      condition: 1,
      shipping_charge_id: 1,
      estimated_delivery_id: 1,
      category_id: category_id,
      prefecture_id: 1,
      products_sizes_id: 1,
      price: 10000,
      name: "test",
      description: "test description",
      images: [],
    )
    expect(item).to be_valid
  end
  
  it "trade_statasが無いとバリデーションに通らない" do
    category = Category.create(name: "レディース")
    category_id = Category.last.id
    user = create(:user)

    item = user.items.build(
      trade_status: nil,
      shipping_method_id: 1,
      condition: 1,
      category_id: category_id,
      shipping_charge_id: 1,
      estimated_delivery_id: 1,
      prefecture_id: 1,
      products_sizes_id: 1,
      price: 10000,
      name: "test",
      description: "test description",
      images: [],
    )
    
    expect(item).not_to be_valid
  end
  
  it "shipping_method_idが無いとバリデーションに通らない" do
    category = Category.create(name: "レディース")
    category_id = Category.last.id
    user = create(:user)
  
    item = user.items.build(
      trade_status: 1,
      shipping_method_id: nil,
      condition: 1,
      shipping_charge_id: 1,
      category_id: category_id,
      estimated_delivery_id: 1,
      prefecture_id: 1,
      products_sizes_id: 1,
      price: 10000,
      name: "test",
      description: "test description",
      images: [],
    )
    expect(item).not_to be_valid
  end
  
  it "conditionが無いとバリデーションに通らない" do
    category = Category.create(name: "レディース")
    category_id = Category.last.id
    user = create(:user)
    
    item = user.items.build(
      trade_status: 1,
      shipping_method_id: 1,
      condition: nil,
      shipping_charge_id: 1,
      estimated_delivery_id: 1,
      category_id: category_id,
      prefecture_id: 1,
      products_sizes_id: 1,
      price: 10000,
      name: "test",
      description: "test description",
      images: [],
    )
    expect(item).not_to be_valid
  end

  it "shipping_charge_idが無いとバリデーションに通らない" do
    category = Category.create(name: "レディース")
    category_id = Category.last.id
    user = create(:user)
    
    item = user.items.build(
      trade_status: 1,
      shipping_method_id: 1,
      condition: 1,
      shipping_charge_id: nil,
      estimated_delivery_id: 1,
      prefecture_id: 1,
      category_id: category_id,
      products_sizes_id: 1,
      price: 10000,
      name: "test",
      description: "test description",
      images: [],
    )
    expect(item).not_to be_valid
  end

  it "estimated_delivery_idが無いとバリデーションに通らない" do
    category = Category.create(name: "レディース")
    category_id = Category.last.id
    user = create(:user)
    
    item = user.items.build(
      trade_status: 1,
      shipping_method_id: 1,
      condition: 1,
      shipping_charge_id: 1,
      estimated_delivery_id: nil,
      category_id: category_id,
      prefecture_id: 1,
      products_sizes_id: 1,
      price: 10000,
      name: "test",
      description: "test description",
      images: [],
    )
    expect(item).not_to be_valid
  end
  
  it "prefecture_idが無いとバリデーションに通らない" do
    category = Category.create(name: "レディース")
    category_id = Category.last.id
    user = create(:user)
    
    item = user.items.build(
      trade_status: 1,
      shipping_method_id: 1,
      condition: 1,
      shipping_charge_id: 1,
      estimated_delivery_id: 1,
      category_id: category_id,
      prefecture_id: nil,
      products_sizes_id: 1,
      price: 10000,
      name: "test",
      description: "test description",
      images: [],
    )
    expect(item).not_to be_valid
  end
  

  it "priceが無いとバリデーションに通らない" do
    category = Category.create(name: "レディース")
    category_id = Category.last.id
    user = create(:user)
    
    item = user.items.build(
      trade_status: 1,
      shipping_method_id: 1,
      condition: 1,
      shipping_charge_id: 1,
      estimated_delivery_id: 1,
      category_id: category_id,
      prefecture_id: 1,
      products_sizes_id: 1,
      price: nil,
      name: "test",
      description: "test description",
      images: [],
    )
    expect(item).not_to be_valid
  end

  it "price上限を超えるととバリデーションに通らない" do
    category = Category.create(name: "レディース")
    category_id = Category.last.id
    user = create(:user)
    
    item = user.items.build(
      trade_status: 1,
      shipping_method_id: 1,
      condition: 1,
      category_id: category_id,
      shipping_charge_id: 1,
      estimated_delivery_id: 1,
      prefecture_id: 1,
      products_sizes_id: 1,
      price: 10000000,
      name: "test",
      description: "test description",
      images: [],
    )
    expect(item).not_to be_valid
  end

  it "price下限より下回るととバリデーションに通らない" do
    category = Category.create(name: "レディース")
    category_id = Category.last.id
    user = create(:user)
    
    item = user.items.build(
      trade_status: 1,
      shipping_method_id: 1,
      condition: 1,
      shipping_charge_id: 1,
      category_id: category_id,
      estimated_delivery_id: 1,
      prefecture_id: 1,
      products_sizes_id: 1,
      price: 100,
      name: "test",
      description: "test description",
      images: [],
    )
    expect(item).not_to be_valid
  end

  it "nameが無いとバリデーションに通らない" do
    category = Category.create(name: "レディース")
    category_id = Category.last.id
    user = create(:user)
    
    item = user.items.build(
      trade_status: 1,
      shipping_method_id: 1,
      condition: 1,
      shipping_charge_id: 1,
      estimated_delivery_id: 1,
      prefecture_id: 1,
      category_id: category_id,
      products_sizes_id: 1,
      price: 10000,
      name: nil,
      description: "test description",
      images: [],
    )
    expect(item).not_to be_valid
  end

  it "descriptionが無いとバリデーションに通らない" do
    category = Category.create(name: "レディース")
    category_id = Category.last.id
    user = create(:user)
    
    item = user.items.build(
      trade_status: 1,
      shipping_method_id: 1,
      condition: 1,
      shipping_charge_id: 1,
      category_id: category_id,
      estimated_delivery_id: 1,
      prefecture_id: 1,
      products_sizes_id: 1,
      price: 10000,
      name: "test",
      description: nil,
      images: [],
    )
    expect(item).not_to be_valid
  end
end
