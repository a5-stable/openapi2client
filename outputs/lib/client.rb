require 'faraday'

class ApiClient
  API_BASE_URL = 'https://petstore.swagger.io/v2'

  def initialize(api_key)
    @api_key = api_key
    @connection = Faraday.new(url: API_BASE_URL) do |faraday|
      faraday.request :url_encoded
      faraday.adapter Faraday.default_adapter
    end
  end

  def get(resource, params = {})
    request(:get, resource, params)
  end

  def post(resource, body = {})
    request(:post, resource, body)
  end

  def put(resource, body = {})
    request(:put, resource, body)
  end

  def delete(resource)
    request(:delete, resource)
  end

  private

  def request(method, resource, data = {})
    response = @connection.send(method) do |request|
      request.url(resource, data)
      request.headers['Authorization'] = "Bearer #{@api_key}"
    end
    JSON.parse(response.body, symbolize_names: true)
  end
end
