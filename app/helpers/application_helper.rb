module ApplicationHelper
  def default_locale
    I18n.default_locale.to_s
  end

  def price(number)
    number_to_currency((number / 100), locale: :fr) 
  end

  #image sizes
  def size_small
    "60x60"
  end
end
