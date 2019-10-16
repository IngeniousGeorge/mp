if Rails.env.development?
  AdminUser.create!(email: "admin@example.com", password: "password", password_confirmation: "password", confirmed_at: DateTime.now)
  
  c1 = Client.create!(name: "jim", email: "jim@ig.com", password: "password", password_confirmation: "password", confirmed_at: DateTime.now)
  Basket.create(client_id: c1.id)
  Location.create(name: "Home", slug: "home", recipient: "Jim Norton", street: "Sonnenalle 1", city: "Berlin", country: "Germany", postal_code: "12047", delivery: true, billing: true, owner_type: "Client", owner_id: c1.id)
  
  c2 = Client.create!(name: "jc", email: "jc@ig.com", password: "password", password_confirmation: "password", confirmed_at: DateTime.now)
  Basket.create(client_id: c2.id)
  Location.create(name: "JC", slug: "jc", recipient: "JC Baroulet", street: "Sonnenalle 200", city: "Berlin", country: "Germany", postal_code: "12059", delivery: true, billing: true, owner_type: "Client", owner_id: c2.id)
  
  Category.create([{name: "Food"},{name: "Retail"}])
  CategoryTranslation.create([{lang: "fr", name: "Alimentation", category_id: 1}, {lang: "fr", name: "Détail", category_id: 2}])
  
  s1 = Seller.new(name: "Jane Choco", slug: "jane-choco", email: "jane@sel.com", password: "password", password_confirmation: "password", description: "Best chocolates in Berlin", translations:"en|fr", confirmed_at: DateTime.now)
  s1.cover.attach(io: File.open('/home/ig/Code/mp/spec/files/cover.jpeg'), filename: 'cover.jpeg')
  s1.images.attach(io: File.open('/home/ig/Code/mp/spec/files/image1.jpeg'), filename: 'image1.jpeg')
  s1.images.attach(io: File.open('/home/ig/Code/mp/spec/files/image2.jpeg'), filename: 'image2.jpeg')
  s1.save
  SellerTranslation.create(lang: "fr", description: "Les meilleurs chocolats de Berlin", seller_id: s1.id)

  Location.create(name: "Office", slug: "office", recipient: "Jane Choco", street: "Weserstraße 100", city: "Berlin", country: "Germany", postal_code: "12047", delivery: true, billing: true, owner_type: "Seller", owner_id: s1.id)

  p1 = Product.new(name: "Chocolate", category: 1, description: "Amazing chocolate!!!", price: 100000, price_excl_vat: 80000, translations:"en|fr", seller_id: s1.id)
  p1.cover.attach(io: File.open('/home/ig/Code/mp/spec/files/cover.jpeg'), filename: 'cover.jpeg')
  p1.images.attach(io: File.open('/home/ig/Code/mp/spec/files/image1.jpeg'), filename: 'image1.jpeg')
  p1.images.attach(io: File.open('/home/ig/Code/mp/spec/files/image2.jpeg'), filename: 'image2.jpeg')
  p1.save
  ProductTag.create(tag: "yummy", product_id: p1.id)
  ProductTag.create(tag: "delicious", product_id: p1.id)
  ProductTranslation.create(lang: "fr", name: "Chocolat", description: "Super chocolat!!!", product_id: p1.id)
  ProductTag.create(tag: "trop bon", product_id: p1.id)
  ProductTag.create(tag: "delicieux", product_id: p1.id)

  p2 = Product.new(name: "Marmite", category: 1, description: "You won't believe how bad it tastes", price: 2959, price_excl_vat: 2367, translations:"en|fr", seller_id: s1.id)
  p2.cover.attach(io: File.open('/home/ig/Code/mp/spec/files/cover.jpeg'), filename: 'cover.jpeg')
  p2.images.attach(io: File.open('/home/ig/Code/mp/spec/files/image1.jpeg'), filename: 'image1.jpeg')
  p2.images.attach(io: File.open('/home/ig/Code/mp/spec/files/image2.jpeg'), filename: 'image2.jpeg')
  p2.save
  ProductTag.create(tag: "awful", product_id: p2.id)
  ProductTag.create(tag: "just bad", product_id: p2.id)
  ProductTranslation.create(lang: "fr", name: "Marmite", description: "C'est incroyable à quel point c'est mauvais", product_id: p2.id)
  ProductTag.create(tag: "atroce", product_id: p2.id)
  ProductTag.create(tag: "juste afreux", product_id: p2.id)

  s2 = Seller.create(name: "Jack Jack", slug: "jack-jack", email: "jack@sel.com", password: "password", password_confirmation: "password", description: "All you possibly need in Berlin", translations:"en|fr", confirmed_at: DateTime.now)
  Location.create(name: "Warehouse", slug: "warehaouse", recipient: "Mr. Jack Nicholson", street: "Innstraße 10", city: "Berlin", country: "Germany", postal_code: "12045", delivery: true, billing: true, owner_type: "Seller", owner_id: s2.id)
  SellerTranslation.create(lang: "fr", description: "Tout ce qu'il vous faut à Berlin", seller_id: s2.id)

  p3 = Product.new(name: "Shoe horn", category: 2 , description: "You'll never tie your shoes again", price: 1299, price_excl_vat: 1039, translations:"en|fr", seller_id: s2.id)
  p3.cover.attach(io: File.open('/home/ig/Code/mp/spec/files/cover.jpeg'), filename: 'cover.jpeg')
  p3.images.attach(io: File.open('/home/ig/Code/mp/spec/files/image1.jpeg'), filename: 'image1.jpeg')
  p3.images.attach(io: File.open('/home/ig/Code/mp/spec/files/image2.jpeg'), filename: 'image2.jpeg')
  p3.save
  ProductTag.create(tag: "useful", product_id: p3.id)
  ProductTag.create(tag: "foot wear", product_id: p3.id)
  ProductTranslation.create(lang: "fr", name: "Chausse pied", description: "Vous ne ferez plus jamais vos lacets!", product_id: p3.id)
  ProductTag.create(tag: "pratique", product_id: p3.id)
  ProductTag.create(tag: "pour vos pieds", product_id: p3.id)

  p4 = Product.new(name: "Rake", category: 2, description: "Autumn's best friend", price: 10000, price_excl_vat: 8000, translations:"en|fr", seller_id: s2.id)
  p4.cover.attach(io: File.open('/home/ig/Code/mp/spec/files/cover.jpeg'), filename: 'cover.jpeg')
  p4.images.attach(io: File.open('/home/ig/Code/mp/spec/files/image1.jpeg'), filename: 'image1.jpeg')
  p4.images.attach(io: File.open('/home/ig/Code/mp/spec/files/image2.jpeg'), filename: 'image2.jpeg')
  p4.save
  ProductTag.create(tag: "useful", product_id: p4.id)
  ProductTag.create(tag: "tool", product_id: p4.id)
  ProductTranslation.create(lang: "fr", name: "Chausse pied", description: "Vous ne ferez plus jamais vos lacets!", product_id: p4.id)
  ProductTag.create(tag: "pratique", product_id: p4.id)
  ProductTag.create(tag: "outil", product_id: p4.id)

  puts "seeding complete"
end
