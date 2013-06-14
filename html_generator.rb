require "json"
require "open-uri"
require "stringex"

class HTMLGenerator


  # ROUTING METHODS
  def index(text)
    products = retrieve_json_data("http://lcboapi.com/products?q=#{text}&page=1")
    print_html_header
    puts "<h1>THESE DRINKS WILL BE WAITING FOR YOU</h1>"
    products.each do |product|
         puts "<div class='product'>"
         puts "  <h2>#{product['name'].to_ascii}</h2>"
         # puts "  <img src='#{product['image_thumb_url']}'  class='product-thumbnail'/>"
         puts "  <ul class='product-data'>"
         puts "    <li>id: #{product['id']}</li>"
         puts "    <li>producer: #{product['producer_name']}</li>"
         puts "    <li>primary category: #{product['primary_category']}</li>"
         puts "    <li>secondary category: #{product['secondary_category']}</li>"
         puts "    <li>volume: #{product['volume_in_milliliters']} ml</li>"
         puts "    <li>price: $#{price_in_dollars(product['price_in_cents'])}</li>"
         puts "  </ul>"
         puts "</div>"
       end
    print_html_footer
  end

  def show(product_id)
    product = retrieve_json_data("http://lcboapi.com/products/#{product_id}")
    print_html_header
    puts "<h1>THIS IS THE DRINK YOU REQUESTED</h1>"
    puts "<div class='product'>"
    puts "  <h2>#{product['name'].to_ascii}</h2>"
    puts "  <ul class='product-data'>"
    puts "    <li>id: #{product['id']}</li>"
    puts "    <li>producer: #{product['producer_name']}</li>"
    puts "    <li>primary category: #{product['primary_category']}</li>"
    puts "    <li>secondary category: #{product['secondary_category']}</li>"
    puts "    <li>volume: #{product['volume_in_milliliters']} ml</li>"
    puts "    <li>price: $#{price_in_dollars(product['price_in_cents'])}</li>"
    puts "  </ul>"
    puts "</div>"
    print_html_footer
  end

  def airmiles
    products = retrieve_json_data("http://lcboapi.com/products?where=has_bonus_reward_miles&order=price_in_cents.desc&page=1")
    print_html_header
    puts "<h1>THESE DRINKS WILL GIVE YOU MAD AIRMILES YO</h1>"
    products.each do |product|
         puts "<div class='product'>"
         puts "  <h2>#{product['name'].to_ascii}</h2>"
         puts "  <ul class='product-data'>"
         puts "    <li>id: #{product['id']}</li>"
         puts "    <li>producer: #{product['producer_name']}</li>"
         puts "    <li>primary category: #{product['primary_category']}</li>"
         puts "    <li>secondary category: #{product['secondary_category']}</li>"
         puts "    <li>volume: #{product['volume_in_milliliters']} ml</li>"
         puts "    <li>price: $#{price_in_dollars(product['price_in_cents'])}</li>"
         puts "    <li>airmiles promotion ends: #{product['bonus_reward_miles_ends_on']}"
         puts "  </ul>"
         puts "</div>"
       end
    print_html_footer
  end

  def economy_drinks
    products = retrieve_json_data("http://lcboapi.com/products?order=alcohol_content.desc,price_per_liter_of_alcohol_in_cents.desc&page=1")
    print_html_header
    puts "<h1>THESE DRINKS WILL GETCHA DRUNK</h1>"
    products.each do |product|
         puts "<div class='product'>"
         puts "  <h2>#{product['name'].to_ascii}</h2>"
         puts "  <ul class='product-data'>"
         puts "    <li>id: #{product['id']}</li>"
         puts "    <li>producer: #{product['producer_name']}</li>"
         puts "    <li>primary category: #{product['primary_category']}</li>"
         puts "    <li>secondary category: #{product['secondary_category']}</li>"
         puts "    <li>volume: #{product['volume_in_milliliters']} ml</li>"
         puts "    <li>price: $#{price_in_dollars(product['price_in_cents'])}</li>"
         puts "    <li>alcohol content: #{(product['alcohol_content'] / 100).to_i}%"
         puts "  </ul>"
         puts "</div>"
       end
    print_html_footer
  end

  def promotion
    products = retrieve_json_data("http://lcboapi.com/products?where=has_limited_time_offer&order=limited_time_offer_savings_in_cents.desc&page=1")
    print_html_header
    puts "<h1>THESE DRINKS ARE ON SALE N SHIT</h1>"
    puts "<div class='row-fluid'>"
    products.each do |product|
      puts "  <div class='span12'>"
      puts "  <h2>#{product['name'].to_ascii}</h2>"
      puts "    <li>id: #{product['id']}</li>"
      puts "    <li>producer: #{product['producer_name']}</li>"
      puts "    <li>primary category: #{product['primary_category']}</li>"
      puts "    <li>secondary category: #{product['secondary_category']}</li>"
      puts "    <li>volume: #{product['volume_in_milliliters']} ml</li>"
      puts "    <li>price: $#{price_in_dollars(product['price_in_cents'])}</li>"
      puts "    <li>alcohol content: #{(product['alcohol_content'] / 100).to_i}%"
      puts "    <li>limited time offer ends on: #{product['limited_time_offer_ends_on']}"
      puts "  </div>"
    end
    puts "</div>"
    print_html_footer
  end

  # HELPER METHODS
  def print_html_header
    puts "<!DOCTYPE html>"
    puts "<html>"
    puts "<head>"
    puts "   <title>LCBO Unofficial Website</title>"
    puts "   <meta name='viewport' content='width=device-width, initial-scale=1.0'>"
    puts "   <link rel='stylesheet' type='text/css' href='bootstrap-responsive.css'>"
    puts "</head>"
    puts "<body>"
    puts "\n"
  end

  def print_html_footer
    puts "</body>"
    puts "</html>"
  end

  def retrieve_json_data(url)
    begin
      json_response = open(url).read
      result = JSON.parse(json_response)["result"]
    rescue OpenURI::HTTPError => e
      puts "Error: #{e.message}"
      exit
    end
  end

  def price_in_dollars(cents)
    result = (cents.to_f / 100).round(2)
  end

end
