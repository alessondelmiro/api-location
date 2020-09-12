json.id evaluation.id
json.rating evaluation.rating
json.comment evaluation.comment
json.user do
  json.partial! 'users/user', user: evaluation.user if evaluation.user
end