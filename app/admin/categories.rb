ActiveAdmin.register Category do
  permit_params :name, :cover, category_translations_attributes: [:id, :lang, :name, :category_id, :_destroy]

  index do
    selectable_column
    id_column
    column :name
    actions
  end

  filter :name

  form partial: 'category'
end