require_relative '../lib/concerns/graphic.rb'

class UserLose
 include ::Graphic

 def render(user)
   fishtank(user)
   puts "You lose! The word was: #{user.boards[-1].secret_word}.\nDo you want to play again?"
 end
end

