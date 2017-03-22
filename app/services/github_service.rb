# class GithubService
#
#   def self.starred
#     parse(Faraday.get("https://api.github.com/users/#{@current_user.username}/starred"))[:results]
#   end
#
#   private
#
#   def parse(response)
#     JSON.parse(response.body, symbolize_names: true)
#   end
# end
