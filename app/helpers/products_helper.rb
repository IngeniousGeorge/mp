module ProductsHelper

  # SQL builder for show
  def select_all
    "SELECT * FROM products"
  end

  def select_all_default_locale
    "SELECT * FROM products WHERE translations LIKE '%" + default_locale + "%'"
  end

  def select_translations
    "SELECT p.id, p.name, p.slug, p.category, p.seller_id, p.price, p.price_excl_vat, pt.description
    FROM products p
    LEFT JOIN product_translations pt ON p.id = pt.product_id
    WHERE p.translations LIKE '%" + params['locale'] + "%'"
  end
end