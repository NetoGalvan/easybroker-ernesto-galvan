require_relative "../lib/services/properties_service"

service = Services::PropertiesService.new
properties = service.list_titles

puts "\n=== INICIO LISTADO DE PROPIEDADES ===\n\n"

properties.each do |property|
  puts "#{property[:public_id]} => #{property[:title]}"
end

puts "\n=== FIN LISTADO DE PROPIEDADES ===\n"