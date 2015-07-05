require 'nokogiri'
require 'net/http'
ARGV[0] = $QUERY
class RosettaCode
  def self.get_solution
   sanitized_query = $QUERY.join(" ")
   # get HTML from the rosetta
   uri          = URI("http://rosettacode.org/wiki/" + santized_query)
   body         = Net::HTTP.get(uri)
   # parse it and use CSS selectors to find the ruby solution
   document     = Nokogiri::HTML(body)
   solutions    = document.css('.ruby')
   # format the first solution from text/html into executable ruby
   simple_ruby_solution = solutions.first.text.split("  ").join("\n")
   final_solution = simple_ruby_solution.gsub("putsend", "return \n end")
   puts eval(final_solution)
  end
end

RosettaCode.get_solution
