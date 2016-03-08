class DisplaysController < ApplicationController
  
  def index
    @nodes = Node.all
  end
  def show
    @id = Node.find(params[:id])
    @nodes = Node.all
  end
  
  private
  def depth(input)
    count = 0
    while(!input.index(".").nil?)
      count += 1
      index = input.index(".")
      input[index, input.length - 1]
    end
    return count
  end
end
