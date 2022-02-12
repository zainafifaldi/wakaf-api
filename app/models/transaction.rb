class Transaction < ApplicationRecord
  enum state: {
    pending: 0,
    ready:   1,
    cancel:  2
  }
end
