module RequestSpecHelper
  def json_body
    @json_body ||= JSON.parse(response.body, symbolize_names: true)
  end
  
  def authenticated_header(user, headers)
    token = JsonWebToken.encode(user_id: user.id) if user
    headers["Authorization"] = token
    headers
  end
end
