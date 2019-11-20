module ProductSql

  def self.get_products(params)

    default_locale = I18n.default_locale.to_s

    sql = params['locale'] == default_locale ? 
    "SELECT * FROM products WHERE (translations LIKE '%" + default_locale + "%')"
    :
    "SELECT p.id, p.name, p.slug, p.category, p.seller_id, p.price, p.price_excl_vat, pt.description
    FROM products p
    LEFT JOIN product_translations pt ON p.id = pt.product_id
    WHERE (p.translations LIKE '%" + params['locale'] + "%')"

    sql += " LIMIT 8"

    Product.find_by_sql(sql)
  end

  private

    def select_all_default_locale
      "SELECT * FROM products WHERE (translations LIKE '%" + default_locale + "%')"
    end
    
    def select_translations(locale)
      "SELECT p.id, p.name, p.slug, p.category, p.seller_id, p.price, p.price_excl_vat, pt.description
      FROM products p
      LEFT JOIN product_translations pt ON p.id = pt.product_id
      WHERE (p.translations LIKE '%" + locale + "%')"
    end
    
    def default_locale
      I18n.default_locale.to_s
    end

end