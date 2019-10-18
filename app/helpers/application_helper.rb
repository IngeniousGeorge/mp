module ApplicationHelper
  def default_locale
    I18n.default_locale.to_s
  end

  #image sizes
  def size_small
    "60x60"
  end
end
