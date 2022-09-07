Dir[
  "#{Rails.root}/app/libraries/*.rb",
  "#{Rails.root}/app/requests/*.rb",
  "#{Rails.root}/app/serializers/*.rb",
  "#{Rails.root}/app/services/*.rb",
  "#{Rails.root}/lib/*.rb"
].each {|file| load file}
