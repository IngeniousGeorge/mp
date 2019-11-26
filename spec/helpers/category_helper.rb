def attach_cover_to_categories
  Category.all.each do |category| 
    category.cover.attach(io: File.open('/home/ig/Code/mp/spec/files/cover.png'), filename: 'cover.png')
  end
end