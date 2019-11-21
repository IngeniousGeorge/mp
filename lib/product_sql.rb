module ProductSql

  def self.get_products(params)

    default_locale = I18n.default_locale.to_s

    if params['sort'] == nil
      sort = "p.created_at"
    else
      sort = "p." + params['sort']
    end

    if params['order'] == nil
      order = "ASC"
    else
      order = params['order'].upcase
    end

    if params['limit'] == nil
      limit = "8"
    else
      limit = params['limit']
    end

    if params['page'] == nil || params['page'] == "1"
      offset = "0"
    else
      offset = ((params['page'].to_i - 1) * limit.to_i).to_s
    end

    seller_id = Seller.find_by_slug(params['seller']).id if params['seller']

    ###

    sql = params['locale'] == default_locale ? 
    "SELECT * FROM products p WHERE (translations LIKE '%" + default_locale + "%')"
    :
    "SELECT p.id, p.name, p.slug, p.category, p.seller_id, p.price, p.price_excl_vat, p.created_at, pt.description
    FROM products p
    LEFT JOIN product_translations pt ON p.id = pt.product_id
    WHERE (p.translations LIKE '%" + params['locale'] + "%')"

    sql += " AND p.category LIKE '" + params['category'] + "'" if params['category']

    sql += " AND p.seller_id = '" + seller_id + "'" if seller_id

    # if tag sql += " AND p.tag LIKE '" + tag + "'"

    sql += " ORDER BY " + sort + " " + order

    sql += " LIMIT " + limit

    sql += " OFFSET " + offset

    Product.find_by_sql(sql)
  end

  # private

    # def offset
    #   ((params['page'].to_i - 1) * 8).to_s
    # end

    # def select_all_default_locale
    #   "SELECT * FROM products WHERE (translations LIKE '%" + default_locale + "%')"
    # end
    
    # def select_translations(locale)
    #   "SELECT p.id, p.name, p.slug, p.category, p.seller_id, p.price, p.price_excl_vat, pt.description
    #   FROM products p
    #   LEFT JOIN product_translations pt ON p.id = pt.product_id
    #   WHERE (p.translations LIKE '%" + locale + "%')"
    # end
    
    # def default_locale
    #   I18n.default_locale.to_s
    # end

end