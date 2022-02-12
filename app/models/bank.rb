require 'yaml'

class Bank
  BANKS_FILE = File.read(File.expand_path('lib/constants/banks.yml', __FILE__))
  # BANKS = ERB.new(File.open(File.expand_path('lib/constants/banks.yml', Schema.root)))

  def banks
    YAML.load(BANKS_FILE).with_indifferent_access
  end
end
