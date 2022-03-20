module Transactions
  class TransactionSerializer < ActiveModel::Serializer
    attributes :id,
               :transaction_number,
               :donor_name,
               :donor_phone_number,
               :donor_email,
               :state,
               :created_at,
               :updated_at

    has_many :products, serializer: TransactionProducts::ProductSerializer
  end
end
