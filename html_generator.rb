require "json"
require "open-uri"

class HTMLGenerator

  def index(text)
    products = retrieve_json_data("http://lcboapi.com/products?q=#{text}")
    puts products[0]
  end

  def print_html_header
    puts "<!DOCTYPE html>"
    puts "<html>"
    puts "<head>"
    puts "   <title>LCBO Unofficial Website</title>"
    puts "   <meta name='viewport' content='width=device-width, initial-scale=1.0'>"
    puts "   <link rel='stylesheet' type='text/css' href='css/bootsrap.min.css'>"
    puts "   <link rel='stylesheet' type='text/css' href='css/main.css'>"
    puts "</head>"
    puts "<body>"
    puts "\n"
  end

  def print_html_footer
    puts "</body>"
    puts "</html>"
  end

  def retrieve_json_data(url)
    interim = open(url).read
    parsed = JSON.parse(interim)
    result = parsed["result"]
  end

end

