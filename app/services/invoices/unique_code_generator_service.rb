module Invoices
  class UniqueCodeGeneratorService < AppService
    SEARCH_UNIQUE_CODE_ITERATION_LIMIT = 10

    attr_reader :transaction_amount, :params

    def initialize(transaction_amount, params)
      @transaction_amount = transaction_amount
      @params = params
    end

    def call
      return [0, 0] if params[:payment_method] != 'bank_transfer_automatic'

      i = 0
      valid = false
      unique_code = 0

      while valid == false && i < SEARCH_UNIQUE_CODE_ITERATION_LIMIT
        pos = (i.zero? ? -1 : ((i - 1) % Invoice::UNIQUE_CODE_LEN))
        unique_code = generate_unique_code(pos, unique_code)
        total_transfer = transaction_amount + unique_code

        valid = Invoice.unique_code_valid?(total_transfer)

        i += 1
      end

      raise Invoices::Errors::UniqueCode, 'Could not generate unique code' if valid == false

      [unique_code, total_transfer]
    end

    private

    def generate_unique_code(pos, current_unique_code = nil)
      if pos == -1
        generate_all_unique_code
      else
        change_single_unique_code(pos, current_unique_code)
      end
    end

    def generate_all_unique_code
      unique_code = 0
      (0..(3 - 1)).each do |i|
        rand_number = rand(0..9)
        unique_code += rand_number * (10**i)
      end
      unique_code
    end

    def change_single_unique_code(pos, current_unique_code)
      number_in_pos = (current_unique_code % (10**(pos+1)) / (10**pos)).floor
      rand_number = rand(0..9)
      current_unique_code - (number_in_pos * (10**pos)) + (rand_number * (10**pos))
    end
  end
end
