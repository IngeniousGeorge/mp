ActiveAdmin.register Seller do
  permit_params :name, :slug, :email, :password, :description, :translations, :cover, seller_translations_attributes: [:id, :lang, :description, :seller_id, :_destroy]

  index do
    selectable_column
    id_column
    column :name
    column :slug
    column :email
    column :password
    column :description
    column :translations
    actions
  end

  filter :name

  form partial: 'seller'
end