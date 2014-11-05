#!ruby
require 'droplet_kit'

client = DropletKit::Client.new(access_token: ENV['DIGITAL_OCEAN_KEY'])
client.droplets.all.each do |droplet|
  puts "deleting: #{droplet.name} :: #{droplet.id}"
  client.droplets.delete(id: droplet.id)
end

