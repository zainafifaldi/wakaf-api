class Banner < ApplicationRecord
  scope :active, -> { where(active: true) }
  scope :ordered, -> { order(order: :asc) }
end
