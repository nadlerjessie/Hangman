require_relative '../lib/concerns/graphic.rb'

class UserDisplay
 include ::Graphic

 def render(user)
   fishtank(user)
   puts "\n\n\n #{user.boards[-1].reveal_letter.split('').join(' ')}"
   puts "Incorrect Letters Guessed:\n#{user.boards[-1].incorrect.sort.join(' ')}"
 end
end