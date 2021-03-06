class NodesController < ApplicationController
  before_action :set_node, only: [:edit, :update, :show, :destroy]

  def index
    @nodes = Node.all
    
    # @sorted = sort(to_class())
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
    @id = Node.find(params[:id])
    @node = Node.find(params[:id])
    @parent = @node.position.chomp(".")
    @this = Node.find(params[:id])
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
  
  class FakeNode
    @title
    @content
    @position
    @temp_position
    
    def title=(input)
      @title = input
    end
    
    def content=(input)
      @content = input
    end
    
    def position=(input)
      @position = input
    end
    
    def temp_position=(input)
      @temp_position = input
    end
    
    def title
      return @title
    end
    
    def content
      return @content
    end
    
    def position
      return @position
    end
    
    def temp_position
      return @temp_position
    end
  end
  
  def to_class()
    arr = Array.new
    Node.all.each do |f|
      temp = FakeNode.new()
      temp.title = f.title
      temp.content = f.content
      temp.position = f.position
      temp.temp_position = f.position
      arr.push(temp)
    end
    
    return arr
  end
  
  def sort(input_arr)
    arr = input_arr
    arr1 = Array.new
    arr2 = Array.new
    sorted = Array.new
    
    arr.each do |f|
      if f.temp_position.include?(".") != true
          arr1.push(f)
      end
    end
    
    arr1.each do |f|
      arr.delete(f)
    end
    
    puts "arr1[0].title/content/position before merge_sort(arr1) = #{arr1[0].title} / #{arr1[0].content} / #{arr1[0].position}"
    if arr1.length == 1
      puts "THE LOGIC CHOSE THIS."
    else
      arr1 = merge_sort(arr1)
    end
    
    puts "arr1[0].title/content/position after merge_sort(arr1) = #{arr1[0].title} / #{arr1[0].content} / #{arr1[0].position}"
    
    arr1.each do |f|
      county = 0
      sorted.push(f)
      arr.each do |g|
        puts "\n\n"
        puts "#{f.position} is the parent of? #{g.position}"
        
        
        
        if g.temp_position.include? f.temp_position
          arr2.push(g)
          puts "It said yup."
          
          length = g.temp_position.length
          
          arr2[county].temp_position = arr2[county].temp_position[f.temp_position.length + 1 .. length - 1]
          county += 1
        end
      end
      
      arr2.each do |q|
        arr.delete(q)
      end
      
      puts arr2.length
      sort(arr2)
    end
    
    return sorted
  end
  
  
  # MERGE SORT BELOW :D
  
  def merge_sort(arr)
    
    puts "\n\n\n==WELCOME TO MERGE SORT==\n\n\n"
    
    local_arr = arr

=begin
    local_arr.each do |f|
      puts f.title
      puts f.content
      puts f.position
      puts f.temp_position
      puts "insider merge sort\nThe length of arr = #{local_arr.length}\n\n"
    end
=end

    if(local_arr.length == 1)
      local_arr.each do |f|
        puts "\n\nTHIS IS INSIDE MERGE SORT"
        puts f.title
        puts f.content
        puts f.position
        puts f.temp_position
        puts "This is right before the return statement\n\n"
      end
      return local_arr
    end
    
    length = local_arr.length
    cut_length = length.to_i / 2
    
=begin
    local_arr.each do |f|
      puts f.title
      puts f.content
      puts f.position
      puts f.temp_position
      puts "Hello from inside mergesort \n\n"
    end
=end

    puts "The length of local_arr = #{local_arr.length}\n\n"
    arr1 = Array.new
    arr2 = Array.new
    sorted = Array.new
    
    count = 0
    while count < cut_length do
      arr1.push(arr[count])
      count += 1
    end
    
    while count < arr.length do
      arr2.push(arr[count])
      count += 1
    end
    
    arr1.each do |f|
      puts f.title
      puts f.content
      puts f.position
      puts f.temp_position
      puts "Hello from inside mergesort (arr1) \n\n"
    end
    
    arr2.each do |f|
      puts f.title
      puts f.content
      puts f.position
      puts f.temp_position
      puts "Hello from inside mergesort (arr2) \n\n"
    end
    
    
=begin
    count = 0
    arr1_count = 0
    arr2_count = 0
    while count < arr.length
      puts "Count: #{count}\tarr1_count: #{arr1_count}\tarr2_count: #{arr2_count}"
      
      temp1 = arr1[arr1_count]
      temp2 = arr2[arr2_count]
      if(arr1_count < arr1.length - 1 && arr2_count < arr2.length - 1)
        if(temp1.temp_position < temp2.temp_position)
          sorted.push(temp1)
          arr1_count += 1
        else
          sorted.push(temp2)
          arr2_count += 1
        end
      end
      
      count += 1
    end
    
    return sorted
=end

    count = 0
    while count < local_arr.length
      if(!arr1.empty? && !arr2.empty?)
        temp1 = arr1[0]
        temp2 = arr2[0]
        
        puts "temp1\tposition: #{temp1.position}\ttemp_position: #{temp1.temp_position}\n"
        puts "temp2\tposition: #{temp2.position}\ttemp_position: #{temp2.temp_position}\n"
        
        if(temp1.temp_position < temp2.temp_position)
          sorted.push(temp1)
          arr1.delete(temp1)
          puts "Count: #{count}\tPosition: #{temp1.position}\n\n"
        else
          sorted.push(temp2)
          puts "Count: #{count}\tPosition: #{temp2.position}\n\n"
          arr2.delete(temp2)
        end
      elsif
        sorted.push(arr2[0])
        arr2.delete(arr2[0])
      elsif
        sorted.push(arr1[0])
        arr1.delete(arr1[0])
      end
=begin
      if(arr1.empty?)
        sorted.push(arr2[0])
        arr2.delete(arr2[0])
      else
        sorted.push(arr1[0])
        arr1.delete(arr1[0])
      end
=end
      
      count += 1
    end
    
    puts "\n\nSorted length: #{sorted.length}"
    
    sorted.each do |f|
      puts "Position: #{f.position}"
    end
    
    return sorted
  end
end
