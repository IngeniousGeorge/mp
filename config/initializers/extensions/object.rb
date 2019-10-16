class Object
  def translate_object(lang)
    translated_class = self.class
    translated_object = self.class.new(self.attributes)
    translation_class = Object.const_get(self.class.to_s + "Translation")
    parent = self.class.to_s.downcase
    sql = "SELECT * FROM " + parent + "_translations WHERE " + parent + "_id='" + self.id + "';"
    translation = translation_class.find_by_sql(sql).first

    translated_object.assign_attributes(translation.attributes.except('id').select{ |key, _| translated_class.attribute_names.include? key })
    return translated_object
  end
end
