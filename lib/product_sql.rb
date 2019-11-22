module ProductSql

  def self.get_products(params)

    if I18n.available_locales.include? params['locale'].to_sym
      #replace description with translation if locale not default
      sql = params['locale'].to_sym == I18n.default_locale ? 
      ["SELECT p.id, p.name, p.slug, p.category, p.seller_id, p.price, p.price_excl_vat, p.created_at, p.description AS description 
        FROM products p 
        WHERE (p.translations LIKE ?)", "%#{params['locale']}%"]
      :
      ["SELECT p.id, p.name, p.slug, p.category, p.seller_id, p.price, p.price_excl_vat, p.created_at, pt.description AS description
        FROM products p
        LEFT JOIN product_translations pt ON p.id = pt.product_id
        WHERE (p.translations LIKE ?)", "%#{params['locale']}%"]

      #check for cat/sel/tag/q and add AND statement
      if params['category']
        sql[0] += " AND p.category LIKE ?"
        sql << params['category']
      end

      if params['seller']
        seller_id = Seller.find_by_slug(params['seller']).id
        sql[0] += " AND p.seller_id = ?"
        sql << seller_id
      end

      if params['tag']
        sql[0] += " AND p.id IN (SELECT product_id FROM product_tags WHERE tag = ?)"
        sql << params['tag']
      end

      if params['q']
        sql[0] += " AND p.name LIKE ? 
          OR description LIKE ? 
          OR p.category = (SELECT id FROM categories c WHERE c.name LIKE ?)"
        3.times { sql << "%#{params['q']}%" }
      end

      #add limit/page/sort/order
      if params['sort'] == nil
        sort = "p.created_at"
      elsif params['sort'] == "price"
        sort = "p.price"
      end
      
      if params['order'] == "asc"
        order = "ASC"
      elsif params['order'] == "desc"
        order = "DESC"
      else
        order = nil
      end

      sql[0] += " ORDER BY #{sort} #{order}"

      if params['limit'] == nil
        limit = 8
      else
        limit = params['limit']
      end
      sql[0] += " LIMIT ?"
      sql << limit

      if params['page'] == nil || params['page'] == "1"
        offset = 0
      else
        offset = ((params['page'].to_i - 1) * limit.to_i).to_s
      end
      sql[0] += " OFFSET ?"
      sql << offset

      p sql
      Product.find_by_sql(sql)
    end
  end
end