ActiveAdmin.register Seller do
  permit_params :name, :slug, :email, :password, :description, :categories, :translations

  index do
    selectable_column
    id_column
    column :name
    column :slug
    column :email
    column :password
    column :description
    column :categories
    column :translations
    actions
  end

  filter :name

  form do |f|
    f.inputs do
      f.input :name
      f.input :slug
      f.input :email
      f.input :password
      f.input :description
      f.input :categories
      f.input :translations
    end
    f.actions
  end

end