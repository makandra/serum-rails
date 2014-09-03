# Script to generate a million users so we can test scalability.
# origin: M
(0..1000000).each do |i|
  new_batch = (i % 1000 == 0)
  if new_batch
    puts ";"
    puts "-- record ##{i}"
    puts 'INSERT INTO users (email, encrypted_password, username, first_name, last_name, town, country, deleted) VALUES '
  end
  puts ", " unless new_atch
  puts "('email.address#{i}@domain.tld', '2b15f280d3cbfaecc5091bde27ca824c1628dd0c', 'username#{i}', 'Anna', 'Smith', 'Foohausen', 'Fooland', 0) "
end
puts ";"

