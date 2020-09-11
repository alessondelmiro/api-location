json.id    location.id
json.name  location.name
json.description location.description
json.address do
  json.partial! 'addresses/address', address: location.address if location.address
end 
json.user do
  json.partial! 'users/user', user: location.user if location.user
end