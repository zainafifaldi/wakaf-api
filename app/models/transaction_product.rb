class TransactionProduct < ApplicationRecord
  enum state: {
    pending:   0,
    ordered:   1,
    completed: 2
  }
end
