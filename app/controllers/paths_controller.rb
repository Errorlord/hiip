class PathsController < ApplicationController
  before_action :set_path, only: [:edit, :update, :show, :destroy]
  
  @@newpath
  
  def index
    @paths = Path.all
  end
  
  def new
    @path = Path.new
  end
  
  def create
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
  
  def find_next_empty(input)
    count = 1
    
    @paths = Path.all
    
    @paths.each do |f|
      string = input.position + "."
      if f.position.index(string)
        count = count + 1
      end
    end
    output = input.position
    output.to_s
    output.concat("." + count.to_s)
    return output
  end
  
  
end