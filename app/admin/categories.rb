ActiveAdmin.register Category do
  permit_params :name, category_translations_attributes: [:id, :lang, :name, :category_id, :_destroy]

  index do
    selectable_column
    id_column
    column :name
    actions
  end

  filter :name

  form do |f|
    panel 'Warning' do
      "Set a transaltion for all languages! => #{I18n.available_locales.join("|")}"
    end
    f.inputs do
      f.input :name
      f.has_many :category_translations, allow_destroy: true do |a|
        a.input :lang
        a.input :name
      end
    end
    f.actions
  end

end