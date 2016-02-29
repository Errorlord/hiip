class DisplaysController < ApplicationController
  
  def index
    @paths = Node.all
  end
  def show
    @id = Node.find(params[:id])
    @paths = Node.all
  end
end
