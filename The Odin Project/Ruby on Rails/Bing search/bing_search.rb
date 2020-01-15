require 'rest-client'

class BlingSearch
    def initialize
        @search = "https://www.bing.com/search?q="
        self.get_input
    end
    def get_input
        puts "What would you like to search?"
        input = gets.chomp
        input = input.gsub(/\s/, '+')
        search_result = RestClient.get(@search+input)
        display_results(search_result)
    end
    def display_results(result)
        p result.code
        p result.headers
        p result.cookies
        p result.body
    end
end