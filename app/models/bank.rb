require 'yaml'

class Bank
  BANKS_FILE = File.read(Rails.root.join('lib/constants/banks.yml'))
  # BANKS_FILE = ERB.new(File.open(File.expand_path('lib/constants/banks.yml', Schema.root)))

  def self.banks
    YAML.load(BANKS_FILE).with_indifferent_access
  end

  def self.bank_codes
    banks.keys.map(&:to_s)
  end
end
