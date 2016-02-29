class WelcomeController < ApplicationController
  def index
    @questions = Path.where("position like '%.%'")
  end
  def handle_answer
    # @myinput = 
    redirect_to paths_path
  end
end
