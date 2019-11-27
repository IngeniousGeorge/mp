if Rails.env.development?

  lorem = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."

  AdminUser.create!(email: "admin@example.com", password: "password", password_confirmation: "password", confirmed_at: DateTime.now)
  
  c1 = Client.create!(name: "jim", email: "jim@ig.com", password: "password", password_confirmation: "password", confirmed_at: DateTime.now)
  Basket.create(client_id: c1.id)
  Location.create(name: "Home", slug: "home", recipient: "Jim Norton", street: "Sonnenalle 1", city: "Berlin", country: "Germany", postal_code: "12047", delivery: true, billing: true, owner_type: "Client", owner_id: c1.id)
  
  c2 = Client.create!(name: "jc", email: "jc@ig.com", password: "password", password_confirmation: "password", confirmed_at: DateTime.now)
  Basket.create(client_id: c2.id)
  Location.create(name: "JC", slug: "jc", recipient: "JC Baroulet", street: "Sonnenalle 200", city: "Berlin", country: "Germany", postal_code: "12059", delivery: true, billing: true, owner_type: "Client", owner_id: c2.id)
  
  c1 = Category.create(name: "Food", description: "It's so ymmy!")
  c2 = Category.create(name: "Retail", description: "It's so useful!")
  c3 = Category.create(name: "Other", description: "It's everything else!")
  CategoryTranslation.create([{lang: "fr", name: "Alimentation", description: "C'est tellement bon!", category_id: c1.id}, {lang: "fr", name: "Détail", description: "C'est tellement utile!", category_id: c2.id}, {lang: "fr", name: "Autre", description: "C'est tout le reste", category_id: c3.id}])
  c1.cover.attach(io: File.open('/home/ig/Code/mp/spec/files/cover.png'), filename: 'cover.png')
  c2.cover.attach(io: File.open('/home/ig/Code/mp/spec/files/cover.png'), filename: 'cover.png')
  c3.cover.attach(io: File.open('/home/ig/Code/mp/spec/files/cover.png'), filename: 'cover.png')
  
  s1 = Seller.new(name: "Jane Choco", slug: "jane-choco", email: "jane@sel.com", password: "password", password_confirmation: "password", description: "Best chocolates in Berlin", translations:"en|fr", confirmed_at: DateTime.now)
  s1.cover.attach(io: File.open('/home/ig/Code/mp/spec/files/cover.png'), filename: 'cover.png')
  s1.images.attach(io: File.open('/home/ig/Code/mp/spec/files/seller.png'), filename: 'seller.png')
  s1.images.attach(io: File.open('/home/ig/Code/mp/spec/files/seller.png'), filename: 'seller.png')
  s1.save
  SellerTranslation.create(lang: "fr", description: "Les meilleurs chocolats de Berlin", seller_id: s1.id)

  Location.create(name: "Office", slug: "office", recipient: "Jane Choco", street: "Weserstraße 100", city: "Berlin", country: "Germany", postal_code: "12047", delivery: true, billing: true, owner_type: "Seller", owner_id: s1.id)

  p1 = Product.new(name: "Chocolate", category: c1.id, description: "Amazing chocolate!!!", price: 100000, price_excl_vat: 80000, translations:"en|fr", seller_id: s1.id)
  p1.cover.attach(io: File.open('/home/ig/Code/mp/spec/files/cover.png'), filename: 'cover.png')
  p1.images.attach(io: File.open('/home/ig/Code/mp/spec/files/product.png'), filename: 'product.png')
  p1.images.attach(io: File.open('/home/ig/Code/mp/spec/files/product.png'), filename: 'product.png')
  p1.save
  ProductTag.create(tag: "yummy", lang: "en", product_id: p1.id)
  ProductTag.create(tag: "delicious", lang: "en", product_id: p1.id)
  ProductTranslation.create(lang: "fr", description: "Super chocolat!!!", product_id: p1.id)
  ProductTag.create(tag: "trop bon", lang: "fr", product_id: p1.id)
  ProductTag.create(tag: "delicieux", lang: "fr", product_id: p1.id)

  p2 = Product.new(name: "Marmite", category: c1.id, description: "You won't believe how bad it tastes", price: 2959, price_excl_vat: 2367, translations:"en|fr", seller_id: s1.id)
  p2.cover.attach(io: File.open('/home/ig/Code/mp/spec/files/cover.png'), filename: 'cover.png')
  p2.images.attach(io: File.open('/home/ig/Code/mp/spec/files/product.png'), filename: 'product.png')
  p2.images.attach(io: File.open('/home/ig/Code/mp/spec/files/product.png'), filename: 'product.png')
  p2.save
  ProductTag.create(tag: "awful", lang: "en", product_id: p2.id)
  ProductTag.create(tag: "just bad", lang: "en", product_id: p2.id)
  ProductTranslation.create(lang: "fr", description: "C'est incroyable à quel point c'est mauvais", product_id: p2.id)
  ProductTag.create(tag: "atroce", lang: "fr", product_id: p2.id)
  ProductTag.create(tag: "juste afreux", lang: "fr", product_id: p2.id)

  20.times do |i|
    i += 1
    pi = Product.new(name: "Food product " + i.to_s, category: c1.id, description: "Food product description: " + lorem, price: 10000, price_excl_vat: 8000, translations:"en|fr", seller_id: s1.id)
    pi.cover.attach(io: File.open('/home/ig/Code/mp/spec/files/cover.png'), filename: 'cover.png')
    pi.images.attach(io: File.open('/home/ig/Code/mp/spec/files/product.png'), filename: 'product.png')
    pi.images.attach(io: File.open('/home/ig/Code/mp/spec/files/product.png'), filename: 'product.png')
    pi.save
    ProductTag.create(tag: "one", lang: "en", product_id: pi.id)
    ProductTag.create(tag: "two", lang: "en", product_id: pi.id)
    ProductTranslation.create(lang: "fr", description: "Description produit: " + lorem, product_id: pi.id)
    ProductTag.create(tag: "un", lang: "fr", product_id: pi.id)
    ProductTag.create(tag: "deux", lang: "fr", product_id: pi.id)
  end

  s2 = Seller.create(name: "Jack Jack", slug: "jack-jack", email: "jack@sel.com", password: "password", password_confirmation: "password", description: "All you possibly need in Berlin", translations:"en|fr", confirmed_at: DateTime.now)
  Location.create(name: "Warehouse", slug: "warehaouse", recipient: "Mr. Jack Nicholson", street: "Innstraße 10", city: "Berlin", country: "Germany", postal_code: "12045", delivery: true, billing: true, owner_type: "Seller", owner_id: s2.id)
  SellerTranslation.create(lang: "fr", description: "Tout ce qu'il vous faut à Berlin", seller_id: s2.id)
  s2.cover.attach(io: File.open('/home/ig/Code/mp/spec/files/cover.png'), filename: 'cover.png')

  p3 = Product.new(name: "Shoe horn", category: c2.id , description: "You'll never tie your shoes again", price: 1299, price_excl_vat: 1039, translations:"en|fr", seller_id: s2.id)
  p3.cover.attach(io: File.open('/home/ig/Code/mp/spec/files/cover.png'), filename: 'cover.png')
  p3.images.attach(io: File.open('/home/ig/Code/mp/spec/files/seller.png'), filename: 'seller.png')
  p3.images.attach(io: File.open('/home/ig/Code/mp/spec/files/seller.png'), filename: 'seller.png')
  p3.save
  ProductTag.create(tag: "useful", lang: "en", product_id: p3.id)
  ProductTag.create(tag: "foot wear", lang: "en", product_id: p3.id)
  ProductTranslation.create(lang: "fr", description: "Vous ne ferez plus jamais vos lacets!", product_id: p3.id)
  ProductTag.create(tag: "pratique", lang: "fr", product_id: p3.id)
  ProductTag.create(tag: "pour vos pieds", lang: "fr", product_id: p3.id)

  p4 = Product.new(name: "Rake", category: c2.id, description: "Autumn's best friend", price: 10000, price_excl_vat: 8000, translations:"en|fr", seller_id: s2.id)
  p4.cover.attach(io: File.open('/home/ig/Code/mp/spec/files/cover.png'), filename: 'cover.png')
  p4.images.attach(io: File.open('/home/ig/Code/mp/spec/files/product.png'), filename: 'product.png')
  p4.images.attach(io: File.open('/home/ig/Code/mp/spec/files/product.png'), filename: 'product.png')
  p4.save
  ProductTag.create(tag: "useful", lang: "en", product_id: p4.id)
  ProductTag.create(tag: "tool", lang: "en", product_id: p4.id)
  ProductTranslation.create(lang: "fr", description: "Le meilleur ami de l'automne", product_id: p4.id)
  ProductTag.create(tag: "pratique", lang: "fr", product_id: p4.id)
  ProductTag.create(tag: "outil", lang: "fr", product_id: p4.id)

  20.times do |i|
    i += 1
    pi = Product.new(name: "Retail product " + i.to_s, category: c2.id, description: "Retail product description: " + lorem, price: 10000, price_excl_vat: 8000, translations:"en|fr", seller_id: s2.id)
    pi.cover.attach(io: File.open('/home/ig/Code/mp/spec/files/cover.png'), filename: 'cover.png')
    pi.images.attach(io: File.open('/home/ig/Code/mp/spec/files/product.png'), filename: 'product.png')
    pi.images.attach(io: File.open('/home/ig/Code/mp/spec/files/product.png'), filename: 'product.png')
    pi.save
    ProductTag.create(tag: "one", lang: "en", product_id: pi.id)
    ProductTag.create(tag: "two", lang: "en", product_id: pi.id)
    ProductTranslation.create(lang: "fr", description: "Description produit de detail: " + lorem, product_id: pi.id)
    ProductTag.create(tag: "un", lang: "fr", product_id: pi.id)
    ProductTag.create(tag: "deux", lang: "fr", product_id: pi.id)
  end

  puts "seeding complete"
end
