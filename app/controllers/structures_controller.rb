class StructuresController < ApplicationController
=begin
  def has_children(input)
    @structures = Structure.all
    position = input.position
    @structures.each do |f|
      if f.parent_position = position
        puts "Title: #{f.title}\tDescription: #{f.description}"
        puts "\t#{has_children(f)}"
      else
        puts "Title: #{f.title}\tDescription: #{f.description}"
      end
    end
  end
=end
  def new
    @structure = Structure.new
  end

  def create
    @structure = Structure.new(structure_params)
    
    if@structure.save
      redirect_to structure_path(@structure)
    end
  end
  
  def show
    @structure = Structure.find(params[:id])
  end
  
  private
  def structure_params
    params.require(:structure).permit(:title, :description, :position)
  end
end