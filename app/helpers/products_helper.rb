module ProductsHelper
  def select_all
    "SELECT * FROM products"
  end

  def select_translations
    "SELECT p.id, p.slug, p.category, p.seller_id, p.price, p.price_excl_vat, pt.name, pt.description
    FROM products p
    LEFT JOIN product_translations pt ON p.id = pt.product_id
    WHERE p.translations LIKE '%" + params['locale'] + "%'"
  end
end