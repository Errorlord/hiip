def new
  @path = Path.new
end

def create
  
end

# { :controller => "paths", :action => "new", :parent => f }

def find_next_empty(input)
  string = input.position.to_s + "."
  count = 1
  Path.all.each do |f|
    if !f.position.index(string).nil?
      count = count + 1
    end
  end
  
  output = "input position" + string.to_s + "\tcount" + count.to_s
  return output
end