module Categorize
  def self.define_all_as_hash

    category_hash = Hash.new

    category_hash[I18n.default_locale.to_s] = Category.all.pluck(:name, :id)

    I18n.available_locales.each do |lang|
      if lang != I18n.default_locale
        category_hash[lang.to_s] = CategoryTranslation.where("lang = '" + lang.to_s + "'").pluck(:name, :category_id)
      end
    end

    Category.define_singleton_method(:all_as_hash) do
      category_hash
    end
    
  end
end