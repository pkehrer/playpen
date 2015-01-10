require 'net/http'
require 'rubygems'

module ApplicationHelper

  @@APIKEY = 'AIzaSyBtC_Brv14XWjM8tdwqSIYaubnNsW3FZAw'
  #@@APIKEY = 'AIzaSyB4u45MfJz3kJSAnmeXC1I4nxs0VeHloG8'
  @@SEARCHKEY = '007027742686371237774:ti1x9yery30'

  def web_search(query, start)
    url = make_url(query, start, false)
    return retrieve(url)
  end

  def image_search(query, start)
    url = make_url(query, start, true)
    return retrieve(url)
  end

  def make_url(query, start, image)
    query = query.gsub('safe=', '')
    image_mode = image ? "&searchType=image" : ""

    "https://www.googleapis.com/customsearch/v1?key=#{@@APIKEY}&cx=#{@@SEARCHKEY}&q=#{URI.encode(query)}&safe=high&start=#{start}#{image_mode}"
  end

  def retrieve(url)
    url = URI.parse(url)
    puts "Searching with: #{url}"

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    req = Net::HTTP::Get.new(url.request_uri)
    response = http.request(req)
    puts response.body
    response.body
  end

end
