class Invoice < ApplicationRecord
  AVAILABLE_PAYMENT_METHODS = %w[bank_transfer].freeze
  INV_NUMBER_PREFIX = 'WKF'.freeze
  INV_NUMBER_SUFFIX = 'INV'.freeze
  INV_NUMBER_LEN = 7

  enum state: {
    pending:  0,
    paid:     1,
    canceled: 2,
    expired:  3,
    refunded: 4
  }

  belongs_to :trx, class_name: 'Transaction', foreign_key: :transaction_id

  validates :payment_method, inclusion: AVAILABLE_PAYMENT_METHODS
  validates :payment_detail, presence: true

  before_create :set_initial_state, :set_expire_time
  after_create :set_invoice_number

  private

  def set_initial_state
    self.state = :pending unless self.state.present?
  end

  def set_expire_time
    self.expire_time = Time.now + 1.day
  end

  def set_invoice_number
    number = self.id.to_s.rjust(INV_NUMBER_LEN, '0')
    self.invoice_number = "#{INV_NUMBER_PREFIX}#{number}#{INV_NUMBER_SUFFIX}"
    self.save!
  end
end
