require "./html_generator.rb"

ACTIONS = ["index", "show"]

if ARGV.empty?
  puts "Error, correct usage: 'ruby router.rb index [query]"
else
  action = ARGV[0]
  gen = HTMLGenerator.new

  if action == "index"
    text = ARGV[1]
    gen.index(text)

  # elsif action == "show"
  #   id = ARGV[1]
  #   if id.nil?
  #     puts "Error, correct usage: 'ruby router.rb show [desired action]'"
  #   else
  #     generator.show(id)
  #   end
  else
    puts "Unknown action! Accepted actions: #{ ACTIONS }"
  end
end



