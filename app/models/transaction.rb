class Transaction < ApplicationRecord
  TRX_NUMBER_PREFIX = 'WKFTRX'.freeze
  TRX_NUMBER_LEN = 7.freeze

  enum state: {
    pending: 0,
    ready:   1,
    cancel:  2
  }

  belongs_to :user, class_name: 'User'

  has_many :products, class_name: 'TransactionProduct'
  has_many :invoices, class_name: 'Invoice'

  before_create :set_initial_state
  after_create :set_transaction_number

  private

  def set_initial_state
    self.state = :pending unless self.state.present?
  end

  def set_transaction_number
    number = self.id.to_s.rjust(TRX_NUMBER_LEN, '0')
    self.transaction_number = "#{TRX_NUMBER_PREFIX}#{number}"
    self.save!
  end
end
