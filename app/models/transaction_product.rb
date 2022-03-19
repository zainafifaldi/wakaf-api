class TransactionProduct < ApplicationRecord
  enum state: {
    pending:   0,
    ordered:   1,
    completed: 2
  }

  belongs_to :trx, class_name: 'Transaction', foreign_key: :transaction_id
  belongs_to :product, class_name: 'Product'

  # has_many :images, class_name: 'ProductImage', foreign_key: :product_id, primary_key: :product_id
  has_many :images, class_name: 'ProductImage', through: :product

  before_create :set_initial_state

  private

  def set_initial_state
    self.state = :pending unless self.state.present?
  end
end
