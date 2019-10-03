if Rails.env.development?
  AdminUser.create!(email: "admin@example.com", password: "password", password_confirmation: "password", confirmed_at: DateTime.now)
  
  c1 = Client.create!(name: "jim", email: "jim@ig.com", password: "password", password_confirmation: "password", confirmed_at: DateTime.now)
  Basket.create(client_id: c1.id)
  Location.create(name: "Home", slug: "home", recipient: "Jim Norton", street: "Sonnenalle 1", city: "Berlin", country: "Germany", postal_code: "12047", delivery: true, billing: true, owner_type: "Client", owner_id: c1.id)
  
  c2 = Client.create!(name: "jc", email: "jc@ig.com", password: "password", password_confirmation: "password", confirmed_at: DateTime.now)
  Basket.create(client_id: c2.id)
  Location.create(name: "JC", slug: "jc", recipient: "JC Baroulet", street: "Sonnenalle 200", city: "Berlin", country: "Germany", postal_code: "12059", delivery: true, billing: true, owner_type: "Client", owner_id: c2.id)
  
  Category.create([{name: "Food"},{name: "Retail"}])
  
  s1 = Seller.create(name: "Jane Choco", slug: "jane-choco", email: "jane@sel.com", password: "password", password_confirmation: "password", description: "Best chocolates in Berlin", confirmed_at: DateTime.now)
  Location.create(name: "Office", slug: "office", recipient: "Jane Choco", street: "Weserstraße 100", city: "Berlin", country: "Germany", postal_code: "12047", delivery: true, billing: true, owner_type: "Seller", owner_id: s1.id)
  p1 = Product.create(name: "Chocolate", category: "Food", description: "Amazing chocolate!!!", price: 100000, price_excl_vat: 80000, seller_id: s1.id)
  ProductTag.create(tag: "yummy", product_id: p1.id)
  ProductTag.create(tag: "delicious", product_id: p1.id)
  p2 = Product.create(name: "Marmite", category: "Food", description: "You won't believe how bad it tastes", price: 2959, price_excl_vat: 2367, seller_id: s1.id)
  ProductTag.create(tag: "awful", product_id: p2.id)
  ProductTag.create(tag: "just bad", product_id: p2.id)


  s2 = Seller.create(name: "Jack Jack", slug: "jack-jack", email: "jack@sel.com", password: "password", password_confirmation: "password", description: "All you possibly need in Berlin", confirmed_at: DateTime.now)
  Location.create(name: "Warehouse", slug: "warehaouse", recipient: "Mr. Jack Nicholson", street: "Innstraße 10", city: "Berlin", country: "Germany", postal_code: "12045", delivery: true, billing: true, owner_type: "Seller", owner_id: s2.id)
  p3 = Product.create(name: "Shoe horn", category: "Retail" , description: "You'll never tie your shoes again", price: 1299, price_excl_vat: 1039, seller_id: s2.id)
  ProductTag.create(tag: "useful", product_id: p3.id)
end

# DbTranslation.create(

# )

#ADD description seller
