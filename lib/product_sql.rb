module ProductSql

  def self.get_products(params)

    if I18n.available_locales.include? params['locale'].to_sym
      #replace description with translation if locale not default
      sql = params['locale'].to_sym == I18n.default_locale ? 
      ["SELECT p.id, p.name, p.slug, p.category, p.seller_id, p.price, p.price_excl_vat, p.tags, p.created_at, p.description
        FROM products p 
        WHERE (p.translations LIKE ?)", "%#{params['locale']}%"]
      :
      ["SELECT p.id, p.name, p.slug, p.category, p.seller_id, p.price, p.price_excl_vat, p.tags, p.created_at, pt.description
        FROM products p
        LEFT JOIN product_translations pt ON p.id = pt.product_id
        WHERE (p.translations LIKE ?)", "%#{params['locale']}%"]

      #check for cat/sel/tag/q and add AND statements
      if params['category']
        #transform string in uuid if not uuid
        params['category'] = Category.find_by_name(params['category']).id unless /[0-9a-fA-F]{8}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{12}/.match?(params['category'])
        sql[0] += " AND p.category = ?"
        sql << params['category']
      end

      if params['seller']
        seller_id = Seller.find_by_slug(params['seller']).id
        sql[0] += " AND p.seller_id = ?"
        sql << seller_id
      end

      if params['tag']
        sql[0] += " AND p.id IN (SELECT product_id FROM product_tags t WHERE t.tag = ? AND t.lang = ?)"
        sql << params['tag']
        sql << params['locale']
      end

      if params['q']
        # check locale if the product or the product_translation table is to be searched
        locale_table = I18n.default_locale == params['locale'].to_sym ? "p" : "pt"
        sql[0] += " AND p.name LIKE ? 
          OR #{locale_table}.description LIKE ? 
          OR p.category = (SELECT id FROM categories c WHERE c.name LIKE ?)
          OR p.id IN (SELECT product_id FROM product_tags t WHERE t.tag LIKE ? AND t.lang = ?)"
        4.times { sql << "%#{params['q']}%" }
        sql << params['locale']
      end

      #get number of records for the query
      max_size = Product.find_by_sql(sql).size 

      #add limit/page/sort/order
      if params['sort'] == nil
        sort = "p.name"
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
        limit = 12
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

      result_set = Product.find_by_sql(sql)

      #add tags
      result_set.each do |product| 
        tags = ProductTag.where(["product_id = ? and lang = ?", product.id, params['locale']])
        tags.each { |t| product.tags << t.tag }
      end

      return { max_size: max_size, set: result_set }
    end
  end
end