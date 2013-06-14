require "./html_generator.rb"

ACTIONS = ["index", "show", "airmiles", "drunk", "country"]

if ARGV.empty?
  puts "Error, correct usage: 'ruby router.rb index [query]"
else
  action = ARGV[0]
  gen = HTMLGenerator.new

  if action == "index"
    text = ARGV[1]
    gen.index(text)

  elsif action == "show"
    id = ARGV[1]
    if id.nil?
      puts "Error, correct usage: 'ruby router.rb show [product id]'"
    else
      gen.show(id)
    end

  elsif action == "airmiles"
    gen.airmiles

  elsif action == "cheap"
    gen.economy_drinks

  elsif action == "promo"
    gen.promotion


  else
    puts "Unknown action! Accepted actions: #{ ACTIONS }"
  end
end



