class Cart < ApplicationRecord
  scope :user, -> { where(reference: 'user') }
  scope :guest, -> { where(reference: 'guest') }

  belongs_to :product, class_name: 'Product'
end
