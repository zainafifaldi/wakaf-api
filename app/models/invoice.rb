class Invoice < ApplicationRecord
  enum state: {
    pending:  0,
    paid:     1,
    canceled: 2,
    expired:  3,
    refunded: 4
  }
end
