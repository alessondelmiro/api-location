json.id    @user.id
json.name  @user.name
json.email @user.email
json.address do
  json.partial! 'addresses/address', address: @user.address if @user.address
end