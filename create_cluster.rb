#!ruby
require 'droplet_kit'

node_count = ARGV.shift.to_i
name_prefix = ARGV.shift
cloud_config_path = ARGV.shift
discovery_url = `curl -s https://discovery.etcd.io/new`.strip
user_data = File.read(File.expand_path(cloud_config_path))
user_data = user_data.gsub('<discovery_url>', discovery_url)

puts "DISCOVERY: #{discovery_url}"

client = DropletKit::Client.new(access_token: ENV['DIGITAL_OCEAN_KEY'])
# existing_droplets = client.droplets.all.to_a.map(&:name)
# puts "existing_droplets: #{existing_droplets}"
# existing_prefixes = existing_droplets.map{|n| n.split('-')[0..-2].join('-')}
#                                      .uniq
# puts "existing_prefixes: #{existing_prefixes}"
# existing_regex = %r(#{existing_prefixes.join('|')})
# matching = existing_droplets.select{|n| n =~ existing_regex}
# puts "matching: #{matching}"
# 

puts "user_data: #{user_data}"
puts "Creating #{node_count} nodes"
created = []
node_count.times do |i|
  name = "#{name_prefix}-#{i}"
  puts "creating #{name} | #{i+1} of #{node_count}"
  droplet = DropletKit::Droplet.new(name: name,
                                    region: 'nyc3',
                                    image: 'coreos-stable',
                                    #size: '512mb',
                                    size: '2gb',
                                    ssh_keys: [319446],
                                    ipv6: false,
                                    private_networking: true,
                                    user_data: user_data)
  created << client.droplets.create(droplet)
end
puts "CREATED:\n#{created.join("\n\n")}"

