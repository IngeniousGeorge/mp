# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if Rails.env.development?
  AdminUser.create!(email: "admin@example.com", password: "password", password_confirmation: "password", confirmed_at: DateTime.now)

  c1 = Client.create!(name: "jim", email: "jim@ig.com", password: "password", password_confirmation: "password", confirmed_at: DateTime.now)
  Basket.create(client_id: c1.id)
  l1 = Location.create(name: "jim norton", street: "Sonnenalle 1", city: "Berlin", country: "Germany", postal_code: "12047", owner_type: "Client", owner_id: c1.id)

  c2 = Client.create!(name: "jc", email: "jc@ig.com", password: "password", password_confirmation: "password", confirmed_at: DateTime.now)
  Basket.create(client_id: c2.id)
  l2 = Location.create(name: "jc", street: "Sonnenalle 200", city: "Berlin", country: "Germany", postal_code: "12059", owner_type: "Client", owner_id: c2.id)

  s1 = Seller.create(name: "Jane Choco", slug: "jane-choco", email: "jane@sel.com", password: "password", password_confirmation: "password", confirmed_at: DateTime.now)
  l3 = Location.create(name: "Jane Choco", street: "Weserstraße 100", city: "Berlin", country: "Germany", postal_code: "12047", owner_type: "Seller", owner_id: s1.id)
  # path = Rails.root.join("storage")
  s1.logo.attach()
  # s1.bg.attach(io: File.open(Rails.root.join("storage")), filename: 'jane-choco_bg.jpeg')
  p1 = Product.create(name: "Chocolate", category: "food", key_words: ["yummy", "great"], description: "Amazing chocolate!!!", price: 100000, price_excl_vat: 80000, seller_id: s1.id)
  # p1.logo.attach(io: File.open(Rails.root.join("storage")), filename: 'jane-choco_chocolate_logo.jpeg')
  # p1.image.attach(io: File.open(Rails.root.join("storage")), filename: 'jane-choco_chocolate_img1.jpeg')
  # p1.image.attach(io: File.open(Rails.root.join("storage")), filename: 'jane-choco_chocolate_img2.jpeg')
  p2 = Product.create(name: "Marmite", category: "food", key_words: ["ewww", "terrible"], description: "You won't believe how bad it tastes", price: 2959, price_excl_vat: 2367, seller_id: s1.id)
  # p2.logo.attach(io: File.open(Rails.root.join("storage")), filename: 'jane-choco_marmite_logo.jpeg')

  s2 = Seller.create(name: "Jack Jack", slug: "jack-jack", email: "jack@sel.com", password: "password", password_confirmation: "password", confirmed_at: DateTime.now)
  l4 = Location.create(name: "jack jack", street: "Innstraße 10", city: "Berlin", country: "Germany", postal_code: "12045", owner_type: "Seller", owner_id: s2.id)
  # SellerLocation.create(location_id: l4.id, seller_id: s2.id)
  # s2.logo.attach(io: File.open(Rails.root.join("storage")), filename: 'jack_logo.png')
  # s2.bg.attach(io: File.open(Rails.root.join("storage")), filename: 'jack_bg.jpeg')
  p3 = Product.create(name: "Shoe horn", category: "retail", key_words: ["great", "useful"], description: "You'll never tie your shoes again", price: 1299, price_excl_vat: 1039, seller_id: s2.id)
  # p3.logo.attach(io: File.open(Rails.root.join("storage")), filename: 'jack-jack_shoe_horn_logo.jpeg')
end

# DbTranslation.create(

# )

#ADD description seller
