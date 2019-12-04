if Rails.env.development?

  lorem = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur."
  
  def shifted_names_as_array(string)
    array = []
    space_position = string.index(' ')
    string.downcase!.gsub!(/\s/, '')
    max = string.size
    max.times do |i|
      j = 0
      new_string = "                                           "
      string.each_char do |c|
        new_string[(j + i)] = c if (j + i) <= max
        new_string[((j + i) - max)] = c if (j + i) > max
        j = j+1
      end
      new_string.gsub!(/\s/, '')
      new_string = new_string[0..(space_position-1)] + " " + new_string[space_position..max]
      array << new_string.titleize
    end
    return array.uniq
  end

  AdminUser.create!(email: "admin@example.com", password: "password", password_confirmation: "password", confirmed_at: DateTime.now)
  
  c1 = Client.create!(name: "jim", email: "jim@ig.com", password: "password", password_confirmation: "password", confirmed_at: DateTime.now)
  Basket.create(client_id: c1.id)
  Location.create(name: "Home", slug: "home", recipient: "Jim Norton", street: "Sonnenalle 1", city: "Berlin", country: "Germany", postal_code: "12047", delivery: true, billing: true, owner_type: "Client", owner_id: c1.id)
  
  c2 = Client.create!(name: "jc", email: "jc@ig.com", password: "password", password_confirmation: "password", confirmed_at: DateTime.now)
  Basket.create(client_id: c2.id)
  Location.create(name: "JC", slug: "jc", recipient: "JC Baroulet", street: "Sonnenalle 200", city: "Berlin", country: "Germany", postal_code: "12059", delivery: true, billing: true, owner_type: "Client", owner_id: c2.id)
  
  c1 = Category.create(name: "Food", description: "It's so ymmy!")
  c2 = Category.create(name: "Fashion", description: "It's so beautiful!")
  c3 = Category.create(name: "Books", description: "It's so interresting!")
  CategoryTranslation.create([{lang: "fr", name: "Alimentation", description: "C'est tellement bon!", category_id: c1.id}, {lang: "fr", name: "Mode", description: "C'est tellement beau!", category_id: c2.id}, {lang: "fr", name: "Livres", description: "C'est tellement interressant!", category_id: c3.id}])
  c1.cover.attach(io: File.open('/home/ig/Code/mp/app/assets/images/categories/food.jpg'), filename: 'food.jpg')
  c2.cover.attach(io: File.open('/home/ig/Code/mp/app/assets/images/categories/fashion.jpg'), filename: 'fashion.jpg')
  c3.cover.attach(io: File.open('/home/ig/Code/mp/app/assets/images/categories/books.jpg'), filename: 'books.jpg')
  
  s1 = Seller.new(name: "Alfredo Choco", slug: "alfredo-choco", email: "alfredo@mp.com", password: "password", password_confirmation: "password", description: "Best chocolates in Berlin", translations:"en|fr", confirmed_at: DateTime.now)
  s1.cover.attach(io: File.open('/home/ig/Code/mp/app/assets/images/alfredo-choco/cover.jpg'), filename: 'cover.jpg')
  s1.save
  SellerTranslation.create(lang: "fr", description: "Les meilleurs chocolats de Berlin", seller_id: s1.id)

  Location.create(name: "Office", slug: "office", recipient: "Alfredo Choco", street: "Weserstraße 100", city: "Berlin", country: "Germany", postal_code: "12047", delivery: true, billing: true, owner_type: "Seller", owner_id: s1.id)

  s2 = Seller.new(name: "Ciara Flowers", slug: "ciara-flowers", email: "ciara@mp.com", password: "password", password_confirmation: "password", description: "All the colors of Mother Nature", translations:"en|fr", confirmed_at: DateTime.now)
  s2.cover.attach(io: File.open('/home/ig/Code/mp/app/assets/images/ciara-flowers/cover.jpg'), filename: 'cover.jpg')
  s2.save
  SellerTranslation.create(lang: "fr", description: "Toutes les couleurs de Dame Nature", seller_id: s2.id)

  Location.create(name: "Warehouse", slug: "warehaouse", recipient: "Ciara Flowers", street: "Innstraße 10", city: "Berlin", country: "Germany", postal_code: "12045", delivery: true, billing: true, owner_type: "Seller", owner_id: s2.id)

  s3 = Seller.new(name: "Julie & the Sea", slug: "julie-and-the-sea", email: "julie@mp.com", password: "password", password_confirmation: "password", description: "Everything you need to set sail, and more", translations:"en|fr", confirmed_at: DateTime.now)
  s3.cover.attach(io: File.open('/home/ig/Code/mp/app/assets/images/julie-and-the-sea/cover.jpg'), filename: 'cover.jpg')
  s3.save
  SellerTranslation.create(lang: "fr", description: "Tout ce dont vous avez besoin pour prendre le large, et plus encore", seller_id: s3.id)

  Location.create(name: "Bureaux", slug: "bureaux", recipient: "Julie Durand", street: "15 rue des Chenes", city: "Montbert", country: "France", postal_code: "44140", delivery: true, billing: true, owner_type: "Seller", owner_id: s3.id)

  
  shifted_names = shifted_names_as_array("Praline Cake")
  shifted_names.each_with_index do |name, i| 
    price = (1500 * (i+1)) / 10
    price_ev = (1500 * (i+1)) / 12
    p1 = Product.new(name: name, category: c1.id, description: "Amazing " + name + "! " + lorem, price: price, price_excl_vat: price_ev, translations:"en|fr", seller_id: s1.id)
    p1.cover.attach(io: File.open('/home/ig/Code/mp/app/assets/images/alfredo-choco/praline-cake/cover.jpg'), filename: 'cover.jpg')
    p1.images.attach(io: File.open('/home/ig/Code/mp/app/assets/images/alfredo-choco/praline-cake/img1.jpg'), filename: 'img1.jpg')
    p1.images.attach(io: File.open('/home/ig/Code/mp/app/assets/images/alfredo-choco/praline-cake/img2.jpg'), filename: 'img2.jpg')
    p1.images.attach(io: File.open('/home/ig/Code/mp/app/assets/images/alfredo-choco/praline-cake/img3.jpg'), filename: 'img3.jpg')
    p1.save
    ProductTag.create(tag: "yummy", lang: "en", product_id: p1.id)
    ProductTag.create(tag: "delicious", lang: "en", product_id: p1.id)
    ProductTranslation.create(lang: "fr", description: "Super " + name + "! " + lorem, product_id: p1.id)
    ProductTag.create(tag: "trop bon", lang: "fr", product_id: p1.id)
    ProductTag.create(tag: "delicieux", lang: "fr", product_id: p1.id)
  end

  shifted_names = shifted_names_as_array("Classic Apron")
  shifted_names.each_with_index do |name, i| 
    price = (1500 * (i+1)) / 10
    price_ev = (1500 * (i+1)) / 12
    p2 = Product.new(name: name, category: c2.id, description: "Amazing " + name + "! " + lorem, price: price, price_excl_vat: price_ev, translations:"en|fr", seller_id: s1.id)
    p2.cover.attach(io: File.open('/home/ig/Code/mp/app/assets/images/alfredo-choco/classic-apron/cover.jpg'), filename: 'cover.jpg')
    p2.images.attach(io: File.open('/home/ig/Code/mp/app/assets/images/alfredo-choco/classic-apron/img1.jpg'), filename: 'img1.jpg')
    p2.images.attach(io: File.open('/home/ig/Code/mp/app/assets/images/alfredo-choco/classic-apron/img2.jpg'), filename: 'img2.jpg')
    p2.images.attach(io: File.open('/home/ig/Code/mp/app/assets/images/alfredo-choco/classic-apron/img3.jpg'), filename: 'img3.jpg')
    p2.save
    ProductTag.create(tag: "classy", lang: "en", product_id: p2.id)
    ProductTag.create(tag: "ageless", lang: "en", product_id: p2.id)
    ProductTranslation.create(lang: "fr", description: "Super " + name + "! " + lorem, product_id: p2.id)
    ProductTag.create(tag: "classieux", lang: "fr", product_id: p2.id)
    ProductTag.create(tag: "indémodable", lang: "fr", product_id: p2.id)
  end

  shifted_names = shifted_names_as_array("Cupcake Book")
  shifted_names.each_with_index do |name, i| 
    price = (1500 * (i+1)) / 10
    price_ev = (1500 * (i+1)) / 12
    p3 = Product.new(name: name, category: c3.id, description: "Amazing " + name + "! " + lorem, price: price, price_excl_vat: price_ev, translations:"en|fr", seller_id: s1.id)
    p3.cover.attach(io: File.open('/home/ig/Code/mp/app/assets/images/alfredo-choco/cupcake-book/cover.jpg'), filename: 'cover.jpg')
    p3.images.attach(io: File.open('/home/ig/Code/mp/app/assets/images/alfredo-choco/cupcake-book/img1.jpg'), filename: 'img1.jpg')
    p3.images.attach(io: File.open('/home/ig/Code/mp/app/assets/images/alfredo-choco/cupcake-book/img2.jpg'), filename: 'img2.jpg')
    p3.images.attach(io: File.open('/home/ig/Code/mp/app/assets/images/alfredo-choco/cupcake-book/img3.jpg'), filename: 'img3.jpg')
    p3.save
    ProductTag.create(tag: "full of ideas", lang: "en", product_id: p3.id)
    ProductTag.create(tag: "yummy", lang: "en", product_id: p3.id)
    ProductTranslation.create(lang: "fr", description: "Super " + name + "! " + lorem, product_id: p3.id)
    ProductTag.create(tag: "plein d'idées", lang: "fr", product_id: p3.id)
    ProductTag.create(tag: "trop bon", lang: "fr", product_id: p3.id)
  end

  shifted_names = shifted_names_as_array("Rose Water")
  shifted_names.each_with_index do |name, i| 
    price = (1500 * (i+1)) / 10
    price_ev = (1500 * (i+1)) / 12
    p4 = Product.new(name: name, category: c1.id, description: "Amazing " + name + "! " + lorem, price: price, price_excl_vat: price_ev, translations:"en|fr", seller_id: s2.id)
    p4.cover.attach(io: File.open('/home/ig/Code/mp/app/assets/images/ciara-flowers/rose-water/cover.jpg'), filename: 'cover.jpg')
    p4.images.attach(io: File.open('/home/ig/Code/mp/app/assets/images/ciara-flowers/rose-water/img1.jpg'), filename: 'img1.jpg')
    p4.images.attach(io: File.open('/home/ig/Code/mp/app/assets/images/ciara-flowers/rose-water/img2.jpg'), filename: 'img2.jpg')
    p4.images.attach(io: File.open('/home/ig/Code/mp/app/assets/images/ciara-flowers/rose-water/img3.jpg'), filename: 'img3.jpg')
    p4.save
    ProductTag.create(tag: "exotic", lang: "en", product_id: p4.id)
    ProductTag.create(tag: "yummy", lang: "en", product_id: p4.id)
    ProductTranslation.create(lang: "fr", description: "Super " + name + "! " + lorem, product_id: p4.id)
    ProductTag.create(tag: "exotique", lang: "fr", product_id: p4.id)
    ProductTag.create(tag: "trop bon", lang: "fr", product_id: p4.id)
  end

  shifted_names = shifted_names_as_array("Green Dress")
  shifted_names.each_with_index do |name, i| 
    price = (1500 * (i+1)) / 10
    price_ev = (1500 * (i+1)) / 12
    p5 = Product.new(name: name, category: c2.id, description: "Amazing " + name + "! " + lorem, price: price, price_excl_vat: price_ev, translations:"en|fr", seller_id: s2.id)
    p5.cover.attach(io: File.open('/home/ig/Code/mp/app/assets/images/ciara-flowers/green-dress/cover.jpg'), filename: 'cover.jpg')
    p5.images.attach(io: File.open('/home/ig/Code/mp/app/assets/images/ciara-flowers/green-dress/img1.jpg'), filename: 'img1.jpg')
    p5.images.attach(io: File.open('/home/ig/Code/mp/app/assets/images/ciara-flowers/green-dress/img2.jpg'), filename: 'img2.jpg')
    p5.images.attach(io: File.open('/home/ig/Code/mp/app/assets/images/ciara-flowers/green-dress/img3.jpg'), filename: 'img3.jpg')
    p5.save
    ProductTag.create(tag: "colorful", lang: "en", product_id: p5.id)
    ProductTag.create(tag: "classy", lang: "en", product_id: p5.id)
    ProductTranslation.create(lang: "fr", description: "Super " + name + "! " + lorem, product_id: p5.id)
    ProductTag.create(tag: "coloré", lang: "fr", product_id: p5.id)
    ProductTag.create(tag: "classieux", lang: "fr", product_id: p5.id)
  end

  shifted_names = shifted_names_as_array("Lilac Book")
  shifted_names.each_with_index do |name, i| 
    price = (1500 * (i+1)) / 10
    price_ev = (1500 * (i+1)) / 12
    p6 = Product.new(name: name, category: c3.id, description: "Amazing " + name + "! " + lorem, price: price, price_excl_vat: price_ev, translations:"en|fr", seller_id: s2.id)
    p6.cover.attach(io: File.open('/home/ig/Code/mp/app/assets/images/ciara-flowers/lilac-book/cover.jpg'), filename: 'cover.jpg')
    p6.images.attach(io: File.open('/home/ig/Code/mp/app/assets/images/ciara-flowers/lilac-book/img1.jpg'), filename: 'img1.jpg')
    p6.images.attach(io: File.open('/home/ig/Code/mp/app/assets/images/ciara-flowers/lilac-book/img2.jpg'), filename: 'img2.jpg')
    p6.images.attach(io: File.open('/home/ig/Code/mp/app/assets/images/ciara-flowers/lilac-book/img3.jpg'), filename: 'img3.jpg')
    p6.save
    ProductTag.create(tag: "full of ideas", lang: "en", product_id: p6.id)
    ProductTag.create(tag: "beautiful", lang: "en", product_id: p6.id)
    ProductTranslation.create(lang: "fr", description: "Super " + name + "! " + lorem, product_id: p6.id)
    ProductTag.create(tag: "plein d'idées", lang: "fr", product_id: p6.id)
    ProductTag.create(tag: "magnifique", lang: "fr", product_id: p6.id)
  end

  shifted_names = shifted_names_as_array("Arcachon Oysters")
  shifted_names.each_with_index do |name, i| 
    price = (1500 * (i+1)) / 10
    price_ev = (1500 * (i+1)) / 12
    p7 = Product.new(name: name, category: c1.id, description: "Amazing " + name + "! " + lorem, price: price, price_excl_vat: price_ev, translations:"en|fr", seller_id: s3.id)
    p7.cover.attach(io: File.open('/home/ig/Code/mp/app/assets/images/julie-and-the-sea/arcachon-oysters/cover.jpg'), filename: 'cover.jpg')
    p7.images.attach(io: File.open('/home/ig/Code/mp/app/assets/images/julie-and-the-sea/arcachon-oysters/img1.jpg'), filename: 'img1.jpg')
    p7.images.attach(io: File.open('/home/ig/Code/mp/app/assets/images/julie-and-the-sea/arcachon-oysters/img2.jpg'), filename: 'img2.jpg')
    p7.images.attach(io: File.open('/home/ig/Code/mp/app/assets/images/julie-and-the-sea/arcachon-oysters/img3.jpg'), filename: 'img3.jpg')
    p7.save
    ProductTag.create(tag: "delicious", lang: "en", product_id: p7.id)
    ProductTag.create(tag: "seafood", lang: "en", product_id: p7.id)
    ProductTranslation.create(lang: "fr", description: "Super " + name + "! " + lorem, product_id: p7.id)
    ProductTag.create(tag: "delicieux", lang: "fr", product_id: p7.id)
    ProductTag.create(tag: "crustacés", lang: "fr", product_id: p7.id)
  end

  shifted_names = shifted_names_as_array("Sailor Cap")
  shifted_names.each_with_index do |name, i| 
    price = (1500 * (i+1)) / 10
    price_ev = (1500 * (i+1)) / 12
    p8 = Product.new(name: name, category: c2.id, description: "Amazing " + name + "! " + lorem, price: price, price_excl_vat: price_ev, translations:"en|fr", seller_id: s3.id)
    p8.cover.attach(io: File.open('/home/ig/Code/mp/app/assets/images/julie-and-the-sea/sailor-cap/cover.jpg'), filename: 'cover.jpg')
    p8.images.attach(io: File.open('/home/ig/Code/mp/app/assets/images/julie-and-the-sea/sailor-cap/img1.jpg'), filename: 'img1.jpg')
    p8.images.attach(io: File.open('/home/ig/Code/mp/app/assets/images/julie-and-the-sea/sailor-cap/img2.jpg'), filename: 'img2.jpg')
    p8.images.attach(io: File.open('/home/ig/Code/mp/app/assets/images/julie-and-the-sea/sailor-cap/img3.jpg'), filename: 'img3.jpg')
    p8.save
    ProductTag.create(tag: "classy", lang: "en", product_id: p8.id)
    ProductTag.create(tag: "captain", lang: "en", product_id: p8.id)
    ProductTranslation.create(lang: "fr", description: "Super " + name + "! " + lorem, product_id: p8.id)
    ProductTag.create(tag: "classieux", lang: "fr", product_id: p8.id)
    ProductTag.create(tag: "capitaine", lang: "fr", product_id: p8.id)
  end

  shifted_names = shifted_names_as_array("Moby Dick")
  shifted_names.each_with_index do |name, i| 
    price = (1500 * (i+1)) / 10
    price_ev = (1500 * (i+1)) / 12
    p9 = Product.new(name: name, category: c3.id, description: "Amazing " + name + "! " + lorem, price: price, price_excl_vat: price_ev, translations:"en|fr", seller_id: s3.id)
    p9.cover.attach(io: File.open('/home/ig/Code/mp/app/assets/images/julie-and-the-sea/moby-dick/cover.jpg'), filename: 'cover.jpg')
    p9.images.attach(io: File.open('/home/ig/Code/mp/app/assets/images/julie-and-the-sea/moby-dick/img1.jpg'), filename: 'img1.jpg')
    p9.images.attach(io: File.open('/home/ig/Code/mp/app/assets/images/julie-and-the-sea/moby-dick/img2.jpg'), filename: 'img2.jpg')
    p9.images.attach(io: File.open('/home/ig/Code/mp/app/assets/images/julie-and-the-sea/moby-dick/img3.jpg'), filename: 'img3.jpg')
    p9.save
    ProductTag.create(tag: "ageless", lang: "en", product_id: p9.id)
    ProductTag.create(tag: "captain", lang: "en", product_id: p9.id)
    ProductTranslation.create(lang: "fr", description: "Super " + name + "! " + lorem, product_id: p9.id)
    ProductTag.create(tag: "indémodable", lang: "fr", product_id: p9.id)
    ProductTag.create(tag: "capitaine", lang: "fr", product_id: p9.id)
  end



  # p2 = Product.new(name: "Marmite", category: c1.id, description: "You won't believe how bad it tastes", price: 2959, price_excl_vat: 2367, translations:"en|fr", seller_id: s1.id)
  # p2.cover.attach(io: File.open('/home/ig/Code/mp/assets/images/cover.jpg'), filename: 'cover.jpg')
  # p2.images.attach(io: File.open('/home/ig/Code/mp/assets/images/product.jpg'), filename: 'product.jpg')
  # p2.images.attach(io: File.open('/home/ig/Code/mp/assets/images/product.jpg'), filename: 'product.jpg')
  # p2.save
  # ProductTag.create(tag: "awful", lang: "en", product_id: p2.id)
  # ProductTag.create(tag: "just bad", lang: "en", product_id: p2.id)
  # ProductTranslation.create(lang: "fr", description: "C'est incroyable à quel point c'est mauvais", product_id: p2.id)
  # ProductTag.create(tag: "atroce", lang: "fr", product_id: p2.id)
  # ProductTag.create(tag: "juste afreux", lang: "fr", product_id: p2.id)

  # 20.times do |i|
  #   i += 1
  #   pi = Product.new(name: "Food product " + i.to_s, category: c1.id, description: "Food product description: " + lorem, price: 10000, price_excl_vat: 8000, translations:"en|fr", seller_id: s1.id)
  #   pi.cover.attach(io: File.open('/home/ig/Code/mp/assets/images/cover.jpg'), filename: 'cover.jpg')
  #   pi.images.attach(io: File.open('/home/ig/Code/mp/assets/images/product.jpg'), filename: 'product.jpg')
  #   pi.images.attach(io: File.open('/home/ig/Code/mp/assets/images/product.jpg'), filename: 'product.jpg')
  #   pi.save
  #   ProductTag.create(tag: "one", lang: "en", product_id: pi.id)
  #   ProductTag.create(tag: "two", lang: "en", product_id: pi.id)
  #   ProductTranslation.create(lang: "fr", description: "Description produit: " + lorem, product_id: pi.id)
  #   ProductTag.create(tag: "un", lang: "fr", product_id: pi.id)
  #   ProductTag.create(tag: "deux", lang: "fr", product_id: pi.id)
  # end

  # s2 = Seller.create(name: "Jack Jack", slug: "jack-jack", email: "jack@sel.com", password: "password", password_confirmation: "password", description: "All you possibly need in Berlin", translations:"en|fr", confirmed_at: DateTime.now)
  # Location.create(name: "Warehouse", slug: "warehaouse", recipient: "Mr. Jack Nicholson", street: "Innstraße 10", city: "Berlin", country: "Germany", postal_code: "12045", delivery: true, billing: true, owner_type: "Seller", owner_id: s2.id)
  # SellerTranslation.create(lang: "fr", description: "Tout ce qu'il vous faut à Berlin", seller_id: s2.id)
  # s2.cover.attach(io: File.open('/home/ig/Code/mp/assets/images/cover.jpg'), filename: 'cover.jpg')

  # p3 = Product.new(name: "Shoe horn", category: c2.id , description: "You'll never tie your shoes again", price: 1299, price_excl_vat: 1039, translations:"en|fr", seller_id: s2.id)
  # p3.cover.attach(io: File.open('/home/ig/Code/mp/assets/images/cover.jpg'), filename: 'cover.jpg')
  # p3.images.attach(io: File.open('/home/ig/Code/mp/assets/images/seller.jpg'), filename: 'seller.jpg')
  # p3.images.attach(io: File.open('/home/ig/Code/mp/assets/images/seller.jpg'), filename: 'seller.jpg')
  # p3.save
  # ProductTag.create(tag: "useful", lang: "en", product_id: p3.id)
  # ProductTag.create(tag: "foot wear", lang: "en", product_id: p3.id)
  # ProductTranslation.create(lang: "fr", description: "Vous ne ferez plus jamais vos lacets!", product_id: p3.id)
  # ProductTag.create(tag: "pratique", lang: "fr", product_id: p3.id)
  # ProductTag.create(tag: "pour vos pieds", lang: "fr", product_id: p3.id)

  # p4 = Product.new(name: "Rake", category: c2.id, description: "Autumn's best friend", price: 10000, price_excl_vat: 8000, translations:"en|fr", seller_id: s2.id)
  # p4.cover.attach(io: File.open('/home/ig/Code/mp/assets/images/cover.jpg'), filename: 'cover.jpg')
  # p4.images.attach(io: File.open('/home/ig/Code/mp/assets/images/product.jpg'), filename: 'product.jpg')
  # p4.images.attach(io: File.open('/home/ig/Code/mp/assets/images/product.jpg'), filename: 'product.jpg')
  # p4.save
  # ProductTag.create(tag: "useful", lang: "en", product_id: p4.id)
  # ProductTag.create(tag: "tool", lang: "en", product_id: p4.id)
  # ProductTranslation.create(lang: "fr", description: "Le meilleur ami de l'automne", product_id: p4.id)
  # ProductTag.create(tag: "pratique", lang: "fr", product_id: p4.id)
  # ProductTag.create(tag: "outil", lang: "fr", product_id: p4.id)

  # 20.times do |i|
  #   i += 1
  #   pi = Product.new(name: "Retail product " + i.to_s, category: c2.id, description: "Retail product description: " + lorem, price: 10000, price_excl_vat: 8000, translations:"en|fr", seller_id: s2.id)
  #   pi.cover.attach(io: File.open('/home/ig/Code/mp/assets/images/cover.jpg'), filename: 'cover.jpg')
  #   pi.images.attach(io: File.open('/home/ig/Code/mp/assets/images/product.jpg'), filename: 'product.jpg')
  #   pi.images.attach(io: File.open('/home/ig/Code/mp/assets/images/product.jpg'), filename: 'product.jpg')
  #   pi.save
  #   ProductTag.create(tag: "one", lang: "en", product_id: pi.id)
  #   ProductTag.create(tag: "two", lang: "en", product_id: pi.id)
  #   ProductTranslation.create(lang: "fr", description: "Description produit de detail: " + lorem, product_id: pi.id)
  #   ProductTag.create(tag: "un", lang: "fr", product_id: pi.id)
  #   ProductTag.create(tag: "deux", lang: "fr", product_id: pi.id)
  # end



  # c1 = Category.create(name: "Food", description: "It's so ymmy!")
  # c2 = Category.create(name: "Retail", description: "It's so useful!")
  # c3 = Category.create(name: "Other", description: "It's everything else!")
  # CategoryTranslation.create([{lang: "fr", name: "Alimentation", description: "C'est tellement bon!", category_id: c1.id}, {lang: "fr", name: "Détail", description: "C'est tellement utile!", category_id: c2.id}, {lang: "fr", name: "Autre", description: "C'est tout le reste", category_id: c3.id}])
  # c1.cover.attach(io: File.open('/home/ig/Code/mp/spec/files/cover.jpg'), filename: 'cover.jpg')
  # c2.cover.attach(io: File.open('/home/ig/Code/mp/spec/files/cover.jpg'), filename: 'cover.jpg')
  # c3.cover.attach(io: File.open('/home/ig/Code/mp/spec/files/cover.jpg'), filename: 'cover.jpg')
  
  # s1 = Seller.new(name: "Jane Choco", slug: "jane-choco", email: "jane@sel.com", password: "password", password_confirmation: "password", description: "Best chocolates in Berlin", translations:"en|fr", confirmed_at: DateTime.now)
  # s1.cover.attach(io: File.open('/home/ig/Code/mp/spec/files/cover.jpg'), filename: 'cover.jpg')
  # s1.images.attach(io: File.open('/home/ig/Code/mp/spec/files/seller.jpg'), filename: 'seller.jpg')
  # s1.images.attach(io: File.open('/home/ig/Code/mp/spec/files/seller.jpg'), filename: 'seller.jpg')
  # s1.save
  # SellerTranslation.create(lang: "fr", description: "Les meilleurs chocolats de Berlin", seller_id: s1.id)

  # Location.create(name: "Office", slug: "office", recipient: "Jane Choco", street: "Weserstraße 100", city: "Berlin", country: "Germany", postal_code: "12047", delivery: true, billing: true, owner_type: "Seller", owner_id: s1.id)

  # p1 = Product.new(name: "Chocolate", category: c1.id, description: "Amazing chocolate!!!", price: 100000, price_excl_vat: 80000, translations:"en|fr", seller_id: s1.id)
  # p1.cover.attach(io: File.open('/home/ig/Code/mp/spec/files/cover.jpg'), filename: 'cover.jpg')
  # p1.images.attach(io: File.open('/home/ig/Code/mp/spec/files/product.jpg'), filename: 'product.jpg')
  # p1.images.attach(io: File.open('/home/ig/Code/mp/spec/files/product.jpg'), filename: 'product.jpg')
  # p1.save
  # ProductTag.create(tag: "yummy", lang: "en", product_id: p1.id)
  # ProductTag.create(tag: "delicious", lang: "en", product_id: p1.id)
  # ProductTranslation.create(lang: "fr", description: "Super chocolat!!!", product_id: p1.id)
  # ProductTag.create(tag: "trop bon", lang: "fr", product_id: p1.id)
  # ProductTag.create(tag: "delicieux", lang: "fr", product_id: p1.id)

  # p2 = Product.new(name: "Marmite", category: c1.id, description: "You won't believe how bad it tastes", price: 2959, price_excl_vat: 2367, translations:"en|fr", seller_id: s1.id)
  # p2.cover.attach(io: File.open('/home/ig/Code/mp/spec/files/cover.jpg'), filename: 'cover.jpg')
  # p2.images.attach(io: File.open('/home/ig/Code/mp/spec/files/product.jpg'), filename: 'product.jpg')
  # p2.images.attach(io: File.open('/home/ig/Code/mp/spec/files/product.jpg'), filename: 'product.jpg')
  # p2.save
  # ProductTag.create(tag: "awful", lang: "en", product_id: p2.id)
  # ProductTag.create(tag: "just bad", lang: "en", product_id: p2.id)
  # ProductTranslation.create(lang: "fr", description: "C'est incroyable à quel point c'est mauvais", product_id: p2.id)
  # ProductTag.create(tag: "atroce", lang: "fr", product_id: p2.id)
  # ProductTag.create(tag: "juste afreux", lang: "fr", product_id: p2.id)

  # 20.times do |i|
  #   i += 1
  #   pi = Product.new(name: "Food product " + i.to_s, category: c1.id, description: "Food product description: " + lorem, price: 10000, price_excl_vat: 8000, translations:"en|fr", seller_id: s1.id)
  #   pi.cover.attach(io: File.open('/home/ig/Code/mp/spec/files/cover.jpg'), filename: 'cover.jpg')
  #   pi.images.attach(io: File.open('/home/ig/Code/mp/spec/files/product.jpg'), filename: 'product.jpg')
  #   pi.images.attach(io: File.open('/home/ig/Code/mp/spec/files/product.jpg'), filename: 'product.jpg')
  #   pi.save
  #   ProductTag.create(tag: "one", lang: "en", product_id: pi.id)
  #   ProductTag.create(tag: "two", lang: "en", product_id: pi.id)
  #   ProductTranslation.create(lang: "fr", description: "Description produit: " + lorem, product_id: pi.id)
  #   ProductTag.create(tag: "un", lang: "fr", product_id: pi.id)
  #   ProductTag.create(tag: "deux", lang: "fr", product_id: pi.id)
  # end

  # s2 = Seller.create(name: "Jack Jack", slug: "jack-jack", email: "jack@sel.com", password: "password", password_confirmation: "password", description: "All you possibly need in Berlin", translations:"en|fr", confirmed_at: DateTime.now)
  # Location.create(name: "Warehouse", slug: "warehaouse", recipient: "Mr. Jack Nicholson", street: "Innstraße 10", city: "Berlin", country: "Germany", postal_code: "12045", delivery: true, billing: true, owner_type: "Seller", owner_id: s2.id)
  # SellerTranslation.create(lang: "fr", description: "Tout ce qu'il vous faut à Berlin", seller_id: s2.id)
  # s2.cover.attach(io: File.open('/home/ig/Code/mp/spec/files/cover.jpg'), filename: 'cover.jpg')

  # p3 = Product.new(name: "Shoe horn", category: c2.id , description: "You'll never tie your shoes again", price: 1299, price_excl_vat: 1039, translations:"en|fr", seller_id: s2.id)
  # p3.cover.attach(io: File.open('/home/ig/Code/mp/spec/files/cover.jpg'), filename: 'cover.jpg')
  # p3.images.attach(io: File.open('/home/ig/Code/mp/spec/files/seller.jpg'), filename: 'seller.jpg')
  # p3.images.attach(io: File.open('/home/ig/Code/mp/spec/files/seller.jpg'), filename: 'seller.jpg')
  # p3.save
  # ProductTag.create(tag: "useful", lang: "en", product_id: p3.id)
  # ProductTag.create(tag: "foot wear", lang: "en", product_id: p3.id)
  # ProductTranslation.create(lang: "fr", description: "Vous ne ferez plus jamais vos lacets!", product_id: p3.id)
  # ProductTag.create(tag: "pratique", lang: "fr", product_id: p3.id)
  # ProductTag.create(tag: "pour vos pieds", lang: "fr", product_id: p3.id)

  # p4 = Product.new(name: "Rake", category: c2.id, description: "Autumn's best friend", price: 10000, price_excl_vat: 8000, translations:"en|fr", seller_id: s2.id)
  # p4.cover.attach(io: File.open('/home/ig/Code/mp/spec/files/cover.jpg'), filename: 'cover.jpg')
  # p4.images.attach(io: File.open('/home/ig/Code/mp/spec/files/product.jpg'), filename: 'product.jpg')
  # p4.images.attach(io: File.open('/home/ig/Code/mp/spec/files/product.jpg'), filename: 'product.jpg')
  # p4.save
  # ProductTag.create(tag: "useful", lang: "en", product_id: p4.id)
  # ProductTag.create(tag: "tool", lang: "en", product_id: p4.id)
  # ProductTranslation.create(lang: "fr", description: "Le meilleur ami de l'automne", product_id: p4.id)
  # ProductTag.create(tag: "pratique", lang: "fr", product_id: p4.id)
  # ProductTag.create(tag: "outil", lang: "fr", product_id: p4.id)

  # 20.times do |i|
  #   i += 1
  #   pi = Product.new(name: "Retail product " + i.to_s, category: c2.id, description: "Retail product description: " + lorem, price: 10000, price_excl_vat: 8000, translations:"en|fr", seller_id: s2.id)
  #   pi.cover.attach(io: File.open('/home/ig/Code/mp/spec/files/cover.jpg'), filename: 'cover.jpg')
  #   pi.images.attach(io: File.open('/home/ig/Code/mp/spec/files/product.jpg'), filename: 'product.jpg')
  #   pi.images.attach(io: File.open('/home/ig/Code/mp/spec/files/product.jpg'), filename: 'product.jpg')
  #   pi.save
  #   ProductTag.create(tag: "one", lang: "en", product_id: pi.id)
  #   ProductTag.create(tag: "two", lang: "en", product_id: pi.id)
  #   ProductTranslation.create(lang: "fr", description: "Description produit de detail: " + lorem, product_id: pi.id)
  #   ProductTag.create(tag: "un", lang: "fr", product_id: pi.id)
  #   ProductTag.create(tag: "deux", lang: "fr", product_id: pi.id)
  # end

  puts "seeding complete"
end
