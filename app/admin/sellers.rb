ActiveAdmin.register Seller do
  permit_params :name, :slug, :email, :password, :description, :translations

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

  form do |f|
    f.inputs do
      f.input :name
      f.input :slug
      f.input :email
      f.input :password
      f.input :description
      f.input :translations
    end
    f.actions
  end

end