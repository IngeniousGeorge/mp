class ProductImagesValidator < ActiveModel::Validator
  def validate(record)
    unless record.logo.attached? && record.images.attached?
      record.errors[:image] << 'Products require one cover image and at least one other image'
    end
  end
end