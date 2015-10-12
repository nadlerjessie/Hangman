require_relative '../lib/User.rb'
require_relative '../lib/concerns/graphic.rb'

class UserController
  extend ::Graphic

  def create
    view = UserNew.new
    view.render
  end

  def show(lives)
    view = UserShow.new
    view.render
  end
  def take_guess
    view = UserGuess.new
    view.render
  end
end