Dir[
  "#{Rails.root}/app/serializers/*.rb",
  "#{Rails.root}/app/services/*.rb",
  "#{Rails.root}/lib/*.rb"
].each {|file| load file}
