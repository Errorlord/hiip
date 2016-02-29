class DisplaysController < ApplicationController
  
  def index
    @paths = Path.all
  end
  def show
    @id = Path.find(params[:id])
    @paths = Path.all
  end
end
