json.id    location.id
json.name  location.name
json.description location.description
json.address do
  json.partial! 'addresses/address', address: location.address if location.address
end 
json.user do
  json.partial! 'users/user', user: location.user if location.user
end
json.general_evaluation do
  json.partial! 'general_evaluations/general_evaluation', general_evaluation: location.general_evaluation if location.general_evaluation
end