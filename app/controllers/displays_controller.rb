class DisplaysController < ApplicationController
  
  def index
    @nodes = Node.all
  end
  def show
    @id = Node.find(params[:id])
    @nodes = Node.all
    @parent = @id.position.chomp(".")
    @this = Node.find(params[:id])
    
    @nodes.each do |f|
      if(f.position == @parent)
        @thing = f
      end
    end
    
    hasChildren
  end
  def getParent
    @nodes = Node.all
    @id = Node.find(params[:id])
    @id = @id.position.chomp(".")
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
    
  def hasChildren
    nodes = Node.all
    pos = Node.find(params["id"])
    pos.position.concat(".")
    
    nodes.each do |f|
      if f.position.include? "#{pos}"
        @children = true
      end
    end
  end
end
