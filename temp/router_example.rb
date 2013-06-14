require "uri"
require "json"

class ItemsController

  def initialize
    @items = []
    1.upto(10) do |item|
      @items << { id: item, name: "Item #{item}" }
    end
  end

  def index
    @items.each do |item|
      puts "id: #{ item[:id] } - #{ item[:name] }"
    end
  end

  def show(index)
    item = @items[index - 1]
    puts "id: #{ item[:id] } - #{ item[:name] }"
  end

end


class Router

  def initialize(url)
    items = ItemsController.new

    case url
    when "/index"
      items.index
    when "/items/1"
      items.show(1)
    else
      items.index
    end
  end

end

http_method = ARGV[0]
url         = ARGV[1]

Router.new(http_method, url)



# command line argument parsing
# puts "First arg:  #{ARGV[0]}"
# puts "Second arg: #{ARGV[1]}"
# puts "Third arg:  #{ARGV[2]}"

# matt ⮀ Desktop ⮀ ruby argv.rb hello world hi
# First arg:  hello
# Second arg: world
# Third arg:  hi

# matt ⮀ Desktop ⮀ ruby argv.rb "test example here lol" wat
# First arg:  test example here lol
# Second arg: wat
# Third arg:


# test1 = URI.encode "http://google.com"
# => "http://google.com"
# URI.encode "http://google.com?q=ruby on rails"
# => "http://google.com?q=ruby%20on%20rails"


# json formats in http request api's
# "http://en.wikipedia.org/w/api.php?action=query&titles=ruby&prop=info&format=json"
  # returns:
# result = {"query":{
#             "normalized":[
#               {"from":"ruby","to":"Ruby"}],
#             "pages":{
#               "43551":{
#                 "pageid":43551,
#                 "ns":0,
#                 "title":"Ruby",
#                 "contentmodel":"wikitext",
#                 "pagelanguage":"en",
#                 "touched":"2013-06-04T09:52:01Z",
#                 "lastrevid":558263634,
#                 "counter":"",
#                 "length":24301}}}}
