class PathsController < ApplicationController
  before_action :set_path, only: [:edit, :update, :show, :destroy]
  
  def index
    @paths = Path.all
  end
  
  def new
    @path = Path.new
    
    @parent = Path.find(params[:parent])
  end
  
  def create
=begin
    begin
      @parent = @@newpath
    rescue
      @parent = Path.find(1)
      @parent.position = 1
    end
    @path = Path.new(path_params)
    begin
      @path.position = find_next_empty(@parent)
    end
    @path.position = @parent.position
=end

    @path = Path.new(path_params)
    
    @position = Path.find(params[:parent]).position     # string
    @path.position = find_next_empty(@position)
    
    if @path.save
      flash[:notice] = "Path was succesfully created"
      redirect_to path_path(@path)
    else
      render 'new'
    end
  end
  
  def show
    @@newpath = Path.new
    @@newpath.position = @path.position
    @paths = Path.all
  end
  
  def edit
      @parent = Path.find(params[:parent])
  end
  
  def update
    @path = Path.find(params[:id])
    if @path.save
      flash[:notice] = "Path was successfully updated"
      redirect_to path_path(@path)
    else
      render 'new'
    end
  end
  
  def destroy
    @path.destroy
    flash[:notice] = "Article was succesfully deleted"
    redirect_to paths_path
  end
  
  private
  def set_path
    @path = Path.find(params[:id])
  end
  
  def path_params
    params.require(:path).permit(:title, :content)
  end
  
=begin
  def find_next_empty(input)
    count = 1
    
    @paths = Path.all
    
    string = input.position + "."
    @paths.each do |f|
      if !f.position.index(string).nil?
        count = count + 1
      end
    end
    output = input.position
    output.to_s
    output.concat("." + count.to_s)
    return output
  end
=end
  
  def find_next_empty(input)  # string
  
    string_child = input + "."
    
    count = 0
    Path.all.each do |f|
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
end