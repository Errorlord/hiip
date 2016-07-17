class NodesController < ApplicationController
  before_action :set_node, only: [:edit, :update, :show, :destroy]

  def index
    @nodes = Node.all
  end
  
  def new
    @node = Node.new
    
    @parent = Node.find(params[:parent])
  end

  def create
    @node = Node.new(node_params)
    # @parent = Node.find(params[:parent])
    
    @node.parent = Node.find(params[:parent]).position
    @node.position = find_next_empty(@node.parent)
    
    if @node.save
      flash[:notice] = "Node was succesfully created, #{params[:parent]}"
      redirect_to node_path(@node)
    else
      render 'new'
    end
  end
  
  def show
    @nodes = Node.all
    @node = Node.find(params[:id])
  end
  
  def edit
    @parent = Node.find(params[:id])
  end
  
  def update
    if @node.update(node_params)
      flash[:notice] = "Node was succesfully updated!\nHello.\n#{@node.content()}\t#{params[:node]}"
      redirect_to node_path(@node)
    else
      render 'new'
    end
  end
  
  def destroy
    destroy_children(@node)
    @node.destroy
    flash[:notice] = "Node (and children) were succesfully destroyed!"
    redirect_to nodes_path
  end
  
  private # does not need an end tag
  
  def set_node
    @node = Node.find(params[:id])
  end
  
  def node_params
    params.require(:node).permit(:title, :content)
  end
  
  def find_next_empty(input)  # string (which should be the path)
  
    string_child = input + "."
    
    count = 0
    Node.all.each do |f|
      if f.position.index(string_child) == 0  #f.position (input) string_child (kill)
        if get_level(f.position, string_child) > count
          count = get_level(f.position, string_child)
        end
      end
    end
    
    count += 1
    
    #output = string.to_s + count.to_s
    output = input + "." + count.to_s
    return output
  end
  
  def get_level(input, kill) 
    temp = input.sub(kill,"")
    my_length = temp.index(".")
    if my_length
      return temp[0, my_length].to_i
    else
      return temp.to_i
    end
  end
  
  def has_children(input)
    @boolean = false
    Node.all.each do |f|
      if f.parent == input.position
        @boolean = true
      end
    end
    return @boolean
  end
  
  def destroy_children(input)
    Node.all.each do |f|
      if f.parent == input.position
        if has_children(f)
          destroy_children(f)
        end
        f.destroy
      end
    end
  end

end